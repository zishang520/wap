<script language="jscript" runat="server">
/*
** 这是一个后台登陆控制器
** 语法：newController = IController.create([__construct[,__destruct]]);
** __construct：构造函数；
** __destruct：析构函数；
** ip2int：ip转为整型
** int2ip：同理
@@@@@@@@@@@X5111111111111111sssss111sri;;::,:;is11
@@@@@@@@@@X51111111111111sssrrrrrrssri;;;rsr;:;;is
@@@@@@@@@@555h11ssrrrrrriiiiiii;iiii;;;;s555hs;;;;
@@@@@@@@@@hri;;;;;;;;;;;;::;;::::::::;:ihh55S5sii;
@@@@@@    ,::;;;iiirrsssri:,,,,,.,,,,::s1hh5551irr
@@    .,:;;irs1hh5555hh11si,,,,.. ..,,;rs1hh551irr
@  .,:;is15S399933SSS55hh1si:,,,,...,,;irs11h1rirr
@  :is539GG88899933SSS55hh1r::::::,,,,irss1hh1;ii;
@ .:r98GGGGG888999S5SSS55hhi;;;;i;::,:irss1hhs;ri;
@  :r58GGGGG88935s1S3SSS55s;iiiiri;;:;ss111hhiir;i
@@ .:i1399Sh5hsi;s33333SSs;rr;rssrii;i11hhhhr;ri;i
@@@  ,;r1hhh5hsr5999933S1irr;is1srii;ihh5551irriis
@@@@@  .;15Shs198888995rrsr;;s111r;i;i55555hrrr;i1
@@@@@@  ,rsrsS8GGG889hrssi:ir111si;iii5SSSS5srr;r1
@@@@  .:rir59GGGGG85ss1s;,;iii;;;;iriiS3333Ssrr;i1
@@   ,iirh9GGGGG8S1shhs, .,,:::;ir11rrS399331rri;s
@  .;iis38GGGGG8hshSShsiiiiir1hhhhhh11399999Shsr:r
  ,iir58GGGGG9511SS51sssrr533S555S39999888883hsr,:
 .ii19GGGGG8Srir111hh53399G83398G8S5hh159GGG3hrs,,
 :i18GGGGGGShhSS3988GGGGGGGGGGG9Shshhh1s15S385ri. 
 ,rS8GGGGGGGGGGGGGGGGGG8933935hsrssi;;;iiiir11i,  
 .ih8GGGGGGGGGGGGGGG835h1ss1sri;:.   @@    .,.    
@ :rh98GGGGGGG893SS5hs1h1ri:.    @@@@@@@@@@@@@ @@@
@@ :i1555555hhhsssriii,.   @@@@@@@@@@@@@@@@@@@@@@@
@@  .;irrrrriiii;,    @@@@@@@@@@@@@@@@@@@@@@@@@@@@
*/
LoginController = IController.create();//控制器命名，这里不需要auth，不然会无限循环
//默认Action 
LoginController.extend("Index", function(){
	this.display("Login:Index");
});
//对象中加了TRue的是POST方法
LoginController.extend("Index", true, function(){
	//判断
	var username=F.post("username");
	var password=F.post("password");
	var psafe=F.post("safe");
	var ssafe=F.session("safe");
	if (psafe.toLocaleLowerCase()!==ssafe.toLocaleLowerCase() || is_empty(psafe) || is_empty(ssafe)) {
		F.session('__error','验证码不正确');//把储物注入SESSION、跳转后Auth会自动注入到模板
		F.goto(Mo.U('Login/Index'));
		F.exit();
	}
	F.session.destroy("safe");//销毁验证码
	if (is_empty(username) || is_empty(password)) {
		F.session('__error','用户名或密码不能为空');//把储物注入SESSION、跳转后Auth会自动注入到模板
		F.goto(Mo.U('Login/Index'));
		F.exit();
	}
	var str="username='" + F.encodeHtml(username) + "'";
	var rs = M("Admin","id").where(str).orderby("id DESC").limit(1,1).query();
	if (rs.count()<=0){
		F.session('__error','用户不存在');//把储物注入SESSION、跳转后Auth会自动注入到模板
		F.goto(Mo.U('Login/Index'));
		F.exit();
	}
	rs.select(function(item){
		if (item.password!==MD5(password)) {
			F.session('__error','密码错误');//把储物注入SESSION、跳转后Auth会自动注入到模板
			F.goto(Mo.U('Login/Index'));
			F.exit();
		}
		var datetime=F.formatdate(new Date(),"yyyy-MM-dd-HH:mm");
		var string='{"id":'+item.id+',"username":"' + item.username +'","password":"' + item.password +'","ip":' + ip2int(F.server("REMOTE_ADDR")) + '}';
		var token=MD5(string+AES_EN(string,1));
		var csrf=ip2int(F.server("REMOTE_ADDR"))+datetime;
		var __csrf = AES_EN(ip2int(F.server("REMOTE_ADDR"))+F.formatdate(new Date(),"HH:mm:ss"),1);
		cookie('__csrf',__csrf);//cookie注入csrf
		F.session('__csrf',__csrf);//session注入CSRF
		//注入登录成功后的cookie标志，已加密，密钥在lIBRARY/Auth.asp
		cookie("Z_Cookies", {
			__Hash : AES_EN(string,1),
			__token : token,
			__login : datetime
		});
		//同上
		F.session("admin.__Hash",AES_EN(string,1));
		F.session("admin.__login",datetime);
		F.session("admin.__token",token);
		if(F.server("HTTP_REFERER")!=Mo.U('Login/Index'))F.goto(F.server("HTTP_REFERER")); else F.goto(Mo.U('Home/Index'));
	});
});
LoginController.extend("Logout",function(){
	F.session.destroy("admin.__token");
	F.session.destroy("admin.__login");
	F.session.destroy("admin.__Hash");
	cookie("Z_Cookies",'');
	F.goto(Mo.U('Login/Index'));
});
//一个验证码方法
LoginController.extend("Safe",function(){
	ExceptionManager.errorReporting(E_ERROR);
	Safecode("safe", {padding:8, odd:3, font:'yahei'});
});
</script>