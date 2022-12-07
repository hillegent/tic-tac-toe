
winner = 0


last = false 
now = false
require ("bot")

local ScreenLock = 0

local BotLock = 0

local step
local StartPosX = 150
local StartPosY = 75



squares = {};

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local function square(x,y)
  return{
  owner = 0,
  x = x,
  y = y,
  last = false,
  now = false
  }
end


function loadField()
  whoseMove = 1
  winner = 0
  last = false 
  now = false
  ScreenLock = 0
  step = 450 / fieldSize
  local arr = {}
  for i =1, fieldSize, 1 do
    arr[i]= {}
    end
  
  currX = StartPosX
  currY = StartPosY
  for i = 1, fieldSize, 1 do
    for j = 1, fieldSize ,1 do
      Asquare = square(currX, currY)
      arr[i][j] = Asquare
      currX = currX + step
      end
    currX = StartPosX
    currY = currY + step
  end
  squares = arr
end


function drawField()
  love.graphics.print(compRole)
  info()
  for i = 1 , fieldSize, 1 do
    for j = 1, fieldSize, 1 do
    love.graphics.setColor(0.5,0.5,0.5,1)
    
    squares[i][j].last = squares[i][j].now
    local color = {0.3, 0.3, 0.4, 1.0}
    local mx, my = love.mouse.getPosition()
        
    local hot = mx > squares[i][j].x and mx < squares[i][j].x + step and 
                    my > squares[i][j].y and my < squares[i][j].y + step
    if hot then
      color = {0.8, 0.8, 0.9, 1.0}
    end
    
    squares[i][j].now = love.mouse.isDown(1)
    b = compRole == whoseMove
    if squares[i][j].now and not squares[i][j].last 
      and hot and (squares[i][j].owner == 0) 
      and ScreenLock > 100 and (winner == 0) 
      and (not b)
    then
        squares[i][j].owner = whoseMove
        turnMove()
    end
    
    love.graphics.setColor(unpack(color)) 
    love.graphics.rectangle("line",
        squares[i][j].x,
        squares[i][j].y,
        step, step)
      
    if (squares[i][j].owner == 1) then
        drawCross(squares[i][j].x,squares[i][j].y)
    end
    
    if (squares[i][j].owner == 2) then
       love.graphics.circle("line",
       squares[i][j].x + step * 0.5,
       squares[i][j].y + step * 0.5,
          step * 0.4)
    end
    
    if ScreenLock < 101 and not Game.menu then
      ScreenLock = ScreenLock + 1
    end
    if BotLock < 31 and not Game.menu then
      BotLock = BotLock + 1
    end
  end
  if (compRole == 3 or b) and (winner == 0) and BotLock > 30  then
      local arr = deepcopy(squares)
      res = compMove(whoseMove, arr)
      squares[res[1]][res[2]].owner = whoseMove
      turnMove()
      BotLock = 0
    end
  winn()
  
  showButton()
end


end

function drawCross(x,y)
  love.graphics.line(x + step * 0.1,y + step * 0.1,x + step * 0.9,y + step * 0.9);
  love.graphics.line(x + step * 0.9,y + step * 0.1,x + step * 0.1,y + step * 0.9);
end

function turnMove()
  if(whoseMove == 1) then
    whoseMove = 2
  else
    if (whoseMove == 2) then 
      whoseMove = 1
    end
  end
end



function winn()
  freeSquares = 0
  for i = 1, fieldSize, 1 do 
    for j = 1, fieldSize, 1 do
      if squares[i][j].owner == 0 then
        freeSquares = freeSquares +1
      end
    end
  end
  
  if freeSquares == 0 then 
    winner = 3
  end
  
    local win
  notChanged = true
  -- check lines
  for i = 1, fieldSize, 1 do 
    for j = 1, fieldSize-1, 1 do
      if squares[i][j].owner == squares[i][j+1].owner then 
        win = squares[i][j].owner
        else
          notChanged = false
        end
    end
    if not(win ==0) and notChanged then
      love.graphics.line(squares[i][1].x + step*0.3, squares[i][1].y + step*0.5,
        squares[i][fieldSize].x + step*0.7, squares[i][fieldSize].y + step*0.5)
      winner = win
      break end
    notChanged = true  
  end
  
  for j = 1, fieldSize, 1 do -- check colums
    for i = 1, fieldSize -1, 1 do
      if squares[i][j].owner == squares[i+1][j].owner then 
        win = squares[i][j].owner
        else
          notChanged = false
        end
    end
    if not(win ==0) and notChanged then
      love.graphics.line(squares[1][j].x + step*0.5, squares[1][j].y + step*0.3,
        squares[fieldSize][j].x + step*0.5, squares[fieldSize][j].y + step*0.7)
      winner = win
      break end
    notChanged = true  
  end
  
  -- check right diagonal
  for i = 1, fieldSize -1, 1 do
      if  squares[i][fieldSize - i + 1].owner == squares[i+1][fieldSize - i].owner then 
        win = squares[i][fieldSize - i + 1].owner
        else
          notChanged = false
        end
  end
      if not(win ==0) and notChanged then
        love.graphics.line(squares[1][fieldSize].x + step*0.5, squares[1][fieldSize].y + step*0.3,
          squares[fieldSize][1].x + step*0.5, squares[fieldSize][1].y + step*0.7)
        winner = win
      
      end
  notChanged = true  
  
  -- check left diagonal
  for i = 1, fieldSize -1, 1 do
      if  squares[i][i].owner == squares[i+1][i+1].owner then 
        win = squares[i][i].owner
        else
          notChanged = false
        end
  end
      if not(win ==0) and notChanged then
        love.graphics.line(squares[1][1].x + step*0.5, squares[1][1].y + step*0.3,
          squares[fieldSize][fieldSize].x + step*0.5, squares[fieldSize][fieldSize].y + step*0.7)
        winner = win
      
      end
  notChanged = true 
end










function info()
  ww = love.graphics.getWidth()
  if winner == 0 then 
    love.graphics.print("now", 50, ww /2)
    if whoseMove == 1 then
      drawCross(10,ww/2 + 20)
    else 
      love.graphics.circle("line",10+ step * 0.4,ww/2 + 20+ step * 0.4,step * 0.4)
    end
  end
  
  if winner == 1 then 
    love.graphics.print("WINNER", 50, ww /2)
      drawCross(10,ww/2 + 20)
  end
   if winner == 2 then 
    love.graphics.print("WINNER", 50, ww /2)
      love.graphics.circle("line",10+ step * 0.4,ww/2 + 20+ step * 0.4,step * 0.4)
  end
  if winner == 3 then 
    love.graphics.print("DRAW", 50, ww /2)
  end
  
  
  
end



function showButton()
  font = love.graphics.newFont(30)
  last = now
  button_width = 100
  button_height = 50
  bx = love.graphics.getWidth() / 2
  by = love.graphics.getHeight() -70
  local color = {0.3, 0.3, 0.4, 1.0}
  local mx, my = love.mouse.getPosition()
        
  local hot = mx > bx and mx < bx + button_width and 
                    my > by and my < by + button_height
  if hot then
    color = {0.8, 0.8, 0.9, 1.0}
  end
  now = love.mouse.isDown(1)
  if now and not last and hot then
    backToMenu()
  end
  love.graphics.setColor(unpack(color))
  text = "Menu"
  love.graphics.rectangle("fill",bx, by,button_width, button_height)
  love.graphics.setColor(1,1,1,1)
  local textW = font:getWidth(text)
  local textH = font:getHeight(text)
  love.graphics.print(text, font, bx, by)
end







