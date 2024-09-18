# frozen_string_literal: true

# The Game module contains the classes and methods for playing the game.
#
# @see SetGame
module Game
  # The initial size of the game board.
  #
  # @return [Integer]
  START_SIZE = 12
  MAX_SETS = 27

  # Executes the action associated with the given choice.
  #
  # @param actions [Hash] The hash mapping choices to actions.
  # @param choice [String] The user's choice.
  # @return [Boolean] True if the action was successfully performed, false otherwise.
  def self.perform_action(actions, choice)
    if actions[choice]
      actions[choice].call
      true
    else
      puts "#{choice} is not a valid option. Please try again."
      false
    end
  end
end
