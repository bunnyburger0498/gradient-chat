SetWorkingDir %A_ScriptDir%
;#InstallKeybdHook
#SingleInstance force
#include ColorGradient.ahk
;SetKeyDelay, 10, 10
SendMode Event

mainColoursForLinearGradient := [ "0xA8B290", "0x009A9A", "0x362D38", "0xF4FF00" ]
gradientDivider := 10
gradientColourisedArray := []



;MsgBox % gradientColourisedArray[5]

currentColorArray := ["FF2500", "FF5A00", "FFB900", "F4FF00", "6FFF00", "2AFF00", "00FF6F", "00FFF4", "00A4FF", "002AFF", "7A00FF", "FF00DF", "FF0084" ]	;all hue strong
currentColorArray := ["222222", "404040", "5C5C5C", "686868", "848484", "959595", "B2B2B2", "D6D6D6", "F7F7F7" ] ;greyscale
currentColorArray := ["FF8A00", "FFC400", "DFFF00", "84FF00", "1FFF00", "00FF5F", "00FFAF", "00EFFF", "00B9FF", "008AFF" ]	;nice hue

currentColorArray := gradientColourisedArray


Gui, Add, Text,, Insert hex colour per line
Gui, Add, Edit, r7 vGradientArrayTextEdit w135, FFEB1F`nFF0000
Gui, Add, Text,, Gradient Divider
Gui, Add, Edit, r1 w50 Number, 
Gui, Add, UpDown, vtxtGradientDivider, %gradientDivider%
Gui, Add, Button, Default w80 gFindGradient, Find Gradient
Gui, Add, Button, Default w80 gResetArray, Reset Array
Gui, Add, Button, Default w120 gSaveFile, Save Current Colour Array
Gui, Add, ListView, r5 w200 gFileListView vvarFileListView, FileName|Colours
Gui, Add, ListView, r5 w200 gLV_Preview vvarLV_Preview, Hex|Colours
Gui,+AlwaysOnTop
Gui, Add, CheckBox, Checked gfAlwaysOnTop vchkTop, Always on Top





Gui, ListView, varFileListView

Loop, %A_ScriptDir%\ColourTexts\*.*
{
	FileRead, tmpText, %A_ScriptDir%\ColourTexts\%A_LoopFileName%
	;Msgbox % A_LoopFileName
	readText := StrSplit(tmpText, "`n")
	colCount := readText.MaxIndex()
	LV_Add("", A_LoopFileName, colCount)
}
	
LV_ModifyCol(1, 145)
LV_ModifyCol(2, "50 Integer Center")

Gui,Show,, CSS Colour Script
;dont include return after gui,show, else it will ignore the rest of the auto-execute 

currentIndex := 1
isIncreasing = true
newColourEverySpace = false
newColourEveryChar = true


Hotkey, % Chr(32),NewHotkeys ;loop creating hotkeys for a-z


Loop 32
 Hotkey, % Chr(A_Index+32),NewHotkeys ;loop creating hotkeys for a-z

Loop 6
 Hotkey, % Chr(A_Index+90),NewHotkeys ;loop creating hotkeys for a-z

Loop 4
 Hotkey, % Chr(A_Index+122),NewHotkeys ;loop creating hotkeys for a-z
 

Suspend
;--------------------------------------END OF AUTORUN--------------------------------------
Return
;------------------------------------------------------------------------------------------

LV_Preview:
{
	;nothing for now, maybe doubleclick to select array position

	return
}

updatePreview()
{
	index := currentColorArray.MaxIndex()
	
	Loop, index
	{
		FileRead, tmpText, %A_ScriptDir%\ColourTexts\%A_LoopFileName%
		;Msgbox % A_LoopFileName
		readText := StrSplit(tmpText, "`n")
		colCount := readText.MaxIndex()
		LV_Add("", A_LoopFileName, colCount)
	}
	
	LV_ModifyCol(1, 145)
	LV_ModifyCol(2, "50 Integer Center")
	
	return
}

