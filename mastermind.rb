# Base class the runs all the logic and handles turns
class Game
  def initialize
    @player = Human.new
    @code = %w[1 2 3 4]
  end

  def play_game
    @player.show_instructions
    round = 1
    12.times do
      puts "Round #{round}!"
      round += 1
      result = play_round
      if result
        puts 'The code was broken!'
        break
      end
    end
  end

  def play_round
    input = @player.input
    results = check_guess(input)
    display_results(results)
    win = results[0] == 4
  end

  def check_guess(input)
    colored_pegs = 0
    white_pegs = 0
    code_copy = @code.dup
    input.each_with_index do |number, index|
      if code_copy[index] == number
        colored_pegs += 1
        code_copy[index] = 0

      elsif  code_copy.include? number
        white_pegs += 1
        code_copy[code_copy.find_index(number)] = 0
      end
    end
    [colored_pegs, white_pegs]
  end

  def display_results(results)
    puts "Colored pegs: #{results[0]}"
    puts "White pegs: #{results[1]}"
  end
end

# Basic class that gets input from the player and stores info about them
class Player
  def initialize; end
end

# A human player
class Human < Player
  def input
    valid = false
    until valid
      puts 'Input your guess. Type for numbers 1-6'
      guess = gets.chomp.split('')
      valid = valid_guess?(guess)
      puts 'You idiot!' unless valid
    end
    guess
  end

  def valid_guess?(guess)
    guess.each do |number|
      number = number.to_i
      return false unless number.is_a? Integer

      return false if number > 6 || number < 1

      return false unless guess.length == 4
    end
    true
  end

  def show_instructions
    puts 'Try to guess the code in 12 guesses!'
    puts 'Colored pegs mean you have the correct number and placement'
    puts 'White pegs mean correct number but incorrect placement'
  end
end

# A computer player
class Comp < Player
end

x = Game.new
x.play_game
