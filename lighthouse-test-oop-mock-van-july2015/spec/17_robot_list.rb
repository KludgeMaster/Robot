
require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot1 = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
  end

  it "should keep track of all instances of Robot class" do
    expect(Robot.robot_list).to eq([@robot1, @robot2, @robot3])
  end

end
#   it "should use shield first before health drops" do
#     @robot.wound(20)
#     expect(@robot.health).to eq(100)
#     expect(@robot.shield).to eq(30)
#   end

#   it "if damage is big, use shield first and then health" do
#     @robot.wound(120)
#     expect(@robot.health).to eq(30)
#     expect(@robot.shield).to eq(0)
#   end

#   it "if battery is consumed, it should restore shield to 50" do
#     @robot.wound(120)
#     @battery.heal(@robot)
#     expect(@robot.health).to eq(30)
#     expect(@robot.shield).to eq(50) 
#   end    
# end



# robot1 = Robot.new
# robot2 = Robot.new

# puts Robot.robot_list.inspect
# puts Robot.in_position(0,0)
