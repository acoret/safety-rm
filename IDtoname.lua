fuc.IDtoON=function (args)-- get the old path
	local file={},work
	setmetatable(file,{__index=table})
	for i=2,#args do
	  work=list[tonumber(args[i])]
	   if (not work) then
		   print "ID don't exsit,error 2"
		 else
		   file:insert(work)
	   end
   	end
	if debug then print ("n of file in IDtoON:",#file) end
	local name,filename,work,tfpath,tryname
	name={}
	filename={}
	for i,v in pairs(file) do --insert time and try more
	   work=v[3].." "
	   local add=function(x) if debug then print ("matched in IDtoON:",x) end if x~=" " then table.insert(name,{v[2],x,v[1]}) return "" end end
	   work=string.gsub(work,"\"(.-)\"",add)
	   work=string.gsub(work,"'(.-)'",add)
	   work=string.gsub(work,"[^ ]- ",add)
	   end
	   for i,v in pairs(name) do
		tryname=string.match(v[2],".+/((.-))$")
		if debug then print("tryname in IDtoON:",tryname) end
		if not tryname then tryname=v[2] end
		tfpath=trash..v[3].."/"..tryname
		local fir=string.sub(v[2],1,1)
		local sec=string.sub(v[2],2,2)
	     if (fir~="~" and fir=="/") or (fir=="~" and sec=="/") then --v[2]=real filename v[3]=trashname
		   --real path
		 table.insert(filename,{"'"..v[2].."'","'"..tfpath.."'"})
   	     else
		   --false path
		 table.insert(filename,{"'"..v[1].. v[2].."'","'"..tfpath.."'"})
	     end
	   end
	   return filename
end
