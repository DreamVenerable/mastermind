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
      @hint = []
      #continue_guess # Uncomment to control guesses
      ai_choice
      puts "Computer guessed #{@ai_guess}"
      compare_guess(@ai_guess, @hint, @input.dup)
      puts "Computer hints: #{@hint.to_s}"
      ai_algorithm
      sleep 0.5
    end
  end

  def ai_choice
    @ai_guess = @sequences.first
  end

  # Swaszek algorithm
  def ai_algorithm
    @bar = []
    @sequences.each_with_index do |element, i|
      @test_hint = []
      @bar.push(compare_guess(@ai_guess.dup, @test_hint, element.dup))
    end

    indexes = @bar.filter_map.with_index { |ele, i| ele == @hint ? i : nil }

    @sequences.replace(@sequences.values_at(*indexes))
  end

  # Lets the user control when computer guesses
  def continue_guess
    print "Press any key\n"
    STDIN.getch
    print "                 \n"
  end
end
