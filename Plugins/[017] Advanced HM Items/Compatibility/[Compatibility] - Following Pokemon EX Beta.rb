#This is need if AdvancedItemsFieldMoves is load after Following Pokemon EX
if PluginManager.installed?("Following Pokemon EX")

  class Game_Player
    alias_method :update_move_with_follower, :update_move unless method_defined?(:update_move_with_follower)
    def update_move
      update_move_with_follower
      FollowingPkmn.unhide_follower(false) if !moving?
    end
  end

  class Scene_Map
    alias __followingpkmn__update update unless method_defined?(:__followingpkmn__update)
    def update(*args)
      __followingpkmn__update(*args)
      t_key = FollowingPkmn::TOGGLE_FOLLOWER_KEY
      if t_key && FollowingPkmn.can_check? && Input.trigger?(t_key)
        FollowingPkmn.toggle
      end

      # Quick party cycling with W/S/A keys
      if FollowingPkmn.can_check? && $player && $player.party.length >= 2
        if !$game_temp.in_battle && !$game_temp.in_menu && !$game_player.moving?
          # S key - Rotate party forward (first Pokemon goes to end)
          forward_key = FollowingPkmn::CYCLE_PARTY_FORWARD_KEY
          if forward_key && Input.trigger?(forward_key)
            first_pkmn = $player.party.shift
            $player.party.push(first_pkmn)
            pbSEPlay("GUI party switch") rescue pbSEPlay("Choose")
            FollowingPkmn.refresh(true) if defined?(FollowingPkmn)
          end

          # W key - Rotate party backward (last Pokemon goes to first)
          backward_key = FollowingPkmn::CYCLE_PARTY_BACKWARD_KEY
          if backward_key && Input.trigger?(backward_key)
            last_pkmn = $player.party.pop
            $player.party.unshift(last_pkmn)
            pbSEPlay("GUI party switch") rescue pbSEPlay("Choose")
            FollowingPkmn.refresh(true) if defined?(FollowingPkmn)
          end
        end
      end

      if $PokemonGlobal.call_refresh[0]
        FollowingPkmn.refresh($PokemonGlobal.call_refresh[1])
        $PokemonGlobal.call_refresh = false
      end
    end
  end
end
