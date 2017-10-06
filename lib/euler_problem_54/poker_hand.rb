module EulerProblem54
  class PokerHand

    attr_reader :cards
    def initialize(card_1,card_2,card_3,card_4,card_5)
      @cards = [card_1,card_2,card_3,card_4,card_5]
    end

    def find_matches
      @find_matches ||= @cards.group_by(&:face_value).select{|_k,group| group.size > 1}
    end

    def find_non_matches
      @find_non_matches ||= @cards.group_by(&:face_value).select{|_k,group| group.size == 1}
    end

    def rank
      case
      when royal_flush?
        9
      when straight_flush?
        8
      when four_of_a_kind?
        7
      when full_house?
        sorted_matches = find_matches.sort_by{|_k,group|group.size}
        three_of_a_kind_value = sorted_matches.last[1][0].value
        6.0 + (three_of_a_kind_value)/100.0
      when flush?
        5
      when straight?
        4
      when three_of_a_kind?
        match_value = find_matches.values.flatten.first.value
        3.0 + (match_value)/100.0
      when two_pairs?
        sorted_matches = find_matches.sort_by{|key,_g|Card::VALID_VALUES.index(key)}
        high_pair_value = sorted_matches.last[1][0].value
        low_pair_value = sorted_matches.first[1][0].value
        2.0 + (high_pair_value)/100.0 + (low_pair_value)/10_000.0
      when one_pair?
        pair_value = find_matches.values.flatten.first.value
        1.0 + (pair_value)/100.0
      else
        0
      end
    end

    def unpaired_high_card
      find_non_matches.sort_by{|key,_g|Card::VALID_VALUES.index(key)}.last[1][0]
    end

    # High Card: Highest value card.
    def high_card
      sorted_cards.last
    end

    # One Pair: Two cards of the same value.
    def one_pair?
      find_matches.any?{|_k,group|group.size >= 2}
    end

    # Two Pairs: Two different pairs.
    def two_pairs?
      find_matches.size == 2 && find_matches.all?{|_k,group|group.size >= 2}
    end

    # Three of a Kind: Three cards of the same value.
    def three_of_a_kind?
      find_matches.any?{|_k,group|group.size == 3}
    end

    # Straight: All cards are consecutive values.
    def straight?
      !one_pair? && sorted_cards.last.value - sorted_cards.first.value == 4
    end

    # Flush: All cards of the same suit.
    def flush?
      @cards.map(&:suit).uniq.size == 1
    end

    # Full House: Three of a kind and a pair.
    def full_house?
      find_matches.size == 2 && find_matches.any?{|_k,group|group.size == 3}
    end

    # Four of a Kind: Four cards of the same value.
    def four_of_a_kind?
      find_matches.any?{|_k,group|group.size == 4}
    end

    # Straight Flush: All cards are consecutive values of same suit.
    def straight_flush?
      straight? && flush?
    end

    # Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
    def royal_flush?
      straight_flush? && sorted_cards.last.face_value == 'A'
    end

  private
    def sorted_cards
      @sorted_cards ||= @cards.sort_by(&:value)
    end

  end
end
