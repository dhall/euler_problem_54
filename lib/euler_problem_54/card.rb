module EulerProblem54
  class Card
    VALID_VALUES = %w(2 3 4 5 6 7 8 9 T J Q K A)
    VALID_SUITS = %w(D H C S)
    attr_reader :face_value, :suit

    def initialize(face_value,suit)
      @face_value = set_value face_value
      @suit = set_suit suit
    end

    def value
      VALID_VALUES.index face_value
    end

  private

    def set_value(face_value)
      unless VALID_VALUES.include? face_value
        raise("invalid face value, must be one of #{VALID_VALUES}")
      end
      @face_value = face_value
    end

    def set_suit(suit)
      unless VALID_SUITS.include? suit
        raise("invalid suit, must be one of #{VALID_SUITS}")
      end
      @suit = suit
    end

  end
end
