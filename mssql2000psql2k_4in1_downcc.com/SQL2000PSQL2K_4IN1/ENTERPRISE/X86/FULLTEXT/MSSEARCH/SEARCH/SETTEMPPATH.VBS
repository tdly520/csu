Sub Usage
    WScript.Echo "Microsoft Search Version 2.0"
	WScript.Echo "Sets the temp path location"
	WScript.Echo
	WScript.Echo "Usage:	settemppath.vbs [path]"
	WScript.Echo "Example:	settemppath.vbs c:\temp"
	WScript.Echo
end Sub

Sub Main

    if WScript.Arguments.Count = 1 then
		if WScript.Arguments(0) = "/?" or WScript.Arguments(0) = "-?" then
			Usage
		    WScript.Quit(1)
		end if
    end if

	Set objHost = CreateObject("MSSearch.Admin.1")
	objHost.HostName = ""	'can be any host name

	if WScript.Arguments.Count = 0 then
        wscript.echo "Current temp path for mssearch is: " & objHost.TempPath
		wscript.Quit(1)
	end if

    wscript.echo "Setting temp path for mssearch to " & wscript.arguments(0)
    objHost.TempPath = wscript.arguments(0)
    wscript.echo "Succeeded."

End Sub

call Main