SaveFile:
{	
	Gui, Submit, NoHide
	
	IfNotExist, %A_ScriptDir%\ColourTexts
		FileCreateDir, %A_ScriptDir%\ColourTexts
	
	;
	textBlock := ""
	i := 1
	while i <= currentColorArray.Length()
	{
	   tmp123 := currentColorArray[i]
	   textBlock = %textBlock%%tmp123%`n
	   ++i
	   ;Msgbox % textBlock
	}
	;remove new line at the end
	textBlockLength := StrLen(textBlock)
	textBlockLength := textBlockLength - 1
	textBlock := SubStr(textBlock, 1, textBlockLength)
	
	
	FileSelectFile, OutputDirFileName, S 16, %A_WorkingDir%\ColourTexts\MyColour.txt, Save Current Colour Array, Text Documents (*.txt)
	
	;If OutputDirFileName last 4 letter is not .txt, then add it
	If ErrorLevel != 1		;as long as user does not cancel the dialog
	{
		checkExt := SubStr(OutputDirFileName, -3)	;0 inclusive, so true number of letters is 4, not 3
		;Msgbox % checkExt
		if checkExt != .txt
			OutputDirFileName = %OutputDirFileName%.txt
		FileDelete, % OutputDirFileName	;delete first so fileappend does not append if overwriting
		FileAppend, % textBlock , % OutputDirFileName
	}
	
	;TODO - Refresh ListView for Files
	Gui, ListView, varFileListView
	LV_Delete()
	
	Loop, %A_ScriptDir%\ColourTexts\*.*
	{
		FileRead, tmpText, %A_ScriptDir%\ColourTexts\%A_LoopFileName%
		;Msgbox % A_LoopFileName
		readText := StrSplit(tmpText, "`n")
		colCount := readText.MaxIndex()
		LV_Add("", A_LoopFileName, colCount)
	}
	
	LV_ModifyCol(1, 145)
	LV_ModifyCol(2, "50 Integer Center")
	
	return
}

fAlwaysOnTop:
{
	Gui, Submit, NoHide
	If chkTop = 1
	{
		Gui, +AlwaysOnTop
	}
	else
	{
		Gui, -AlwaysOnTop
	}
}

ResetArray:
{
	currentIndex := 1
	return
}

FindGradient:
{
	GuiControlGet, GradientArrayTextEdit
	;Msgbox % GradientArrayTextEdit
	emptyArr := []
	resetArray(LineArray)
	LineArray.ObjFullyClone(emptyArr)
    LineArray := StrSplit(GradientArrayTextEdit, "`n")
	
	i := 1
	while i <= LineArray.Length()
	{
	   ;Msgbox % LineArray[i]
	   tmpLA := LineArray[i]
	   hexOnly := SubStr(tmpLA, -5)
	   LineArray[i] := hexOnly
	   ;Msgbox % LineArray[i]
	   ++i
	}
	
	
    ; for each, line in LineArray
        ; MsgBox, % line
		
	;Check to see if theres a empty line at end and remove it
	LineArrayLastIndex := LineArray.MaxIndex()
	texts := LineArray[LineArrayLastIndex]
	; if texts = ""
		; LineArray.RemoveAt(LineArrayLastIndex)
	;TODO - fix potential user error later
	;Msgbox % texts
	
	GuiControlGet, txtGradientDivider
	gradientDivider := txtGradientDivider
	gradientDivider := gradientDivider*2	
	;Msgbox % gradientDivider
	resetArray(gradientColourisedArray)
	
	
	gradientColourisedArray.ObjFullyClone(emptyArr)
	;Msgbox % gradientColourisedArray.Length()
	
	loop, %gradientDivider% {
	;Msgbox % A_Index
	Index := A_Index / gradientDivider
	colour := ColorGradient(Index,LineArray*)
	;color := SubStr(color,-5,6)
	;Msgbox % colour
	gradientColourisedArray[A_Index] := colour
	}
	
	; currentColorArray := ""
	; currentColorArray := []
	; Msgbox % currentColorArray.Length()
	; ;Remove previous array
	resetArray(currentColorArray)

	
	;Reset any used index of current array to 1
	currentIndex := 1
	emptyArr := []
	currentColorArray.ObjFullyClone(emptyArr)
	;currentColorArray := gradientColourisedArray
	currentColorArray.ObjFullyClone(gradientColourisedArray)
	currentColorArray := gradientColourisedArray
	;gradientColourisedArray:=ObjFullyClone(currentColorArray)
	;Msgbox % currentColorArray.Length()
	;Msgbox % currentColorArray.Length()
	;Msgbox % currentColorArray.MaxIndex()
}

