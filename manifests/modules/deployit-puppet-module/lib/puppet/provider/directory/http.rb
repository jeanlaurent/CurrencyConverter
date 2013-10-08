require 'base64'
require 'net/http'
require 'puppet/provider/rest_provider'

Puppet::Type.type(:directory).provide :http, :parent => Puppet::Provider::DeployitRepository do
  @doc = "Manage a Deployit core.Directory CI using http protocol"

  defaultfor :operatingsystem => :ubuntu

  def exists?
    is_exists? @resource[:id]
  end

  def create
    do_create to_ci
  end

  def destroy
    delete @resource[:id]
  end

  def to_ci
    ConfigurationItem.new(@resource[:type],@resource[:id] )
  end

end

