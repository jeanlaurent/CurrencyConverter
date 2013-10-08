require 'puppet/type'

Puppet::Type.newtype :environment do
  @doc = "Manage an udm.Environment CI on Deployit Server."

  newparam :id, :namevar => true do
    desc "CI id"
  end

  newparam :type do
    desc "CI Type"
    defaultto "udm.Environment"
  end

  newparam :members do
    desc "CI members"
    defaultto []
  end

  newparam :dictionaries do
    desc "CI dictionaries"
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

