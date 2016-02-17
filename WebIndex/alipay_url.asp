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
sVerifyResult = objNotify.VerifyReturn()

If sVerifyResult Then	'验证成功
	'商户订单号
	out_trade_no = Request.QueryString("out_trade_no")
	'支付宝交易号
	trade_no = Request.QueryString("trade_no")
	'下面的是JS对向
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
				Model__("VipLog").where(str).Update "isbuy",2,"rebuys","支付宝"
			END IF
		END IF
	shutdown()
	'JS对向结束
	'交易状态
	trade_status = Request.QueryString("trade_status")
	
	If Request.QueryString("trade_status") = "TRADE_FINISHED" or Request.QueryString("trade_status") = "TRADE_SUCCESS" Then
		Response.Write "success"
	Else
		Response.Write "trade_status="&Request.QueryString("trade_status")
	End If

	'——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
	
	'*********************************************************************
else '验证失败
    response.Write "fail"
end if
%>
