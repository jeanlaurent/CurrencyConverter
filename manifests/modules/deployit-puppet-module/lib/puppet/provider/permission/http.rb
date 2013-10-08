require 'base64'
require 'net/http'
require 'puppet/provider/rest_provider'

Puppet::Type.type(:permission).provide :http, :parent => Puppet::Provider::DeployitPermission do
  @doc = "Set and unset permission on core.Directory CI using http protocol"

  defaultfor :operatingsystem => :ubuntu

  def exists?
	is_granted(@resource[:permission], @resource[:role], @resource[:id])
  end

  def create
	do_create(@resource[:permission], @resource[:role], @resource[:id])
  end

  def destroy
	delete(@resource[:permission], @resource[:role], @resource[:id])
  end

end

