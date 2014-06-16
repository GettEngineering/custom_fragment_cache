module CustomFragmentCache
  class Railtie < Rails::Railtie
    initializer "custom_fragment_cache.extend_cache_helpers" do |app|
      ActiveSupport.on_load :action_view do
        include Helper
      end

      JbuilderTemplate.class_eval do
        def custom_cache!(resource, name, options = {}, &block)
          CacheHelperMethod.base_custom_cache(self, :cache!, resource, name, options, &block)
        end
      end
    end
  end
end