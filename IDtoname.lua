fuc.IDtoOP=function (args)-- get the old path
	local file={}
	setmetatable(file,{__index=table})
	for i=2,#args do
	   if (not pcall(file:insert(list[args[i]]))) then
		   print "ID don't exsit,error 2"
	   end
   	end
	local name={},filename={},work
	for i,v in pairs(file) do
	   work=v[3].." "
	   work=string.gsub(work,"\"*-\"",function (x) table.insert(name,{v[2],x}) return nil end)
	   work=string.gsub(work,"'*-'",function (x) table.insert(name,{v[2],x}) return nil end)
	   work=string.gsub(work,"[^ ]- ",function (x) table.insert(name,{v[2],x}) return nil end)
	   end
	   for i,v in pairs(name) do
	     if string.sub(v[2],1,1)=="/" then
		   --real path
		 table.insert(filename,{v[2],v[2]})
   	     else
		   --false path
		 table.insert(filename,{v[1].. v[2],v[2]})
	     end
	   end
	   return filename;
end
