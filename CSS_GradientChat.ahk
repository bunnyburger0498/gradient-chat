SetWorkingDir %A_ScriptDir%
;#MaxThreadsPerHotkey 2
#MaxThreads 1	;Do not conflict with ListView Updates, else variable will be in different states causing corruption 
;#InstallKeybdHook
#SingleInstance force
#include ColorGradient.ahk
#Include Class_LV_Colors.ahk
;SetKeyDelay, 10, 10
;SendMode Event

; Disable Buttpon if no LV is selected


; Get LV Current Postion and String
; Place string into array
; delete that array pos
; re-arrange to one text
; put text into new textfile

; Sims4 FlowFit Mod


mainColoursForLinearGradient := [ "0xA8B290", "0x009A9A", "0x362D38", "0xF4FF00" ]
gradientDivider := 10
gradientColourisedArray := []



;MsgBox % gradientColourisedArray[5]

currentColorArray := ["FF2500", "FF5A00", "FFB900", "F4FF00", "6FFF00", "2AFF00", "00FF6F", "00FFF4", "00A4FF", "002AFF", "7A00FF", "FF00DF", "FF0084" ]	;all hue strong
currentColorArray := ["222222", "404040", "5C5C5C", "686868", "848484", "959595", "B2B2B2", "D6D6D6", "F7F7F7" ] ;greyscale
currentColorArray := ["FF8A00", "FFC400", "DFFF00", "84FF00", "1FFF00", "00FF5F", "00FFAF", "00EFFF", "00B9FF", "008AFF" ]	;nice hue

currentColorArray := gradientColourisedArray


; Gui, Add, Text,, Insert hex colour per line
; Gui, Add, Edit, r7 vGradientArrayTextEdit w100, FFEB1F`nFF0000
; Gui, Add, Text,, Gradient Divider
; Gui, Add, Edit, r1 w50 Number vtxtGradientDivider, %gradientDivider%
; Gui, Add, UpDown, , %gradientDivider%
; Gui, Add, Button, Default w80 gFindGradient, Find Gradient
; Gui, Add, Button, Default w80 gResetArray, Reset Array
; Gui, Add, Button, Default w120 gSaveFile, Save Current Colour Array
; Gui, Add, ListView, r5 w200 -Multi gFileListView vvarFileListView, FileName|Colours
; Gui, Add, ListView, r5 w200 -Multi Grid NoSort hwndHLV gLV_PreviewColour vvarLV_PreviewColour, >|#|Hex|Colour
; Gui,+AlwaysOnTop
; Gui, Add, CheckBox, Checked gfAlwaysOnTop vchkTop, Always on Top

Gui, Add, ListView, r5 x6 y7 w200 h150 -Multi gFileListView vvarFileListView, FileName|Colours
Gui, Add, ListView, r5 x6 y158 w201 h297 -Multi Grid NoSort LV0x10 hwndHLV gLV_PreviewColour vvarLV_PreviewColour, >|#|Hex|Colour
Gui, Add, GroupBox, x216 y7 w130 h250 , Gradient Creator	

Gui, Add, Text, x226 y27 w110 h20, Insert Hex Per Line
Gui, Add, Edit, x226 y47 w110 h100 r7 vGradientArrayTextEdit w100, FFEB1F`nFF0000

Gui, Add, Text, x227 y147 w109 h14 +Center, Gradient Divider
Gui, Add, Edit, r1 x227 y162 w110 h20 Number vtxtGradientDivider, %gradientDivider%
Gui, Add, UpDown, , %gradientDivider%

Gui, Add, Button, x226 y187 w110 h20 gFindGradient, Find Gradient
Gui, Add, Button, x226 y207 w110 h20 gResetArray, Reset Colour Pos
Gui, Add, Button, x226 y227 w110 h20 gSaveFile, Save Gradient

Gui, Add, GroupBox, x216 y257 w130 h170 , Coloured Word
; Gui, Add, CheckBox, x231 y432 w110 h20 , Always on Top
Gui, Add, Edit, x226 y277 w110 h20 vvarColouredWord , (͡o‿O͡)/%A_Space%
Gui, Add, Button, x226 y297 w110 h20 Disabled gbtnColourWordAdd, Add Word to List
Gui, Add, Button, x226 y397 w110 h20 Disabled gbtnColourWordDelete, Delete Selection
Gui, Add, ListView, -Multi Grid NoSort -Hdr NoSortHdr LV0x10 x226 y317 w110 h80 vvarLV_ColourWordList gLV_ColourWordList, " "

