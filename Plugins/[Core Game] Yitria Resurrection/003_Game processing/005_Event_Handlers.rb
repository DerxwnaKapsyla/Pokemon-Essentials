#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
# * Changes addIf to check handlers in reverse order (last-in, first-checked).
#   This allows custom handlers defined later to override base Essentials 
#   handlers without needing to manually erase them.
#   Necessary for custom Poké Ball behavior and other item handler overrides.
#==============================================================================#

class HandlerHash2

  def [](sym)
    sym = sym.id if !sym.is_a?(Symbol) && sym.respond_to?("id")
    return @hash[sym] if sym && @hash[sym]
    @add_ifs.reverse.each do |add_if|
      return add_if[1] if add_if[0].call(sym)
    end
    return nil
  end
  
end