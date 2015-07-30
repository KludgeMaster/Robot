class Robot
  class CanOnlyAttackRobotError < StandardError; end
  class DeadAlreadyError < StandardError; end
  class NoEnemyAroundError < StandardError; end

  MAX_WEIGHT = 250

  attr_accessor :position, :items, :health, :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)
    @items << item if items_weight + item.weight <= MAX_WEIGHT
    @equipped_weapon = item if item.is_a? Weapon
    # binding.pry
    if item.is_a? BoxOfBolts 
    
      if health <= 80
        item.feed(self) # this doesn't work!!!!
      else
        @items << item
      end
    end
  end

  def items_weight
    total_weight = 0
    @items.each do |item|
      total_weight += item.weight
    end
    total_weight
    # @items.inject(0) do |total_weight, item|
    #   total_weight + item.weight
    # end
  end

  def wound(dmg)
    @health -= dmg if @health > 0 
    @health = 0 if @health < 0
  end

  def heal(patch)
    @health += patch if @health < 100
  end

  def heal!(patch)
    
    if @health <= 0 
      raise DeadAlreadyError, "You are already dead!!"
    else
      @health += patch
    end
  end

  def attack(enemy)
    unless enemy.is_a? Robot 
      raise CanOnlyAttackRobotError, "You can't attack anything other than a robot!!"
    else
      if within_reach?(enemy)
        if @equipped_weapon
          @equipped_weapon.hit(enemy)
          if @equipped_weapon.is_a? Grenade
            @equipped_weapon = nil
          end
        else
          enemy.wound(5)
        end
      else
        # raise NoEnemyAroundError, "No enemy is found near you!!"
      end 
    end
  end


  # def attack(enemy)
  #   if enemy.is_a? Robot 

  #     if nearby_1?(enemy)
  #       if @equipped_weapon
  #         @equipped_weapon.hit(enemy)
  #       else
  #         enemy.wound(5)
  #       end
  #     else
  #       # raise NoEnemyAroundError, "No enemy is found near you!!"
  #     end
  #   else
  #     raise CanOnlyAttackRobotError, "You can't attack anything other than a robot!!"
  #   end
  # end

  private
  # def capacity
  #   items_weight < 250
  # end
  def within_reach?(enemy)
    ((@position[0] - enemy.position[0]).abs <= @equipped_weapon.range && (@position[1] == enemy.position[1])) || ((@position[1] - enemy.position[1]).abs <= @equipped_weapon.range && (@position[0] == enemy.position[0]))
  end
      
  # def nearby_1?(enemy)
  #   ((@position[0] - enemy.position[0]).abs == 1 && (@position[1] == enemy.position[1])) || ((@position[1] - enemy.position[1]).abs == 1 && (@position[0] == enemy.position[0]))
  # end

  # def nearby_2?(enemy)
  #   ((@position[0] - enemy.position[0]).abs <=2  && (@position[1] == enemy.position[1])) || ((@position[1] - enemy.position[1]).abs <= 2 && (@position[0] == enemy.position[0]))
  # end
end
