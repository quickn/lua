
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
  scrollView:setPosition(ccp(0,100))
  scrollView:setScale(1.0)
  scrollView:setViewSize(CCSizeMake(display.width,display.height-200))
  scrollView:setDirection(kCCScrollViewDirectionVertical)
  scrollView:setClippingToBounds(true)
  scrollView:setBounceable(true)
  --设置颜色
  local layerColor = CCLayerColor:create(ccc4(125,123,0,255));
  scrollView:setContainer(layerColor)
  for i = 0,5 do
    local  menu = CCMenu:create()
    local function onTouchEvent(eventType,x,y)
      if eventType ~= 'began' then
        device.showAlert('eventType',eventType);
      end
    end
    local function onNodeEvnent(event)
      device.showAlert('eventType',event);
    end
    menu:setContentSize(CCSize(display.width, 100))
    y = 100*i;
    menu:setPosition(0,display.height-y-200);
    --    cc.ui.UILabel.new({text = tostring(i).."align CENTER ddddddddddd dddddddddddd", size = 35, color = display.COLOR_RED,dimensions=CCSizeMake(200,100)})
    --      :align(display.TOP_LEFT)
    --      :addTo(layer)
    --local sprite1 = CCSprite:create("Button01.png")
    local sprite1 = display.newSprite("Button01.png",display.cx):align(display.TOP_RIGHT);
    local item3 = CCMenuItemSprite:create(sprite1,null)
    item3:registerScriptTapHandler(onTouchEvent)
    local item4 = CCMenuItemFont:create("I toggle enable items"..tostring(i))
    item4:registerScriptTapHandler(onTouchEvent)
    menu:addChild(item4);
    menu:addChild(item3)
    scrollView:addChild(menu)
    --transition.moveBy(node, {time = 2.0, x = 100})
  end
  scrollView:addKeypadEventListener(function(event)
    --退出程序
    if event == "back" then
      os.exit()
    end
  end)
  scrollView:setKeypadEnabled(true)
  game:addChild(scrollView)
  display.replaceScene(game, "fade", 0.6, display.COLOR_WHITE)
end
