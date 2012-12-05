require 'active_resource/connection'

class ActiveResource::Connection
  def apply_ssl_options_with_ssl_version(http)
    apply_ssl_options_without_ssl_version(http)

    http.ssl_version = @ssl_options[:ssl_version] if @ssl_options[:ssl_version]

    http
  end

  alias_method_chain :apply_ssl_options, :ssl_version
end