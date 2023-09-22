require_relative 'mastermind.rb'

class Player
  include PlayerChoice
  include StartGame
  include Stop
  include Compare

  def initialize
    @sequences = [*1..6].repeated_permutation(4).to_a
    @ai_code = @sequences.sample
    @hint = []
    game
  end

  def round
    unless stop?
      sleep 0.5
      puts "Guesses remaining #{@max_rounds}"
      choice
      compare_guess_with_code
      sleep 0.5
      puts "Your hint: #{@hint.to_s}"
      @hint = []
    end
  end
end