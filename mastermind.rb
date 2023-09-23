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
  def compare_guess(code)
    code.each_index do |i|
      correct_place(i) if @input[i] - code[i] == 0
    end
    similiar = code & @input 
    similiar.count.times { |ele| @hint.push('W') }
  end

  def correct_place(i)
    @hint.push('R')
    @input[i] = 0
  end
end
