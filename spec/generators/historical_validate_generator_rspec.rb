require 'rspec'
require 'generators/historical_validate/historical_validate_generator'
require 'generators/active_record/historical_validate_generator'

RSpec.describe HistoricalValidate::Generators::HistoricalValidateGenerator, type: :generator do
  let(:dest_path) { File.expand_path("../../../tmp", __FILE__) }
  destination File.expand_path("../../../tmp", __FILE__)
  before { prepare_destination }

  it 'run task' do
    gen = generator ['User', '--orm=active_record']
    expect(gen).to receive :inject_devise_invitable_content
    gen.invoke_all 
  end

  describe 'generated files' do
    before do
      gen = generator ['User', '--orm=active_record']
      gen.invoke_all
    end

    describe 'migrate file' do
      subject do
        p File.join(dest_path, '/db/migrate/*_historical_validate_add_to_users.rb')
        name = Dir.glob(File.join(dest_path, '/db/migrate/*_historical_validate_add_to_users.rb')).first
        file(name)
      end
      it { is_expected.to exist }
      it { is_expected.to contain(/class HistoricalValidateAddTo/) }
    end
  end
end
