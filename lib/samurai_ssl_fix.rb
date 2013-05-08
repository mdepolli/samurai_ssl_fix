require 'active_resource_monkey_patch'

require 'samurai'

Samurai::Base.ssl_options = {:ssl_version => :TLSv1}