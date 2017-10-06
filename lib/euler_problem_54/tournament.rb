module EulerProblem54
  class Tournament
    require 'byebug'
    attr_reader :player_1, :player_2
    def initialize
      @player_1, @player_2 = Player.new('Frank'), Player.new('Jim')
      setup_player_hands
    end

    def setup_player_hands
      File.open(File.join(__dir__,'poker.txt'),'r').each do |line|
        card_values = line.chomp.split
        player_1.hands << build_hand(card_values[0..4])
        player_2.hands << build_hand(card_values[5..9])
      end
    end

    def play
      player_1.hands.each_with_index do |index,hand_1|
        hand_2 = player_2.hands[index]
        if hand_1.rank > hand_2.rank
          player_1.add_win
        elsif hand_1.rank < hand_2.rank
          player_2.add_win
        else #tie
          if hand_1.high_card.value > hand_2.high_card.value
            player_1.add_win
          else
            player_2.add_win
          end
        end
      end
      {player_1:player_1.wins,player_2:player_2.wins}
    end


    def build_hand(value_pairs)
      cards = value_pairs.map{|values| Card.new(values[0],values[1])}
      hand = PokerHand.new(*cards)
    end
  end
end
