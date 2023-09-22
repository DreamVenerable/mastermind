require_relative 'mastermind.rb'

class Computer
  include PlayerChoice
  include StartGame
  include Stop
  include Compare

  def initialize
    @sequences = [*1..6].repeated_permutation(4).to_a
    choice
    game
  end

  def round
    @ai_code = [1, 1, 2, 2]
    compare_guess_with_code
  end

end