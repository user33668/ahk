#SingleInstance force
#NoTrayIcon

;将快捷方式放在“快捷键”目录下
SetWorkingDir %A_ScriptDir%/快捷键/

;设置快捷启动
^#f::run,"Everything"
^#s::run,"FSCapture"
^#e::run,"Evernote"
^#c::run,"计算器"
^#z::run,"ssr"
^#v::run,"v2rayN"
^#k::run,"KeePass"
^#b::
	IfWinExist, 屏幕键盘
		Winclose
	else
		run,"屏幕键盘"
	return
;^#X::run,notepad "%OneDrive%\文档\Diary.txt"
^#X::
	IfWinExist, Diary.txt - 记事本
	{
		IfWinActive, Diary.txt - 记事本
		{
   			Send, ^s
			Send,!{F4}
		}
		else
			WinActivate, Diary.txt - 记事本
		return
	}
	else
	{
		run, notepad "%OneDrive%\文档\Diary.txt"
	}
	return

;Ins::send {Raw}/etc/init.d/iptables restart

;控制音量
;RControl & Numpad8::Send,{Volume_Up}
;RControl & Numpad2::Send,{Volume_Down}

;快速切屏
#a::Send ^#{Left}
#s::Send ^#{right}

;快速输入
#F1::send,%A_YYYY%-%A_MM%-%A_DD%	 ;日期

;无效项目
;^#t::run,"D:\document\工具\比目鱼\比目鱼.exe";刚添加上去就失效，真是人生无常啊。