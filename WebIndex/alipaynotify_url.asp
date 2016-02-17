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

<!--#include file="../Pay/alipay/class/alipay_notify.asp"-->

<%
'计算得出通知验证结果
Set objNotify = New AlipayNotify
sVerifyResult = objNotify.VerifyNotify()
if sVerifyResult then	'验证成功
	'商户订单号
	out_trade_no = Request.Form("out_trade_no")
	'支付宝交易号
	trade_no = Request.Form("trade_no")
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
			END IF
			' Set list = new ArrayList
			Model__("User").where(userstr).Update "vipexpire",vipovertime,"isvip",isvip
			Model__("VipLog").where(str).Update "isbuy",2,"rebuys","支付宝"
		END IF
	'dim b:b=JSON.stringify(F.server())
	shutdown()
	'LogResult(b)
	trade_status = Request.Form("trade_status")

	If Request.Form("trade_status") = "TRADE_SUCCESS" Then
		'判断该笔订单是否在商户网站中已经做过处理
		'如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
		'如果有做过处理，不执行商户的业务程序

		'注意：
		'付款完成后，支付宝系统发送该交易状态通知

		Response.Write "success"	'请不要修改或删除

		'调试用，写文本函数记录程序运行情况是否正常
		'LogResult("这里写入想要调试的代码变量值，或其他运行的结果记录")
	ElseIf Request.Form("trade_status") = "TRADE_FINISHED" Then
		'判断该笔订单是否在商户网站中已经做过处理
		'如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
		'如果有做过处理，不执行商户的业务程序

		'注意：
		'退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知

		Response.Write "success"	'请不要修改或删除

		'调试用，写文本函数记录程序运行情况是否正常
		'LogResult("这里写入想要调试的代码变量值，或其他运行的结果记录")
	Else
		'其他状态判断。

		Response.Write "success"
		'调试用，写文本函数记录程序运行情况是否正常
		'LogResult ("这里写入想要调试的代码变量值，或其他运行的结果记录")
	End If

	'——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

	'*********************************************************************
else '验证失败
	response.Write "fail"
	' 调试用，写文本函数记录程序运行情况是否正常
	startup()
	dim a:a=JSON.stringify(F.server())
	shutdown()
	LogResult(a)
end if
%>