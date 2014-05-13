
require("config")
require("framework.init")
scene = nil
-- define global module
Main = {}

function Main:instance()
    o = require("app.scenes.index").new()
    return o;
end

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
  MyApp.super.ctor(self)
  self.objects_ = {}
end

function MyApp:run()
  CCFileUtils:sharedFileUtils():addSearchPath("assets/res/yl/")
  --self:enterScene('article', nil, "fade", 0.6, display.COLOR_WHITE)
  display.replaceScene(Main:instance(), "fade", 0.6, display.COLOR_WHITE)
end

function MyApp:exit()
  os.exit()
end

function MyApp:enterMainScene()
  display.replaceScene(require("yl.index").new(), "fade", 0.6, display.COLOR_WHITE)
end

return MyApp
