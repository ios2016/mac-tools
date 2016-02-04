
## 用applescript实现读取配置文件，选择登录的ssh 用户名与密码，实现自动终端登录 ##

用Automoter 添加服务，运行shell ，
设置启动快捷键，我这里用command+shift+0
![设置启动快捷键][1]

----------

## 运行结果 ##
运行快捷键  command+shift+0
需注意：当前光标所在的程序的快捷键冲突

 1. 选择登陆的主机
 
![选择登陆的主机][2]
 2. 选择好后，会自动打开终端，并粘贴用户与密码，可能网络不好，ssh会慢点，密码在剪切板中，手动粘贴即可，程序中延迟1s粘贴密码

![enter description here][3]



  [1]: https://github.com/ios2016/mac-tools/blob/master/doc/imgs/sshAuto/1454595761026.jpg "1454595761026.jpg"
  [2]: https://github.com/ios2016/mac-tools/blob/master/doc/imgs/sshAuto//1454596185616.jpg "1454596185616.jpg"
  [3]: https://github.com/ios2016/mac-tools/blob/master/doc/imgs/sshAuto//1454596328180.jpg "1454596328180.jpg"
