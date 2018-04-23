
class Player
  @move_forwards = false
  
  def needs_healing?(health)
    health < 10
  end
  
  def full_health?(health)
    health == 20
  end
  
  def walk_in_direction(warrior, backward)
    if backward == true
      warrior.walk!(:backward)
    else
      warrior.walk!
    end
  end
  
  def play_turn(warrior)
    @in_safety = warrior.health >= @last_health 
    @move_forwards = false if needs_healing?(warrior.health) && !@in_safety
    
    if @in_safety && !full_health?(warrior.health)
      warrior.rest!
    elsif @move_forwards == false
      if warrior.feel(:backward).empty?
        walk_in_direction(warrior, true)
      elsif warrior.feel(:backward).captive?
        warrior.rescue!(:backward)
      elsif warrior.feel(:backward).wall?
        @move_forwards = true
      end
    elsif @move_forwards == true
      if warrior.feel.empty?
        walk_in_direction(warrior, false)
      elsif warrior.feel.captive?
        warrior.rescue!
      else 
        warrior.attack!
      end
    end
  
    @last_health = warrior.health
  end
end
  