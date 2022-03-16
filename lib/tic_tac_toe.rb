require 'pry'

class TicTacToe
    attr_accessor :board
    WIN_COMBINATIONS =[
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
    ]

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "

    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token="X")
       @board[index] = token 
    end

    def position_taken?(index)
        @board[index] != " "
    end    

    def valid_move?(index)
        index >= 0 && index <= 8 && !self.position_taken?(index) 
    end

    def turn_count
        @board.count{|square| square != " "}
    end

    def current_player
        self.turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Move"
        input = gets
        index = self.input_to_index(input)
        token = current_player
        if valid_move?(index)
            move(index, token)
            display_board
        else
            self.turn
        end
    end

    def won?
        xs = []
        os = []
        @board.each_index do |index|
            if @board[index] == "X"
                xs << index
            elsif @board[index] == "O"
                os << index
            end
        end
        WIN_COMBINATIONS.each do |combo| 
            if combo.all?{|square| xs.include?(square)} || combo.all?{|square| os.include?(square)}
                return combo
            end
        end
        false
    end

    def full?
        !@board.any?{|square| square == " "}
    end

    def draw?
        self.full? && !self.won?
    end
   
    def over?
        self.draw? || self.won?
    end

    def winner
        if self.won?
            self.current_player == "X" ? "O" : "X"
        end
    end

    def play
        if self.over?
           puts self.won? ?  "Congratulations #{self.winner}!" : "Cat's Game!"
        else
            self.turn
            self.play
        end
    end

end
