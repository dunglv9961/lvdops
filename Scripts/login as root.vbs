Sub Main
	xsh.Screen.Synchronous = true

	xsh.Screen.Send "su -"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 100

	xsh.Screen.WaitForString "Password: "
	xsh.Screen.Send "!dlatl00"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 100
End Sub