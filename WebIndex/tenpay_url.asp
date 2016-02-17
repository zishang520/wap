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

log_result("进入前台通知页面！！！！！")


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
	'下面的是JS对向
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
	'JS对向结束
	If "1" = trade_mode Then '即时到帐
		If "0" = trade_state Then
	
	
	
	
	
			log_result("即时到账前台通知成功")
			Response.Write("Success")'即时到帐支付成功
	    '处理成功
		Else  
			log_result("即时到账前台通知失败")
			Response.Write("即时到帐支付失败trade_state=" & trade_state)'
		End If
	Else
		If "2"= trade_mode  Then    ' 中介担保 
			If  "0"= trade_state  Then
		
		
		
		
				log_result("中介担保前台通知成功")
				Response.Write("Success")'支付成功"trade_state=" + trade_state
			Else 
				log_result("中介担保前台通知失败，trade_state=" & trade_state)
				Response.Write("中介担保支付失败trade_state=" & trade_state)

	    	End if
	    End If
    End If
Else'签名失败
	Response.Write("签名签证失败")
	Dim debugInfo
	debugInfo = resHandler.getDebugInfo()
	Response.Write("<br/>debugInfo:" & debugInfo & "<br/>")
End If
%>