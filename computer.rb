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
      foo = compare_guess(@ai_guess, @hint, @input)
      puts "Computer hints: #{foo.to_s}"
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
    @sequences.each do |elem| 
      #@scrap = @ai_guess
      @test_hint.push(compare_guess(elem, @hint, @ai_guess)) #@scrap instead of @ai_guess
    end
  end

  def compare_hint_arrays
    # code
  end

  # Lets the user control when computer guesses
  def continue_guess
    print "Press any key\n"
    STDIN.getch
    print "                 \n"
  end
end
