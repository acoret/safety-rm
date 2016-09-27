fuc={}
list={}
if not arg then arg={} end
installed="/home/uncrepter/Code/safety-rm/" --installmarked
pwd=arg[#arg] .. "/"
arg[#arg]=nil
trash="~/.trash/" --tra
debug=nil
--print "debug set"

loadlist=loadfile (installed .. "list.lua")--利用原来的表数据读入。
loadtoname=loadfile (installed .."IDtoname.lua")
if loadlist then loadlist() end
loadtoname()

setmetatable(list,{__index=table})
do
if debug then
  local e=os.execute
  os.execute=print
end
end
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
  local time=string.gsub(os.date("%x-%X"),"/","-")
  local aim=trash..time
  --[[local exsit=os.execute ("ls "..aim..quiet)
  if not exsit then
	os.execute("mkdir "..aim..quiet)
  end]]
  os.execute("mkdir "..aim..quiet)
  local moved=os.execute("mv "..table.concat(file)..aim.."/")
  if debug then print (time,pwd,table.concat(file)) end
  list:insert({time,pwd,table.concat(file)})
  ret=1
end

fuc.list=function (args)
  local name
    if args then
	  if debug then print ("argn: " .. #args) end
	if #args>1 then
	  for j=2,#args do
		name=args[j]
		for i,v in pairs(list) do
		  if string.match(v[3],name) then
		    print ("ID: "..i,"time="..v[1],"path="..v[2],"file="..v[3])
		  end
		end
	  end
	else
	  for i,v in pairs(list) do
		print ("ID: "..i,"time="..v[1],"path="..v[2],"file="..v[3])
	  end
	end

	else
	  for i,v in pairs(list) do
		print ("ID: "..i,"time="..v[1],"path="..v[2],"file="..v[3])
	  end
	end

end

fuc.unrm=function(args) --change the way,use a functhion to get name,and now unrm just use mv
  local name
  print "Don't miss the ID !"
  local filename
  local aim,time	
  filename=fuc.IDtoON(args)

  for i,v in pairs(filename) do
	os.execute("mv " .. v[2] .. " "..v[1])
  end
  for i=2,#args do 
	list[tonumber(args[i])]=nil
  end
end



--保存list表
fuc.save=function ()
  file=io.open(installed.."list.lua","w")
  local str={}
  setmetatable(str,{__index=table})
  str:insert("list={}\n")
  for i,v in pairs(list) do
	str:insert("list["..i.."]={\n    ")
	for j,k in pairs(v) do
	  str:insert("\""..k)
	  str:insert("\",\n    ")
	end
	str[#str]="\"}\n"
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

fuc.rlrm=function (args)
  if #args<2 then return 0 end
  local v
  for i=2,#args do
	v=list[tonumber(args[i])]
		print ("ID: "..args[i],"time="..v[1],"path="..v[2],"file="..v[3])
	end
	print "are u sure? it can't be overi\nplease input the the ID again"
	local input=io.read()
	input=input .. " "
	local nargs={"mv "}
	string.gsub(input,"(.-) ",function(x) table.insert(x) end)
  end


if fuc[arg[1]] then
  fuc[arg[1]](arg)
  fuc.save()
  return ret
else
  print "No such command,please check help"
  return ret
end