if !FileExist("WordPaste.txt")
{
	FileAppend,, %A_ScriptDir%\WordPaste.txt, UTF-16
}
else
{
	;LV_Delete()
	FileRead, vText, WordPaste.txt
	;Msgbox % vText

	Loop, parse, vText, `n, `r  ; Specifying `n prior to `r allows both Windows and Unix files to be parsed.
	{
		LV_Add("", A_LoopField)
	}
}



Gui,+AlwaysOnTop
Gui, Add, CheckBox, x231 y432 w110 h20 Checked gfAlwaysOnTop vchkTop, Always on Top

;LV_Colors
Gui, ListView, varLV_PreviewColour

LV_ModifyCol()
LV_ModifyCol(3, 55)
LV_ModifyCol(4, 70)

; Create a new instance of LV_Colors
CLV := New LV_Colors(HLV, True, True, True)
; Set the colors for selected rows
;CLV.SelectionColors(0xF0F0F0)
If !IsObject(CLV) {
   MsgBox, 0, ERROR, Couldn't create a new LV_Colors object!
   ExitApp
}
WinSet, Redraw, , ahk_id %HLV%
CLV.OnMessage()


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




Gui,Show,, Counter Strike Source Colour Gradient Chat Script
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

NumpadSub::Reload


LV_PreviewColour:
{
	;TODO - If double click, select array index as current 
	return
}


;*Update Preview when FindGradient or FileListView is Updated
LV_PreviewColourUpdate()
{
	global
	;Select ListView to edit
	Gui, ListView, varLV_PreviewColour
	
	
	; Create a new instance of LV_Colors
	;CLV.Clear()
	
	
	;Delete previous preview
	LV_Delete()
	
	Gui, Submit, NoHide
	GuiControl, -Redraw, %HLV%
	;CLV.Clear(1, 1)
	CLV.OnMessage(False)

	;Add Preview Colour Information to the ListView
	textColour := ""
	i := 1
	while i <= currentColorArray.Length()
	{
	   textColour := currentColorArray[i]
	   StringUpper, textColour, textColour
	   LV_Add("", , i, textColour)	;Add Colour Feature is LV_Colours
	   textColour = 0x%textColour%
	   ;Msgbox % i " and " textColour
	   ;asd := CLV.Cell(i, 4, textColour, textColour)
	   ;Msgbox % asd
	   ++i
	}
	
	CLV.OnMessage(False)
	CLV.OnMessage()
	; ;Add Colours
	i := 1
	while i <= currentColorArray.Length()
	{
	   textColour := currentColorArray[i]
	   StringUpper, textColour, textColour
	   ;LV_Add("", , i, textColour)	;Add Colour Feature is LV_Colours
	   textColour = 0x%textColour%
	   ;Msgbox % i " and " textColour
	   GuiControl, -Redraw, %HLV%
	   asd := CLV.Cell(i, 4, textColour, " ")
	   ;Msgbox % asd
	   ++i
	}
	;Gui, Submit, NA
	GuiControl, +Redraw, %HLV%
	WinSet, Redraw, , ahk_id %HLV%
	;Gui, Show, AutoSize Center
	;Gui, Maximize
	;Gui, Minimize
	;Gui, Show
	;Gui, Restore
	;Gui, Submit, NoHide
	
	GuiControl, Focus, %HLV%
	
	; LV_ModifyCol()
	; LV_ModifyCol(3, 55)
	; LV_ModifyCol(4, 70)
	
	;LV_ModifyCol(2, "50 Integer Center")
	
	;Select ListView to edit 
	Gui, ListView, varFileListView

	Gui, Submit, NoHide
	
	CLV.OnMessage(False)
	CLV.OnMessage()
	
	return
}

