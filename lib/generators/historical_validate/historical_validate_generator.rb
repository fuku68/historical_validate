module HistoricalValidate
  module Generators
    class HistoricalValidateGenerator < Rails::Generators::NamedBase
      namespace "historical_validate"

      def inject_devise_invitable_content
        # path = File.join("app", "models", "#{file_path}.rb")
        # inject_into_file(path, "historical_validatable, :", :after => "devise :") if File.exists?(path)
      end

      hook_for :orm
    end
  end
end
