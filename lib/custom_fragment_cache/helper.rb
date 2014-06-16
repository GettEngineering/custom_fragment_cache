module CustomFragmentCache
  module Helper
    def custom_cache(resource, name, options = {}, &block)
      CacheHelperMethod.base_custom_cache(self, :cache, resource, name, options, &block)
    end
  end
end