<script language="jscript" runat="server">
//用户登录注册控制器
LoginApiController = IController.create();
var Session = require("session");
//post接收登录信息
LoginApiController.extend("Index", function(){
	//判断用户名和密码是否为空
	var str;
	var username=F.all("username");
	if (F.string.exp(username,/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/)===username && username!='') {//判断是否是用户名
		str="username='" + username + "'";
	}else if(F.string.email(username)==username){//判断是否是邮箱
		str="email='" + username +"'";
	}else if(F.string.exp(username,/^0?1[3|4|5|6|7|8][0-9]\d{8}$/)==username && username!=''){//判断是否是手机号
		str="mobile='" + username +"'";
	}else{
		str="username='" + username + "'";//如果都不是就是为用户名
	}
	if (F.string.exp(F.all("password"),/^[a-zA-Z0-9_]{6,16}$/)!=F.all("password") || F.all("password")=='') {
		F.echo('{"type":"401","msg":"false","sid":"","error":"password Incorrect format"}');//密码格式
		F.exit();
	}
	//判断用户是否存在
	var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).query();
	if (rs.count()<=0){
		F.echo('{"type":"302","msg":"false","sid":"","error":"username not has"}');
		F.exit();
	}
	//密码格式判断
	rs.select(function(item){
		if (item.password!==MD5(F.all("password"))) {
			F.echo('{"type":"303","msg":"false","sid":"","error":"password error"}');//密码错误
			F.exit();
		}else if(item.islogin==1){
			F.echo('{"type":"304","msg":"false","sid":"","error":"username Prohibit login"}');//禁止登录
			F.exit();
		}
		//更新登录时间
		var vip;
		var lastip=ip2int(F.server("REMOTE_ADDR"));
		var lasttime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
		var updatestr={
			"lasttime":lasttime,
			"lastip":lastip
		};
		M("User","id").where(str).Update(updatestr);
		//
		if (item.isvip==1) {
			vip='"isvip":"' + item.isvip + '","vipexpire":"' + item.vipexpire + '",';
		}else{
			vip='"isvip":"' + item.isvip + '",';
		}
		var string='{"id":"' + item.id +'","username":"' + item.username +'","password":"' + item.password +'","money":"' + item.money + '","isemail":"' + item.isemail + '","ismobile":"' + item.ismobile + '",' + vip + '"lastip":"' + lastip + '"}';
		Session("USER__Hash",AES_EN(string,1));
		if(F.all("readme")===1){
			Session.setTimeout(302400);//sid有校期7天
		}else{
			Session.setTimeout(43200);//默认一天
		}
		F.echo('{"type":"200","msg":"true","sid":"'+Session.id+'","error":""}');//输出额结果并退出程序
		F.exit();
	});
});
//获取注册星系
LoginApiController.extend("Reg",function(){
	var username = F.safe(F.all("username"));
	var password = MD5(F.all("password"));
	var confirmPassword = MD5(F.all("confirmPassword"));
	var email = F.all("email");
	var mobile = F.all("mobile");
	var regtime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var regip = ip2int(F.server("REMOTE_ADDR"));
	if (F.string.exp(username,/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/)!=username || username=='') {
		F.echo('{"type":"400","msg":"false","sid":"","error":"username Incorrect format"}');//用户名格式
		F.exit();
	}
	if (F.string.email(email)!=email || email=='') {
		F.echo('{"type":"401","msg":"false","sid":"","error":"email Incorrect format"}');//邮箱格式
		F.exit();
	}
	if (F.string.exp(mobile,/^0?1[3|4|5|6|7|8][0-9]\d{8}$/)!=mobile || mobile=='') {
		F.echo('{"type":"402","msg":"false","sid":"","error":"mobile Incorrect format"}');//手机格式
		F.exit();
	}
	if (F.string.exp(F.all("password"),/^[a-zA-Z0-9_]{6,16}$/)!=F.all("password") || F.all('password')=='') {
		F.echo('{"type":"403","msg":"false","sid":"","error":"password Incorrect format"}');//密码格式
		F.exit();
	}
	if (confirmPassword!==password) {
		F.echo('{"type":"503","msg":"false","sid":"","error":"password Not equal to rpassword"}');//两次输入密码不匹配
		F.exit();
	}
	var str="username='" + username + "'";
	var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).query().count();
	var stre="email='" + email + "'";
	var rse = M("User","id").where(stre).orderby("id DESC").limit(1,1).query().count();
	var strm="mobile='" + mobile + "'";
	var rsm = M("User","id").where(strm).orderby("id DESC").limit(1,1).query().count();
	if (rs>0) {
		F.echo('{"type":"500","msg":"false","sid":"","error":"username Occupied"}');//用户名被占用
		F.exit();
	}
	if (rse>0) {
		F.echo('{"type":"501","msg":"false","sid":"","error":"email Occupied"}');//邮箱已被占用
		F.exit();
	}
	if (rsm>0) {
		F.echo('{"type":"502","msg":"false","sid":"","error":"mobile Occupied"}');//手机已被占用
		F.exit();
	}
	var Insertstr={
		"username":username,
		"password":password,
		"email":email,
		"mobile":mobile,
		"regtime":regtime,
		"regip":regip
	};
	M("User","id").Insert(Insertstr);
	var string='{"username":"' + username +'","lastip":"' + regip + '"}';
	Session("USER__Hash",AES_EN(string,1));
	Session.setTimeout(43200);
	F.echo('{"type":"200","msg":"true","sid":"'+Session.id+'","error":""}');//输出结果并退出程序
	F.exit();
});
//验证码
LoginApiController.extend("Safe",function(){
	ExceptionManager.errorReporting(E_ERROR);
	Safecode("safe", {padding:8, odd:3, font:'yahei'});
});
//注册检测检测状态，只允许POST请求，你可以使用all
LoginApiController.extend("Check",function(){
	//验证名是否存在
	if (F.all('username')!="") {
		var username=F.all('username');
		if(F.string.exp(username,/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/)!==username){
			F.echo('{"valid":"false"}');//用户名不合法
			F.exit();
		}
		var str="username='" + F.safe(username) + "'";
		var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).query().count();
		if (rs<=0) {
			F.echo('{"valid":"true"}');
		}else{
			F.echo('{"valid":"false"}');
		}
	}
	//验证邮箱是否可用
	if (F.all('email')!="") {
		var useremail=F.all('email');
		if(F.string.email(useremail)!=useremail){
			F.echo('{"valid":"false"}');
			F.exit();
		}
		var stre="email='" + F.safe(useremail) + "'";
		var rse = M("User","id").where(stre).orderby("id DESC").limit(1,1).query().count();
		if (rse<=0) {
			F.echo('{"valid":"true"}');
		}else{
			F.echo('{"valid":"false"}');
		}
	}
	//验证手机是否可用
	if (F.all('mobile')!="") {
		var usermobile=F.all('mobile');
		if (F.string.exp(usermobile,/^0?1[3|4|5|6|7|8][0-9]\d{8}$/)!=usermobile){
			F.echo('{"valid":"false"}');
			F.exit();
		}
		var strm="mobile='" + F.safe(usermobile) + "'";
		var rsm = M("User","id").where(strm).orderby("id DESC").limit(1,1).query().count();
		if (rsm<=0) {
			F.echo('{"valid":"true"}');
		}else{
			F.echo('{"valid":"false"}');
		}
	}
});
//登录检测用户名，只允许POst请求，你可以修改为ALL
LoginApiController.extend("CheckLogin",function(){
	if (F.all('username')!="") {
		var username=F.all('username');
		if(F.string.exp(username,/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/)!==username){
			F.echo('{"valid":"false"}');//用户名不合法
			F.exit();
		}
		var str="username='" + F.safe(username) + "'";
		var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).query().count();
		if (rs<=0) {
			F.echo('{"valid":"false"}');//用户名不存在返回false
		}else{
			F.echo('{"valid":"true"}');//用户名存在返回TRUE
		}
	}
});
//验证码验证
LoginApiController.extend("CheckSafe",function(){
	if (F.all('safe')!="") {
		if (F.all("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || F.all("safe")=='' || F.session("safe")=='') {
			F.echo('{"valid":"false"}');
		}else{
			F.echo('{"valid":"true"}');
		}
	}
});
</script>