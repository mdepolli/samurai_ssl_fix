require 'active_resource_monkey_patch'
require 'net_https_monkey_patch'

Samurai::Base.ssl_options = {:ssl_version => :TLSv1}