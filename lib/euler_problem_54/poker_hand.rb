module EulerProblem54
  class PokerHand
    attr_reader :cards
    def initialize(card_1,card_2,card_3,card_4,card_5)
      @cards = [card_1,card_2,card_3,card_4,card_5]
    end

    def value
      @value ||= @cards.map(&:value).reduce(:+)
    end

    def find_matches
      @find_matches ||= @cards.group_by(&:face_value).select{|_k,group| group.size > 1}
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
      sorted_cards.last.value - sorted_cards.first.value == 4
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