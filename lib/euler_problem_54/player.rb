module EulerProblem54
  class Player
    attr_accessor :wins, :hands
    def initialize
      @hands = []
      @wins = 0
    end

    def add_win
      @wins += 1
    end
  end
end
