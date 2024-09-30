Sub Usage
    const L_Echo1_Text = "Microsoft Search Version 1.0"
	const L_Echo2_Text = "Queries the gatherer status log"
	const L_Echo3_Text = ""
	const L_Echo4_Text = "Usage:	gthrlog.vbs <log file name> [/u URL-filter] [/b] [/n] [/t TransactionType]"
	const L_Echo5_Text = "		[/e error] [/s status]"
	const L_Echo6_Text = ""
	const L_Echo7_Text = "	URL-filter is any URL with wild characters, including * and ?"
	const L_Echo8_Text = "	/b	-	means order by descending timestamp"
	const L_Echo9_Text = "	/n	-	means display any messages that don't match the filter"
	const L_Echo10_Text = "	/t	-	specifies the notification (transaction) type [a,d,m - add, delete, modify]"
	const L_Echo11_Text = "			during crawls transaction type can only be add or delete"
	const L_Echo12_Text = "	/e	-	specifies the error mask, like an HRESULT"
	const L_Echo13_Text = "	/s	-	specifies the transaction status, like an HRESULT"

	WScript.Echo L_Echo1_Text
	WScript.Echo L_Echo2_Text
	WScript.Echo L_Echo3_Text
	WScript.Echo L_Echo4_Text
	WScript.Echo L_Echo5_Text
	WScript.Echo L_Echo6_Text
	WScript.Echo L_Echo7_Text
	WScript.Echo L_Echo8_Text
	WScript.Echo L_Echo9_Text
	WScript.Echo L_Echo10_Text
	WScript.Echo L_Echo11_Text
	WScript.Echo L_Echo12_Text
	WScript.Echo L_Echo13_Text
	WScript.Echo 

end Sub

Sub Main

const L_Question1_Text = "/?"
const L_Question2_Text = "-?"
const L_Url1_Text = "/u"
const L_Url2_Text = "-u"

const L_No1_Text = "/n"
const L_No2_Text = "-n"

const L_Back1_Text = "/b"
const L_Back2_Text = "-b"

const L_Type1_Text = "/t"
const L_Type2_Text = "-t"
const L_TypeAdd_Text = "a"
const L_TypeDelete_Text = "d"
const L_TypeModify_Text = "m"

const L_Error1_Text = "/e"
const L_Error2_Text = "-e"

const L_Status1_Text = "/s"
const L_Status2_Text = "-s"

const L_ErrorQuery_Text = "Unable to create the query object"
const L_UnableToExecute_Text = "Unable to execute query"

const L_Add_Text = "Add"
const L_Modify_Text = "Modify"
const L_Delete_Text = "Delete"

'    On Error Resume Next

    if WScript.Arguments.Count = 0 then
	Usage
	WScript.Quit(1)
	end if

    if  ( WScript.Arguments.Count = 1 and _
         ( WScript.Arguments(0) = L_Question1_Text or WScript.Arguments(0) = L_Question2_Text ) ) then
		Usage
	    WScript.Quit(1)
    end if

	Set query = WScript.CreateObject("MSSearch.GatherLog.1")
	if not IsObject(query) then
		wscript.echo L_ErrorQuery_Text
		wscript.quit(1)
	end if

	i = 0
	do while i < wscript.arguments.count
		if WScript.Arguments(i) = L_Question1_Text or WScript.Arguments(i) = L_Question2_Text then
			Usage
		    WScript.Quit(1)
		elseif WScript.Arguments(i) = L_Url1_Text or WScript.Arguments(i) = L_Url2_Text then
			i = i+1
			if i >= WScript.Arguments.Count Then
				Usage
				WScript.Quit(1)
			end if

			query.Url = WScript.Arguments(i)
		elseif WScript.Arguments(i) = L_No1_Text or WScript.Arguments(i) = L_No2_Text then
			query.Not = True
		elseif WScript.Arguments(i) = L_Back1_Text or WScript.Arguments(i) = L_Back2_Text then
			query.Forward = False
		elseif WScript.Arguments(i) = L_Type1_Text or WScript.Arguments(i) = L_Type2_Text then
			i = i+1
			if i >= WScript.Arguments.Count Then
				Usage
				WScript.Quit(1)
			end if

			if WScript.Arguments(i) = L_TypeAdd_Text then
				query.TransactionType = 0
			elseif WScript.Arguments(i) = L_TypeDelete_Text then
				query.TransactionType = 1
			elseif WScript.Arguments(i) = L_TypeModify_Text then
				query.TransactionType = 2
			else
				Usage
				WScript.Quit(1)
			end if
		elseif WScript.Arguments(i) = L_Error1_Text or WScript.Arguments(i) = L_Error1_Text then
			i = i+1
			if i >= WScript.Arguments.Count Then
				Usage
				WScript.Quit(1)
			end if

			e = "&H" & WScript.Arguments(i)
			query.ErrorCode = CLng(e)
		elseif WScript.Arguments(i) = L_Status1_Text or WScript.Arguments(i) = L_Status2_Text then
			i = i+1
			if i >= WScript.Arguments.Count Then
				Usage
				WScript.Quit(1)
			end if

			s = "&H" & WScript.Arguments(i)
			query.StatusCode = CLng(s)
		else
			file = WScript.Arguments(i)
		end if

		i = i + 1
	loop

	dim result
	set result = query.ExecuteQuery(file)

	if not isobject(result) then
		wscript.echo L_UnableToExecute_Text
		wscript.quit(1)
	end if

	dim record

	for each record in result
		dim TransactionType
		if record.TransactionType = 1 then
			TransactionType = L_Delete_Text
		elseif record.TransactionType = 0 then
			TransactionType = L_Add_Text
		elseif record.TransactionType = 2 then
			TransactionType = L_Modify_Text
		end if
		wscript.echo record.TimeStamp & Chr(9) & record.Url & Chr(9) & TransactionType & Chr(9) & record.ErrorMessage
	next
end sub

call Main
