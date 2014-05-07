
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")
require("utils.Util")

-- define global module
game = {}

function game.startup()
  CCFileUtils:sharedFileUtils():addSearchPath("assets/res/")
  game.showArticles()
end

function game.exit()
  os.exit()
end


local function createGrid(scene)
  display.newColorLayer(ccc4(255, 255, 255, 255)):addTo(scene)

  for y = display.bottom, display.top, 40 do
    local line = display.newPolygon({{display.left, y}, {display.right, y}}):addTo(scene)
    line:setLineColor(ccc4f(0.9, 0.9, 0.9, 1.0))
    if y%10==0 then
      cc.ui.UILabel.new({text = y, size = 20, color = display.COLOR_BLACK})
        :align(display.RIGHT_TOP,display.cx, y)
        :addTo(scene)
    end
  end

  for x = display.left, display.right, 40 do
    local line = display.newPolygon({{x, display.top}, {x, display.bottom}}):addTo(scene)
    line:setLineColor(ccc4f(0.9, 0.9, 0.9, 1.0))

    if x%10==0 then
      cc.ui.UILabel.new({text = x, size = 20, color = display.COLOR_BLACK})
        :align(display.RIGHT_TOP,x, display.cy)
        :addTo(scene)
    end
  end

  local line = display.newPolygon({{display.left, display.cy}, {display.right, display.cy}}):addTo(scene)
  line:setLineColor(ccc4f(1.0, 0.75, 0.75, 1.0))

  local line = display.newPolygon({{display.cx, display.top}, {display.cx, display.bottom}}):addTo(scene)
  line:setLineColor(ccc4f(1.0, 0.75, 0.75, 1.0))
end


function game.showArticles()
  -- display.replaceScene(require("test.ArticleScene").new(), "fade", 0.6, display.COLOR_WHITE)
  local game =  display.newScene("game");
  createGrid(game)
  local scrollView = CCScrollView:create()
  scrollView:setPosition(ccp(0,0))
  scrollView:setScale(1.0)
  --scrollView:registerScriptHandler(function() self:changeScrollState() end,0)
  scrollView:setViewSize(CCSizeMake(display.width,display.height))
  scrollView:setDirection(kCCScrollViewDirectionVertical)
  scrollView:setClippingToBounds(true)
  scrollView:setBounceable(true)
  --scrollView:setColor(display.RED)

  for i = 0,10 do
    local node = display.newNode()
    node:setContentSize(CCSize(display.width, 100))
    y = 100*i;
    node:setPosition(display.cx, display.height-y)
    node:setColor(ccc3(64, 64, 64))
--    node:addTouchEventListener(handler(node,function()
--      device.showAlert("Confirm Exit", i)
--    end))

    local sprite1 = display.newSprite("Button01.png"):align(display.CENTER_LEFT);
    cc.ui.UILabel.new({text = "align CENTER ddddddddddd dddddddddddd", size = 35, color = display.COLOR_BLACK,dimensions=CCSizeMake(200,100)})
      :align(display.CENTER_RIGHT)
      :addTo(node)
    require("framework.api.EventProtocol").extend(node)

    node:addEventListener("CLICKED_EVENT", handler(node,function()
      device.showAlert("Confirm Exit", i)
    end))

    --local label,H = Util.createTextDialog('ddddddddddddddddddddddddddddddddd',30,10);
    --label.setDimensions(CCSizeMake(50, 0));
    --node:addChild(label)
    node:addChild(sprite1)
    scrollView:addChild(node);
  --game:addChild(node)
  --scrollView:setContainer(note)
  --transition.moveBy(node, {time = 2.0, x = 100})
  end
  --local layer = display.newLayer()
  game:addChild(scrollView)
  display.replaceScene(game, "fade", 0.6, display.COLOR_WHITE)
end
