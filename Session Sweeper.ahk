﻿If ProcExist("GTA5.exe")
{
    Process_Suspend("GTA5.exe")
    TrayTip, Session Sweeper, Grand Theft Auto V suspended., , 1
    Sleep, 10000
    Process_Resume("GTA5.exe")
    TrayTip, Session Sweeper, Grand Theft Auto V resumed., , 1
}
Else
{
    TrayTip, Session Sweeper, Grand Theft Auto V is not running., , 3
}

Exitapp

; autohotkey.com/board/topic/30341-process-suspendresume-exampleexe/?p=193859

Process_Suspend(PID_or_Name){
    PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name
    h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)
    If !h   
        Return -1
    DllCall("ntdll.dll\NtSuspendProcess", "Int", h)
    DllCall("CloseHandle", "Int", h)
}

Process_Resume(PID_or_Name){
    PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name
    h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)
    If !h   
        Return -1
    DllCall("ntdll.dll\NtResumeProcess", "Int", h)
    DllCall("CloseHandle", "Int", h)
}

ProcExist(PID_or_Name=""){
    Process, Exist, % (PID_or_Name="") ? DllCall("GetCurrentProcessID") : PID_or_Name
    Return Errorlevel
}