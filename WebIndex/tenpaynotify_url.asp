<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<script language="jscript" runat="server" src="../MoLib/AMo.js"></script>
<%
Response.charset="utf-8"
define "MO_DEBUG",false '打开调试功能true未开启
define "MO_DEBUG_MODE","APPLICATION" 'bug调试模式 APPLICATION SESSION 以及DIRECT 档前页面 
define "MO_APP_NAME", "Pay" '项目名称
define "MO_APP", "../Pay" '项目地址
define "MO_CORE", "../MoLib" '核心文件地址
define "MO_COMPILE_CACHE", true '开启或关闭缓存
define "MO_PLUGIN_MODE", true 
define "MO_ERROR_REPORTING", E_NONE '异常显示级别，E_INFO, E_WARNING, E_ERROR, E_NOTICE, E_NONE可随意组合，上线后建议设置为E_NONE
%>
<!--#include file="../Pay/tenpay/Class/PayResponseHandler.asp"-->
<!--#include file="../Pay/tenpay/Class/tenpay_util.asp"-->
<!--#include file="../Pay/tenpay/Class/tenpay_config.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
'---------------------------------------------------------
'财付通双接口处理回调示例，商户按照此示例进行开发即可
'---------------------------------------------------------

log_result("进入后台通知页面！！！！！")

'创建支付应答对象
Dim resHandler
Set resHandler = new PayResponseHandler
resHandler.setKey(key)

