# CustomFragmentCache

CustomFragmentCache gives you a simple way for defining your own fragments cache with the ability to specify expiration according to fields.

## Installation

Add this line to your application's Gemfile:

    gem 'custom_fragment_cache'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install custom_fragment_cache

## Usage
### Define fragments:
Define it on ActiveRecord:
``` ruby
class User < ActiveRecord::Base
  include CustomFragmentCache
  
  define_cache_fragment(:full_name, trigger_fields: %w(first_name last_name)) # When one of the trigger fields will be changed it will expire the cache
  define_cache_fragment(:full_name, safe_fields: %w(id created_at updated_at)) # When one of the none safe fields will be changed it will expire the cache
end
```

You can also define it on ActiveRecord::Observer
``` ruby
class UserCache < ActiveRecord::Observer
  include CustomFragmentCache
  observe :user

  define_cache_fragment(:full_name, trigger_fields: %w(first_name last_name))
end
```

### Use cache on the view:
Use `custom_cache` instead of `cache`
``` ruby
<p>
  <span>Hello </span>
  <span><% custom_cache(User.first, :full_name) { "#{User.first.first_name} #{User.first.last_name}" } %></span>
</p>
```

Jbuilder support
``` ruby
json.custom_cache!(user, :full_name) do
  json.first_name user.first_name
  json.last_name user.last_name
end
```



## Contributing

1. Fork it ( http://github.com/<my-github-username>/custom_fragment_cache/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
