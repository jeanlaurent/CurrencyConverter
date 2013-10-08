require 'puppet'
require 'open-uri'
require 'rexml/document'


class ConfigurationItem
  attr_accessor :id, :type, :properties

  def initialize(type, id)
    @type = type
    @id = id
    @properties = {}
  end

  def to_s
    "CI: '#{@id}' ''#{@type}'' #{@properties})"
  end

end

class DeployitCommunicator
  def initialize(endpoint, username, password)
    url = URI.parse(endpoint)
    @connection = Net::HTTP.new(url.host,url.port)
    @connection.use_ssl = false
    @username=username
    @password=password
    @types={}
  end

  def do_get(path)
    execute(Net::HTTP::Get.new(URI::encode path))
  end

  def do_delete(path)
    execute(Net::HTTP::Delete.new(URI::encode path))
  end

  def do_put(path)
    execute(Net::HTTP::Put.new(URI::encode path))
  end

  def do_post(path,xml)
    request = Net::HTTP::Post.new(URI::encode path)
    request.body = xml
    request.add_field "Content-Type", "application/xml"
    execute(request)
  end

  def to_s
    "Deployit Communicator #{@endpoint}"
  end

private
  def type(name)
    doc = do_get "/deployit/metadata/type/#{name}"
    @types[name]=Hash[doc.elements.to_a("/descriptor/property-descriptors/property-descriptor").map { |x| [x.attributes['name'], x] }]
  end

  def execute(request)
	  #TODO: manage error when the remote server is not available (eg not started)
    request.basic_auth @username, @password
    res = @connection.request(request)
    raise Puppet::Error, "cannot send request to deployit server #{res.code}/#{res.message}:#{res.body}"  unless res.is_a?(Net::HTTPSuccess)
    REXML::Document.new res.body
  end

public
  def to_xml(ci)
    pd=type(ci.type)
    doc = REXML::Document.new
    root = doc.add_element ci.type, {'id' => ci.id}
    ci.properties.each do |key, value|
      property = root.add_element(key)
      case pd[key].attributes['kind']
        when 'SET_OF_STRING', 'LIST_OF_STRING'
          value.each do |v|
            property.add_element("value").text = v
          end
        when 'SET_OF_CI', 'LIST_OF_CI'
          value.each do |v|
	    property.add_element("ci", {"ref" => v})
          end
        when 'MAP_STRING_STRING'
          value.each do |k, v|
            property.add_element("entry", {'key' => k}).text = v
          end
        when 'CI'
          property.add_attribute('ref', value)
        else
          property.text = value
      end

    end
    doc.to_s()
  end


  def from_xml(doc)
    ci = ConfigurationItem.new(doc.root.name, doc.root.attributes["id"])
    pd=type(ci.type)
    doc.elements.each("/*/*") do |prop|
      case pd[prop.name].attributes["kind"]
        when 'SET_OF_STRING', 'LIST_OF_STRING'
          values = []
          prop.elements.each("//#{prop.name}/value") { |v|
            values << v.text
          }
          ci.properties[prop.name]=values
        when 'SET_OF_CI', 'LIST_OF_CI'
          values = []
          prop.elements.each("//#{prop.name}/ci") { |v|
            values << v.attributes['ref']
          }
          ci.properties[prop.name]=values
        when 'MAP_STRING_STRING'
          values = {}
          prop.elements.each("//#{prop.name}/entry") { |v|
            values[v.attributes['key']]=v.text
          }
          ci.properties[prop.name]=values
        when 'CI'
          ci.properties[prop.name]=prop.attributes['ref']
        else
          ci.properties[prop.name]=prop.text

      end
    end
    ci
  end

end

class Puppet::Provider::RestProvider  < Puppet::Provider 
  def communicator 
    return @communicator if defined?(@communicator)
    deployit_resource = resource.catalog.resources.find{|x| x.class == Puppet::Type::Deployit  && x[:name] == @resource[:server].title}
    raise Puppet::Error, " Cannotfind any deployit servers matching '#{@resource[:server]}' in '#{resource.catalog.resources.find_all{|x| x.class == Puppet::Type::Deployit}}'" unless deployit_resource
    @communicator = DeployitCommunicator.new(deployit_resource[:url], deployit_resource[:username], deployit_resource[:password])
    @communicator
  end

  def GET(path)
     communicator.do_get(path)
  end

  def GET?(path)
    '<boolean>true</boolean>' == GET(path).elements['//boolean'].to_s	
  end

  def POST(path)
    communicator.do_post(path, to_xml)
  end

  def DELETE(path)
    communicator.do_delete(path)
  end

  def PUT(path)
    communicator.do_put(path)
  end
end


class Puppet::Provider::DeployitRepository  < Puppet::Provider::RestProvider
  def is_exists?(id)
    doc = communicator.do_get "/deployit/repository/exists/#{id}"
    '<boolean>true</boolean>' == doc.elements['//boolean'].to_s	
  end

  def read(id)
    doc = communicator.do_get "/deployit/repository/ci/#{id}"
    communicator.from_xml(doc)
  end
  
  def do_create(ci)
    doc = communicator.to_xml(ci)
    newdoc = communicator.do_post "/deployit/repository/ci/#{ci.id}", doc
    communicator.from_xml(newdoc)
  end
  
  def delete(id)
    communicator.do_delete "/deployit/repository/ci/#{id}"
  end
end

class Puppet::Provider::DeployitPermission  < Puppet::Provider::RestProvider
  def is_granted(permission,role, id)
    doc = communicator.do_get "/deployit/security/permission/#{permission}/#{role}/#{id}"
    '<boolean>true</boolean>' == doc.elements['//boolean'].to_s	
  end

  def do_create(permission, role, id)
    communicator.do_put "/deployit/security/permission/#{permission}/#{role}/#{id}"
  end
  
  def delete(permission, role, id)
    communicator.do_delete "/deployit/security/permission/#{permission}/#{role}/#{id}"
  end

end


