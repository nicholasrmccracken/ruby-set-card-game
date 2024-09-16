# frozen_string_literal: true

module Game
  # Abstract class for a player in the game.
  class AbstractPlayer
    # Makes a move in the game.
    # @raise [NotImplementedError] if the method is not implemented
    def make_move
      raise NotImplementedError, 'Make move method must be implemented'
    end
  end

  # Represents a user player in the game.
  class UserPlayer < AbstractPlayer
    # @return [String] the name of the user player
    attr_reader :name

    # Initializes a new user player.
    # @param [String] name the name of the user player
    def initialize(name)
      super
      @name = name
    end

    # Makes a move in the game.
    def make_move
    end
  end

  # Represents an AI player in the game.
  class AIPlayer < AbstractPlayer
    @count = 1

    # @return [String] the name of the AI player
    attr_reader :name

    # Initializes a new AI player.
    def initialize
      super
      @name = "AI #{self.class.count}"
      self.class.increment_count
    end

    # Makes a move in the game.
    def make_move
    end

    class << self
      # @return [Integer] the count of AI players
      attr_reader :count

      # Increments the count of AI players.
      def self.increment_count
        @count += 1
      end
    end
  end
end
