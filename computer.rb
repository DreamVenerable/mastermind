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
    @test_hint = []
    @scrap = []
    choice
    game
  end
  
  def round
    unless stop?
      continue_guess
      ai_choice
      puts "Computer guessed #{@ai_guess}"
      compare_guess(@ai_guess, @hint, @input)
      puts "Computer hints: #{@hint.to_s}"
      ai_algorithm
      sleep 0.5
      @hint = []
    end
  end

  def ai_choice
    @ai_guess = @sequences.first
  end

  # Swaszek algorithm
  def ai_algorithm
    unless stop?
      @sequences.keep_if do |elem| 
        @scrap = @ai_guess
        @test_hint = []
        compare_guess(elem, @test_hint, @scrap) == @hint
      end
    end
  end

  def compare_test(elem, arr, scrap)
    elem.each_index do |i|
      correct_place(i, arr, scrap) if scrap[i] - elem[i] == 0
    end

    similiar = elem & scrap
    similiar.count.times { |ele| arr.push('W') }
    arr
  end

  # Lets the user control when computer guesses
  def continue_guess
    print "Press any key\n"
    STDIN.getch
    print "                 \n"
  end
end
