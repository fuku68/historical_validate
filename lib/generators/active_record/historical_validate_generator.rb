require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    # HistoricalValidateGenerator
    class HistoricalValidateGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_devise_migration
        migration_template 'migration.rb',
                           "db/migrate/historical_validate_add_to_#{table_name}.rb",
                           migration_version: migration_version
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]" if Rails.version.start_with? '5.'
      end
    end
  end
end
