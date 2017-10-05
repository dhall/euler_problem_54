module EulerProblem54
  class Player
    attr_accessor :wins, :hands
    attr_reader :name
    def initialize(name)
      @name = name
      @hands = []
    end
  end
end
