class RobotsController < ApplicationController
  include ToyRobot

  def index
  end

  def create

    logger.info "@@@@@@ PARAMS: #{params.inspect}"

    robot = ToyRobot::Rover.new([])
    robot.go!

    respond_to do |format|
  		format.json { render json: robot.show_the_path }
    end
  end
end
