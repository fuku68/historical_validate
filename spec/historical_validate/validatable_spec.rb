require 'spec_helper'

RSpec.describe HistoricalValidate::Models::Validatable do
  let(:target) { User.new }
  before do
     HistoricalValidate.config.generation_num = 3
  end

  describe '#record_password_history' do
    let(:password) { 'abcd1234' }
    let(:md5_password) { '4321dcba' }
    before do
      target.password = password
      allow(Digest::MD5).to receive(:hexdigest).and_return(md5_password)
    end

    context 'password nil' do
      let(:password) { nil }
      it do
        expect(Digest::MD5).not_to receive(:hexdigest)
        target.save
      end
    end

    context 'password not nil' do
      it do
        expect(Digest::MD5).to receive(:hexdigest)
        target.save
        expect(target.password_histories).to eq([md5_password].to_json)
      end
    end

    context 'full generation' do
      before do
        target.password_histories = HistoricalValidate.config.generation_num.times.map do |n|
          n.to_s
        end
      end

      it do
        expect(Digest::MD5).to receive(:hexdigest)
        target.save
        expect(JSON.parse(target.password_histories)[0]).to eq(md5_password)
        expect(JSON.parse(target.password_histories).length).to eq(HistoricalValidate.config.generation_num)
      end
    end
  end

  describe '#historical_check_password' do
    let(:password) { 'abcd1234' }
    let(:md5_password) { Digest::MD5.hexdigest(password) }
    before do
      target.password = password
    end

    context 'nil' do
      it do
        target.historical_check_password
        expect(target.errors[:password]).to eq([])
      end
    end

    context 'not incliude' do
      before do
        target.password_histories = HistoricalValidate.config.generation_num.times.map do |n|
          n.to_s
        end.to_json
      end

      it do
        target.historical_check_password
        expect(target.errors[:password]).to eq([])
      end
    end

    context 'incliude' do
      before do
        array = HistoricalValidate.config.generation_num.times.map do |n|
          n.to_s
        end
        array[0] = md5_password
        target.password_histories = array.to_json
      end

      it do
        target.historical_check_password
        expect(target.errors[:password]).not_to eq([])
      end
    end

    context 'over incliude' do
      before do
        array = (HistoricalValidate.config.generation_num + 1).times.map do |n|
          n.to_s
        end
        array[-1] = md5_password
        target.password_histories = array.to_json
      end

      it do
        target.historical_check_password
        expect(target.errors[:password]).to eq([])
      end
    end
  end
end
