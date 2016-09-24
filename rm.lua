fuc={}
list={}
installed="~/Code/lua/" --installmarked
pwd=arg[#arg].."/"
arg[#arg]=nil
trash="~/.trash/" --tra

loadfile (installed.."list.lua")--利用原来的表数据读入。

setmetatable(list,{__index=table})
local quiet=" >/dev/null 2>/dev/null"
ret=1
--删除 也就是rm啦
fuc.rm=function(args)
  if #args<2 then
	return 1;
  end
  local file={}
  for i=2,#args do
	table.insert(file,args[i])
	table.insert(file," ")
  end
  local time=os.date("%x-%X")
  local aim=trash..time
  --[[local exsit=os.execute ("ls "..aim..quiet)
  if not exsit then
	os.execute("mkdir "..aim..quiet)
  end]]
  os.execute("mkdir "..aim..quiet)
  local moved=os.execute("mv "..table.concat(file)..aim)
  list:insert({time,pwd,table.concat(file)})
  ret=1
end

fuc.list=function (args)
  local name
	if args>1 then
	  for j=2,#args do
		name=args[j]
		for i,v in pairs(list) do
		  if string.match(list[3],name) then
		    print ("ID: "..i,"time="..list[1],"path="..list[2],"file="..list[3])
		  end
		end
	  end
	else
	  for i,v in pairs(list) do
		print ("ID: "..i,"time="..list[1],"path="..list[2],"file="..list[3])
	  end
	end

end

fuc.unrm=function(args)
  local name
  print "make sure the ID please"
  local ID,file={}
  for i=2,#args do
	ID=args[i]
	string.gsub(list[ID],".- ",function (x) table.insert(file,x) end)
    --unfinished
	
  end
end



--保存list表
fuc.save=function ()
  file=io.open(installed.."list.lua","w+")
  local str={}
  setmetatable(str,{__index=table})
  str:insert("list={}\n")
  for i,v in pairs(list) do
	str:insert("list["..i.."]={\n    ")
	for j,k in pairs(v) do
	  str:insert("\""..k)
	  str:insert(",\n    ")
	end
	str[#str]="}\n"
  end
  if debug then
    print("list输出为:",str:concat())
  else
    file:write(str:concat())
    file:flush()
    file:close()
  end
end

--安装该脚本需要初始化一些数据
fuc.install=function(args)
	local newinstall=args[1]
	local newtrash=args[2]
	local file=io.open(pwd.."rm.lua","rw")
	local str=file:read("all")
	str=string.gsub(str,"installed=.-%-%-in","installed="..newinstalled .." %-%-in")
	str=string.gsub(str,"trash=.-%-%-tr","trash="..newtrash .." %-%-tr")
	file:write(str)
	file:flush()
	file:close()
end


if fuc[arg[1]] then
  fuc[arg[1]](arg)
  return ret
else
  print "No such command,please check help"
  return ret
end
