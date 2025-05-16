scrx=love.graphics.getWidth()
scry=love.graphics.getHeight()

if love ~= nil then
  lutro = love
end
local Lutron = require("Lutron/Lutron")
local Player1 = require("Player1")
local Player2 = require("Player2")
local Ball = require("Ball")
local Background = require("Background")
local Score = require("Score")
local game = Lutron(320, 240, nil, 33, 33, 33)
lutro.load = function()
  do
    game:addEntity(Background(game))
    game:addEntity(Ball(game), "ball")
    game:addEntity(Player1(game), "player1")
    game:addEntity(Player2(game), "player2")
    game:addEntity(Score(game, 1), "player1score")
    game:addEntity(Score(game, 2), "player2score")
    game:load()
    return game
  end
end
do
  local _base_0 = game
  local _fn_0 = _base_0.update
  lutro.update = function(...)
    return _fn_0(_base_0, ...)
  end
end
do
  local _base_0 = game
  local _fn_0 = _base_0.draw
  lutro.draw = function(...)

--REMOVED THIS SH*T
    return _fn_0(_base_0, ...)
  end
end
