#===============================================================================
# UI module
#===============================================================================
module UIHandlers
  @@handlers = {}

  def self.add(ui, option, hash)
    @@handlers[ui] = HandlerHash.new if !@@handlers.has_key?(ui)
    @@handlers[ui].add(option, hash)
  end

  def self.remove(ui, option)
    @@handlers[ui]&.remove(option)
  end

  def self.clear(ui)
    @@handlers[ui]&.clear
  end

  def self.each(ui)
    return if !@@handlers.has_key?(ui)
    @@handlers[ui].each { |option, hash| yield option, hash }
  end

  def self.each_available(ui, *args)
    return if !@@handlers.has_key?(ui)
    options = @@handlers[ui]
    keys = options.keys
    sorted_keys = keys.sort_by { |option| options[option]["order"] || keys.index(option) }
    sorted_keys.each do |option|
      hash = options[option]
      if hash["plugin"]
        next if PluginManager.installed?(hash["plugin"][0]) && !hash["plugin"][1]
        next if !PluginManager.installed?(hash["plugin"][0]) && hash["plugin"][1]
      end
      next if hash["condition"] && !hash["condition"].call(*args)
      if hash["name"].is_a?(Proc)
        name = hash["name"].call
      else
        name = _INTL(hash["name"])
      end
      icon = _INTL(hash["suffix"])
      menu = hash["options"] || []
      yield option, hash, name, icon, menu
    end
  end

  def self.call(menu, option, function, *args)
    option_hash = @@handlers[menu][option]
    return nil if !option_hash || !option_hash[function]
    return option_hash[function].call(*args)
  end
  
  def self.get_info(menu, option, type = nil)
    option_hash = @@handlers[menu][option]
    return nil if !option_hash
    case type
    when :name    then return _INTL(option_hash["name"])
    when :suffix  then return _INTL(option_hash["suffix"])
    when :options then return option_hash["options"] || []
    end
    return _INTL(option_hash["name"]), _INTL(option_hash["suffix"]), option_hash["options"]
  end
end