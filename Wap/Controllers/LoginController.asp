<script language="jscript" runat="server">
//用户登录注册控制器
LoginController = IController.create();
var Session = require("session");
//打印登录页面
LoginController.extend("Index", function(){
	this.display("Login:Index");
});
//post接收登录信息
LoginController.extend("Index", true, function(){
	//判断验证码是否正确
	if (F.post("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || F.post("safe")=='' || F.session("safe")=='') {
		F.session('__error','验证码不正确');
		F.goto(Mo.U('Login/Index'));
		F.exit();
	}
	//判断用户名和密码是否为空
	if (F.post("username")=="" || F.post("password")=="") {
		F.session('__error','用户名或密码不能为空');
		F.goto(Mo.U('Login/Index'));
		F.exit();
	}
	var str="username='" + F.post("username") + "'";
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
		var vip;
		var lastip=ip2int(F.server("REMOTE_ADDR"));
		var lasttime = F.formatdate(new Date(),"yyyy/MM/dd HH:mm:ss");
		var updatestr='{"lasttime":"' + lasttime +'","lastip":"' + lastip + '"}';
		var updatestrjson=JSON.parse(updatestr);
		M("User","id").where(str).Update(updatestrjson);
		//
		if (item.isvip==1) {
			vip='"isvip":"' + item.isvip + '","vipexpire":"' + item.vipexpire + '",';
		}else{
			vip='"isvip":"' + item.isvip + '",';
		}
		var string='{"id":"' + item.id +'","username":"' + item.username +'","password":"' + item.password +'","money":"' + item.money + '","isemail":"' + item.isemail + '","ismobile":"' + item.ismobile + '",' + vip + '"lastip":"' + lastip + '"}';
		var token=MD5(string+AES_EN(string,1));
		var csrf=ip2int(F.server("REMOTE_ADDR"))+lasttime;
		var __csrf = AES_EN(ip2int(F.server("REMOTE_ADDR"))+F.formatdate(new Date(),"HH:mm:ss"),1);
		cookie('__csrf',__csrf);
		F.session('__csrf',__csrf);
		cookie("USER_Cookies", {
			__Hash : AES_EN(string,1),
			__token : token,
			__login : lasttime
		});
		F.session("USER.__Hash",AES_EN(string,1));
		F.session("USER.__login",lasttime);
		F.session("USER.__token",token);
		F.session.destroy("safe");
		F.goto(Mo.U('Home/Index'),'登陆成功');
		F.exit();
	});
});
//用户注册
LoginController.extend("Reg",function(){
	this.display("Login:Reg");
});
//获取注册星系
LoginController.extend("Reg",true,function(){
	if (F.post("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || F.post("safe")=='' || F.session("safe")=='') {
		F.session('__error','验证码不正确');
		F.goto(Mo.U('Login/Reg'));
		F.exit();
	}
	var username = F.post("username");
	var password = MD5(F.post("password"));
	var confirmPassword = MD5(F.post("confirmPassword"));
	var email = F.post("email");
	var mobile = F.post("mobile");
	var regtime = F.formatdate(new Date(),"yyyy/MM/dd HH:mm:ss");
	var regip = ip2int(F.server("REMOTE_ADDR"));
	var str="username='" + username + "'";
	var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).query().count();
	var stre="email='" + email + "'";
	var rse = M("User","id").where(stre).orderby("id DESC").limit(1,1).query().count();
	var strm="mobile='" + mobile + "'";
	var rsm = M("User","id").where(strm).orderby("id DESC").limit(1,1).query().count();
	if (rs>0) {
		F.session('__error','用户名已被占用');
		F.goto(Mo.U('Login/Reg'));
	}
	if (rse>0) {
		F.session('__error','邮箱已被占用');
		F.goto(Mo.U('Login/Reg'));
	}
	if (rsm>0) {
		F.session('__error','手机已被占用');
		F.goto(Mo.U('Login/Reg'));
	}
	if (confirmPassword!==password) {
		F.session('__error','两次输入密码不匹配');
		F.goto(Mo.U('Login/Reg'));
	}
	var Insertstr='{"username":"' + username +'","password":"' + password +'","email":"' + email +'","mobile":"' + mobile +'","regtime":"' + regtime +'","regip":"' + regip +'"}';
	var Insertstrjson=JSON.parse(Insertstr);
	M("User","id").Insert(Insertstrjson);
	F.goto(Mo.U('Index/Index'));
	F.exit();
});
//验证码
LoginController.extend("Safe",function(){
	ExceptionManager.errorReporting(E_ERROR);
	Safecode("safe", {padding:8, odd:3, font:'yahei'});
});
//注册检测检测状态，只允许POST请求，你可以开启all
LoginController.extend("Check",true,function(){
	//验证名是否存在
	if (F.post('username')!="") {
		var str="username='" + F.post('username') + "'";
		var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).query().count();
		if (rs<=0) {
			F.echo('{"valid":"true"}');
		}else{
			F.echo('{"valid":"false"}');
		}
	}
	//验证邮箱是否可用
	if (F.post('email')!="") {
		var stre="email='" + F.post('email') + "'";
		var rse = M("User","id").where(stre).orderby("id DESC").limit(1,1).query().count();
		if (rse<=0) {
			F.echo('{"valid":"true"}');
		}else{
			F.echo('{"valid":"false"}');
		}
	}
	//验证手机是否可用
	if (F.post('mobile')!="") {
		var strm="mobile='" + F.post('mobile') + "'";
		var rsm = M("User","id").where(strm).orderby("id DESC").limit(1,1).query().count();
		if (rsm<=0) {
			F.echo('{"valid":"true"}');
		}else{
			F.echo('{"valid":"false"}');
		}
	}
});
//登录检测用户名，只允许POst请求，你可以修改为ALL
LoginController.extend("CheckLogin",true,function(){
	if (F.post('username')!="") {
		var str="username='" + F.post('username') + "'";
		var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).query().count();
		if (rs<=0) {
			F.echo('{"valid":"false"}');//用户名不存在返回false
		}else{
			F.echo('{"valid":"true"}');//用户名存在返回TRUE
		}
	}
});
//验证码验证
LoginController.extend("CheckSafe",true,function(){
	if (F.post('safe')!="") {
		if (F.post("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || F.post("safe")=='' || F.session("safe")=='') {
			F.echo('{"valid":"false"}');
		}else{
			F.echo('{"valid":"true"}');
		}
	}
});
</script>