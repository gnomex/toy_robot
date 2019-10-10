require 'rails_helper'

RSpec.describe ToyRobot do
  describe ToyRobot::Rover, 'place command' do
    it 'be placed on the table' do
      bb8 = ToyRobot::Rover.new(["PLACE 1,2,SOUTH", "REPORT"])

      expect {bb8}.to output("1,2,SOUTH").to_stdout
      expect(bb8.is_on_the_table?).to be_truthy
    end
  end
end
