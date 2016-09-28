# safety-rm
*Everybody know rm could be little dangerous to use,if u rm some unbackup or something by mistake,u can't just bring it back on a easy way,especially when u rm lots of file.*
###And i know there is much sh to prevent it.BUT THIS IS MY PROJECt,so i use the lua not bash.
##SRM IN LUA
  it use lua as save list,u can read list or search it to know when and where u rm your file.And u can bring it back by a easy way.
now,i maybe to tell u it's complete,when u use it,u should do this,
it depend on lua.so try to install lua5.3
and i use alias and fish,so,i think u can do it too.
add every command into your bashrc,if u want to add your command,i hope you use my style or like my style ,maybe u ask why?
because,,,reason.ehn.reason...and i'd like to accept your command,in fact i make a mistake in code,that make code slower but not very slow.
function rm
	lua ~/Code/safety-rm/rm.lua "rm" $argv (pwd)
end

in bash,
alias rm="lua ~/Code/safety-rm/rm.lua rm $1 $(pwd)"
just take these,it need 3 arg,first (command) (file or ID) (pwd)

###now it have these command
*rm $(filename)
list $(filename)
unrm $(fileID which found in list command)
rlrm $(fileID which found in list command)*
