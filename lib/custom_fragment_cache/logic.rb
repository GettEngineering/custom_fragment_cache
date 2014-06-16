module CustomFragmentCache
  module Logic
    extend ActiveSupport::Concern

    def expire_cache?(fragment_cache, record)
      if fragment_cache.fields_method == :safe
        unsafe_dirty_fields = record.changed - fragment_cache.fields
        return true if unsafe_dirty_fields.present?
      elsif fragment_cache.fields_method == :trigger
        trigger_dirty_fields = record.changed & fragment_cache.fields
        return true if trigger_dirty_fields.present?
      end
    end

    def expire_fragment(key)
      action_controller = ActionController::Base.new

      if action_controller.send(:cache_configured?)
        action_controller.instrument_fragment_cache :expire_fragment, key do
          if key.is_a?(Regexp)
            action_controller.cache_store.delete_matched(key)
          elsif action_controller.cache_store.is_a?(ActiveSupport::Cache::RedisStore)
            # TODO find better solution
            action_controller.cache_store.delete_matched("*#{key}*")
          else
            action_controller.cache_store.delete(key)
          end
        end
      end
    end

    def prefix
      "custom_fragment_cache"
    end

    def cache_key(fragment_name, record)
      "#{prefix}:#{record.class.name.downcase}-#{record.id}:#{fragment_name}"
    end
    module_function :cache_key, :prefix

    module ClassMethods
      def add_fragment_cache(fragment_cache)
        (@fragment_caches ||= []) << fragment_cache
      end

      def fragment_caches
        @fragment_caches || []
      end

      def define_cache_fragment(name, opts = {})
        fragment_cache = CustomFragmentCache::Fragment.new(name, opts)
        add_fragment_cache(fragment_cache)
      end
    end
  end
end