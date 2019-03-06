;����Ҫ���е�ahk�ű����ڸýű�ͬĿ¼�µ�scriptĿ¼�¡�
;��������Ҫ���еĽű������#NoTrayIcon��ʹ�䲻��ʾͼ��

#Persistent
#SingleInstance force
Menu, Tray, Icon, %A_ScriptDir%\tray.ico

SetWorkingDir %A_ScriptDir%\scripts\

DetectHiddenWindows On  ; ����̽��ű������ص������ڡ�
SetTitleMatchMode 2  ; ������Ҫָ��������ʾ���ļ�������·����

scriptCount = 0
edit = "Notepad"
OnExit ExitSub

Menu scripts_unopen, Add, �������, Menu_Tray_Exit
Menu scripts_unopen, ToggleEnable, �������
Menu scripts_unopen, Default, �������
Menu scripts_unopen, Add
Menu scripts_unclose, Add, ����ر�, Menu_Tray_Exit
Menu scripts_unclose, ToggleEnable, ����ر�
Menu scripts_unclose, Default, ����ر�
Menu scripts_unclose, Add
Menu scripts_edit, Add, �༭�ű�, Menu_Tray_Exit
Menu scripts_edit, ToggleEnable, �༭�ű�
Menu scripts_edit, Default, �༭�ű�
Menu scripts_edit, Add
Menu scripts_reload, Add, ���ؽű�, Menu_Tray_Exit
Menu scripts_reload, ToggleEnable, ���ؽű�
Menu scripts_reload, Default, ���ؽű�
Menu scripts_reload, Add

; ����scriptsĿ¼�µ�ahk�ļ�
Loop, %A_ScriptDir%\scripts\*.ahk
{
    StringRePlace menuName, A_LoopFileName, .ahk

    scriptCount += 1
    scripts%scriptCount%0 := A_LoopFileName

    IfWinExist %A_LoopFileName% - AutoHotkey    ; �Ѿ���
    {
        Menu scripts_unclose, add, %menuName%, tsk_close
        scripts%scriptCount%1 = 1
    }
    else
    {
        Menu scripts_unopen, add, %menuName%, tsk_open
        scripts%scriptCount%1 = 0
    }
    Menu scripts_edit, add, %menuName%, tsk_edit
    Menu scripts_reload, add, %menuName%, tsk_reload
}


; ���ӹ���ť
;Menu, Tray, Icon, %A_ScriptDir%\resources\ahk.ico
Menu, Tray, Click, 1
Menu, Tray, Tip, AHK Mange
Menu, Tray, Add, AHK Mange, Menu_Show
Menu, Tray, ToggleEnable,AHK Mange
Menu, Tray, Default,AHK Mange
;Menu, Tray, Add, �������нű�, tsk_openAll
Menu, Tray, Add, δ������, :scripts_unopen
;Menu, Tray, Add, �ر����нű�, tsk_closeAll
Menu, Tray, Add, ��������, :scripts_unclose
;Menu, Tray, Add
Menu, Tray, Add, �༭�ű�, :scripts_edit
Menu, Tray, Add, ���ؽű�, :scripts_reload
Menu, Tray, Add
Menu, Tray, Add, ��Ŀ¼, Menu_Tray_OpenDir
;Menu, Tray, Add
Menu, Tray, Add, ����, Menu_Tray_Reload
;Menu, Tray, Add
;Menu, Tray, Add, �༭����, Menu_Tray_Edit
;Menu, Tray, Add
Menu, Tray, Add, �˳�, Menu_Tray_Exit
Menu, Tray, NoStandard

GoSub tsk_openAll

Return

tsk_openAll:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If  scripts%A_index%1 = 0    ;û��
    {
        IfWinNotExist %thisScript% - AutoHotkey    ; û�д�
            Run %A_ScriptDir%\scripts\%thisScript%

        scripts%A_index%1 = 1

        StringRePlace menuName, thisScript, .ahk
        Menu scripts_unclose, add, %menuName%, tsk_close
        Menu scripts_unopen, delete, %menuName%
    }
}
Return

tsk_open:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If thisScript = %A_thismenuitem%.ahk  ; match found.
    {
        IfWinNotExist %thisScript% - AutoHotkey    ; û�д�
            Run %A_ScriptDir%\scripts\%thisScript%

        scripts%A_index%1 := 1

        Menu scripts_unclose, add, %A_thismenuitem%, tsk_close
        Menu scripts_unopen, delete, %A_thismenuitem%

        Break
    }
}
Return

tsk_close:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If thisScript = %A_thismenuitem%.ahk  ; match found.
    {
        WinClose %thisScript% - AutoHotkey
        scripts%A_index%1 := 0

        Menu scripts_unopen, add, %A_thismenuitem%, tsk_open
        Menu scripts_unclose, delete, %A_thismenuitem%

        Break
    }
}
Return

tsk_closeAll:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If scripts%A_index%1 = 1  ; �Ѵ�
    {
        WinClose %thisScript% - AutoHotkey
        scripts%A_index%1 = 0

        StringRePlace menuName, thisScript, .ahk
        Menu scripts_unopen, add, %menuName%, tsk_open
        Menu scripts_unclose, delete, %menuName%
    }
}
Return

tsk_edit:
Run, %edit% %A_ScriptDir%\scripts\%A_thismenuitem%.ahk
Return

tsk_reload:
Loop, %scriptCount%
{
    thisScript := scripts%A_index%0
    If thisScript = %A_thismenuitem%.ahk  ; match found.
    {
        WinClose %thisScript% - AutoHotkey
        Run %A_ScriptDir%\scripts\%thisScript%
        Break
    }
}
Return


Menu_Tray_OpenDir:
	Run %A_ScriptDir%
Return

Menu_Tray_Exit:
	ExitApp
Return

Menu_Tray_Reload:
	Reload
Return

Menu_Tray_Edit:
	Edit
Return

ExitSub:
    Loop, %scriptCount%
    {
        thisScript := scripts%A_index%0
        If scripts%A_index%1 = 1  ; �Ѵ�
        {
            WinClose %thisScript% - AutoHotkey
            scripts%A_index%1 = 0

            StringRePlace menuName, thisScript, .ahk
        }
    }
	Menu, Tray, NoIcon
    ExitApp
Return

Menu_Show:
    Menu, Tray, Show
Return
