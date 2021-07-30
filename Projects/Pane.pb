;==============================================
;<BEGIN>
;General Functions
;==============================================
ProcedureDLL Initialize()
UseJPEGImageDecoder()
UsePNGImageDecoder()
UseTIFFImageDecoder()
UseTGAImageDecoder()
EndProcedure 

ProcedureDLL _CreateGadgetList(hWindow)
CreateGadgetList(hWindow)
EndProcedure

ProcedureDLL _FreeGadget(nGadget.l)
FreeGadget(nGadget)
EndProcedure

;==============================================
;General Functions
;<END>
;==============================================

;ProcedureDLL ()
;EndProcedure

ProcedureDLL Image_Create();pImage.s, nImageID.l, nGadgetID.l, nX.l, nY.l, nWidth.l, nHeight.l)
;Result = StartDrawing(OutputID) 
;LoadImage(nImageID, pImage)
;ImageGadget(nGadgetID, nX, nX, nWidth, nHeight, ImageID(nImageID)) 
;DrawImage(ImageID(nImageID), nX, nY, nWidth, nHeight) 

;StopDrawing() 
 If StartDrawing(ScreenOutput())
    Box(10,10,20,20)
    Line(30,50,100,100)
 
    StopDrawing() 
  EndIf


EndProcedure








ProcedureDLL ProgressBar_Create(hWindow.l, nGadgetID.l, nWidth.l, nHeight.l, nMin.l, nMax.l, nSmooth.c, nVertical.c) 
nFlags.l = 0

If nSmooth = 1
nFlags = nFlags + #PB_ProgressBar_Smooth
EndIf

If nVertical = 1
nFlags = nFlags + #PB_ProgressBar_Vertical
EndIf

hWnd.l = ProgressBarGadget(nGadgetID,0,0,nWidth,nHeight,nMin,nMax,nFlags)
ProcedureReturn hWnd
EndProcedure 

ProcedureDLL ProgressBar_SetCurrentPos(nGadgetID.l, nCurrentPos.l)
SetGadgetState(nGadgetID, nCurrentPos)
ProcedureReturn nCurrentPos
EndProcedure


ProcedureDLL _SetGadgetColor(nGadgetID.l)
;Color = RGB(nRed, nGreen, nBlue)
;Result = MessageRequester(Str(nGadgetID), "Please make your input:", #PB_MessageRequester_YesNo)
SetGadgetColor(nGadgetID, #PB_Gadget_BackColor, $000000)
EndProcedure
; IDE Options = PureBasic 4.20 (Windows - x86)
; ExecutableFormat = Shared Dll
; CursorPosition = 27
; FirstLine = 15
; Folding = 8-
; EnableXP
; Executable = ..\..\..\AutoPlay 8.0\PopUp Workspace\CD_Root\AutoPlay\Plugins\Pane\Pane.dll
; DisableDebugger