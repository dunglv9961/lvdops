Sub Main
	xsh.Screen.Synchronous = true
	
	xsh.Screen.Send VbCr
	xsh.Screen.Send "#Start checking..."
	xsh.Screen.Send VbCr

	xsh.Screen.Send "bpps -a | grep /bpdbm"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 5000

	xsh.Screen.Send "bpps -a | grep /bpjobd"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 5000
	
	xsh.Screen.Send "bpps -a | grep /nbemm"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 5000
	
	xsh.Screen.Send "bpps -a | grep /nbrb"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 5000
	
	xsh.Screen.Send "bpps -a | grep /bprd"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 5000
	
	xsh.Screen.Send "bpps -a | grep /nbpem"
	xsh.Screen.Send VbCr
	xsh.Session.Sleep 5000
	
	xsh.Screen.Send "#Checking ended."
	xsh.Screen.Send VbCr
End Sub