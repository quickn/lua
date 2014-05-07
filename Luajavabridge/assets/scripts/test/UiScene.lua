require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

local MainScene = class("MainScene", function()
  return display.newScene("MainScene")
end)

function MainScene:ctor()
  self:createImage()
  --self.createLabel()
end

function MainScene:createLabel()
  cc.ui.UILabel.new({
    text = "fixed size",
    size = 16,
    color = display.COLOR_BLACK,
  }):align(display.CENTER, display.cx + 350, display.cy + 170):addTo(self)
end

function MainScene:createImage()
  for i = 0,5 do
    cc.ui.UIImage.new("Button02.png")
      :setLayoutSize(600, 300)
      :align(display.LEFT_TOP, display.cx, 300*i)
      :addTo(self)
  end
end

return MainScene
