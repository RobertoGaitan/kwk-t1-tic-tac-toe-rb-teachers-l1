
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    current_token = current_player(board)
    move(board, index, current_token)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |position_1, position_2, position_3|
      if board[position_1] == "X" && board[position_2] == "X" && board[position_3] == "X"
        return [position_1, position_2, position_3]
        break
      end
      if board[position_1] == "O" && board[position_2] == "O" && board[position_3] == "O"
          return [position_1, position_2, position_3]
          break
      end
  end
  return false
end

def full?(board)
  board.each do |token|
    if token == " " || token == ""
       return false
       break
     end
 end
return true
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    winning_token = won?(board)
    winneris = board[winning_token[0]]
    return winneris
  end
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "X" || token == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  counter = 0
  counter = turn_count(board)
  counter % 2 == 0 ? "X" : "O"
end

def play(board)
    while !over?(board) do
      turn(board)
    end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
