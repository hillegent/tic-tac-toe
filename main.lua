
whoseMove = 1
compRole = 0
fieldSize = 3

require ("menu")
require ("gameField")
require("settings")



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
end

function love.update(dt)
  
end

function love.draw()
  if Game.menu then
    drawMenu()
  end 
  if Game.settings then
    drawMenu()
  end 
  if Game.single then
    drawField()
  end
  if Game.multiPlayer then
    drawField()
    compRole = 0
  end
  if Game.CompVsComp then
    drawField()
    compRole = 3
  end
end

function backToMenu()
  Game.menu = true
  Game.single = false
  Game.multiPlayer = false
  Game.CompVsComp = false
  loadMenu()
end