
require("config")
require("framework.init")

function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end

--require("app.UIDemoApp").new():run()
--require("beachmakeGame")
--require("game")
--game.startup()
--require("app.MyApp").new():run()
--require("DragGame")
--game.startup()

--require("config")
--display.replaceScene(require("scenes.NightMainScene").new())

--CCFileUtils:sharedFileUtils():addSearchPath("assets/res/")
--display.replaceScene(require("test.UiScene").new(), "fade", 0.6, display.COLOR_WHITE)

import("test.test")
game.startup();

