
require_relative 'spec_helper'

describe Robot do

 describe "#in_position" do
    before :each do
      @robot1 = Robot.new
      @robot2 = Robot.new
      @robot3 = Robot.new
    end
    
    it "should return all robots in postion x, y" do
      @robot3.move_up
      expect(Robot.in_position(0,0)).to eq([@robot1, @robot2])
    end
  end
end



