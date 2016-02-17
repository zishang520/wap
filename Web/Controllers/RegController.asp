<script language="jscript" runat="server">
//用户登录注册控制器
RegController = IController.create();
//用户注册
RegController.extend("Reg",function(){
	var data = M("Basics","id").where('id=1').select();
	this.assign('data',data);
	this.display("Reg:Reg");
});
//获取注册星系
RegController.extend("Reg",true,function(){
	if (F.post("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || is_empty(F.post("safe")) || is_empty(F.session("safe"))) {
		F.session('__error','验证码不正确');
		F.goto(Mo.U('Reg/Reg'));
		F.exit();
	}
	F.session.destroy("safe");//销毁验证码
	if(is_empty(F.post('Registration')) || F.post('Registration')!='1'){
		F.session('__error','请同意注册协议');
		F.goto(Mo.U('Reg/Reg'));
		F.exit();
	}
	var username = F.post.safe("username");
	if (F.string.exp(username,/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/)!=username && is_empty(username)) {//判断是否是用户名
		F.session('__error','用户名格式不正确');
		F.goto(Mo.U('Reg/Reg'));
		F.exit();
	}
	var email = F.post.email("email");
	if(F.string.email(email)!=email){//判断是否是邮箱
		F.session('__error','邮箱格式不正确');
		F.goto(Mo.U('Reg/Reg'));
		F.exit();
	}
	var str="username='" + username + "'";
	var rs = M("User","id").where(str).orderby("id DESC").select().count();
	var stre="email='" + email + "'";
	var rse = M("User","id").where(stre).orderby("id DESC").select().count();
	if (rs>0) {
		F.session('__error','用户名已被占用');
		F.goto(Mo.U('Reg/Reg'));
		F.exit();
	}
	if (rse>0) {
		F.session('__error','邮箱已被占用');
		F.goto(Mo.U('Reg/Reg'));
		F.exit();
	}else{
		F.session("REG.username",username);
		F.session("REG.useremail",email);
		this.display("Reg:RegGo");
	}
});
RegController.extend("REmailSafe",true,function(){
	var REG = F.session.parse("REG");
	var email=REG['useremail'];
	var username=REG['username'];
	var CEmail = Mo.A("Email");
	F.echo(CEmail.RegSafe(email,username));
});
RegController.extend("RegGo",true,function(){
	if (F.post("emailsafe").toLocaleLowerCase()!==F.session('__emailsafe').toLocaleLowerCase() || is_empty(F.post("emailsafe")) || is_empty(F.session('__emailsafe'))) {
		F.session('__error','确认码不正确');
		F.goto(Mo.U('Reg/Reg'));
		F.exit();
	}
	F.session.destroy("__emailsafe");//销毁验证码
	var pass=F.post("password");
	if (F.string.exp(pass,/^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$/)!=pass || is_empty(pass)) {
		F.session('__error','密码格式不正确');
		F.goto(Mo.U('Reg/Reg'));
		F.exit();
	}
	var REG = F.session.parse("REG");
	var email=REG['useremail'];
	var username=REG['username'];
	var password = MD5(pass);
	var confirmPassword = MD5(F.post("confirmPassword"));
	var regtime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var regip = ip2int(F.server("REMOTE_ADDR"));
	if (confirmPassword!==password) {
		F.session('__error','两次输入密码不匹配');
		F.goto(Mo.U('Reg/Reg'));
		F.exit();
	}
	var Insertstr={
		"username":username,
		"password":password,
		"email":email,
		"regtime":regtime,
		"regip":regip,
		"isemail":1
	};
	M("User","id").Insert(Insertstr);
	this.display("Reg:RegOK");
});
</script>