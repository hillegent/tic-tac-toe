whoseMove = 1

fieldSize = 3

require ("menu")
require ("gameField")



Board = {}

Game = {
  menu = true,
  single = false,
  multiPlayer = false,
  CompVsComp = false
}

function love.load()
  love.window.setTitle("tic-tac-toe")
  loadMenu()
  loadField()
end

function love.update(dt)
  
end

function love.draw()
  if Game.menu then
    drawMenu()
  end 
  if Game.single then
    drawField()
  end
  if Game.single then
    
  end
end

function CompMove()

end

function PlayerMove()
  
end
