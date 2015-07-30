class Robot
  # class CanOnlyAttackRobotError < StandardError; end
  # class DeadAlreadyError < StandardError; end
  
  
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
      @items << item if capacity
      @equipped_weapon = item if item.is_a? Weapon
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
    if enemy.is_a? Robot
      if @equipped_weapon
        @equipped_weapon.hit(enemy)
      else
        enemy.wound(5)
      end
    else
      raise CanOnlyAttackRobotError, "You can't attack anything other than a robot!!"
    end
  end

  private
  def capacity
    items_weight < 250
  end

  
end
