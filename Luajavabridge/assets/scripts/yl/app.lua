
require("config")
require("framework.init")
scene = nil
-- define global module

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
  MyApp.super.ctor(self)
  self.objects_ = {}
end

function MyApp:run()
  CCFileUtils:sharedFileUtils():addSearchPath("assets/res/yl/")
  --self:enterScene('article', nil, "fade", 0.6, display.COLOR_WHITE)
 -- display.replaceScene(require("app.scenes.index").new(), "fade", 0.6, display.COLOR_WHITE)
  self:enterScene("index", nil, "fade", 0.6, display.COLOR_WHITE)
end

function MyApp:exit()
  os.exit()
end


return MyApp
