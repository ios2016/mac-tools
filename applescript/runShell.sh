echo "applescript auto login ssh"
#这里可以知道密码文件位置
filePath="/Users/zhanghl/Library/Scripts/Applications/Terminal/pwd.prop"
osascript /Users/zhanghl/Library/Scripts/Applications/Terminal/autoSsh.scpt $filePath
exit 0
