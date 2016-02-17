<?php
ini_set('date.timezone','Asia/Shanghai');
//error_reporting(E_ERROR);

require_once "../lib/WxPay.Api.php";
require_once "WxPay.NativePay.php";
require_once 'log.php';

//模式一
/**
 * 流程：
 * 1、组装包含支付信息的url，生成二维码
 * 2、用户扫描二维码，进行支付
 * 3、确定支付之后，微信服务器会回调预先配置的回调地址，在【微信开放平台-微信支付-支付配置】中进行配置
 * 4、在接到回调通知之后，用户进行统一下单支付，并返回支付信息以完成支付（见：native_notify.php）
 * 5、支付完成之后，微信服务器会通知支付成功
 * 6、在支付成功通知中需要查单确认是否真正支付成功（见：notify.php）
 */
$notify = new NativePay();

//模式二
/**
 * 流程：
 * 1、调用统一下单，取得code_url，生成二维码
 * 2、用户扫描二维码，进行支付
 * 3、支付完成之后，微信服务器会通知支付成功
 * 4、在支付成功通知中需要查单确认是否真正支付成功（见：notify.php）
 */
$input = new WxPayUnifiedOrder();
if(isset($_POST) && !empty($_POST)){
	$input->SetBody($_POST['WIDsubject']);//商品描述
	$input->SetAttach($_POST['WIDbody']);//附加文本
	$input->SetOut_trade_no($_POST['WIDout_trade_no']); //订单号
	$input->SetTotal_fee($_POST['WIDtotal_fee']*100);//支付金额 分为单位1=0.01元
	$input->SetTime_start(date("YmdHis"));//交易开始时间
	$input->SetTime_expire(date("YmdHis", time() + 600));//交易结束时间
	$input->SetGoods_tag($_POST['WIDsubject']);//商品标记
	$input->SetNotify_url("http://paysdk.weixin.qq.com/example/notify.php");//通知地址
	$input->SetTrade_type("NATIVE");//交易类型 JSAPI、NATIVE、APP 
	$input->SetProduct_id("123456789");//用户标识 	openid 
	$result = $notify->GetPayUrl($input);
	$url2 = !empty($result["code_url"])?$result["code_url"]:'';
	echo ($url2);
}
?>