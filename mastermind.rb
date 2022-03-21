# Base class the runs all the logic and handles turns
class Game
  def initialize
    @player = Human.new
    @code = %w[1 2 3 4]
  end

  def play_round
    input = @player.input
    results = check_guess(input)
    display_results(results)
  end

  def check_guess(input)
    colored_pegs = 0
    white_pegs = 0
    p input
    p @code
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

  def input
    [2, 3, 4, 5]
  end
end

# A human player
class Human < Player
  def input
    puts 'Input your guess. Type for numbers 1-6'
    guess = gets.chomp.split('')
  end
end

# A computer player
class Comp < Player
end

x = Game.new
x.play_round
