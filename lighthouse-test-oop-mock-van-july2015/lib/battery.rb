class Battery < Item

  def initialize
    super("Battery", 25)
  end

  def heal(robot)
    robot.shield = 50
  end
  


end
