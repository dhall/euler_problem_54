module EulerProblem54
  class Tournament
    require 'byebug'
    attr_reader :players
    def initialize
      @players = [Player.new('player 1'), Player.new('player 2')]
    end

    def play
      File.open(File.join(__dir__,'poker.txt'),'r').each do |line|
        card_values = line.chomp.split
        @players[0].hands << build_hand(card_values[0..4])
        @players[1].hands << build_hand(card_values[5..9])
      end
    end

    def build_hand(value_pairs)
      cards = value_pairs.map{|values| Card.new(values[0],values[1])}
      hand = PokerHand.new(*cards)
    end
  end
end
