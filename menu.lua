

buttons = {}

function newButton(text, fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false
  }
  end

ScreenLock = 0

function loadMenu()
  ScreenLock = 0
  buttons = {}
  table.insert(buttons, newButton("Single player", 
    function()
      loadSelect()
    end))
    table.insert(buttons, newButton("Multi player", 
    function()
      Game.menu = false
      compRole = 0
      loadField()
      Game.multiPlayer = true
    end))
    table.insert(buttons, newButton("Computer vs Computer", 
    function()
      Game.menu = false
      loadField()
      Game.CompVsComp = true
    end))
    table.insert(buttons, newButton("Settings", 
    function()
      loadSettings()
    end))
    table.insert(buttons, newButton("Exit", 
    function()
      love.event.quit(0)
    end))
  font = love.graphics.newFont(30)
end
function drawMenu()
      local ww = love.graphics.getWidth()
      local wh = love.graphics.getHeight()
      local button_width = ww * (1/2)
      local button_height = 55
      local margin = 16
      local cursoreY = 0
      local total_heigth = (button_height + margin) * #buttons 
      for i, button in ipairs(buttons) do 
        button.last = button.now
        local bx = (ww * 0.5) - (button_width * 0.5)
        local by = (wh * 0.5) - (total_heigth * 0.5) + cursoreY
        
        local color = {0.3, 0.3, 0.4, 1.0}
        local mx, my = love.mouse.getPosition()
        
        local hot = mx > bx and mx < bx + button_width and 
                    my > by and my < by + button_height
        if hot then
          color = {0.8, 0.8, 0.9, 1.0}
        end
        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot and ScreenLock > 15 then
          button.fn()
          end
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle("fill",
          bx,
          by,
          button_width, button_height)
        cursoreY = cursoreY + button_height + margin
        love.graphics.setColor(0,0,0,1)
        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)
        love.graphics.print(button.text, font, (ww* 0.5) - textW * 0.5 , by + textH * 0.3 )
      end
      if ScreenLock < 16 then
      ScreenLock = ScreenLock + 1
    end
  end