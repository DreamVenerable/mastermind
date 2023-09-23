require_relative 'mastermind.rb'
require 'io/console'

class Computer
  include PlayerChoice
  include StartGame
  include Stop
  include Compare

  def initialize
    @sequences = [*1..6].repeated_permutation(4).to_a
    @sequences.delete_if { |element| element == [1, 1, 2, 2] }.unshift([1, 1, 2, 2])
    @hint = []
    choice
    game
  end
  
  def round
    unless stop?
      continue_guess
      ai_choice
      puts "Computer guessed #{ai_choice}"
      p ai_choice
      compare_guess_with_code(ai_choice, @hint)
      ai_algorithm
      sleep 0.5
      puts "Computer hints: #{@hint.to_s}"
      @hint = []
    end
  end

  def ai_choice
    @ai_code = @sequences.first
  end

  def ai_algorithm
    test_hint = []
    @sequences.keep_if do |elem|
      elem.each_index do |i|
        if ai_choice[i] - elem[i] == 0
          test_hint.push('R')
        elsif ai_choice.any?(elem[i])
          test_hint.unshift('W')
        end
      end
      test_hint == @hint
    end
    p @sequences
  end

  def continue_guess
    print "Press any key\n"
    STDIN.getch
    print "                 \n"
  end
end