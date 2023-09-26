module PlayerChoice
  # Input from user for either guesses or secret code choice
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
  def game(name)
    @max_rounds = 12
    while @max_rounds > 0
      round
      @max_rounds -= 1 
    end
    puts "#{name} lost!"
  end
end

module GameEnd
  def game_end(name)
    if stop?
      puts "#{name} won!" if stop?
      @max_rounds = 0
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
    # Right number & right placement hint
    code.each_index { |i| correct_place(i, arr, guess) if guess[i] - code[i] == 0 }

    # Right number but wrong placement
    similiar = (code & guess).flat_map { |n| [n]*[guess.count(n), code.count(n)].min }
    similiar.count.times { |ele| arr.push('W') }
    return arr
  end
  
  def correct_place(i, arr, guess)
    arr.push('R')
    guess[i] = 0
  end
end
