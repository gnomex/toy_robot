class RobotsController < ApplicationController
  include ToyRobot

  def index
  end

  def create
    commands = params[:cmd] #[:commands]

    logger.info "received #{commands.class} params are #{commands}"

    robot = ToyRobot::Rover.new(commands.split("|"))
    robot.go!

    render json: { steps: robot.show_the_path }
  end
end
