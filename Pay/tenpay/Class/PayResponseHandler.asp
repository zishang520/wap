<!--#include file="PayRequestHandler.asp"-->
<%
'
'即时到帐支付应答类
'============================================================================
'api说明：
'getKey()/setKey(),获取/设置密钥
'getParameter()/setParameter(),获取/设置参数值
'getAllParameters(),获取所有参数
'isTenpaySign(),是否财付通签名,true:是 false:否
'getDebugInfo(),获取debug信息
'
'============================================================================
'


Class PayResponseHandler

	'密钥
	Private key

	'应答的参数
	Private parameters

	'debug信息
	Private debugInfo

	'初始构造函数
	Private Sub class_initialize()
		key = ""
		Set parameters = Server.CreateObject("Scripting.Dictionary")
		debugInfo = ""
				
		parameters.RemoveAll
		
		Dim k
		Dim v
		
		'GET
		For Each k In Request.QueryString
			v = Request.QueryString(k)
			setParameter k,v
		Next
		
		'POST
		For Each k In Request.Form
			v = Request(k)
			setParameter k,v
		Next
		
	End Sub

	'获取密钥
	Public Function getKey()
		getKey = key
	End Function
	
	'设置密钥
	Public Function setKey(key_)
		key = key_
	End Function
	
	'获取参数值
	Public Function getParameter(parameter)
		getParameter = parameters.Item(parameter)
	End Function
	
	'设置参数值
	Public Sub setParameter(parameter, parameterValue)
		If parameters.Exists(parameter) = True Then
			parameters.Remove(parameter)
		End If
		parameters.Add parameter, parameterValue	
	End Sub

	'获取所有请求的参数,返回Scripting.Dictionary
	Public Function getAllParameters()
		getAllParameters = parameters
	End Function

	'是否财付通签名
	'true:是 false:否
	Public Function isTenpaySign()
		Dim keys,k,v
		keys	= parameters.Keys()
		'按字母顺序排序
		for i=0 to UBound(keys)-1
			for j=i+1 to UBound(keys)
				if StrComp(keys(i), keys(j)) > 0 then 
					tmp=keys(i)
					keys(i)=keys(j)
					keys(j)=tmp
				end if
			next
		next
		md5str = ""
		'组合签名字符串
		For Each k in keys
			v = getParameter(k)
			if v <> "" and k <> "sign" and k <> "key" then
				md5str = md5str & k & "=" & v & "&"
			end if
		Next
		md5str = md5str & "key=" & key
		Dim sign
		sign=LCase(MD5(md5str,32))
		
		Dim tenpaySign
		tenpaySign = LCase( getParameter("sign"))

		'debugInfo
		debugInfo = md5str & " => sign:" & sign & " tenpaySign:" & tenpaySign

		isTenpaySign = (sign = tenpaySign)
	End Function

	
	'获取debug信息
	Function getDebugInfo()
		getDebugInfo = debugInfo
	End Function
	
End Class
%>