# Represents the playing area where cards are dealt.

module Game
  class Board
    def initialize
      @found_sets = []
      @sets = []
    end

    # Keep track of valid sets found
    #
    # @param set [Array<Card>] The found set.
    # @return [Array<Array<Card>>] The list of sets found by player.
    def track_found_sets(set)
      @found_sets << set
      put "#{@found_sets.size} sets found!"
    end
  end
end
