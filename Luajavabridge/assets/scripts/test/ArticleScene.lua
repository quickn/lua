local ArticleScene = class("ArticleScene",function()
  return display.newScene("ArticleScene")
end
)

-- 在构造函数中初始化场景内容
function ArticleScene:ctor()
    -- 添加一张背景图
    local bg = display.newSprite("Button01.png", display.cx, display.cy)
    self:addChild(bg)
    -- 将背景图标记为自动清理
    self:markAutoCleanupImage("Button01.png")
    
    self.heigth = 100
 
    -- 创建一个文字显示对象，并保存到场景对象的 counterLabel 属性中
    self.counterLabel = ui.newTTFLabel({
        text = "FRAME 00000",
        font = "Arial",
        size = 24,
        x = display.cx,
        y = display.cy,
    })
    self:addChild(self.counterLabel)
    -- 初始化计数器
    self.counter = 0
end


function ArticleScene:onEnterFrame(dt)
    -- 在帧事件里增加计数器，并更新文字
    self.counter = self.counter + 1
    self.counterLabel:setString(string.format("FRAME %05d", self.counter))
end
 
function ArticleScene:onEnter()
    -- 在场景开始运行时，注册帧事件
    self:scheduleUpdate(handler(self, self.onEnterFrame))
end

return ArticleScene;