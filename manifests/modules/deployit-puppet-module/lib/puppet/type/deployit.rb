require 'puppet/type'

Puppet::Type.newtype :deployit do
  @doc = "Manage deployit server connectivity info such as username, password, url."

  newparam(:name, :namevar => true) do
    desc "The name of the deployit server."
  end

  newparam :username do
    desc "username used to connect to Deployit server"
  end

  newparam :password do
    desc "password used to connect to Deployit server"
  end

  newparam :url do
    desc "deployit url"
    validate do |value|
	fail("Invalid url #{value}") unless URI.parse(value).is_a?(URI::HTTP)
    end
  end

  newparam :version do
    desc "deployit server version"
    defaultto '3.9.1'
  end

end

Puppet::Type.newmetaparam(:server) do
  desc "Provide a new metaparameter for all resources called server."
end

