module HistoricalValidate
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../", __FILE__)

      def copy_locale
        copy_file "../../../config/locales/en.yml", "config/locales/historical_validate.en.yml"
        copy_file "../../../config/locales/ja.yml", "config/locales/historical_validate.ja.yml"
      end
    end
  end
end
