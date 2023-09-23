module PlayerChoice
  def choice
    begin
      @number = gets.match(/^-?[1-6]{4}$/)[0]
    rescue StandardError
      puts 'Wrong input, Try again!'
      retry
    else
      @number = @number.to_i.digits.reverse
      p "You chose #{@number}"
      sleep 0.5
    end
  end
end

module StartGame
  def game
    @max_rounds = 12
    while @max_rounds > 0
      round
      @max_rounds -= 1 
    end
  end
end

module Stop
  def stop?
    @number == @ai_code
  end
end

module Compare
  def compare_guess_with_code(guess, arr)
    guess.each_index do |i|
      if @number[i] - guess[i] == 0
        arr.push('R')
      elsif @number.any?(guess[i])
        arr.unshift('W')
      end
    end
  end
end
