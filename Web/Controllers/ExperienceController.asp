<script language="jscript" runat="server">
/*
** 这是一个用户管理控制器
** 语法：newController = IController.create([__construct[,__destruct]]);
** __construct：构造函数；
** __destruct：析构函数；
** ip2int：ip转为整型
** int2ip：同理
*/
ExperienceController = IController.create(function(){
	if(!auth()){
		var ctrl = Mo.A("Login");
		ctrl.Index(); //调用Login控制器的Index方法
		F.exit();
	}else{
		var user=new USERINFO();//获取用户名，缓存在session
		id=user.id();//加載為控制器全域變量
		username=user.username();//加載為控制器全域變量
		email=user.email();//加載為控制器全域變量
	}
});//控制器命名//auth()为验证状态
ExperienceController.extend("Index", function(){
	F.echo('hello world');
});
</script>