Sub Main
	xsh.Screen.Synchronous = true

	xsh.Screen.Send "su - messvcd5"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 100

	xsh.Screen.WaitForString "Password: "
	xsh.Screen.Send "vhMessvcd%"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 100
End Sub