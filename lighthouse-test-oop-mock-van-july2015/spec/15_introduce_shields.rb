
require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @battery = Battery.new
  end

  it "should use shield first before health drops" do
    @robot.wound(20)
    expect(@robot.health).to eq(100)
    expect(@robot.shield).to eq(30)
  end

  it "if damage is big, use shield first and then health" do
    @robot.wound(120)
    expect(@robot.health).to eq(30)
    expect(@robot.shield).to eq(0)
  end

  it "if battery is consumed, it should restore shield to 50" do
    @robot.wound(120)
    @battery.heal(@robot)
    expect(@robot.health).to eq(30)
    expect(@robot.shield).to eq(50) 
  end    
end




