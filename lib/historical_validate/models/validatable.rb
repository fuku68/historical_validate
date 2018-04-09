module HistoricalValidate
  module Models
    module Validatable
      extend ActiveSupport::Concern
      included do
        before_save :record_password_history
      end

      ##
      # record MD5 value of paaword
      #
      def record_password_history
        return if self.password.nil?
        password_hash = Digest::MD5.hexdigest(self.password)
        histories = if self.password_histories.present?
                      JSON.parse(self.password_histories)
                    else
                      []
                    end
        if histories.length == 0 || histories[0] != password_hash
          histories.unshift(password_hash)
        end
        self.password_histories = histories.slice(0, HistoricalValidate.config.generation_num).to_json
      end

      ##
      # check valudate
      #
      def historical_check_password
        histories = if self.password_histories.present?
                      JSON.parse(self.password_histories)
                    else
                      []
                    end
        return unless histories.include?(Digest::MD5.hexdigest(self.password))
        errors.add :password, :included_historical_password, num: HistoricalValidate.config.generation_num
      end
    end
  end
end
