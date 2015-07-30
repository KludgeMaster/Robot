require_relative 'spec_helper'

describe Robot do
  before :each do
    @irobot = Robot.new
  end

  it "should run fine" do
    irobot = Robot.new
    irobot.health = -20

    expect{irobot.heal!(200)}.to raise_error(Robot::DeadAlreadyError, "You are already dead!!")

    irobot2 = Robot.new
    hammer = Weapon.new("hammer",20,10)

    expect{irobot2.attack(hammer)}.to raise_error
  end
  
end
