class Robot
  class CanOnlyAttackRobotError < StandardError; end
  class DeadAlreadyError < StandardError; end
  class NoEnemyAroundError < StandardError; end

  MAX_WEIGHT = 250
  @@robot_list = []
  attr_reader :position, :items, :health, :equipped_weapon
  attr_accessor :shield

#---------- Class method---------------------------------

  def self.robot_list 
    @@robot_list
  end

  def self.in_position(x,y)
    robots = []
    @@robot_list.each do |robot|
      robots << robot if robot.position == [x,y]
    end
    robots
  end

#---------- Instance method------------------------------

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @shield = 50
    @@robot_list  << self
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
    @items << item if items_weight + item.weight <= MAX_WEIGHT # pick up item if there is enough room
    @equipped_weapon = item if item.is_a? Weapon #if weapon, equip it
    # binding.pry
    if item.is_a? BoxOfBolts 
    
      if health <= 80
        item.feed(self) 
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
    # binding.pry
    if shield >= dmg    # break shield first before reducing shield
      @shield -= dmg
    else
      @health -= dmg - shield #if @health > 0 
      @health = 0 if @health < 0
      @shield = 0
    end
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
      if within_reach?(enemy)  # check if target is within the reach of currently equipped weapon
        if @equipped_weapon
          @equipped_weapon.hit(enemy)
          if @equipped_weapon.is_a? Grenade  #Grenade is one-time use only
            @equipped_weapon = nil
          end
        else
          enemy.wound(5)  # by default, robot can deliver 5 dmg
        end
      else
        # raise NoEnemyAroundError, "No enemy is found near you!!"  # this needs to be uncomment
      end 
    end
  end

  def scan # ugly way,
    robot_in_sight = []
    # binding.pry
    robot_in_sight += self.class.in_position(@position[0]+1,@position[1])
    robot_in_sight += self.class.in_position(@position[0]-1,@position[1])
    robot_in_sight += self.class.in_position(@position[0],@position[1]+1) 
    robot_in_sight += self.class.in_position(@position[0],@position[1]-1)
    robot_in_sight
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
  def within_reach?(enemy)  # returns true if enemy is within the reach of currently equipped weapon
    ((@position[0] - enemy.position[0]).abs <= @equipped_weapon.range && (@position[1] == enemy.position[1])) || ((@position[1] - enemy.position[1]).abs <= @equipped_weapon.range && (@position[0] == enemy.position[0]))
  end
      
  # def nearby_1?(enemy)
  #   ((@position[0] - enemy.position[0]).abs == 1 && (@position[1] == enemy.position[1])) || ((@position[1] - enemy.position[1]).abs == 1 && (@position[0] == enemy.position[0]))
  # end

  # def nearby_2?(enemy)
  #   ((@position[0] - enemy.position[0]).abs <=2  && (@position[1] == enemy.position[1])) || ((@position[1] - enemy.position[1]).abs <= 2 && (@position[0] == enemy.position[0]))
  # end
end
