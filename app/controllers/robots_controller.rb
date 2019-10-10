class RobotsController < ApplicationController
  include ToyRobot

  def index
  end

  def create
    # robot = ToyRobot::Rover.new([])
    # robot.go!

    # @backtracking = robot.history
  end
end
