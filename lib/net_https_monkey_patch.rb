require 'net/http'
require 'net/https'

module Net
  class HTTP
    if RUBY_VERSION =~ /^1.8/
      # Adds the ability to access the ssl_version of the ssl_context (already exists in Ruby 1.9.3)
      ssl_context_accessor :ssl_version
    end
  end
end
