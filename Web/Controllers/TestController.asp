<script language="jscript" runat="server">
/*
** 创建一个新的Controller对象；
** 语法：
** __construct：构造函数；
** __destruct：析构函数；
*/
TestController = IController.create();
//验证码
TestController.extend("Index",function(){
	dump(F.server());
});
</script>