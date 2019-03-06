;已知BUG
;在chrome浏览器在页面http://www.miui.com/thread-1423672-1-1.html，切屏时会出现同时翻页的bug

;已修复BUG
;在CAD中鼠标中键失效问题：使用#if与if进行先进行判定快捷键是否生效
;在印象笔记中，当编辑窗口激活时，快捷键失效：使用管理员权限运行程序

#SingleInstance force
#MaxHotkeysPerInterval 2000
#NoTrayIcon

CoordMode, Mouse, Screen
function_locationwin(){
	MouseGetPos, xpos,ypos,,contr,1
	;if  (xpos<40 and ypos>720) ;与屏幕分辨率有关
	if  ( xpos<1 )
		return 1
}

#if function_locationwin()
	WheelDown::send ^#{right}
	Wheelup::send ^#{left}
	Mbutton::send #{tab}
	return
 
XButton2::send ^#{left} ;有导航键的鼠标
XButton1::send ^#{right}

