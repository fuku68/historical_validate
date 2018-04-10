module HistoricalValidate
  module Models
    # Validatable
    module Validatable
      extend ActiveSupport::Concern
      included do
        before_save :record_password_history
      end

      ##
      # record MD5 value of paaword
      #
      def record_password_history
        return if password.nil?
        password_hash = Digest::MD5.hexdigest(password)
        histories = if password_histories.present?
                      JSON.parse(password_histories)
                    else
                      []
                    end
        # store password_hash value
        histories.unshift(password_hash) if histories.empty? || histories[0] != password_hash
        self.password_histories = histories.slice(0, HistoricalValidate.config.generation_num).to_json
      end

      ##
      # check valudate
      #
      def historical_check_password
        histories = if password_histories.present?
                      JSON.parse(password_histories)
                    else
                      []
                    end
        return unless histories.include?(Digest::MD5.hexdigest(password))
        errors.add :password, :included_historical_password, num: HistoricalValidate.config.generation_num
      end
    end
  end
end
