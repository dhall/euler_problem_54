require 'spec_helper'

module EulerProblem54
  RSpec.describe 'Player' do
    it 'can be instantiated' do
      expect(Player.new).to be_a(Player)
    end
  end
end
