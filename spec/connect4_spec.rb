require "./lib/connect_four.rb"
require "pry-byebug" 


describe Game do



  describe "#choose" do
    it "asks the players to choose their game pieces" do
      game = Game.new  
      player = double("player") 
      allow(player).to receive(:name).and_return(game.choose)  
    end 

    it "resolves the conflict between similar game_pieces" do
      game = Game.new 
      player,player2 = double,double 
      allow(player).to receive(:name).and_return(game.choose)
      allow(player2).to receive(:name).and_return(game.choose)
      expect(player2.name).not_to eq(player.name)   
    end 
  end 

  describe "#input" do
    it "allow the player to input into the grid" do 
      player = double 
      player2 = double 
      game = Game.new
      allow(player).to receive(:name).and_return(game.choose)
      allow(player2).to receive(:name).and_return(game.choose)
      game.player = player 
      game.player2 = player2   
      game.input   
      expect(game.grid[5][0]).to eq(player.name) 
    end  
  end
  
  describe "game_over?" do
    it "returns true when it finds a pattern" do
      game = Game.new
      player = double 
      allow(player).to receive(:name).and_return(game.choose)
      player2 = double 
      allow(player2).to receive(:name).and_return(game.choose)
      game.player = player 
      game.player2 = player2  
      10.times { game.input } 
      game.display  
      expect(game.game_over?).to eq(true)   
    end  
  end 
  
end 
 