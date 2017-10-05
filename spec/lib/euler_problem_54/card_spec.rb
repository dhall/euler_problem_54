require 'spec_helper.rb'

module EulerProblem54
  RSpec.describe Card do
    it 'can not be instantiated without value and suit' do
      expect{Card.new}.to raise_error(ArgumentError)
    end

    it 'can be instantiated' do
      expect(Card.new('2','D')).to be_a(Card)
    end
  end
end
