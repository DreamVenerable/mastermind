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
  def compare_guess_with_code
    p @ai_code
    @ai_code.each_index do |i|
      if @ai_code.any?(@number[i]) && @number[i] - @ai_code[i] == 0
        @hint.push('R')
      elsif @ai_code.any?(@number[i])
        @hint.unshift('W')
      end
    end
  end
end