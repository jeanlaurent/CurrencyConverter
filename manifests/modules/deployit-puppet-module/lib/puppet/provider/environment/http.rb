require 'base64'
require 'net/http'
require 'puppet/provider/rest_provider'

Puppet::Type.type(:environment).provide :http, :parent => Puppet::Provider::DeployitRepository do
  @doc = "Create Deployit environment CI using http protocol"

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
    ci = ConfigurationItem.new(@resource[:type],@resource[:id] )
    ci.properties['members']=@resource[:members]
    ci.properties['dictionaries']=@resource[:dictionaries]
    ci
  end

end

