#!ruby

require_relative 'rover'
require 'optparse'

$options = {commands: []}

OptionParser.new do |opts|
	opts.banner = "Toy robot cli: cli.rb [options]"
  
  opts.on("-f", "--file=file", "Load commands from file") do |file|
    $options[:commands] =  []
    File.readlines(file).each do |line|
      $options[:commands] << line.strip
    end
  end

  opts.on("-c", "--commands=commands", "Give commands as STRING with pipe | separated") do |commands|
    $options[:commands] = commands.split('|')
  end
end.parse!

robot = ToyRobot::Rover.new($options[:commands])
robot.go!