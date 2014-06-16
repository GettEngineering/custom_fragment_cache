module CustomFragmentCache
  class CacheHelperMethod
    def self.base_custom_cache(context, method_name, resource, name, options = {}, &block)
      if CustomFragmentCache.configuration.enabled
        fragment_cache_key = ::CustomFragmentCache::Logic.cache_key(name, resource)
        default_options = { expires_in: CustomFragmentCache.configuration.expiration_time }
        context.__send__(method_name, fragment_cache_key, default_options.merge(options), &block)
      else
        block.call
      end
    end
  end
end