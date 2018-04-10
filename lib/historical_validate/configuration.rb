module HistoricalValidate
  # Configuration
  class Configuration
    # @param num [Integer, String, nil]
    def generation_num=(num)
      if !num.nil? && !num.is_a?(Integer) && num !~ /^[0-9]+$/
        raise ArgumentError, '`generation_num` must be a integer or a digit string.'
      end
      @generation_num = num.to_i
    end

    def generation_num
      @generation_num || 0
    end
  end
end
