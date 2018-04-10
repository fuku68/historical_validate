require 'rspec'
require 'generators/historical_validate/install_generator'

RSpec.describe HistoricalValidate::Generators::InstallGenerator, type: :generator do
  destination File.expand_path("../../../tmp", __FILE__)
  before { prepare_destination }

  it 'run task' do
    gen = generator
    expect(gen).to receive :copy_initializer
    expect(gen).to receive :copy_locale
    gen.invoke_all
  end

  describe 'generated files' do
    before do
      run_generator
    end

    describe 'initilizer file' do
      subject { file('config/initializers/historical_validate.rb') }
      it { is_expected.to exist }
      it { is_expected.to contain(/HistoricalValidate.configure do |config|/) }
    end

    describe 'locale files' do
      describe 'en.yml' do
        subject { file('config/locales/historical_validate.en.yml') }
        it { is_expected.to exist }
        it { is_expected.to contain(/en:\n/) }
      end

      describe 'ja.yml' do
        subject { file('config/locales/historical_validate.ja.yml') }
        it { is_expected.to exist }
        it { is_expected.to contain(/ja:\n/) }
      end
    end
  end
end
