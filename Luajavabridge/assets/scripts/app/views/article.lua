local ScrollView = import("..ui.ScrollView")
local Article  = class("Article",function()
  --local layer = display.newColorLayer(ccc4(0, 0, 0, 155));
  --require("framework.api.EventProtocol").extend(layer)
  return display.newLayer();
end)

function Article:ctor()
  self.dragThreshold = 40
  self.bouncThreshold = 140
  self.defaultAnimateTime = 0.4
  self.defaultAnimateEasing = "backOut"
  self:setColor(display.COLOR_WHITE)
  self.touchRect = rect
  self.offsetX = 0
  self.offsetY = 0
  self.headH = 60
  self.barH = 60
  self.ViewH = display.height - self.headH - self.barH
  self.sc = display.newLayer();
  self:createScrollView(self.sc);
  self:setTouchEnabled(true)
  self:registerScriptTouchHandler(handler(self, self.onTouch),true)  
  --self:createHead(self.sc);
  self:createButtom(self.sc);
  self:addChild(self.sc);
  self.scene = CCDirector:sharedDirector():getRunningScene();
  self:setOpacity(255);
end

function Article:onTouchMoved(x, y)
      transition.stopTarget(self)
      --transition.moveTo(self,{x=100,y=100,tiem=0.4,});
      self:runAction(CCMoveTo:create(0.4, CCPoint(100,0)));
end

function Article:onTouchEnded(x,y)
  if self.drag.isTap then
        self:onTouchEndedWithTap(x, y)
    else
        self:onTouchEndedWithoutTap(x, y)
    end
    self.drag = nil
end;

function Article:onTouchBegan(x, y)
        self.drag = {
        currentOffsetX = self.offsetX,
        currentOffsetY = self.offsetY,
        startX = x,
        startY = y,
        isTap = true,
    }
    return true
end

function Article:onTouchEndedWithTap(x, y)
    --local cell = self:getCurrentCell()
    --cell:onTouch(event, x, y)
    --cell:onTap(x, y)
end

function Article:onTouch(event,p)
    print("event"..event..p[1].."y"..p[2]);
    if event == "began" then
      self:onTouchBegan(p[1],p[2]);
    elseif event == "moved" then
      self.offsetX =p[1]-self.drag.startX;
      if self.offsetX >= 0 then
        self:setPosition(self.offsetX,0);
      else
        self.offsetX = 0;
      end
      print("self.offsetX"..self.offsetX);
    elseif event == "ended" then
      --self:runAction(CCMoveTo:create(0.4, ccp(0,0)));
        x = self:getPositionX();
        if x>=display.cx then
          x = display.width;
          self:backIndex();
        else
          x = 0;
        end
       -- printf("x:%d",x)
        transition.stopTarget(self)
        transition.moveTo(self, {
            x = x,
            y = y,
            time = self.defaultAnimateTime,
            easing =self.defaultAnimateEasing,
        })
    end
end  

function Article:createSC()
  local view=CCScrollView:create(CCSize(display.right,display.top));
  view:setDirection(0);
  view:addTouchEventListener(function(event, x, y, prevX, prevY)
       print("event"..event);
    end, cc.MULTI_TOUCHES_ON)
  view:setTouchEnabled(false)
  return view;
end

function Article:createScrollView(layer)
  local scrollView = CCScrollView:create()
  --scrollView:setPosition(ccp(0,0))
  local layerColor = Article:getTalks();
  scrollView:setContainer(layerColor)
  scrollView:setKeypadEnabled(true)
  --scrollView:setOpacity(255)
  scrollView:setDirection(kCCScrollViewDirectionVertical)
  scrollView:setClippingToBounds(false)
  scrollView:setBounceable(false)
  layer:addChild(scrollView)
end


function Article:getTalks()  
    local layerColor = CCLayerColor:create(ccc4(125,123,0,255))
    td,tmpH = Util.createTextDialog("的发生的的发生的发生的的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生发生的发生发生的的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生的发生发生的发生",10,10,100)
    --td:setPositionY(y)
    td:setAnchorPoint(ccp(0,0));
    layerColor:addChild(td);
    layerColor:setContentSize(CCSizeMake(200,200))
    --layerColor:setPosition(ccp(display.cx,display.cy))
    return layerColor
end

--创建头部
function Article:createHead(layer)
  local function menuCallbackBugsTest()
    local scene = CCDirector:sharedDirector():getRunningScene();
    scene.layer:setVisible(true);
    self:runAction(CCMoveTo:create(0.4, ccp(display.width,0)))
    scene.layer:getChildByTag(3):setTouchEnabled(true);
    self:destory();
    --self:destory();
  end
  local head = CCLayerColor:create(ccc4(155,255,255,255))
  local menu = CCMenu:create()
  local setting = CCMenuItemImage:create("top_return.png", "top_return.png")
  setting:registerScriptTapHandler(menuCallbackBugsTest)
  menu:setPosition(30,self.headH/2);
  menu:addChild(setting);
  head:addChild(menu);
  head:setContentSize(CCSize(display.width,self.headH));
  head:setPositionY(display.height-self.headH);
  layer:addChild(head);
end

function Article:backIndex()
    local scene = CCDirector:sharedDirector():getRunningScene();
    scene.layer:setVisible(true);
    self:runAction(CCMoveTo:create(0.4, ccp(display.width,0)))
    scene.layer:getChildByTag(3):setTouchEnabled(true);
    scene.curName = "index";
    self:destory();
end

--创建bar
function Article:createButtom(layer)
  local head = CCLayerColor:create(ccc4(155,255,255,155))
  local menu = CCMenu:create()
  local setting = CCMenuItemImage:create("top_return.png", "top_return.png")
  --setting:registerScriptTapHandler(handler(self, self:backIndex()))
  menu:setPosition(30,self.headH/2);
  menu:addChild(setting);
  head:addChild(menu);
  head:setContentSize(CCSize(display.width,self.headH));
  head:setPositionY(0);
  layer:addChild(head);
end

function Article:destory()
  self:setTouchEnabled(false)
  self:removeFromParentAndCleanup(true);
end

return Article

