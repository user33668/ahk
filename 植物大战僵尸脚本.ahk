#SingleInstance force
#IfWinActive ahk_exe PlantsVsZombies.exe

;��ʼ������
CoordMode, Mouse,Client
global state:=0
global NAME:="ֲ���ս��ʬ���İ�"

;�Զ�ʰȡ
#Persistent
SetTimer, Auto_click, 100
return

;��ݰ���
`::function_click(480,50)
1::function_click(120,50)
2::function_click(180,50)
3::function_click(240,50)
q::function_click(300,50)
W::function_click(360,50)
E::function_click(420,50)

;�Զ�ʰȡ����
Auto_click:
{
	if(state)
	{
		if(function_istargate())
		{
			MouseClick, left
			ToolTip,�Զ�ʰȡ
		}
		else
			ToolTip,	
	}
return
}

;�Զ�ʰȡ����
F1::
{
	MouseGetPos, , , id,
	WinGetTitle, title, ahk_id %id%
	if(title = NAME)
	{
		if(state)
		{
			state:=0
			ToolTip,
		}
		else
			state:=1
	}
return
}

function_istargate(){
		MouseGetPos, , , id,
		WinGetTitle, title, ahk_id %id%
		;ToolTip, ahk_id %id%`n%title%
		if(title=NAME)
			return true
		else
			return false
}

function_click(X,Y){
	state:=0
	MouseGetPos, Xpos, Ypos
	MouseClick, left, X, Y, 1,0
	MouseClick, left, Xpos, Ypos
	state:=1
	return
}

