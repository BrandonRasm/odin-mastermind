# Base class the runs all the logic and handles turns
class Game
  def initialize
    @player = new Human
    @code = %w[1 2 3 4]
  end

  def play_round
    input = @player.input
    results = check_guess(input)
  end

  def check_guess(input)
    colored_pegs = 0
    white_pegs = 0
    input.each_with_index do |number, index|
      colored_pegs += 1 if @code[index] == number

      if @code[index] == number
        colored_pegs += 1
      else
        @code.include? number
        white_pegs += 1
      end
    end
    [colored_pegs, white_pegs]
  end
end

# Basic class that gets input from the player and stores info about them
class Player
  def input
    [2, 3, 4, 5]
  end
end

# A human player
class Human < Player
  def input
    puts 'Input your guess. Type for numbers 1-6'
    guess = gets.chomp.split
  end
end

# A computer player
class Comp < Player
end
