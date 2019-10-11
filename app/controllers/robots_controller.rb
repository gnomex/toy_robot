class RobotsController < ApplicationController
  include ToyRobot

  def index
  end

  def create
    commands = params[:cmd][:commands]

    robot = ToyRobot::Rover.new([commands])
    robot.go!

    render json: { steps: robot.show_the_path }
  end
end
