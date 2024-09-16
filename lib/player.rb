# frozen_string_literal: true

module Game
  # Represents a user player in the game.
  class Player
    # @return [String] the name of the player.
    # @return [Integer] the score of the player.
    attr_reader :name, :score

    # Initializes a new Player.
    #
    # @param [String] name the name of the player.
    def initialize(name) @name = name
     
      @score = 0
    end

    # Increments the player's score by 1.
    #
    # @return [Integer] the new score.
    def increment_score
      @score += 1
    end
  end
end
