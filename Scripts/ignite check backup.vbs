Sub Main
	xsh.Screen.Synchronous = true
	xsh.Screen.Send "cat /var/opt/ignite/logs/ignite"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 100
End Sub