local Text = require("Lutron/Entity/Text")
local Audio = require("Lutron/Entity/Audio")
local Score
do
  local _class_0
  local _parent_0 = Text
  local _base_0 = {
    load = function(self)
      _class_0.__parent.__base.load(self)
      return self.soundScore:load()
    end,
    reset = function(self)
      self.text = 0
    end,
    addScore = function(self, amount)
      if amount == nil then
        amount = 1
      end
      self.soundScore:play()
      self.text = self.text + amount
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, game, player)
      _class_0.__parent.__init(self, "0")
      self.soundScore = Audio("Resources/blip.wav")
      self:reset()
      self.position.y = 10
      return self:centerX(game.width / 3 * player)
    end,
    __base = _base_0,
    __name = "Score",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Score = _class_0
  return _class_0
end
