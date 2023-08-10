class PokemonGlobalMetadata
  def recipes
    @recipes = [] unless @recipes
    return @recipes
  end
end

def pbUnlockRecipe(recipe_id)
  $PokemonGlobal.recipes.push(recipe_id)
  $PokemonGlobal.recipes.uniq!
end

def pbLockRecipe(recipe_id)
  return unless $PokemonGlobal.recipes.include?(recipe_id)
  $PokemonGlobal.recipes.delete(recipe_id)
end

def pbGetRecipes(flag=nil)
  if flag
    return GameData::Recipe::DATA.select {|_k,r| r.has_flag?(flag) }.keys
  end
  return GameData::Recipe.keys
end