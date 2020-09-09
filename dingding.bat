@echo off
::任务计划需要定向到ADB目录
cd C:\ADB

::此处修改设备IP地址
::adb connect 192.168.1.233:5555 

::或直接USB插电脑
::adb devices

::模拟按下电源键（需要设备没有设置锁屏）
adb shell input keyevent 26
TIMEOUT /T 3

::模拟点击桌面钉钉图标（自己修改坐标定位）
adb shell input tap 1090 900

::等待15秒极速打卡
TIMEOUT /T 15

::点击下方菜单键（自己修改坐标定位）
adb shell input tap 600 1780

::等待按钮出现
TIMEOUT /T 15

::点击打卡按钮（自己修改坐标定位）
adb shell input tap 600 1010

::等待完全载入
TIMEOUT /T 25

::格式化日期和时间
set today=%date:~0,10%
set hm=%time:~0,2%-%time:~3,2%

::输出打卡结果截图
adb exec-out screencap -p > "打卡截图\打卡时间%today%_%hm%.png"

::关闭钉钉APP
adb shell am force-stop com.alibaba.android.rimet

::邮件标题
set tilte="定时打卡"

::邮件正文内容
set mail=content.txt

::邮件附件图片
set file="打卡截图\打卡时间%today%_%hm%.png"

::接收人
set receiver=usr@xx.com

::发送人
set sender=usr@xxx.com

::邮箱密码
set pwd=12345

::发送消息
blat %mail% -attach %file% -s %tilte% -to %receiver% -server smtp.mxhichina.com -f %sender% -u %sender% -pw %pwd%

::结束ADB程序
::taskkill /f /im adb.exe
