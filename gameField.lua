local love = require "love"

local IsFirst = 0

local step = 450 / fieldSize
local StartPosX = 150
local StartPosY = 75

local squares = {}

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
  currX = StartPosX
  currY = StartPosY
  for i = 1, fieldSize, 1 do
    for j = 1, fieldSize ,1 do
      Asquare = square(currX, currY)
      table.insert(squares, Asquare)
      currX = currX + step
      end
    currX = StartPosX
    currY = currY + step
  end
end

function drawField()
  for i, square in ipairs(squares) do
    love.graphics.setColor(0.5,0.5,0.5,1)
    
    square.last = square.now
    local color = {0.3, 0.3, 0.4, 1.0}
    local mx, my = love.mouse.getPosition()
        
    local hot = mx > square.x and mx < square.x + step and 
                    my > square.y and my < square.y + step
    if hot then
      color = {0.8, 0.8, 0.9, 1.0}
    end
    
    square.now = love.mouse.isDown(1)
    if square.now and not square.last and hot and (square.owner == 0) and IsFirst > 100 then
      square.owner = whoseMove
      turnMove()
    end
        love.graphics.setColor(unpack(color))
    
    love.graphics.rectangle("line",
          square.x,
          square.y,
          step, step)
    if (square.owner == 1) then
       drawCross(square.x,square.y)
       end
     if (square.owner == 2) then
       love.graphics.circle("line",
          square.x + step * 0.5,
          square.y + step * 0.5,
          step * 0.4)
     end
     if IsFirst < 101 then
      IsFirst = IsFirst + 1
     end
     winn()
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
  winner = 0
  notChanged = true
  for i = 0, fieldSize-1, 1 do
    for j = 0, fieldSize*fieldSize-fieldSize, fieldSize do
      if squares[j+i].owner == squares[j+fieldSize+i].owner then 
        winner = square[i].owner
        else
          notChanged = false
        end
    end
    if not(winner ==0) and notChanged then
      love.graphics.line(squares[i].x + step*0.5, squares[i].y + step*0.5,
        squares[fieldSize*fieldSize-fieldSize+i].x + step*0.5, squares[fieldSize*fieldSize-fieldSize+i].y + step*0.5)
      break end
  end
end






