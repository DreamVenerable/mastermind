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
      puts "Computer guessed #{@ai_guess}"
      compare_guess(@ai_guess)
      puts "Computer hints: #{@hint.to_s}"
      #ai_algorithm(choice)
      sleep 0.5
      @hint = []
    end
  end

  def ai_choice
    @ai_guess = @sequences.sample
  end

  # Swaszek algorithm
  # 
  #
  # def ai_algorithm(choice)
  #   test_hint = []
  #   @sequences.keep_if { |elem| compare_test(elem) == compare_guess(@ai_code) }
  #   p @sequences
  # end

  # def compare_test(element)
  #   elem.each_index do |i|
  #     if ai_guess[i] - element[i] == 0
  #       test_hint.push('R')
  #     elsif element.any?(@ai_guess[i])
  #       test_hint.unshift('W')
  #     end
  #   end
  # end

  def continue_guess
    print "Press any key\n"
    STDIN.getch
    print "                 \n"
  end
end
