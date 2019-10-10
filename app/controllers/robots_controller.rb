class RobotsController < ApplicationController
  include ToyRobot

  def index
    @robot = ToyRobot::Rover.new(["PLACE 1,1,EAST"])
    @robot.go!
  end
end
