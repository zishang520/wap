<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<!--#include file="Class/PayRequestHandler.asp"-->
<!--#include file="Class/tenpay_config.asp"-->
<%
If Request.servervariables("REMOTE_ADDR")<>"127.0.0.1" AND Request.servervariables("HTTP_X_CSRF_TOKEN")="" OR Request.Form("__csrf")="" THEN
Response.Write "error"
Response.End
END IF
Response.charset="utf-8"
'---------------------------------------------------------
'财付通双接口支付请求示例，商户按照此文档进行开发即可
'---------------------------------------------------------
'获取提交的商品价格
order_price=trim(Request.Form("order_price"))

'获取提交的商品名称
product_name=trim(Request.Form("product_name"))

'获取提交的备注信息
remarkexplain=trim(Request.Form("remarkexplain"))

'获取提交的订单号
out_trade_no=trim(Request.Form("order_no"))

'支付方式
trade_mode=trim(Request.Form("trade_mode"))

'ip
ip=trim(Request.Form("ip"))

Dim total_fee
Dim desc

'商品价格（包含运费），以分为单位
total_fee = csng(order_price*100)

'商品名称
desc =  "商品：" & product_name&",备注："&remarkexplain

'订单生成时间
strNow = Now()
strNow = Year(strNow) & Right(("00" & Month(strNow)),2) & Right(("00" & Day(strNow)),2) & Right(("00" & Hour(strNow)),2) & Right(("00" &  Minute(strNow)),2) & Right(("00" & Second(strNow)),2)


'创建支付请求对象
Dim reqHandler
Set reqHandler = new PayRequestHandler
reqHandler.setGateUrl("https://gw.tenpay.com/gateway/pay.htm")

'初始化
reqHandler.init()

'设置密钥
reqHandler.setKey(key)

'-----------------------------
'设置支付参数
'-----------------------------
reqHandler.setParameter "partner", partner		'设置商户号
reqHandler.setParameter "out_trade_no", out_trade_no				'商户订单号
reqHandler.setParameter "total_fee", total_fee				'商品总金额,以分为单位
reqHandler.setParameter "return_url", return_url			'回调地址
reqHandler.setParameter "notify_url", notify_url			'通知地址
reqHandler.setParameter "body", desc	                    '商品描述
reqHandler.setParameter "bank_type", "DEFAULT"						'银行类型
reqHandler.setParameter "fee_type", "1"						'银行币种
reqHandler.setParameter "subject", desc             '商品名称(中介交易时必填)
reqHandler.setParameter "spbill_create_ip", ip  '支付机器IP

'系统可选参数
reqHandler.setParameter "sign_type", "MD5"        '签名方式
reqHandler.setParameter "service_version", "1.0"  '接口版本
reqHandler.setParameter "input_charset", "utf-8"    '字符集
reqHandler.setParameter "sign_key_index", "1"     '密钥序号

'业务可选参数
reqHandler.setParameter "attach", ""                      '附加数据，原样返回
reqHandler.setParameter "product_fee", ""                 '商品费用，必须保证transport_fee + product_fee=total_fee
reqHandler.setParameter "transport_fee", "0"            '物流费用，必须保证transport_fee + product_fee=total_fee
reqHandler.setParameter "time_start", strNow            '订单生成时间，格式为yyyymmddhhmmss
reqHandler.setParameter "time_expire", ""                 '订单失效时间，格式为yyyymmddhhmmss
reqHandler.setParameter "buyer_id", ""                    '买方财付通账号
reqHandler.setParameter "goods_tag", ""                   '商品标记
reqHandler.setParameter "trade_mode", trade_mode                 '交易模式，1即时到账(默认)，2中介担保，3后台选择（买家进支付中心列表选择）
reqHandler.setParameter "transport_desc", ""              '物流说明
reqHandler.setParameter "trans_type", "1"                 '交易类型，1实物交易，2虚拟交易
reqHandler.setParameter "agentid", ""                     '平台ID
reqHandler.setParameter "agent_type", ""                  '代理模式，0无代理(默认)，1表示卡易售模式，2表示网店模式
reqHandler.setParameter "seller_id", ""                   '卖家商户号，为空则等同于partner

'请求的URL
Dim reqUrl
reqUrl = reqHandler.getRequestURL()
Response.Write reqUrl

'debug信息
' Dim debugInfo
' debugInfo = reqHandler.getDebugInfo()
' Response.Write("<br/>debugInfo:" & debugInfo & "<br/>")
' Response.Write("<br/>reqUrl:" & reqUrl & "<br/>")
'Response.Write( "<br/>")
'Response.Write( LCase(MD5("财付通支付",32)))
%>