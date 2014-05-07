
require("framework.init")

echo("echo test");

printf("printf test %",34)

--echoError 除了输出信息外，还会打印当前的 Lua 调用堆栈。
echoError("echoError %","test")
echoInfo("echoInfo %","test")

echoLog("myTag","echoLog % % ","[v1,v2]")

local  arr = {a=1,b=2,c=3}
dump(arr,"arr")
