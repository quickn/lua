require("framework.init")

tonumber()

toint()

tobool()

totable()

t = {a=1,b=2}

t2 = clone(t)

local Sprite = class("sprite")

local son = class("Son",Sprite)

function Sprite:run()
  print("run")
end

math.round();

io.exist()

io.readfile()

io.writefile()

io.pathinfo('app/test/test.png')

io.filesize()

t3 = {a=3,b=2}

print(table.nums(t3))

table.keys(t3)

table.values(t3)

for i=0,table.values(t3) do
  print();
end







