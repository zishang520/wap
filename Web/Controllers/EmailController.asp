<script language="jscript" runat="server">
/*
*生成邮箱验证的一个控制器
*/
EmailController = IController.create();
EmailController.extend("Auth",function(){
	var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
	var userkey=F.get('key');
	var keyinfo=F.json(AES_EN(userkey,2));
	if (!is_empty(keyinfo)) {
		var useremail=keyinfo['useremail'];
		var guid=keyinfo['guid'];
		var username=keyinfo['username'];
		var overtime=keyinfo['overtime'];
		var str="guid='"+guid+"' AND useremail='"+useremail+"' AND username='"+username+"'";
		var rs = M("Guid","id").where(str);//数据库查询用户是否存在
		var rsa=rs.orderby("id DESC").select();
		if (rsa.count()>0) {
			if (F.timespan(time)<overtime) {//判断密钥是否过期
				var strarray=rsa.getArray();
				var stra="email='"+strarray[0]['useremail']+"' AND username='"+strarray[0]['username']+"'";
				M('User','id').where(stra).Update({"isemail":1});
				rs.Delete();
				F.echo('激活成功');
			}else{
				rs.Delete();
				F.echo('密钥已过期');
			}
		}else{
			F.echo('密钥无效');
		}
	}else{
		F.echo('密钥无效');
	}
});
//找回密码
EmailController.extend("Rpass",function(){
	var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
	var userkey=F.get('key');
	var keyinfo=F.json(AES_EN(userkey,2));
	if (!is_empty(keyinfo)) {
		var useremail=keyinfo['useremail'];
		var rguid=keyinfo['rguid'];
		var username=keyinfo['username'];
		var overtime=keyinfo['overtime'];
		var pkeystr='{"key":"'+userkey+'","rguid":"'+rguid+'","username":"'+username+'","useremail":"'+useremail+'"}';
		var pkey=AES_EN(pkeystr,1);
		var str="rguid='"+rguid+"' AND useremail='"+useremail+"' AND username='"+username+"'";
		var rs = M("Rguid","id").where(str);//数据库查询用户是否存在
		var rsa=rs.orderby("id DESC").select();
		if (rsa.count()>0) {
			if (F.timespan(time)<overtime) {//判断密钥是否过期
				this.assign('pkey',pkey);
				this.display("Rpass:Rpass");//修改密碼
			}else{
				rs.Delete();
				this.assign('info','密钥已过期，请重新获取');
				this.display("Rpass:RpassMsg");//密鑰已過期或無效
			}
		}else{
			this.assign('info','密钥不存在或已过期');
			this.display("Rpass:RpassMsg");//密鑰已過期或無效
		}
	}else{
		this.assign('info','密钥不存在或已过期');
		this.display("Rpass:RpassMsg");//密鑰已過期或無效
	}
});
//找回密码post
EmailController.extend("Rpass",true,function(){
	var pkey=F.post('pkey');
	var pkeyinfo=F.json(AES_EN(pkey,2));
	if (!is_empty(pkeyinfo)) {
		var key=pkeyinfo['key'];
		var rguid=pkeyinfo['rguid'];
		var username=pkeyinfo['username'];
		var useremail=pkeyinfo['useremail'];
		var password = F.post("password");
		var confirmPassword = MD5(F.post("confirmPassword"));
		if (F.string.exp(password,/^[a-zA-Z0-9_]{6,16}$/)!=password || is_empty(password)) {
			F.session('__error','密码格式不正确');
			F.goto(Mo.U('Email/Rpass','key='+key));
			F.exit();
		}
		var pass=MD5(password);
		if (confirmPassword!==pass) {
			F.session('__error','密码与确认密码不匹配');
			F.goto(Mo.U('Email/Rpass','key='+key));
			F.exit();
		}
		var str="rguid='"+rguid+"' AND useremail='"+useremail+"'";
		var rs = M("Rguid","id").where(str);//数据库查询用户是否存在
		var rsa=rs.orderby("id DESC").select().count();
		if (rsa>0) {
			var str="username='"+username+"' AND email='"+useremail+"'";
			M('User').where(str).Update({"password":pass});
			rs.Delete();
			this.assign('info','密码修改成功,<a href="'+Mo.U('Login/Index')+'">登陆</a>');
			this.display("Rpass:RpassMsg");//密鑰已過期或無效
		}else{
			this.assign('info','密钥不存在或已过期');
			this.display("Rpass:RpassMsg");//密鑰已過期或無效
		}
	}else{
		this.assign('info','传入参数错误，请<a href="javascript:history.go(-1)"><span class="bg-success">返回</span></a>重试');
		this.display("Rpass:RpassMsg");//密鑰已過期或無效
	}
});
//邮箱验证生成控制器
EmailController.extend("AuthLink",function(){
	var mail = require("mail");//引入mail扩展
	var user=new USERINFO();//获取用户名，缓存在session
	var username=user.name();
	if (username){//判断用户名是否存在
		var ustr="username='" + username + "'";
		var rss = M("User","id").where(ustr).orderby("id DESC").select();//数据库查询用户是否存在
		var rsarray=rss.getArray();
		var userid=rsarray[0]['id'];
		var useremail=rsarray[0]['email'];
		var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
		var overtime=F.timespan(F.formatdate(F.date.dateadd("h",2,time),"yyyy-MM-dd HH:mm:ss"));//密钥失效日期
		var totime=F.timespan(F.formatdate(F.date.dateadd("s",128,time),"yyyy-MM-dd HH:mm:ss"));//间隔发送邮件时间
		var guid=F.guid("N");//创建guid
		var str="useremail='"+useremail+"'";
		var rs = M("Guid","id").where(str).orderby("id DESC").select();//查询密钥表
		var Insertstr='{"useremail":"'+useremail+'","guid":"'+guid+'","username":"'+username+'","overtime":"'+overtime+'","totime":"'+totime+'"}';
		if (rs.count()>0){//如果用户的密钥存在就更新
			if (F.timespan(time)>rs.getArray()[0]['totime']) {
				var updatestr={
					"guid":guid,
					"overtime":overtime,
					"totime":totime
				};
				M("Guid","id").where(str).Update(updatestr);
			}else{
				F.echo('{"valid":"false","msg":"500","info":"请求过于频繁"}');//时间限制
				F.exit();
			}
		}else{//否则就插入数据
			var insertstrjson=JSON.parse(Insertstr);
			M("Guid","id").Insert(insertstrjson);
		}
		var _link=Mo.U('Email/Auth','key='+AES_EN(Insertstr,1));//创建密钥地址
		var WebConfig=M("WebConfig","id").where('id=1').select().getArray();//查询网站配置信息
		var web_url=WebConfig[0]['web_url'];//网站地址
		var web_name=WebConfig[0]['web_name'];//网站名称
		var rc=M("Mail","id").where('id=1').select().getArray();
		var body=F.decodeHtml(rc[0]['authbody']);//获取验证用户的邮件模板
		//下面的是替换对用的用户信息
		body=F.replace(body, /{@username@}/ig,username);//替换用户名
		body=F.replace(body, /{@email@}/ig,useremail);//替换用户邮箱
		body=F.replace(body, /{@web_name@}/ig,web_name);//替换网站名
		body=F.replace(body, /{@web_url@}/ig,web_url);//替换网站地址
		body=F.replace(body, /{@link@}/ig,_link);//替换验证地址
		body=F.replace(body, /{@time@}/ig,time);//替换时间
		var title=rc[0]['authtitle'];//获取验证用户的邮件模板
		var servermail=rc[0]['email'];//服务器邮箱
		var serverpassword=rc[0]['password'];//服务器邮箱密码
		var serversmtp=rc[0]['smtp'];//服务器地址
		var email=new mail(servermail,serverpassword,serversmtp);//初始化邮件发送方法
		email.to(useremail,title,body);//创建发送对象
		var bool=email.send();//发送邮件，把发送结果赋值给bool
		if(bool==true){
			F.echo('{"valid":"true","msg":"200","info":"邮件发送成功"}');//发送成功返回TRUE
		}else{
			F.echo(bool);//发送过程中的错误由扩展返回
		}
	}else{
		F.echo('{"valid":"false","msg":"501","info":"用户信息不存在"}');//用户名不存在返回false
	}
});
//找回密码
EmailController.extend("Rpassword",function(useremail){
	var mail = require("mail");//引入mail扩展
	var ustr="email='" + useremail + "'";
	var rssa = M("User","id").where(ustr).orderby("id DESC").select();//数据库查询用户是否存在
	if (rssa.count()>0) {
		var rsarray=rssa.getArray();
		var userid=rsarray[0]['id'];
		var useremail=rsarray[0]['email'];
		var username=rsarray[0]['username'];
		var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
		var overtime=F.timespan(F.formatdate(F.date.dateadd("m",30,time),"yyyy-MM-dd HH:mm:ss"));//密钥失效日期
		var totime=F.timespan(F.formatdate(F.date.dateadd("s",128,time),"yyyy-MM-dd HH:mm:ss"));//间隔发送邮件时间
		var rguid=F.guid("D");//创建guid
		var str="useremail='"+useremail+"'";
		var rs = M("Rguid","id").where(str).orderby("id DESC").select();//查询密钥表
		var Insertstr='{"useremail":"'+useremail+'","rguid":"'+rguid+'","username":"'+username+'","overtime":"'+overtime+'","totime":"'+totime+'"}';
		if (rs.count()>0){//如果用户的密钥存在就更新
			if (F.timespan(time)>rs.getArray()[0]['totime']) {
				var updatestr={
					"rguid":rguid,
					"overtime":overtime,
					"totime":totime
				};
				M("Rguid","id").where(str).Update(updatestr);
			}else{
				return '{"valid":"false","msg":"500","info":"请求过于频繁"}';//时间限制
				F.exit();
			}
		}else{//否则就插入数据
			var insertstrjson=JSON.parse(Insertstr);
			M("Rguid","id").Insert(insertstrjson);
		}
		var _link=Mo.U('Email/Rpass','key='+AES_EN(Insertstr,1));//创建密钥地址
		var WebConfig=M("WebConfig","id").where('id=1').select().getArray();//查询网站配置信息
		var web_url=WebConfig[0]['web_url'];//网站地址
		var web_name=WebConfig[0]['web_name'];//网站名称
		var rc=M("Mail","id").where('id=1').select().getArray();
		var body=F.decodeHtml(rc[0]['rpassword']);//获取验证用户的邮件模板
		//下面的是替换对用的用户信息
		body=F.replace(body, /{@username@}/ig,username);//替换用户名
		body=F.replace(body, /{@email@}/ig,useremail);//替换用户邮箱
		body=F.replace(body, /{@web_name@}/ig,web_name);//替换网站名
		body=F.replace(body, /{@web_url@}/ig,web_url);//替换网站地址
		body=F.replace(body, /{@link@}/ig,_link);//替换验证地址
		body=F.replace(body, /{@time@}/ig,time);//替换时间
		var title=rc[0]['rpasswordtitle'];//获取验证用户的邮件模板
		var servermail=rc[0]['email'];//服务器邮箱
		var serverpassword=rc[0]['password'];//服务器邮箱密码
		var serversmtp=rc[0]['smtp'];//服务器地址
		var email=new mail(servermail,serverpassword,serversmtp);//初始化邮件发送方法
		email.to(useremail,title,body);//创建发送对象
		var bool=email.send();//发送邮件，把发送结果赋值给bool
		if(bool==true){
			return '{"valid":"true","msg":"200","info":"邮件发送成功"}';//发送成功返回TRUE
		}else{
			return bool;//发送过程中的错误由扩展返回
		}
	}else{
		return '{"valid":"false","msg":"501","info":"用户信息不存在"}';//用户名不存在返回false
	}
});
//验证码邮件
EmailController.extend("Safe",function(){
	var mail = require("mail");//引入mail扩展
	var user=new USERINFO();//获取用户名，缓存在session
	var username=user.name();
	if (username){//判断用户名是否存在
		var ustr="username='" + username + "'";
		var rss = M("User","id").where(ustr).orderby("id DESC").select();//数据库查询用户是否存在
		var rsarray=rss.getArray();
		var useremail=rsarray[0]['email'];
		var __safe=randomString(8);//创建随机字符
		F.session('__safe',__safe);//session注入__safe
		var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
		var WebConfig=M("WebConfig","id").where('id=1').select().getArray();//查询网站配置信息
		var web_url=WebConfig[0]['web_url'];//网站地址
		var web_name=WebConfig[0]['web_name'];//网站名称
		var rc=M("Mail","id").where('id=1').select().getArray();
		var body=F.decodeHtml(rc[0]['keybody']);//获取邮件模板
		//下面的是替换对用的用户信息
		body=F.replace(body, /{@username@}/ig,username);//替换用户名
		body=F.replace(body, /{@email@}/ig,useremail);//替换用户邮箱
		body=F.replace(body, /{@web_name@}/ig,web_name);//替换网站名
		body=F.replace(body, /{@web_url@}/ig,web_url);//替换网站地址
		body=F.replace(body, /{@safe@}/ig,__safe);//替换验证字符
		body=F.replace(body, /{@time@}/ig,time);//替换时间
		var title=rc[0]['keytitle'];//获取验证用户的邮件模板
		var servermail=rc[0]['email'];//服务器邮箱
		var serverpassword=rc[0]['password'];//服务器邮箱密码
		var serversmtp=rc[0]['smtp'];//服务器地址
		var email=new mail(servermail,serverpassword,serversmtp);//初始化邮件发送方法
		email.to(useremail,title,body);//创建发送对象
		var bool=email.send();//发送邮件，把发送结果赋值给bool
		if(bool==true){
			F.echo('{"valid":"true","msg":"200","info":"邮件发送成功"}');//发送成功返回TRUE
		}else{
			F.echo(bool);//发送过程中的错误由扩展返回
		}
	}else{
		F.echo('{"valid":"false","msg":"501","info":"用户信息不存在"}');//用户名不存在返回false
	}
});
EmailController.extend("RegSafe",function(useremail,username){
	var mail = require("mail");//引入mail扩展
	var __emailsafe=randomString(8);//创建随机字符
	F.session('__emailsafe',__emailsafe);//session注入__safe
	var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
	if (!is_empty(F.session('totime'))) {
		if(F.timespan(time)<F.session('totime')){
			return '{"valid":"false","msg":"500","info":"请求过于频繁"}';//发送成功返回TRUE
			F.exit();
		}
	}
	var WebConfig=M("WebConfig","id").where('id=1').select().getArray();//查询网站配置信息
	var web_url=WebConfig[0]['web_url'];//网站地址
	var web_name=WebConfig[0]['web_name'];//网站名称
	var rc=M("Mail","id").where('id=1').select().getArray();
	var body=F.decodeHtml(rc[0]['keybody']);//获取邮件模板
	//下面的是替换对用的用户信息
	body=F.replace(body, /{@username@}/ig,username);//替换用户名
	body=F.replace(body, /{@email@}/ig,useremail);//替换用户邮箱
	body=F.replace(body, /{@web_name@}/ig,web_name);//替换网站名
	body=F.replace(body, /{@web_url@}/ig,web_url);//替换网站地址
	body=F.replace(body, /{@safe@}/ig,__emailsafe);//替换验证字符
	body=F.replace(body, /{@time@}/ig,time);//替换时间
	var title=rc[0]['keytitle'];//获取验证用户的邮件模板
	var servermail=rc[0]['email'];//服务器邮箱
	var serverpassword=rc[0]['password'];//服务器邮箱密码
	var serversmtp=rc[0]['smtp'];//服务器地址
	var email=new mail(servermail,serverpassword,serversmtp);//初始化邮件发送方法
	email.to(useremail,title,body);//创建发送对象
	var bool=email.send();//发送邮件，把发送结果赋值给bool
	if(bool==true){
		var totime=F.timespan(time)+128;//下次发送邮件时间
		F.session('totime',totime);
		return '{"valid":"true","msg":"200","info":"邮件发送成功"}';//发送成功返回TRUE
	}else{
		return bool;//发送过程中的错误由扩展返回
	}
});
</script>