module PlayerChoice
  def choice
    begin
      @input = gets.match(/^-?[1-6]{4}$/)[0]
    rescue StandardError
      puts 'Wrong input, Try again!'
      retry
    else
      @input = @input.to_i.digits.reverse
      p "You chose #{@input}"
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
    @hint == ["R", "R", "R", "R"]
  end
end

module Compare
  def compare_guess(code, arr, guess)
    code.each_index do |i|
      correct_place(i, arr, guess) if guess[i] - code[i] == 0
    end
    similiar = code & guess 
    similiar.count.times { |ele| arr.push('W') }
    return arr
  end

  def correct_place(i, arr, input)
    arr.push('R')
    input[i] = 0
  end
end
