require 'historical_validate/version'

# HistoricalValidate
module HistoricalValidate
  autoload :Configuration, 'historical_validate/configuration'
  autoload :Models, 'historical_validate/models'
  autoload :Controllers, 'historical_validate/controllers'

  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end
  end
end
