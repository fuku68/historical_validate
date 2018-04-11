RSpec.describe HistoricalValidate::Configuration do
  let(:config) { described_class.new }

  describe '#generation_num=' do
    subject do
      config.generation_num = num
      config.generation_num
    end

    context 'set nil' do
      let(:num) { nil }
      it 'should be return 0' do
        expect(subject).to eq(0)
      end
    end

    context 'set number' do
      let(:num) { 5 }
      it 'should be return number' do
        expect(subject).to eq(num)
      end
    end

    context 'set string number' do
      let(:num) { '5' }
      it 'should be return number' do
        expect(subject).to eq(num.to_i)
      end
    end

    context 'set decimals' do
      let(:num) { 5.1234 }
      it 'should be raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError, '`generation_num` must be a integer or a digit string.')
      end
    end

    context 'set string decimals' do
      let(:num) { '5.1234' }
      it 'should be raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError, '`generation_num` must be a integer or a digit string.')
      end
    end

    context 'set string' do
      let(:num) { 'ABCD' }
      it 'should be return raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError, '`generation_num` must be a integer or a digit string.')
      end
    end
  end
end