;Update Preview for File List View
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
	;TODO
	;Make sure LineArray and Gradient Divider has a value of at least 2

	GuiControlGet, GradientArrayTextEdit
	;Msgbox % GradientArrayTextEdit
	emptyArr := []
	LineArray := emptyArr
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
	LineArrayLastIndex := LineArray.Length()
	texts := LineArray[LineArrayLastIndex]
	; if texts = ""
		; LineArray.RemoveAt(LineArrayLastIndex)
	;TODO - fix potential user error later
	;Msgbox % texts
	
	GuiControlGet, txtGradientDivider,, txtGradientDivider
	gradientDivider := txtGradientDivider
	;gradientDivider := gradientDivider
	;Msgbox % gradientDivider
	resetArray(gradientColourisedArray)
	
	gradientColourisedArray := emptyArr
	resetArray(gradientColourisedArray)
	gradientColourisedArray.ObjFullyClone(emptyArr)
	;Msgbox % gradientColourisedArray.Length()
	
	;Always set the first colour gradientColourisedArray
	colour := ColorGradient(0,LineArray*)
	StringUpper, colour, colour
	gradientColourisedArray[1] := colour
	
	gradientDivider -= 1
	;Msgbox % gradientDivider
	
	loop, %gradientDivider% 
	{
		;Msgbox % A_Index " and " gradientDivider
		Index := A_Index / gradientDivider
		;Msgbox % Index " and " gradientDivider
		colour := ColorGradient(Index,LineArray*)
		StringUpper, colour, colour
		;color := SubStr(color,-5,6)
		;Msgbox % colour
		;gradientColourisedArray[A_Index] := colour
		gradientColourisedArray.Push(colour)
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
	currentColorArray := gradientColourisedArray
	currentColorArray.ObjFullyClone(gradientColourisedArray)
	currentColorArray := gradientColourisedArray
	gradientColourisedArray:= ObjFullyClone(currentColorArray)
	;Msgbox % currentColorArray.Length()
	;Msgbox % currentColorArray.Length()
	;Msgbox % currentColorArray.MaxIndex()
	
	;Update Preview Colour
	LV_PreviewColourUpdate()
}

