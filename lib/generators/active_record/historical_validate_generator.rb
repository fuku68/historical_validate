require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class HistoricalValidateGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_devise_migration
        migration_template "migration.rb", "db/migrate/historical_validate_add_to_#{table_name}.rb", migration_version: migration_version
      end

      def migration_version
        if Rails.version.start_with? '5.'
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    end
  end
end
