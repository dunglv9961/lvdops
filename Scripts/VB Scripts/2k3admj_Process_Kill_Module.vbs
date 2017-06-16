strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Const ForAppending = 8
Const CONVERT_TO_LOCAL_TIME = True

Set dtmStart = CreateObject("WbemScripting.SWbemDateTime")
dtmStart.SetVarDate Now, CONVERT_TO_LOCAL_TIME

dtmRegular = dtmStart.GetVarDate(CONVERT_TO_LOCAL_TIME)

'Process Name to kill process

Set colProcessList = objWMIService.ExecQuery _
    ("Select * from Win32_Process Where Name = 'MNT.exe' or Name = 'MTL.exe' or Name = 'OPI.exe'")

For Each objProcess in colProcessList
    Wscript.Echo "Process: " & objProcess.Name & " ProcessID : " & objProcess.ProcessID
    dtmStartTime = objProcess.CreationDate
    strReturn = WMIDateStringToDate(dtmStartTime)
    Wscript.Echo strReturn
    Wscript.Echo "Working Set Size: " & objProcess.WorkingSetSize /1024 / 1024
    Wscript.Echo  "CPU Usage : " & CPUUSage(objProcess.ProcessID)
    
'CPU Time Unit : Second
    sngProcessTime = ( CSng(objProcess.KernelModeTime) + _
            CSng(objProcess.UserModeTime)) / 10000000

    timeFlag = DateDiff("h", strReturn, dtmRegular)
    Wscript.Echo "======================================================"

'CPU Time and CPU usage compare (core per usage)
   
    If   ((sngProcessTime > 14400 And CPUUSage(objProcess.ProcessId) > 90) Or objProcess.WorkingSetSize /1024/1024 > 2000  ) then 
 
        Set objFSO = CreateObject("Scripting.FileSystemObject")
			Set objFile = objFSO.OpenTextFile("D:\WORK\PERM\ScriptLog.txt", ForAppending)

'Process kill with cmd command
		  Rem ------------------------------------------------------------- 
        objFile.WriteLine now & " " & objProcess.Name & " ProcessTime:" & sngProcessTime  & " memory:" & objProcess.WorkingSetSize  /1024 /1024 & " ProcessID : " & objProcess.ProcessID & " CPU Usage : " & CPUUSage(objProcess.ProcessID)
        'objFile.WriteLine "cmd /c taskkill /f /pid " & objProcess.ProcessID
        objFile.Close 
        Rem------------------------------------------------ 
		  Set wshShell = WScript.CreateObject ("WSCript.shell")
    	  wshshell.run "cmd /c taskkill /f /pid " & objProcess.ProcessID 	  
       Set wshshell = nothing

    End if

Next

'Date function

Function WMIDateStringToDate(dtmStart)
    WMIDateStringToDate = CDate(Mid(dtmStart, 5, 2) & "/" & _
        Mid(dtmStart, 7, 2) & "/" & Left(dtmStart, 4) _
            & " " & Mid (dtmStart, 9, 2) & ":" & _
                Mid(dtmStart, 11, 2) & ":" & Mid(dtmStart, _
                    13, 2))
End Function

'Process usage Function

Function CPUUSage( ProcID )
        On Error Resume Next
            Set objService = GetObject("Winmgmts:{impersonationlevel=impersonate}!\Root\Cimv2")
      For Each objInstance1 in objService.ExecQuery("Select * from Win32_PerfRawData_PerfProc_Process where IDProcess = '" & ProcID & "'")
          N1 = objInstance1.PercentProcessorTime
          D1 = objInstance1.TimeStamp_Sys100NS
           Exit For
       Next
		WScript.Sleep(2000)

       For Each perf_instance2 in objService.ExecQuery("Select * from Win32_PerfRawData_PerfProc_Process where IDProcess = '" & ProcID & "'")
           N2 = perf_instance2.PercentProcessorTime
           D2 = perf_instance2.TimeStamp_Sys100NS
           Exit For
       Next

       ' CounterType - PERF_100NSEC_TIMER_INV
       ' Formula - (1- ((N2 - N1) / (D2 - D1))) x 100
        Nd = (N2 - N1)
        Dd = (D2-D1)
         PercentProcessorTime = ( (Nd/Dd))  * 100
    
      CPUUSage = Round(PercentProcessorTime ,0)
          
End Function 