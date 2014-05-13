local Article  = class("Article",function(isClip)
  local layer = display.newColorLayer(ccc4(0, 0, 0, 155));
  layer.isClip=isClip
  return layer
end)

function Article:ctor()
  self:setColor(display.COLOR_WHITE)
  self.headH = 60
  self.barH = 60
  self.ViewH = display.height - self.headH - self.barH
  self:createScrollView();
  self:createHead();
  self:createButtom();
end

function Article:createScrollView()
  local scrollView = CCScrollView:create()
  scrollView:setPosition(ccp(0,0))
  --scrollView:setScale(1.0)
  scrollView:setViewSize(CCSizeMake(display.width,display.height))
  scrollView:setDirection(kCCScrollViewDirectionVertical)
  --scrollView:setClippingToBounds(true)
  --scrollView:setBounceable(true)
  --设置颜色
  local layerColor = CCLayerColor:create(ccc4(250,250,250,250));
  scrollView:setContainer(layerColor)
  scrollView:setKeypadEnabled(true)
  self:addChild(scrollView)
end

--创建头部
function Article:createHead()
  local function menuCallbackBugsTest()
    self:runAction(CCMoveTo:create(0.4, ccp(display.width,0)))
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
  self:addChild(head);
end

--创建bar
function Article:createButtom()
  local function menuCallbackBugsTest()
    device.showAlert("dd","test");
  end
  local head = CCLayerColor:create(ccc4(155,255,255,155))
  local menu = CCMenu:create()
  local setting = CCMenuItemImage:create("top_return.png", "top_return.png")
  setting:registerScriptTapHandler(menuCallbackBugsTest)
  menu:setPosition(30,self.headH/2);
  menu:addChild(setting);
  head:addChild(menu);
  head:setContentSize(CCSize(display.width,self.headH));
  head:setPositionY(0);
  self:addChild(head);
end

function Article:destory()
  self:setTouchEnabled(false)
  self:removeFromParentAndCleanup(true);
end

return Article

