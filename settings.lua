

function newButton(text, fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false
  }
  end


function loadSettings()
  buttons = {}
  ScreenLock = 0
  table.insert(buttons, newButton("Select field size", 
    function()
    end))
    table.insert(buttons, newButton("3x3", 
    function()
      fieldSize = 3
      loadMenu()
    end))
    table.insert(buttons, newButton("4x4", 
    function()
      fieldSize = 4
      loadMenu()
    end))
    table.insert(buttons, newButton("5x5", 
    function()
      fieldSize = 5
      loadMenu()
    end))
  font = love.graphics.newFont(30)
end

function loadSelect()
  buttons = {}
  ScreenLock = 0
    table.insert(buttons, newButton("Comtuper first", 
    function()
      Game.menu = false
      compRole = 1
      loadField()
      Game.single = true
    end))
    table.insert(buttons, newButton("You first", 
    function()
      Game.menu = false
      compRole = 2
      loadField()
      Game.single = true
    end))
  font = love.graphics.newFont(30)
end

