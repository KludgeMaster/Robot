class Nuke < Weapon

  def initialize
    super("Nuke", 200, 200)
  end

  def hit(robot)
    super(robot)
    neighbors = robot.scan
    # binding.pry
    neighbors.each do |robot|
      super(robot)
    end
  end

end
