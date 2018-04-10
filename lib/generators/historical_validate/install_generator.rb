module HistoricalValidate
  module Generators
    # InstallGenerator
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path(__dir__)

      # Copies initializer file in application directory
      def copy_initializer
        copy_file '../../../config/initializers/historical_validate.rb', 'config/initializers/historical_validate.rb'
      end

      # Copies locale files in application directory
      def copy_locale
        copy_file '../../../config/locales/en.yml', 'config/locales/historical_validate.en.yml'
        copy_file '../../../config/locales/ja.yml', 'config/locales/historical_validate.ja.yml'
      end
    end
  end
end
