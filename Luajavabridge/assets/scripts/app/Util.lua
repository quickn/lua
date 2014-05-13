Util={}
function Util.print(text)
	--print(text)
end;
-- 当前场景
function Util.getCurScene() 
	return CCDirector:sharedDirector():getRunningScene()
end
-- 将按规则切割好的图片组合起来
function Util.createBoard(filename,height,c4)
	local board = display.newColorLayer(c4)

	local top=display.newSprite(filename .. "_top.png")
	local bottom=display.newSprite(filename .. "_bottom.png")
	local left=display.newSprite(filename .. "_left.png")
	local right=display.newSprite(filename .. "_right.png")
	
	local w=top:getContentSize().width
	w=w-left:getContentSize().width
	w=w-right:getContentSize().width
	local h = height -top:getContentSize().height
	h=h-bottom:getContentSize().height

	top:setAnchorPoint(ccp(0,0))
	top:setPosition(ccp(-right:getContentSize().width,h-1))
	
	bottom:setAnchorPoint(ccp(0,1))
	bottom:setPosition(ccp(-right:getContentSize().width,2))
	
	left:setAnchorPoint(ccp(1,0))
	left:setPosition(ccp(0,0))
	left:setScaleY(h/left:getContentSize().height)	
	
	right:setAnchorPoint(ccp(0,0))
	right:setPosition(ccp(w,0))
	right:setScaleY(h/right:getContentSize().height)

	board:addChild(top,100)
	board:addChild(bottom,100)
	board:addChild(left,100)
	board:addChild(right,100)

	board:setContentSize(CCSizeMake(w+2,h))
	board:ignoreAnchorPointForPosition(false)
	return board
end

function Util.createLevelBoard(filename,c4) 
	local levelBg=display.newScale9Sprite(filename, 0, 0, CCSize(601,547))
	levelBg:setAnchorPoint(ccp(0.5,0.5))
	return levelBg
end 
--[[使用缓存中的图片创建按钮 
	filenames : 参数为string类型时，filename的内容是完整的路径，或者图片名称加上“#”作为前缀
			    参数为table类型时，filename的每一个元素的内容是完整的路径，或者图片名称加上“#”作为前缀
	isTint   : 是否变色，isTint不等于false的时候变色
	func     : 点击按钮时触发的函数
--]]
function Util.createMenuItem(filenames,isTint,func) 
	-- filenames可以是string也可以是table
	local normal,selected,disabled=nil,nil,nil
	if type(filenames)=="string" then
		normal,selected,disabled=filenames,filenames,filenames
	elseif type(filenames)=="table" then
		normal,selected,disabled=filenames[1],filenames[2],filenames[3]
	end
	if nil==selected then selected=normal end
	if nil==disabled then disabled=selected end

	if(func==nil)then func=function() Util.print("------ listener is nil value") end end
	local obj={
		image=normal,
		imageSelected= selected,
		imageDisabled= disabled,
		listener=function (s)
			Util.playEffect("btnclick.ogg")
			func(s)
		end;
	}
	local item = ui.newImageMenuItem(obj);
    -- local n=item:getNormalImage();
	local s=item:getSelectedImage();
	-- local d=item:getDisabledImage();

    if isTint~=false then s:runAction(CCTintTo:create(0, 75, 75, 75)) end
    return item
end
-- 清除对话框
function Util.destoryDialog()
	if nil~=GameConstant.dialogView then  
		GameConstant.dialogView:destory()
	end
end

--[[
text:文本内容
fontsize:字体尺寸
number:每行字数
--]]
function Util.createTextDialog(text,fontsize,number) 
	-- local no=#text/3 --中文字符串的长度
	local no=string.utf8len(text)--中文字符串的长度
	local line =math.ceil(no/number)--的到行数
	local lab=CCLabelTTF:create(text,"Arial",fontsize)
	local W=300
	W=W/15*number
	if line~=1 then
		lab=CCLabelTTF:create(text,CCSize(250,30),kCCTextAlignmentLeft,"Arial",fontsize)
	end
	lab:setAnchorPoint(ccp(0,0.5))
	lab:setColor(ccc3(33,33,33))
	local H=(35-math.floor(line/3.8)*2)*line
	--lab.setContentSize(H);
	return lab,H
end
--[[
	转换为普通的Menu
]]--
function Util.toOrignMenuItem(obj)
	if(obj.imageSelected==nil)then
		obj.imageSelected=obj.image;		
	end;
	if(obj.imageDisabled==nil)then
		obj.imageDisabled=obj.image;		
	end;
	local  func = obj.listener;
	obj.listener=function (s)
		Util.playEffect("btnclick.ogg")
		func(s)
	end;
	local item = ui.newImageMenuItem(obj);
	local normal=item:getNormalImage();
	local select=item:getSelectedImage();
	local disable=item:getDisabledImage();
	normal:setAnchorPoint(CCPoint(0.5, 0.5));
	select:setAnchorPoint(CCPoint(0.5, 0.5));
	disable:setAnchorPoint(CCPoint(0.5, 0.5));
	select:setColor(ccc3(75, 75, 75));
	disable:setColor(ccc3(75, 75, 75));
	normal:setPosition(CCPoint(normal:getContentSize().width / 2, normal:getContentSize().height / 2));
	select:setPosition(CCPoint(normal:getContentSize().width / 2, normal:getContentSize().height / 2));
	disable:setPosition(CCPoint(normal:getContentSize().width / 2, normal:getContentSize().height / 2));
	if(obj.active)then
		item.active=obj.active;
		item.image=obj.image;
	end
	return item;
end
