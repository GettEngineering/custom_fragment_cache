module CustomFragmentCache
  class Fragment
    attr_reader :name, :opts, :fields, :fields_method

    def initialize(name, opts)
      @name = name
      @opts = opts.with_indifferent_access
      @fields = {}
      @fields_method = :none
      set_fields
    end

    def set_fields
      validate_fields_method

      if @opts[:safe_fields].present?
        @fields = @opts[:safe_fields].to_a
        @fields_method = :safe
      elsif @opts[:trigger_fields].present?
        @fields = @opts[:trigger_fields].to_a
        @fields_method = :trigger
      end
    end

    def validate_fields_method
      if @opts.key?(:safe_fields) && @opts.key?(:trigger_fields)
        raise ArgumentError, "Set trigger and safe fields are not allowed together"
      end
    end
  end
end