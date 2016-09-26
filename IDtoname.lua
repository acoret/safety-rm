fuc.IDtoON=function (args)-- get the old path
	local file={}
	setmetatable(file,{__index=table})
	for i=2,#args do
	   if (not pcall(file:insert(list[args[i]]))) then
		   print "ID don't exsit,error 2"
	   end
   	end
	local name={},filename={},work,tfpath,tryname
	for i,v in pairs(file) do --insert time and try more
	   work=v[3].." "
	   work=string.gsub(work,"\"*-\"",function (x) table.insert(name,{v[2],x}) return nil end)
	   work=string.gsub(work,"'*-'",function (x) table.insert(name,{v[2],x}) return nil end)
	   work=string.gsub(work,"[^ ]- ",function (x) table.insert(name,{v[2],x}) return nil end)
	   end
	   for i,v in pairs(name) do
		tryname=string.match(v[2],".+/(.-$)")
		if not tryname then tryname=v[2] end
	     if string.sub(v[2],1,1)=="/" then --v[2]=real filename v[3]=trashname
		   --real path
		 table.insert(filename,{v[2],tfpath})
   	     else
		   --false path
		 table.insert(filename,{v[1].. v[2],tfpath})
	     end
	   end
	   return filename;
end
