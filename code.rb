
class Player
    @wall_behind = nil
    
    def empty_action(warrior, backward)
        if warrior.health < 20 && warrior.health >= @health
          warrior.rest!
        else
          warrior.walk!(:backward)
        end
    end
    
    def play_turn(warrior)
      # cool code goes here
      unless @wall_behind
        if warrior.feel(:backward).empty?
          empty_action(warrior, true)
        elsif warrior.feel(:backward).captive?
          warrior.rescue!(:backward)
        elsif !warrior.feel(:backward).wall?
          @wall_behind = true;
        end
      else
        if warrior.feel.empty?
          empty_action(warrior, false)
        elsif warrior.feel.captive?
          warrior.rescue!
        else 
          warrior.attack!
        end
      end
      @health = warrior.health
    end
  end
    