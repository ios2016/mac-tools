(*  
	ssh auto login
	用于读取密码配置文件，选择需要登录的远程服务器，实现自动登录
	@date:2016年02月03日00:11:49
	@auth Jeff Zhang
*)


(*
open Terminal
case terminal exist,open new tab
case terminal not exist,open new terminal
*)
on makeNewTerminal()
	tell application "System Events"
		try
			set terminal to application process "Terminal"
			set newBoo to false
		on error the error_message number the error_number
			tell application "Terminal" to launch
			--	set newTab to do script "" -- create a new window with no initial command
			--	set current settings of newTab to settings set "Grass"
			-- end tell
			delay 0.5
			set newBoo to true
		end try
		
		set terminal to application process "Terminal"
		set frontmost of terminal to true
		delay 0.5
		-- keystroke "n" using command down
		
		if newBoo then
			keystroke "n" using command down
		else
			keystroke "t" using command down
		end if
	end tell
end makeNewTerminal


(*
login ssh
If the speed of network is slow，you can use command + v to paste password .
because in this program delay 1s
*)
on sshLogin(uname, pwd)
	
	makeNewTerminal()
	beep
	set sshCommand to "ssh " & uname & "
"
	set the clipboard to sshCommand
	tell application "System Events"
		(* Note that the input method is not English *)
		keystroke "v" using command down
		delay 1
		set sshPwd to pwd & "
"
		set the clipboard to sshPwd
		keystroke "v" using command down
		-- set the clipboard to pwd
	end tell
end sshLogin
-- sshLogin("root@192.168.1.71", "password")

on selectItems(itemList)
	if itemList = null or length of itemList = 0 then
		display dialog "empty ssh information list" buttons {"OK"} default button 1
		return false
	end if
	set itemKeys to {}
	repeat with i in itemList
		set end of itemKeys to key1 of i
	end repeat
	set theSelected to choose from list itemKeys with prompt "Pick a ssh connect:"
	if theSelected ≠ false then
		set selectdValue to first item of theSelected
		repeat with i in itemList
			set k to key1 of i
			if k is equal to selectdValue then
				set r to key2 of i
				log "you choose result value is " & r
				return r
			end if
		end repeat
	end if
	return theSelected
end selectItems

on test()
	set FoldersList to {}
	set end of FoldersList to {key1:"RAA", key2:"Research:Journals:RAA11111:"}
	set end of FoldersList to {key1:"Project", key2:"Research:Project:"}
	set end of FoldersList to {key1:"MYSELF", key2:"MYSELF:"}
	set end of FoldersList to {key1:"DoctorPHD", key2:"MYSELF:DoctorPHD"}
	set end of FoldersList to {key1:"Photos", key2:"MYSELF:Photos"}
	set end of FoldersList to {key1:"Journals", key2:"Research:Journals"}
	set end of FoldersList to {key1:"Personal", key2:"Research:Personal"}
	set sresult to selectItems(FoldersList)
	
	if sresult ≠ false then
		set KeyWordSelected to item 1 of sresult
		log "result " & sresult & "  " & KeyWordSelected
	end if
end test

on readSshPropFile(filePath)
	set rs to {}
	try
		set file2content to read POSIX file filePath as «class utf8»
	on error the error_message number the error_number
		display dialog "Error: " & filePath & " not exist" buttons {"Cancel"} default button 1
		return false
	end try
	
	set theLines to paragraphs of file2content
	set AppleScript's text item delimiters to "	"
	
	repeat with linestr in theLines
		if linestr starts with "#" then
		else
			set file2s to every text item of linestr
			if length of file2s = 2 then
				set key1 to first item of file2s
				set key2 to item 2 of file2s
				if key2 contains "=" then
					set end of rs to {key1:key1, key2:key2}
				else
					log key2 & " not right"
				end if
			end if
		end if
	end repeat
	return rs
end readSshPropFile


on main(thefilePath)
	set sshInfoList to readSshPropFile(thefilePath)
	log sshInfoList
	if sshInfoList ≠ false then
		set selectValue to selectItems(sshInfoList)
		if selectValue ≠ false then
			set AppleScript's text item delimiters to "="
			set file2s to every text item of selectValue
			set uname to item 1 of file2s
			set pwd to item 2 of file2s
			log uname & "=" & pwd
			sshLogin(uname, pwd)
		end if
	end if
end main


on run argv
	set thefilePath to "/Users/zhanghl/Library/Scripts/Applications/Terminal/pwd.prop"
	if length of argv = 1 then
		set thefilePath to item 1 of argv
	end if 

	main(thefilePath)
end run




