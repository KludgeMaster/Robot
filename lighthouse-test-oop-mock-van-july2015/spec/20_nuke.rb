
require_relative 'spec_helper'

describe Nuke do

 describe "#hit" do
    before :each do
      @robot1 = Robot.new
      @robot2 = Robot.new
      @robot3 = Robot.new
      @robot4 = Robot.new
      @robot5 = Robot.new
      @nuke = Nuke.new
    end
    
    it "when nuke is used, it should damage neighbors of the enemy" do
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

      @nuke.hit(@robot1) # drop a nuke on robot1
      
      # it should kill robot1 and neighbors (robot2 and 5)
      expect(@robot1.health).to eq(0)
      expect(@robot2.health).to eq(0)
      expect(@robot5.health).to eq(0)

      #the other guys should be okay
      expect(@robot3.health).to eq(100)
      expect(@robot4.health).to eq(100)
      
    end
  end
end



