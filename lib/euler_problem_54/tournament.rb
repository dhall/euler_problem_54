module EulerProblem54
  class Tournament
    require 'byebug'
    attr_reader :player_1, :player_2
    def initialize
      @player_1, @player_2 = Player.new, Player.new
    end

    def setup_player_hands_from_file
      File.open(File.join(__dir__,'poker.txt'),'r').each do |line|
        card_values = line.chomp.split
        player_1.hands << build_hand(card_values[0..4])
        player_2.hands << build_hand(card_values[5..9])
      end
    end

    def play
      player_1.hands.each_with_index do |hand_1,index|
        hand_2 = player_2.hands[index]
        battle(hand_1, hand_2) == :one ? player_1.add_win : player_2.add_win
      end
      {player_1:player_1.wins,player_2:player_2.wins}
    end

    def battle(hand_1,hand_2)
      winner = nil
      if hand_1.rank > hand_2.rank
        winner = :one
      elsif hand_1.rank < hand_2.rank
        winner = :two
      else #tie -- settled by overall high card when 5,4,0 (can't occur for 9,8,7,6,3)
        if [5,4,0].include?(hand_1.rank.to_i)
          tie_breaker_card_1 = hand_1.high_card.value
          tie_breaker_card_2 = hand_2.high_card.value
        else # 2, 1 -- settled by unpaired high card
          tie_breaker_card_1 = hand_1.unpaired_high_card.value
          tie_breaker_card_2 = hand_2.unpaired_high_card.value
        end
        if tie_breaker_card_1 > tie_breaker_card_2
          winner = :one
        elsif tie_breaker_card_1 < tie_breaker_card_2
          winner = :two
        end
      end
      raise unless winner
      winner
    end

    def build_hand(value_pairs)
      cards = value_pairs.map{|values| Card.new(values[0],values[1])}
      hand = PokerHand.new(*cards)
    end
  end
end
