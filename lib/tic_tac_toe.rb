require "pry"
class TicTacToe
  
  def initialize
    @board = Array.new(9, " ")
  end 
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end 
  
  def input_to_index(move)
    move.to_i-1
  end 
  
  def move(index, token = "X")
    @board[index] = token
    # @board
  end 
  
  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O" ? true : false 
  end 
  
  def valid_move?(position)
    @board[position] == " " ? true : false
  end 
  
  def turn 
    puts "Please enter 1-9:"
    choice = gets.strip #remember this is a string input..
    
    until choice.to_i >= 1 && choice.to_i <= 9 
      puts "Invalid input. Please enter 1-9"
      choice = gets.strip
    end
    token = current_player # X or O player
    position = (input_to_index(choice)) #translates it to index value

    while !valid_move?(position)
      choice = gets.strip
      position = (input_to_index(choice))
      valid_move?(position)
    end
    
    move(position, token)
    display_board
    
  end 
  
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end 
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  def won?
    result = nil
    WIN_COMBINATIONS.detect do |combo| #[winning option]
      result = combo if @board[combo[0]] == @board[combo[1]] &&  @board[combo[1]] == @board[combo[2]]
    end 
    result
  end 
  
  def full?
    @board.all?{|position|position!=" "}
  end 
  
  def draw?
    self.full? && !self.won? ? true : false
  end 
  
  def over?
    won?||draw?
  end 
  
  def winner
    winning_player = nil
    winning_arrangement = self.won?
    winning_arrangement.each do |i|
      winning_player = @board[i] if @board[i] == "X" || @board[i] == "O"
    end 
    winning_player
  end 
  
  def play 
    puts "Welcome to Tic Tac Toe!"
    display_board
    
    until over?
      turn
      
      over?
    end
    if over? && won?
      winning_player = self.winner
      puts "Congratulations #{winning_player}!"
    else
      puts "Cats Game!"
    end 
  end 
  
end 