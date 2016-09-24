fuc.IDtoname=function (args)
	local file={}
	setmetatable(file,{__index=table})
	for i=2,#args do
	   if (not pcall(file:insert(list[args[i]]))) then
		   print "ID don't exsit,error 2"
	   end
   	end
	local name={},filename={}
	for i,v in pairs(file) do
	   v[3]=v[3].." "
	   v[3]=string.gsub(v[3],"\"*-\"",function (x) table.insert({v[2],name}) return nil end)
	   v[3]=string.gsub(v[3],"'*-'",function (x) table.insert({v[2],name}) return nil end)
	   v[3]=string.gsub(v[3],"[^ ]- ",function (x) table.insert({v[2],name}) return nil end)
	   end
	   for i,v in pairs(name) do
	     if string.sub(v[2],1,1)=="/" then
		   --real path
		 table.insert(filename,v[2])
   	     else
		   --false path
		 table.insert(filename,v[1].. v[2])
	     end
	   end
	   return filename;
end
