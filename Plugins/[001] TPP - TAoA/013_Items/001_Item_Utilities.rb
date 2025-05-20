def pbLowerEV(pkmn, scene, stat, qty, messages)
  if pkmn.ev[stat] > 0
    pkmn.ev[stat] = 0
    pkmn.calc_stats
  end
  scene.pbRefresh
  return true
end