resetArray(arr)
{
	i := 1
	while i <= arr.Length()
	{
	   arr.RemoveAt(i)
	   ++i
	}
	return
}


ObjFullyClone(obj)
{
	nobj := obj.Clone()
	for k,v in nobj
		if IsObject(v)
			nobj[k] := A_ThisFunc.(v)
	return nobj
}

FileListView:
if(A_GuiEvent = "DoubleClick")
{
	LV_GetText(RowText, A_EventInfo)
	
	FileRead, tmpText, %A_ScriptDir%\ColourTexts\%RowText%
	readText := StrSplit(tmpText, "`n")
	resetArray(currentColorArray)
	emptyArr := []
	currentColorArray.ObjFullyClone(emptyArr)
	currentColorArray := readText
	currentIndex := 1
	; MsgBox % readText.MaxIndex()
	; Loop, % readText.MaxIndex()
		; MsgBox, % readText[A_Index]
	
	ToolTip Loaded "%RowText%"
	SetTimer, RemoveToolTip, -1000
	return

}



;SetKeyDelay, -1, 30

;SendMode, Event




NewHotkeys:
	interceptInput(A_ThisHotkey)
Return



F9::
{
	if(newColourEverySpace = "true")
	{
		newColourEverySpace = false
		newColourEveryChar = true
		Tooltip, "Every Letter"
		SetTimer, RemoveToolTip, -1000
	}
	else
	{
		newColourEverySpace = true
		newColourEveryChar = false
		Tooltip, "Every Word"
		SetTimer, RemoveToolTip, -1000
	}
	
}
return

F11::
	interceptInput(" \O_0/")
	; interceptInput(" ( ͡° ͜ʖ ͡°)")
	; Random, rd, 30, 80
	; Sleep, %rd%
	; interceptInput(" ( ͡° ͜ʖ ͡°)")
	; Random, rd, 30, 80
	; Sleep, %rd%
	; interceptInput(" (☞ ͡° ͜ʖ ͡°)☞")
	; Random, rd, 30, 80
	; Sleep, %rd%
	; interceptInput(" (☞ ͡° ͜ʖ ͡°)☞")
	; Random, rd, 30, 80
	; Sleep, %rd%
	; interceptInput(" (☞ ͡° ͜ʖ ͡°)☞")

	; interceptInput(" ヽ༼ຈل͜ຈ༽ﾉ")
	; Random, rd, 30, 80
	; Sleep, %rd%
	; interceptInput(" ヽ༼◉ل͜◉༽ﾉ")
	; Random, rd, 30, 80
	; Sleep, %rd%
	; interceptInput(" ヽ༼◔ل͜◔༽ﾉ")
	; Random, rd, 30, 80
	; Sleep, %rd%
	; interceptInput(" ヽ༼⊙ل͜⊙༽ﾉ")
	; Random, rd, 30, 80
	; Sleep, %rd%
	; interceptInput(" ヽ༼ಠل͜ಠ༽ﾉ")
	;CopyPastedInput()
return

