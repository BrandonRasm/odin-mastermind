# Base class the runs all the logic and handles turns
class Game
  def initialize
    puts "To play as the codebreaker type '1'."
    puts 'To make your own code type literally anything else'
    choice = gets.chomp
    choice == '1' ? human_breaker_setup : comp_breaker_setup
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

  def generate_random_code
    code = [0, 0, 0, 0]
    code = code.map { rand(1..6).to_s }
    p code
    code
  end

  def generate_player_code
    valid = false
    until valid
      puts "Input a secret code, but don't say it out loud(the computer can hear you)"
      puts 'The code must be 4 numbers long from 1-6'
      guess = gets.chomp.split('')
      valid = @player.valid_guess?(guess)
      puts 'You idiot!' unless valid
    end
    guess
  end

  def human_breaker_setup
    @player = Human.new
    @code = generate_random_code
  end

  def comp_breaker_setup
    @player = Comp.new
    @code = generate_player_code
  end
end

# Basic class that gets input from the player and stores info about them
class Player
  def initialize; end

  def valid_guess?(guess)
    return false unless guess.length == 4

    guess.each do |number|
      number = number.to_i
      return false unless number.is_a? Integer

      return false if number > 6 || number < 1
    end
    true
  end
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

  def show_instructions
    puts 'Try to guess the code in 12 guesses!'
    puts 'Colored pegs mean you have the correct number and placement'
    puts 'White pegs mean correct number but incorrect placement'
  end
end

# A computer player
class Comp < Player
  def show_instructions
    puts "The computer will now try to guess your code. Good Luck!"
  end
end

x = Game.new
x.play_game
