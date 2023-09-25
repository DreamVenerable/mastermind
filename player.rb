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
      @hint = []
      sleep 0.5
      puts "Guesses remaining #{@max_rounds}"
      choice
      compare_guess(@ai_code.dup, @hint, @input.dup)
      sleep 0.5
      puts "Your hint: #{@hint.to_s}"
    end
  end

  def compare_guess(code, arr, guess)
    # Right number & right placement hint
    code.each_index { |i| correct_place(i, arr, code) if guess[i] - code[i] == 0 }

    # Right number but wrong placement
    similiar = (code & guess).flat_map { |n| [n]*[guess.count(n), code.count(n)].min }
    similiar.count.times { |ele| arr.push('W') }
    return arr
  end

  def correct_place(i, arr, code)
    arr.push('R')
    code[i] = 0
  end
end