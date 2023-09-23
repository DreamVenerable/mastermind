require_relative 'mastermind.rb'

class Player
  include PlayerChoice
  include StartGame
  include Stop
  include Compare

  def initialize
    @sequences = [*1..6].repeated_permutation(4).to_a
    @ai_code = [1,2,2,2]#@sequences.sample
    @hint = []
    game
  end

  def round
    unless stop?
      @hint = []
      sleep 0.5
      puts "Guesses remaining #{@max_rounds}"
      choice
      p "#{@ai_code}"
      compare_guess(@ai_code)
      sleep 0.5
      puts "Your hint: #{@hint.to_s}"
    end
  end
end