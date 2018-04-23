
class Player
  # actually a goal to walk forwards
  @move_forwards = false
  @rest_in_safety = false
  
  def needs_healing?(health)
    health < 10
  end
  
  def walk_in_direction(warrior, backward)
    if backward == true
      warrior.walk!(:backward)
    else
      warrior.walk!
    end
  end
  
  def play_turn(warrior)
    @health = warrior.health
      
    if !@move_forwards
      if warrior.feel(:backward).empty?
        walk_in_direction(warrior, true)
      elsif warrior.feel(:backward).captive?
        warrior.rescue!(:backward)
      elsif warrior.feel(:backward).wall?
        @move_forwards = true
      end
    elsif @move_forwards == true
      if @in_safety && needs_healing?(warrior.health)
        @move_forwards = false
         warrior.rest!
      elsif warrior.feel.empty?
        walk_in_direction(warrior, false)
      elsif warrior.feel.captive?
        warrior.rescue!
      else 
        warrior.attack!
      end
    end
  
    @in_safety = warrior.health < @health ? false : true 
    @move_forwards = false if needs_healing?(warrior.health) && !@in_safety
  end
end
  