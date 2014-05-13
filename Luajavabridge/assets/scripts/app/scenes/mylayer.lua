local MyLayer  = class("MyLayer",function()
  local layer = CCLayerColor:create(ccc4(255,255,255,255))
  return layer;
end)

MyLayer.DIRECTION_VERTICAL   = 1
MyLayer.DIRECTION_HORIZONTAL = 2

function MyLayer:ctor()
	self.currentIndex = 0
	-- body
	self.height = display.height
	self.width =display.width;
	self.cells = {}
	    -- create container layer
	-- local view = display.newLayer();
	-- view:setPosition(CCPointMake(0,0));
 --  	view:setContentSize(CCSize(display.width,display.height));
 --    self.view = view;
 --    self:addChild(self.view)
end

function MyLayer:addCell(cell)
    self:addChild(cell)
    self.cells[#self.cells + 1] = cell
    self:reorderAllCells()
   -- self:dispatchEvent({name = "addCell", count = #self.cells})
end

function MyLayer:reorderAllCells()
    local count = #self.cells
    print("count:%d",count);
    local x, y = 0, 0
    local maxWidth, maxHeight = 0, 0
    for i = 1, count do
        local cell = self.cells[i]
        cell:setPosition(x, y)
        printf("i:%d x:%d y:%d ",i,x,y);
        if self.direction == MyLayer.DIRECTION_HORIZONTAL then
            local width = cell:getContentSize().width
            if width > maxWidth then maxWidth = width end
            x = x + width
        else
            local height = cell:getContentSize().height
            if height > maxHeight then maxHeight = height end
            y = y - height
        end
    end

    if count > 0 then
        if self.currentIndex < 1 then
            self.currentIndex = 1
        elseif self.currentIndex > count then
            self.currentIndex = count
        end
    else
        self.currentIndex = 0
    end

    local size
    if self.direction == MyLayer.DIRECTION_HORIZONTAL then
        size = CCSize(x, maxHeight)
    else
        size = CCSize(maxWidth, math.abs(y))
    end
    --self.view:setContentSize(size)
end

function MyLayer:addCell(cell,height,width)
	--剩余的高度
	self.height = self.height - height;
	printf("height:%d",self.height);
	if nil == width then
		width = display.cx;
	end
	cell:setPosition(ccp(width,self.height));
	x,y = cell:getPosition();
	printf("x %d  y %d tag : %d ",x,y,cell:getTag());
	--cell:setContentSize(CCSize(display.width,height));
	self:addChild(cell);
end

return MyLayer