resetArray(arr)
{
	i := 1
	while i <= arr.Length()
	{
	   arr.RemoveAt(i)
	   ;++i
	}
	;Msgbox % arr.Length()
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

LV_ColourWordList:
{
	if(A_GuiEvent = "DoubleClick")
	{
		Gui, ListView, varLV_ColourWordList
		LV_GetText(varColouredWord, A_EventInfo)
				;Msgbox % A_EventInfo " and " varColouredWord

		
		;varColouredWord := varLV_ColourWordList
		;Gui, ListBox, varLV_ColourWordList
		;GuiControlGet, varColouredWord, , varColouredWord
		;GuiControl,, , %%
		;Gui,+LastFound
		;Msgbox % varLV_ColourWordList " and " varColouredWord
		ControlSetText, Edit3,%varColouredWord%
	}

	return
}

btnColourWordAdd:
{
	; Gui, Submit, NoHide
	
	; FileRead, vText, WordPaste.txt
	; ;Msgbox % vText

	; Loop, parse, vText, `n, `r  ; Specifying `n prior to `r allows both Windows and Unix files to be parsed.
	; {
		; LV_Add("", A_LoopField)
	; }
	
	; ;TODO - Refresh ListView for Files
	; Gui, ListView, varLV_ColourWordList
	; LV_Delete()
	
	; Loop, %A_ScriptDir%\ColourTexts\*.*
	; {
		; FileRead, tmpText, %A_ScriptDir%\ColourTexts\%A_LoopFileName%
		; ;Msgbox % A_LoopFileName
		; readText := StrSplit(tmpText, "`n")
		; colCount := readText.MaxIndex()
		; LV_Add("", A_LoopFileName, colCount)
	; }
	
	; IfNotExist, 
		; FileCreateDir, %A_ScriptDir%\WordPaste.txt
		
	GuiControlGet, varColouredWord, , varColouredWord
	
	
	Gui, ListView, varLV_ColourWordList
	
	file := FileOpen(WordPaste.txt, "rw")
	vText := file.Read()
	Msgbox % vText
	
	FileRead, vText, WordPaste.txt
	FileDelete, WordPaste.txt
	
	
	if(vText = "")
		FileAppend, %varColouredWord%, WordPaste.txt, UTF-16
	else
		FileAppend, `r`n%varColouredWord%, WordPaste.txt, UTF-16
	;Msgbox % varColouredWord
	
	FileRead, vText, WordPaste.txt
	;RegExReplace(vText, "(\R)+", "$1")
	
	Loop
	{
		StringReplace, vText, vText, `r`n`r`n, `r`n , UseErrorLevel
		if ErrorLevel = 0  ; No more replacements needed.
			break
	}
	
	; checkStr := SubStr(vText, 1, 2) ; Returns abc
	; if(checkStr = "`n")
	; {
		; vText := SubStr(vText, 3)
	; }
	; Msgbox % vText
	
	FileDelete, WordPaste.txt
	;Sleep, 2000
	FileAppend, %vText%, WordPaste.txt, UTF-16
	;FileAppend, "", WordPaste.txt, UTF-16
	
	; FileRead, MyContents, WordPaste.txt ;read the contents of the text file
	; file := FileOpen("WordPaste.txt", "w") ;this wipes out all text in the file and overwrites it as a blank .txt file
	; file.write(vText) ;this writes "ThisIsTheNewText" to the text file (without the quotes)
	; file.close() ;this closes the file
	
	;TODO - Refresh ListView for Files
	Gui, ListView, varLV_ColourWordList
	LV_Delete()
	
	FileRead, vText, WordPaste.txt
	Loop, parse, vText, `n, `r  ; Specifying `n prior to `r allows both Windows and Unix files to be parsed.
	{
		LV_Add("", A_LoopField)
	}
	
	;LV_ModifyCol()
	
	
		
	return
}

btnColourWordDelete:
{
	return
}

FileListView:
{
if(A_GuiEvent = "DoubleClick")
{
	Gui, ListView, varFileListView

	LV_GetText(RowText, A_EventInfo)
	
	emptyArr := []
	readText := emptyArr
	resetArray(readText)
	readText.ObjFullyClone(emptyArr)
	
	FileRead, tmpText, %A_ScriptDir%\ColourTexts\%RowText%
	;Msgbox % tmpText
	readText := StrSplit(tmpText, "`r`n","`n")
	
	;Msgbox % readText
	
	currentColorArray := emptyArr
	resetArray(currentColorArray)
	currentColorArray.ObjFullyClone(emptyArr)
	
	; MSgbox % readText.MaxIndex()
	
	; Msgbox, yes
	; a := readText.MaxIndex()
	; loop, %a% {
	; ;Msgbox % A_Index
	; colour := readText[A_Index]
	; StringUpper, colour, colour
	; ;color := SubStr(color,-5,6)
	; ;Msgbox % colour
	; currentColorArray[A_Index] := colour
	; Msgbox % currentColorArray[A_Index]
	; }
	
	;resetArray(currentColorArray)
	;emptyArr := []
	;currentColorArray.ObjFullyClone(emptyArr)
	;currentColorArray.ObjFullyClone(readText)
	
	currentColorArray := readText
	;currentColorArray.ObjFullyClone(readText)
	
	; i := 1
	; while i <= readText.Length()
	; {
		; Msgbox % currentColorArray[i] " and " readText[i]
	   ; currentColorArray[i] := readText[i]
	   		; Msgbox % currentColorArray[i] " and " readText[i]

	   ; ++i
	; }
	
	; i := 1
	; while i <= currentColorArray.Length()
	; {
	   ; Msgbox % currentColorArray[i]
	   ; ++i
	; }
	
	;Msgbox % currentColorArray[2]
	currentIndex := 1
	; MsgBox % readText.MaxIndex()
	; Loop, % readText.MaxIndex()
		; MsgBox, % readText[A_Index]
	
	Gui, ListView, varLV_PreviewColour
	
	
	;ToolTip Loaded "%RowText%"
	;SetTimer, RemoveToolTip, -1000
	
	
	
	

}
;Update Preview Colour
	LV_PreviewColourUpdate()
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

	GuiControlGet, varColouredWord
	
	interceptInput(varColouredWord)
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
	KeyWait Control
	
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





GuiClose:
ExitApp
