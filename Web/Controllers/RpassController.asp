<script language="jscript" runat="server">
/*
** 创建一个新的Controller对象；
** 语法：
** __construct：构造函数；
** __destruct：析构函数；
*/
RpassController = IController.create();
RpassController.extend("Index",function(){
	this.display("Rpass:Index");
});
RpassController.extend("Index",true,function(){
	if (F.post("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || is_empty(F.post("safe")) || is_empty(F.session("safe"))) {
		F.session('__error','验证码不正确');
		F.goto(Mo.U('Rpass/Index'));
		F.exit();
	}
	F.session.destroy("safe");//销毁验证码
	var email = F.post.email("email");
	if(F.string.email(email)!=email){//判断是否是邮箱
		F.session('__error','邮箱格式不正确');
		F.goto(Mo.U('Rpass/Index'));
		F.exit();
	}
	var stre="email='" + email + "'";
	var rse = M("User","id").where(stre).orderby("id DESC").select().count();
	if (rse==0) {
		F.session('__error','不存在该邮箱信息');
		F.goto(Mo.U('Rpass/Index'));
		F.exit();
	}else{
		F.session("REG_useremail",email);
		var CEmail = Mo.A("Email");
		var info=JSON.parse(CEmail.Rpassword(email));
		this.assign('info',info['info']);
		this.display("Rpass:RpassOk");
	}
});
RpassController.extend("REmailLink",true,function(){
	var email=F.session('REG_useremail');
	var CEmail = Mo.A("Email");
	F.echo(CEmail.Rpassword(email));
});
</script>