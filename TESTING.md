## You must test on a system that is known to have the OpenSSL bug, like Ubuntu 12.04 LTS with Ruby 1.8.7!

### Validate the issue:

    require 'samurai'
    Samurai.options = {
      :site              => 'https://api.samurai.feefighters.com/v1/',
      :merchant_key      => 'a1ebafb6da5238fb8a3ac9f6',
      :merchant_password => 'ae1aa640f6b735c4730fbb56',
      :processor_token   => '5a0e1ca1e5a11a2997bbf912'
    }

    @transaction = Samurai::Processor.the_processor.purchase('abc123',122.00)
    @transaction.to_json

Returns exception:

    ActiveResource::SSLError: SSL_connect SYSCALL returned=5 errno=0 state=unknown state
      from /gems/activeresource-2.3.14/lib/active_resource/connection.rb:177:in `request'
      from /gems/activeresource-2.3.14/lib/active_resource/connection.rb:156:in `post'
      from /gems/activeresource-2.3.14/lib/active_resource/custom_methods.rb:97:in `post'
      from /gems/samurai-0.3.0/lib/samurai/processor.rb:70:in `execute'
      from /gems/samurai-0.3.0/lib/samurai/processor.rb:39:in `purchase'
      from (irb):9


### Validate the fix:

Add this gem to the Gemfile, then you can run the same code again.  You'll get a 404 (which is good, it means the SSL negotiation succeeded!):

    ActiveResource::ResourceNotFound: Failed with 404 Not Found
      from /gems/activeresource-2.3.14/lib/active_resource/connection.rb:194:in `handle_response'
      from /gems/activeresource-2.3.14/lib/active_resource/connection.rb:173:in `request'
      from /gems/activeresource-2.3.14/lib/active_resource/connection.rb:156:in `post'
      from /gems/activeresource-2.3.14/lib/active_resource/custom_methods.rb:97:in `post'
      from /gems/samurai-0.3.0/lib/samurai/processor.rb:70:in `execute'
      from /gems/samurai-0.3.0/lib/samurai/processor.rb:39:in `purchase'
