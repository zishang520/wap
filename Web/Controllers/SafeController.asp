<script language="jscript" runat="server">
/*
** 创建一个新的Controller对象；
** 语法：
** __construct：构造函数；
** __destruct：析构函数；
*/
SafeController = IController.create();
//验证码
SafeController.extend("Safe",function(){
	ExceptionManager.errorReporting(E_ERROR);
	Safecode("safe", {padding:8, odd:3, font:'yahei'});
});
SafeController.extend("Qr",function(){
	ExceptionManager.errorReporting(E_ERROR);
	var qr =QRCode(10, "H");
	var str=!is_empty(F.get('qr'))?F.decode(F.get('qr')):'没有内容';
	qr.flush(str,4,5);
});
</script>