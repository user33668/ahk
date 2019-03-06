#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
;#NoTrayIcon
;#UseHook on


;TODO 
;激活修饰键更改颜色，而不是显示下划线
;小键盘暂时无法区分numlock状态，需要进一步修改
;无法激活其他脚本中的快捷键
;Capalock Numlock Scrlock 显示状态

;2019-01-02 Fym
;重新排布键盘
;区分左右Alt Ctrl Win Shift 按键
;加入小键盘

  ;w1:基础键宽度 h1:基础键高度 d1:基础键间距 j1:每行的第一个键起始位置 p1:窗口显示位置
  w1:=50, h1:=32, d1=2, j1:=["xm","xm y+"d1*5,"xm y+"d1,"xm y+"-h1,"xm y+"d1,"xm y+"-h1], p1="xcenter y820"
  NewName:={" ":"Space","App":"AppsKey","PrtSc":"PrintScreen","Scrlk":"ScrollLock","Caps":"CapsLock","Num":"NumLock"
          ,"↑":"Up", "↓":"Down","←":"Left", "→":"Right"
          ,1:"Numpad1/NumpadEnd",2:"Numpad2/NumpadDown",3:"Numpad3/NumpadPgDn"
          ,4:"Numpad4/NumpadLeft",5:"Numpad5/NumpadClear",6:"Numpad6/NumpadRight"
          ,7:"Numpad7/NumpadHome",8:"Numpad8/NumpadUp",9:"Numpad9/NumpadPgUp",0:"Numpad0/NumpadIns"
          ,".":"NumpadDot","/":"NumpadDiv","*":"NumpadMult","+":"NumpadAdd","-":"NumpadSub","Ent":"NumpadEnter"}
  
  ModifierKeys := {"LShift":0,"LCtrl":0,"LWin":0,"LAlt":0 ;mks
                  ,"RShift":0,"RCtrl":0,"RWin":0,"RAlt":0}
  ; 键盘布局：[ 键名，宽度，间距 ,高度]

  s1:=[ ["Esc"],["F1",,w1+d1*2],["F2"],["F3"],["F4"],["F5",,w1*0.5+d1]
     ,["F6"],["F7"],["F8"],["F9",,w1*0.5+d1],["F10"],["F11"],["F12"]
     ,["PrtSc",w1*1.2,d1*5],["Scrlk",w1*1.2],["Pause",w1*1.2] ]

  s2:=[ ["~ ``"],["! 1"],["@ 2"],["# 3"],["$ 4"],["% 5"],["^ 6"]
     ,["&& 7"],["* 8"],["( 9"],[") 0"],["_ -"],["+ ="],["Backspace",w1*2]
     ,["Ins",w1*1.2,d1*5],["Home",w1*1.2],["PgUp",w1*1.2],["Num",,d1*5],["/"],["*"],["-"]]

  s3:=[ ["Tab",w1*1.5],["q"],["w"],["e"],["r"],["t"],["y"]
     ,["u"],["i"],["o"],["p"],["{ ["],["} ]"],["| \",w1*1.5]
     ,["Del",w1*1.2,d1*5],["End",w1*1.2],["PgDn",w1*1.2],["7",,d1*5],["8"],["9"],["+",,,h1*2+d1] ]

  s4:=[ ["Caps",w1*2],["a"],["s"],["d"],["f"],["g"],["h"]
     ,["j"],["k"],["l"],[": `;"],[""" '"],["Enter",w1*2+d1],["4",,d1*5+w1*1.2*3+d1*2+d1*5],["5"],["6"] ]

  s5:=[ ["LShift",w1*2.5+d1],["z"],["x"],["c"],["v"],["b"]
     ,["n"],["m"],["< ,"],["> ."],["? /"],["RShift",w1*2.5+d1],["↑",w1*1.2,d1*5+w1*1.2+d1]
     ,["1",,d1+w1*1.2+d1*5],["2"],["3"],["Ent",,,h1*2+d1]]

  s6:=[ ["LCtrl",w1*1.2],["LWin",w1*1.2],["LAlt",w1*1.2],[" ",w1*6.6+d1*6]
     ,["RAlt",w1*1.2],["RWin",w1*1.2],["App",w1*1.2],["RCtrl",w1*1.2]
     ,["←",w1*1.2,d1*5],["↓",w1*1.2],["→",w1*1.2],["0",w1*2+d1,d1*5],["."]]

  Gui, OSK: Destroy
  Gui, OSK: +AlwaysOnTop +Owner +E0x08000000 ; +E0x08000000 点击不激活
  Gui, OSK: Font, s12, Inziu Iosevka SC
  Gui, OSK: Margin, 10, 10
  Gui, OSK: Color, DDEEFF
  Loop, 6 {
    counts:=A_Index ;for循环内无法直接访问loop的A_Index，用counts承接
    For i,v in s%A_Index%
    {
      w:=v.2 ? v.2 : w1
      d:=v.3 ? v.3 : d1
      h:=v.4 ? v.4 : h1
      j:= i=1 ? j1[counts] : "x+"d
      Gui, OSK: Add, Button, %j% w%w% h%h% -Wrap gRunOSK , % v.1
    }
  }
  Gui, OSK: Show, NA %p1%, 屏幕键盘

  RunOSK:
  k:=A_GuiControl
  if k in LShift,LCtrl,LWin,LAlt,RShift,RCtrl,RWin,RAlt
  {
    ModifierKeys[k]:=ModifierKeys[k]?0:1
    if (ModifierKeys[k])
    {
      Gui, Font, bold 
      GuiControl, OSK: Font, % k
    }Else{
      Gui, Font, norm
      GuiControl, OSK: Font, % k  
      SendInput, {Blind}{%k%}
    }
    return
  }
  k:=NewName[k] ? NewName[k] : k
  k:=InStr(k,"/Numpad") ? (GetKeyState("NumLock","T")? StrSplit(k,"/")[1] : StrSplit(k,"/")[2]):k
  k:=InStr(k," ") ? SubStr(k,0) : k ;for example  get '/' from ["? /"]
  k:="{" k "}"
  For i,mks in ["LShift","LCtrl","LWin","LAlt","RShift","RCtrl","RWin","RAlt"]
  {
    if (ModifierKeys[mks])
    {
      ModifierKeys[mks] := 0
      Gui, Font, norm
      GuiControl, OSK: Font, %mks%  
      k ={%mks% Down}%k%{%mks% Up}
    }
  }
  SendInput, {Blind}%k%
  return

 OSKGuiClose:
  Gui, OSK: Destroy
  ExitApp
