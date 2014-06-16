require 'active_support/concern'
require 'active_support/core_ext/object/blank'
require 'custom_fragment_cache/railtie' if defined?(Rails)
require 'custom_fragment_cache/logic'
require 'custom_fragment_cache/fragment'
require 'custom_fragment_cache/helper'
require 'custom_fragment_cache/cache_helper_method'
require 'custom_fragment_cache/configuration'
require 'custom_fragment_cache/version'

module CustomFragmentCache
  extend ActiveSupport::Concern
  include Logic

  included do
    # Don't call after_save when it's Observer
    after_save :fragments_validity unless self.superclass == ActiveRecord::Observer
  end

  # Observer support
  def after_save(record)
    fragments_validity(record)
  end

  def fragments_validity(record = self)
    self.class.fragment_caches.each do |fragment_cache|
      if expire_cache?(fragment_cache, record)
        expire_fragment(cache_key(fragment_cache.name, record))
      end
    end
  end

end