require 'puppet/type'

Puppet::Type.newtype :container do
  @doc = "Manage a CI on Deployit Server."

  newparam :id, :namevar => true do
    desc "CI id"
  end

  newparam :type do
    desc "CI Type"
  end

  newparam :values do
    desc "CI Values"
  end

  newparam :tags do
    desc "CI tags"
    defaultto []
  end
  
  autorequire(:server) do
    self[:server]
  end

  ensurable do
    defaultvalues
    defaultto :present
  end

end

