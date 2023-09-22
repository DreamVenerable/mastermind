require_relative 'player.rb'
require_relative 'computer.rb'

class Game
  def initialize
    puts 'Would you like to be the codebeaker? Y/N'
    choose_mode
  end

  def choose_mode
    choice = gets.chomp.upcase
    case choice
    when 'Y'
      player_guesses
    when 'N'
      computer_guesses
    else
      puts 'Wrong Input, retry!'
      choose_mode
    end
  end

  def player_guesses
    p 'Computer has chosen a secret code, you have 12 attempts to guess it!'
    Player.new
  end

  def computer_guesses
    p 'You are the code creator, choose 4 numbers between 1-6!'
    Computer.new
  end
end

game = Game.new
