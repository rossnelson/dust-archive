class Map

  attr_accessor :address, :width, :height, :content

  def initialize(options={})
    @address = options[:address] ||= "Lalana Ramboatiana, Antananarivo, Madagascar"
    @width   = options[:width] ||= 400
    @height  = options[:height] ||= 400
    @content = options[:content]||= "Madagascar Royal Palace"
  end
  
  def self.find(map_name)
    maps = Hashie::Mash.new(YAML.load(File.read("#{Rails.root}/config/maps.yml")))
    map_options = maps[map_name] ||= {}
    return Map.new map_options
  end

end