CopyPastedInput(pastedStr)
{
	global
	texts := currentColorArray[currentIndex]
	Clipboard = %texts%%pastedStr%
	Send ^v
	Send {Ctrl Up}
return
}

; Loop 94
 ; Hotkey, % Chr(A_Index+32),SomeLabel ;loop creating hotkeys for a-z
; Return

a::
b::
c::
d::
e::
f::
g::
h::
i::
j::
k::
l::
m::
n::
o::
p::
q::
r::
s::
t::
u::
v::
w::
x::
y::
z::
;if capslock on, Capitalise A_ThisHotkey
{
tog := GetKeyState("Capslock", "T")
;Msgbox % tog
if(tog = 1)
{
	aStr := A_ThisHotkey
	StringUpper, newStr, A_ThisHotkey
	interceptInput(newStr)

} else
interceptInput(A_ThisHotkey)
return
}

+a::
+b::
+c::
+d::
+e::
+f::
+g::
+h::
+i::
+j::
+k::
+l::
+m::
+n::
+o::
+p::
+q::
+r::
+s::
+t::
+u::
+v::
+w::
+x::
+y::
+z::
{
;Truncate first letter, then capitalise A_ThisHotkey
newStr := SubStr(A_ThisHotkey, 2, 1)
;Msgbox % newStr

	StringUpper, myStr, newStr
	;Msgbox % myStr
	interceptInput(myStr)

return
}


SomeLabel:

interceptInput(A_ThisHotkey)

Return

F12::Suspend
If A_IsSuspended = 1
{
	Tooltip % UnSuspended
	SetTimer, RemoveToolTip, -1000
	;Suspend, Off
}
Else 
{
	Tooltip % Suspended
	 SetTimer, RemoveToolTip, -1000
	 ;Suspend, On
	
}
Return






RemoveToolTip:
ToolTip
return


;Input, iKey, L1 




interceptInput(interceptedText)
{
	global
	;Msgbox % currentIndex isIncreasing
	
	;Tooltip % interceptedText
	;SetTimer, RemoveToolTip, -1000
	
	;Block users Input when simulating keypresses so the user does not interfere
	;with the process. Without this, holding down keys will trigger the key itself
	;as well as the functions in the code. 
	;For example, in notepad, if we want to hold down the s key, it will trigger both 
	;the code below and Ctrl+S, triggering a save to file dialog.
	;In CSS, if users hold down a key, it may trigger whatever key was below as well.
	;Block Input may also help reliability within css, which should be tested
	BlockInput, On
	
	;
	AutoTrim, Off

	if(newColourEverySpace = "true")
	{
		if(interceptedText = " ")
		{
			texts := currentColorArray[currentIndex]
			Clipboard = %texts%%interceptedText%
			AutoTrim, On
			Send, {Control down}{v}{Control up}
		}
		else
		{
			Clipboard = %interceptedText%
			AutoTrim, On
			Send, {Control down}{v}{Control up}
		}
	}
	
	if(newColourEveryChar = "true")
	{
		if(interceptedText != " ")
		{
			texts := currentColorArray[currentIndex]
			Clipboard = %texts%%interceptedText%
			AutoTrim, On
			Send, {Control down}{v}{Control up}
		}
		else
		{
			Clipboard = %A_Space%
			AutoTrim, On
			Send, {Control down}{v}{Control up}
		}
	}
	
	KeyWait, Control
	
	; texts := currentColorArray[currentIndex]
	; Clipboard = %texts%%interceptedText%
	; Send ^v
	
	;SendInput {Text}%Clipboard%
	
	if(currentIndex >= currentColorArray.MaxIndex())
	{
		isIncreasing = false
	}

	if(currentIndex <= 1)
	{
		isIncreasing = true
	}

	if(isIncreasing = "true")
	{
		currentIndex += 1
	}
	if(isIncreasing = "false")
	{
		currentIndex -= 1
	}
	
	BlockInput, Off
	
	return
}


NumpadSub::Reload


GuiClose:
ExitApp
