
require_relative 'spec_helper'

describe Robot do

 describe "#scan" do
    before :each do
      @robot1 = Robot.new
      @robot2 = Robot.new
      @robot3 = Robot.new
      @robot4 = Robot.new
      @robot5 = Robot.new
    end
    
    it "should return list of robots immediately facing with" do
      # @robot2 at (1,0)
      @robot2.move_up
      # @robot3 at (-2,0)
      @robot3.move_down
      @robot3.move_down
      # @robot4 at (1,-1)
      @robot4.move_up
      @robot4.move_left
      # @robot5 at (0,1)
      @robot5.move_right

      expect(@robot1.scan).to include(@robot5, @robot2)
      expect(@robot1.scan.length).to eq(2)
    end
  end
end



