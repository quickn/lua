local MainScene = class("MainScene", function()
  return display.newScene("MainScene")
end)

function MainScene:ctor()
  local item = ui.newTTFLabelMenuItem({
    text = "call Java - showAlertDialog()",
    size = 64,
    x = display.cx,
    y = display.cy,
    align = ui.TEXT_ALIGN_CENTER,
    listener = function()
      -- call Java method
      self:callBack('hello');
    --      local javaClassName = "com.quick_x.sample.activity.Luajavabridge"
    --      local javaMethodName = "showAlertDialog"
    --      local javaParams = {
    --        "How are you ?",
    --        "I'm great !",
    --        --function(event)
    --        --printf("Java method callback value is [%s]", event)
    --        self:callBack()
    --      --end
    --      }
    --      local javaMethodSig = "(Ljava/lang/String;Ljava/lang/String;I)Z"
    --      local ret = luaj.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    --      print("return",ret);
    end
  })
  self:addChild(ui.newMenu({item}))
end



local function onButtonClicked(event)


  echoError("echoError %q","test")

  echoInfo("echoInfo %q","test")

  echoLog("myTag","echoLog %q ","test")

  if event.buttonIndex == 1 then
  --.... 玩家选择了 YES 按钮
  else
  --.... 玩家选择了 NO 按钮
  end
end

function MainScene:callBack(hello)
  device.showAlert("Confirm Exit", "Are you sure exit game ?", {"YES", "NO"}, onButtonClicked)
  --device.showAlert("Alert","Are you sure exit game?", {"YES", "NO"},onButtonClicked);
  --  local item = ui.newTTFLabelMenuItem({
  --    text = 'VALUE showAlertDialog',
  --    size = 60,
  --    x = 0,
  --    y = 100,
  --    align = ui.TEXT_VALIGN_TOP
  --  })
  --  self:addChild(ui.newMenu({item}))
end

function MainScene:onEnter()
  if device.platform ~= "android" then return end
  -- avoid unmeant back
  self:performWithDelay(function()
    -- keypad layer, for android
    local layer = display.newLayer()
    layer:addKeypadEventListener(function(event)
      if event == "back" then game.exit() end
    end)
    self:addChild(layer)

    layer:setKeypadEnabled(true)
  end, 0.5)
end

return MainScene
