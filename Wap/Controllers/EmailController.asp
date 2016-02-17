<script language="jscript" runat="server">
/*
*生成邮箱验证的一个控制器
*/
EmailController = IController.create();
EmailController.extend("Auth",function(){
	var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
	var userkey=F.get('key');
	var keyinfo=F.json(AES_EN(userkey,2));
	if (typeof(keyinfo)!='undefined') {
		var useremail=keyinfo['useremail'];
		var guid=keyinfo['guid'];
		var username=keyinfo['username'];
		var overtime=keyinfo['overtime'];
		var str="guid='"+guid+"' AND useremail='"+useremail+"' AND username='"+username+"'";
		var rs = M("Guid","id").where(str);//数据库查询用户是否存在
		var rsa=rs.orderby("id DESC").limit(1,1).select();
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
	if (typeof(keyinfo)!='undefined') {
		var useremail=keyinfo['useremail'];
		var rguid=keyinfo['rguid'];
		var username=keyinfo['username'];
		var overtime=keyinfo['overtime'];
		var str="rguid='"+rguid+"' AND useremail='"+useremail+"' AND username='"+username+"'";
		var rs = M("Rguid","id").where(str);//数据库查询用户是否存在
		var rsa=rs.orderby("id DESC").limit(1,1).select();
		if (rsa.count()>0) {
			if (F.timespan(time)<overtime) {//判断密钥是否过期
				F.echo('找回密码');
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
//找回密码post
EmailController.extend("Rpass",true,function(){
	var password = MD5(F.all("password"));
	var confirmPassword = MD5(F.all("confirmPassword"));
	var useremail=F.post('useremail');
	var rguid=F.post('rguid');
	if (F.string.exp(F.all("password"),/^[a-zA-Z0-9_]{6,16}$/)!=F.all("password") || F.all('password')=='') {
		F.echo('{"type":"403","msg":"false","sid":"","error":"password Incorrect format"}');//密码格式
		F.exit();
	}
	if (confirmPassword!==password) {
		F.echo('{"type":"503","msg":"false","sid":"","error":"password Not equal to rpassword"}');//两次输入密码不匹配
		F.exit();
	}
	var str="rguid='"+rguid+"' AND useremail='"+useremail+"'";
	var rs = M("Rguid","id").where(str);//数据库查询用户是否存在
	var rsa=rs.orderby("id DESC").limit(1,1).select();
	if (rsa.count()>0) {
		updatestr='{"password":"'+password+'"}';
		F.echo('找回密码');
	}else{
		F.echo('密钥无效');
	}
});
//邮箱验证生成控制器
EmailController.extend("AuthLink",function(){
	var mail = require("mail");//引入mail扩展
	var user=new USERINFO();//获取用户名，缓存在session
	var username=user.name();
	if (username){//判断用户名是否存在
		var ustr="username='" + username + "'";
		var rss = M("User","id").where(ustr).orderby("id DESC").limit(1,1).select();//数据库查询用户是否存在
		var rsarray=rss.getArray();
		var userid=rsarray[0]['id'];
		var useremail=rsarray[0]['email'];
		var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
		var overtime=F.timespan(F.formatdate(F.date.dateadd("h",2,time),"yyyy-MM-dd HH:mm:ss"));//密钥失效日期
		var totime=F.timespan(F.formatdate(F.date.dateadd("s",128,time),"yyyy-MM-dd HH:mm:ss"));//间隔发送邮件时间
		var guid=F.guid("N");//创建guid
		var str="useremail='"+useremail+"'";
		var rs = M("Guid","id").where(str).orderby("id DESC").limit(1,1).select();//查询密钥表
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
		var body=rc[0]['authbody'];//获取验证用户的邮件模板
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
EmailController.extend("Rpassword",function(){
	var mail = require("mail");//引入mail扩展
	var useremail=F.all('useremail');
	if (F.string.email(useremail)!=useremail || useremail=='') {
		F.echo('邮箱格式不正确');
		F.exit();
	}
	var ustr="email='" + useremail + "'";
	var rssa = M("User","id").where(ustr).orderby("id DESC").limit(1,1).select();//数据库查询用户是否存在
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
		var rs = M("Rguid","id").where(str).orderby("id DESC").limit(1,1).select();//查询密钥表
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
				F.echo('{"valid":"false","msg":"500","info":"请求过于频繁"}');//时间限制
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
		var body=rc[0]['rpassword'];//获取验证用户的邮件模板
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
			F.echo('{"valid":"true","msg":"200","info":"邮件发送成功"}');//发送成功返回TRUE
		}else{
			F.echo(bool);//发送过程中的错误由扩展返回
		}
	}else{
		F.echo('{"valid":"false","msg":"501","info":"用户信息不存在"}');//用户名不存在返回false
	}
});
//验证码邮件
EmailController.extend("Safe",function(){
	var mail = require("mail");//引入mail扩展
	var user=new USERINFO();//获取用户名，缓存在session
	var username=user.name();
	if (username){//判断用户名是否存在
		var ustr="username='" + username + "'";
		var rss = M("User","id").where(ustr).orderby("id DESC").limit(1,1).select();//数据库查询用户是否存在
		var rsarray=rss.getArray();
		var useremail=rsarray[0]['email'];
		var __safe=randomString(8);//创建随机字符
		F.session('__safe',__safe);//session注入__safe
		var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
		var WebConfig=M("WebConfig","id").where('id=1').select().getArray();//查询网站配置信息
		var web_url=WebConfig[0]['web_url'];//网站地址
		var web_name=WebConfig[0]['web_name'];//网站名称
		var rc=M("Mail","id").where('id=1').select().getArray();
		var body=rc[0]['keybody'];//获取邮件模板
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
</script>