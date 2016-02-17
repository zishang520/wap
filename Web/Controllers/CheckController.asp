<script language="jscript" runat="server">
//用户登录注册控制器
CheckController = IController.create();
//注册检测检测状态，只允许POST请求，你可以开启all
CheckController.extend("Check",true,function(){
	//验证名是否存在
	if (!is_empty(F.post('username'))) {
		var str="username='" + F.post('username') + "'";
		var rs = M("User","id").where(str).orderby("id DESC").select().count();
		if (rs==0) {
			F.echo('{"valid":"true"}');
		}else{
			F.echo('{"valid":"false"}');
		}
	}
	//验证邮箱是否可用
	if (!is_empty(F.post('email'))) {
		var stre="email='" + F.post('email') + "'";
		var rse = M("User","id").where(stre).orderby("id DESC").select().count();
		if (rse==0) {
			F.echo('{"valid":"true"}');
		}else{
			F.echo('{"valid":"false"}');
		}
	}
	//验证手机是否可用
	if (!is_empty(F.post('mobile'))) {
		var strm="mobile='" + F.post('mobile') + "'";
		var rsm = M("User","id").where(strm).orderby("id DESC").select().count();
		if (rsm==0) {
			F.echo('{"valid":"true"}');
		}else{
			F.echo('{"valid":"false"}');
		}
	}
});
CheckController.extend("CheckEmail",true,function(){
	if (!is_empty(F.post('email'))) {
		var stre="email='" + F.post('email') + "'";
		var rse = M("User","id").where(stre).orderby("id DESC").select().count();
		if (rse==0) {
			F.echo('{"valid":"false"}');
		}else{
			F.echo('{"valid":"true"}');
		}
	}
});
//登录检测用户名，只允许POst请求，你可以修改为ALL
CheckController.extend("CheckLogin",true,function(){
	var username=F.post('username');
	if (F.string.exp(username,/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/)===username && username!='') {//判断是否是用户名
		str="username='" + username + "'";
	}else if(F.string.email(username)==username){//判断是否是邮箱
		str="email='" + username +"'";
	}else if(F.string.exp(username,/^0?1[3|4|5|6|7|8][0-9]\d{8}$/)==username && username!=''){//判断是否是手机号
		str="mobile='" + username +"'";
	}else{
		str="username='" + username + "'";//如果都不是就是为用户名
	}
	var rs = M("User","id").where(str).orderby("id DESC").select().count();
	if (rs==0) {
		F.echo('{"valid":"false"}');//用户名不存在返回false
	}else{
		F.echo('{"valid":"true"}');//用户名存在返回TRUE
	}
});
//验证码验证
CheckController.extend("CheckSafe",true,function(){
	if (!is_empty(F.post('safe'))) {
		if (F.post("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || is_empty(F.post("safe")) || is_empty(F.session("safe"))) {
			F.echo('{"valid":"false"}');
		}else{
			F.echo('{"valid":"true"}');
		}
	}
	if (!is_empty(F.post('emailsafe'))) {
		if (F.post("emailsafe").toLocaleLowerCase()!==F.session("__emailsafe").toLocaleLowerCase() || is_empty(F.post("emailsafe")) || is_empty(F.session("__emailsafe"))) {
			F.echo('{"valid":"false"}');
		}else{
			F.echo('{"valid":"true"}');
		}
	}
});
</script>