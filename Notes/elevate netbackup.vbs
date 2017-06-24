Sub Main
	xsh.Screen.Synchronous = true
	
	xsh.Screen.Send VbCr
	xsh.Screen.Send "#Start elevating..."
	xsh.Screen.Send VbCr

	xsh.Screen.Send "Support Maintenance"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 1000
	xsh.Screen.WaitForString "maintenance's password:"
	xsh.Screen.Send ""
	xsh.Screen.Send VbCr
	xsh.Screen.Send "/opt/Symantec/sdcssagent/IPS/sisipsoverride.sh"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 5000
	
	xsh.Screen.WaitForString "Choice? [1]"
	xsh.Screen.Send "2"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 1000
	
	xsh.Screen.WaitForString "Choice? [1]"
	xsh.Session.Sleep 1000
	xsh.Screen.Send "6"
	xsh.Screen.Send VbCr

	xsh.Session.Sleep 1000
	xsh.Screen.Send VbCr
	
	xsh.Screen.Send "#Elevating ended."
	xsh.Screen.Send VbCr
End Sub