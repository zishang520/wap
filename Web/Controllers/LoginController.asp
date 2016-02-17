<script language="jscript" runat="server">
//用户登录注册控制器
LoginController = IController.create(function(){
	if(auth()){
		F.goto(Mo.U('User/Index'));
		F.exit();
	}
});
//打印登录页面
LoginController.extend("Index", function(){
	this.display("Login:Index");
});
//post接收登录信息
LoginController.extend("Index", true, function(){
	//判断验证码是否正确
	if (F.post("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || is_empty(F.post("safe")) || is_empty(F.session("safe"))) {
		F.session('__error','验证码不正确');
		F.goto(Mo.U('Login/Index'));
		F.exit();
	}
	F.session.destroy("safe");//销毁验证码
	//判断用户名和密码是否为空
	var pass=F.post.safe("password");
	var username=F.post.safe('username');
	if (is_empty(username) || is_empty(pass)) {
		F.session('__error','用户名或密码不能为空');
		F.goto(Mo.U('Login/Index'));
		F.exit();
	}
	if (F.string.exp(pass,/^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$/)!=pass || is_empty(pass)) {
		F.session('__error','密码格式不正确');
		F.goto(Mo.U('Login/Index'));
		F.exit();
	}
	if (F.string.exp(username,/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/)===username && username!='') {//判断是否是用户名
		str="username='" + username + "'";
	}else if(F.string.email(username)==username){//判断是否是邮箱
		str="email='" + username +"'";
	}else if(F.string.exp(username,/^0?1[3|4|5|6|7|8][0-9]\d{8}$/)==username && username!=''){//判断是否是手机号
		str="mobile='" + username +"'";
	}else{
		str="username='" + username + "'";//如果都不是就是为用户名
	}
	//判断用户是否存在
	var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).query();
	if (rs.count()<=0){
		F.session('__error','用户不存在');
		F.goto(Mo.U('Login/Index'));
		F.exit();
	}
	rs.select(function(item){
		if (item.password!==MD5(F.post("password"))) {
			F.session('__error','密码错误');
			F.goto(Mo.U('Login/Index'));
			F.exit();
		}else if(item.islogin==1){
			F.session('__error','你被禁止登录');
			F.goto(Mo.U('Login/Index'));
			F.exit();
		}
		//更新登录时间
		var lastip=ip2int(F.server("REMOTE_ADDR"));
		var lasttime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
		if (item.vipexpire<lasttime) {
			M("User","id").where(str).Update({"isvip":0});
		}
		M("User","id").where(str).Update({"lasttime":lasttime,"lastip":lastip});
		var string='{"id":' + item.id +',"username":"' + item.username +'","password":"' + item.password +'","email":"' + item.email +'","isemail":' + item.isemail + ',"ismobile":' + item.ismobile + ',"lastip":' + lastip + '}';
		var HASH=AES_EN(string,1);
		var token=MD5(string+HASH);
		cookie("USER_Cookies", {
			__Hash : HASH,
			__token : token,
			__login : lasttime
		});
		F.session("USER.__Hash",HASH);
		F.session("USER.__login",lasttime);
		F.session("USER.__token",token);
		if(F.server("HTTP_REFERER")!=Mo.U('Login/Index'))F.goto(F.server("HTTP_REFERER")); else F.goto(Mo.U('Home/Index'));
	});
});
</script>