'判断签名
If resHandler.isTenpaySign() = True Then
	
	Dim notify_id
	Dim transaction_id
	Dim total_fee
	Dim out_trade_no
	Dim discount
	Dim trade_state
	
	 '通知id
	 notify_id = resHandler.getParameter("notify_id")
	'创建notify_id验证请求对象
	Dim reqHandler1
	Set reqHandler1 = new PayRequestHandler
	'商户在收到后台通知后根据通知ID向财付通发起验证确认，采用后台系统调用交互模式
	reqHandler1.setGateUrl("https://gw.tenpay.com/gateway/simpleverifynotifyid.xml")
	'初始化
	reqHandler1.init()
	'设置密钥
	reqHandler1.setKey(key)
	'设置商户号
	reqHandler1.setParameter "partner", partner
	'商户订单号		
	reqHandler1.setParameter "notify_id", notify_id
	'创建服务器XMLHTTP请求对象
	Dim httpClient
	set httpClient = CreateObject("Msxml2.ServerXMLHTTP.3.0")
	'打开验证Url连接
	httpClient.Open "GET",reqHandler1.getRequestURL(),False
	'提交请求
	httpClient.Send
	'新建服务器XMLDOM文档解析对象
	Set xmlDoc = server.CreateObject("Microsoft.XMLDOM")
	'加载请求返回的XML文档
	xmlDoc.load(httpClient.responseXML)
	'获取文档根元素
	Set obj =  xmlDoc.selectSingleNode("root")
	'遍历root的所有子节点，获取返回的键值对
	For Each node in obj.childnodes
		reqHandler1.setParameter node.nodename, node.text
	Next
	'对返回值进行判断
	If reqHandler1.getParameter("retcode") = "0"  Then
		'商户交易单号
		out_trade_no = resHandler.getParameter("out_trade_no")	

		'财付通交易单号
		transaction_id = resHandler.getParameter("transaction_id")

		'商品金额,以分为单位
		total_fee = resHandler.getParameter("total_fee")
		
		'如果有使用折扣券，discount有值，total_fee+discount=原请求的total_fee
		discount = resHandler.getParameter("discount")
		
		'支付结果
		trade_state = resHandler.getParameter("trade_state")
		
		'交易模式，1即时到账，2中介担保
		trade_mode = resHandler.getParameter("trade_mode")
		'可获取的其他参数还有
		'bank_type			银行类型,默认：BL
		'fee_type			现金支付币种,目前只支持人民币,默认值是1-人民币
		'input_charset		字符编码,取值：GBK、UTF-8，默认：GBK。
		'partner			商户号,由财付通统一分配的10位正整数(120XXXXXXX)号
		'product_fee		物品费用，单位分。如果有值，必须保证transport_fee + product_fee=total_fee
		'sign_type			签名类型，取值：MD5、RSA，默认：MD5
		'time_end			支付完成时间
		'transport_fee		物流费用，单位分，默认0。如果有值，必须保证transport_fee +  product_fee = total_fee
		'判断签名及结果
		If "0" = trade_state Then
			startup()
			dim str,uid,username,goods,userstr,vipovertime,isvip,viptime,times
				times=now()
				str="[orders]='"&out_trade_no&"'"
				set rc=Model__("VipLog").find(str)'查询订单获取用户信息
				IF not isnull(rc) THEN
					IF rc.isbuy=1 THEN
						uid=rc.uid'用户id
						username=rc.username'用户名称
						goods=rc.goods'商品内容
						userstr="[id]="&uid&" AND [username]='"&username&"'"
						set userrc=Model__("User").find(userstr)'查询用户信息
						IF not isnull(userrc) THEN
							IF userrc.isvip=1 THEN'判断是否为vip
								viptime=F.untimespan(userrc.vipexpire)
								vipovertime=F.timespan(F.formatdate(F.date.dateadd("M",goods,viptime),"yyyy-MM-dd HH:mm:ss"))
								isvip=1
							ELSE
								vipovertime=F.timespan(F.formatdate(F.date.dateadd("M",goods,times),"yyyy-MM-dd HH:mm:ss"))
								isvip=1
							END IF
						END IF
						Model__("User").where(userstr).Update "vipexpire",vipovertime,"isvip",isvip
						Model__("VipLog").where(str).Update "isbuy",2,"rebuys","财付通"
					END IF
				END IF
			shutdown()
		END IF
		If "1" = trade_mode Then '即时到帐
			If "0" = trade_state Then
			'----------------------
			'即时到帐处理业务开始
			'-----------------------
			'处理数据库逻辑
			'注意交易单不要重复处理
			'注意判断返回金额
			'-----------------------
			'即时到帐处理业务完毕
			'-----------------------
			'给财付通系统发送成功信息，给财付通系统收到此结果后不在进行后续通知
			log_result("即时到账后台通知成功")
			Response.Write("success")
		    '处理成功
			Else  
				log_result("即时到账后台通知失败")
				Response.Write("即时到帐支付失败")
			End If
		Else
			If trade_mode ="2" Then   '中介担保
				'-----------------------------
				'中介担保处理业务开始
				'------------------------------
						
				'处理数据库逻辑
				'注意交易单不要重复处理
				'注意判断返回金额
				Select Case trade_state
					Case "0":	'付款成功
					
					Case "1":	'交易创建

					Case "2":	'收获地址填写完毕

					Case "4":	'卖家发货成功

					Case "5":	'买家收货确认，交易成功

					Case "6":	'交易关闭，未完成超时关闭

					Case "7":	'修改交易价格成功

					Case "8":	'买家发起退款

					Case "9":	'退款成功

					Case "10":	'退款关闭

					Case else:	'error
						'nothing to do
				End Select
				'------------------------------
				'中介担保处理业务完毕
				'------------------------------
				log_result("中介担保后台通知成功，trade_state=" & trade_state)	
				'给财付通系统发送成功信息，财付通系统收到此结果后不再进行后续通知
				Response.Write("success")
			Else
				Response.Write("后台调用通信失败trade_mode错误")
				'有可能因为网络原因，请求已经处理，但未收到应答。
			End if
		End If
	Else
		Response.Write("Notifyid验证失败")
	End If
Else'签名失败
	Response.Write("签名验证失败")

	Dim debugInfo
	debugInfo = resHandler.getDebugInfo()
	Response.Write("<br/>debugInfo:" & debugInfo & "<br/>")

End If


%>