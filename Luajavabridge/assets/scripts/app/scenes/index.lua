require("app.Util")
local Index = class("Index",function()
  return display.newScene("Index")
end)

function Index:ctor()
  self:setColor(display.COLOR_WHITE)
  self.headH = 60
  self.barH = 20
  self.menuH = 50
  self.ViewH = display.height - self.headH - self.barH - self.menuH;
  local layer = require("app.scenes.mylayer").new() ;
  layer:setPosition(0,0);
  layer:setContentSize(CCSize(display.width,display.height));
  self.layer = layer
  self:createHead()
  self:createBar();
  self:createTableView()
  self:createMenus();
  self:addChild(layer);
end

--创建头部
function Index:createHead()
  local function menuCallbackBugsTest()
    device.showAlert("dd","test");
  end
  local logo = display.newScale9Sprite("sight_read_header_def.png",display.cx,self.headH/2)
  logo:setScale(0.4)
  local head = CCLayerColor:create(ccc4(155,255,255,255))
  local menu = CCMenu:create()
  local setting = CCMenuItemImage:create("setting_btn_n.png", "setting_btn_n.png")
  setting:registerScriptTapHandler(menuCallbackBugsTest)
  menu:setPosition(display.width-30,self.headH/2);
  menu:addChild(setting);
  head:addChild(menu);
  head:addChild(logo);
  self.layer:addCell(head,self.headH,0);
end

--创建bar
function Index:createBar()
  local function menuCallbackBugsTest()
    device.showAlert("dd","test");
  end
  local  menu = CCMenu:create()
  local fonds = {"最新 ","心灵鸡汤","视界","成长"}
  CCMenuItemFont:setFontSize(20);
  CCMenuItemFont:setFontName("Arial");
  for index,title in pairs(fonds) do
    local item = CCMenuItemFont:create(title)
    item:setColor(display.COLOR_BLACK)
    --item:setPositionX(display.width/4*index);
    item:registerScriptTapHandler(menuCallbackBugsTest)
    menu:addChild(item);
  end;
  menu:alignItemsHorizontally()
  --menu:setContentSize(CCSize(display.width,40));
  menu:setTag(2);
  self.layer:addCell(menu,self.barH);
end


function Index:scrollViewDidScroll(view)
  print("scrollViewDidScroll")
end

function Index:scrollViewDidZoom(view)
  print("scrollViewDidZoom")
end

function Index:tableCellTouched(table,cell)
  print("cell touched at index: " .. cell:getIdx())
end

local function cellSizeForTable(table,idx)
  return 65,65
end

local function tableCellTouched(table,cell)
  print("cell touched at index: " .. cell:getIdx())
  local article = require("app.views.article").new();
  --Util.getCurScene():runAction(CCMoveTo:create(0.4, ccp(display.width,display.height)))
  CCDirector:sharedDirector():getRunningScene():addChild(article);
end

local function tableCellAtIndex(table, idx)
  local strValue = string.format("%d",idx)
  local cell = table:dequeueCell()
  local label = nil
  local winSize = CCDirector:sharedDirector():getWinSize()
  if nil == cell then
    cell = CCTableViewCell:new()
    local sprite = CCSprite:create("Icon.png")
    sprite:setPositionX(400)
    cell:addChild(sprite)
    label = CCLabelTTF:create(strValue.."start", "Helvetica", 20.0)
    label:setDimensions(CCSize(300,70));
    label:setPositionX(150)
    --bel:setAnchorPoint(CCPointMake(0,0))
    label:setColor(display.COLOR_BLACK)
    label:setTag(123)
    cell:addChild(label)
  else
    label = tolua.cast(cell:getChildByTag(123),"CCLabelTTF")
    if nil ~= label then
      label:setString(strValue.."sdfsdfffffffffffffffffffffffffffffffffffffffffffffffffffffff")
    end
  end
  return cell
end

local function numberOfCellsInTableView(table)
  return 20
end

local function scrollViewDidScroll(view)

end

local function scrollViewDidZoom(view)

end

function Index:createTableView()
  local winSize = CCDirector:sharedDirector():getWinSize()
  local tableView = CCTableView:create(CCSizeMake(display.width,self.ViewH))
  tableView:setDirection(kCCScrollViewDirectionVertical)
  --tableView:setPosition(CCPointMake(display.left, 140))
  tableView:setVerticalFillOrder(kCCTableViewFillTopDown)
  tableView:registerScriptHandler(scrollViewDidScroll,CCTableView.kTableViewScroll)
  tableView:registerScriptHandler(scrollViewDidZoom,CCTableView.kTableViewZoom)
  tableView:registerScriptHandler(tableCellTouched,CCTableView.kTableCellTouched)
  tableView:registerScriptHandler(cellSizeForTable,CCTableView.kTableCellSizeForIndex)
  tableView:registerScriptHandler(tableCellAtIndex,CCTableView.kTableCellSizeAtIndex)
  tableView:registerScriptHandler(numberOfCellsInTableView,CCTableView.kNumberOfCellsInTableView)
  tableView:reloadData()
  tableView:setTag(3);
  tableView:setColor(ccc3(0,0,0));
  self.layer:addCell(tableView,self.ViewH,0)
end

function Index:onTapLevelIcon(event)
  device.showAlert("",event)
end

--创建底部的菜单
function Index:createMenus()
  local function menuCallback(event)
    device.showAlert('',event);
  end
  local  menu = CCMenu:create()
  local imgs = {"yl_menu_item_self.png ","yl_menu_item_cope.png","yl_menu_item_part.png","yl_menu_item_weibo.png"}
  for i,img in pairs(imgs) do
    i = i -1;
    local nomal = display.newScale9Sprite(img,0,25,CCSize(display.width/4,self.menuH))
    local selected = display.newScale9Sprite("yl_menu_item_s.png",0,25,CCSize(display.width/4,self.menuH))
    local item3 = CCMenuItemSprite:create(nomal,selected,null)
    --item3:setColor(display.COLOR_BLACK);
    item3:setTag(i)
    item3:setPositionX(display.width/4*i+display.width/4/2);
    item3:registerScriptTapHandler(menuCallback)
    menu:addChild(item3);
  end
  --menu:alignItemsHorizontally()
  menu:setTag(4);
  menu:setPosition(0,0);
  local head = CCLayerColor:create(ccc4(155,255,255,255))
  head:setContentSize(CCSize(display.width,self.menuH))
  head:addChild(menu);
  self.layer:addCell(head,self.menuH,0);
end

function Index:onEnter()
  if device.platform ~= "android" then return end
  self:performWithDelay(function()
    -- keypad layer, for android
    local layer = display.newLayer()
    layer:addKeypadEventListener(function(event)
      if event == "back" then os.exit() end
    end)
    self:addChild(layer)
    layer:setKeypadEnabled(true)
  end, 0.5)
end
return Index

