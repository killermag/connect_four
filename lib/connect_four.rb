require_relative 'player.rb'
require 'pry-byebug'

class Game 
  attr_accessor  :game_pieces, :grid, :player, :player2 

  def initialize()
    @toggle = true    
    @game_pieces = ["\u2649","\u264C","\u264E","\u2650"]
    @player = Player.new(choose) 
    @player2 = Player.new(choose)
    @grid = [['O','O','O','O','O','O','O'],
             ['O','O','O','O','O','O','O'],
             ['O','O','O','O','O','O','O'],
             ['O','O','O','O','O','O','O'],
             ['O','O','O','O','O','O','O'],
             ['O','O','O','O','O','O','O']]
             
      play     
  end

  def play 
    loop do 
      system "clear" 
      print "Player one - #{@player.name} \n Player two - #{@player2.name}\n" 
      display 
      input 
      if game_over?
        system "clear"
        display 
        if @toggle 
          puts "Player two won" 
        else 
          puts "Player one won" 
        end 
        break 
      end  
    end 
  end 

  def choose
    count = 0
    @game_pieces.each do |x| 
      print x + " -> #{count+=1}, "
      print "\n" if x == @game_pieces[-1]  
    end 
    input = gets.chomp.to_i 
    return choose if input - 1 < 0 || @game_pieces[input-1].nil? 
    return @game_pieces.slice!(input-1)   
  end 

  def display 
    @grid.each do |x| 
      print x.to_s + "\n"
    end
    
    heredoc = <<-HTML 
―――――――――――――――――――――――――――――――――
  1    2    3    4    5    6    7
    HTML
    puts heredoc  

  end 
    
  def input 
    puts "Select your position"
    pos = gets.chomp.to_i  
    count = 5
    input if pos > 7 || pos < 1 
    while @grid[count][pos-1] != "O" && count != -1 
      count -= 1 
    end 
    if count < 0 
      input
      return  
    end 
    @toggle ? @grid[count][pos-1] = @player.name : @grid[count][pos-1] = @player2.name    
    @toggle ? @toggle = false : @toggle = true 
  end        

  def game_over?()
    count = 5
    iterator = 0 
    while count > 0
       while iterator != 7 
        if @grid[count][iterator] == "O"
          iterator += 1 
          next 
        end 
        if @grid[count][iterator] == @grid[count][iterator+3] # horizontal check
          return true if @grid[count][iterator] == @grid[count][iterator+1] && @grid[count][iterator+3] == @grid[count][iterator+2] 
        elsif @grid[count][iterator] == @grid[count-3][iterator] # vertical check 
          return true if @grid[count][iterator] == @grid[count-1][iterator] && @grid[count-3][iterator] == @grid[count-2][iterator]   
        elsif @grid[count][iterator] == @grid[count-3][iterator+3] # Diagonal check 
          return true if @grid[count][iterator] == @grid[count-1][iterator+1] && @grid[count-2][iterator+2] == @grid[count-3][iterator+3]    
        end  
        iterator += 1 
       end 
      count -= 1
      iterator = 0      
    end 
    false 
  end 


end

game = Game.new 

