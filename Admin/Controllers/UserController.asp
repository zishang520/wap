<script language="jscript" runat="server">
/*
** 这是一个用户管理控制器
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
UserController = IController.create(auth());//控制器命名//auth()为验证状态
Mo.assign('method',Mo.Method);//注入单前控制器名称，以在模板判断是否选中
//默认Action
UserController.extend("Index", function(){
	var rc = M("User","id").limit(F.get.int("page", 1),10).orderby("id desc").select();
	rc.assign("data");
	this.display("User:Index");
});

UserController.extend("VipLog", function(){
	var rc = M("VipLog","id").limit(F.get.int("page", 1),10).orderby("id desc").select();
	rc.assign("data");
	this.display("User:VipLog");
});
//打印创建页面
UserController.extend("Create", function() {
	this.display("User:Create");
});
//创建用户信息
UserController.extend("Stroe", function() {
	var pass=F.post("password");
	var username = F.encodeHtml(F.post("username"));
	if (F.string.exp(username,/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/)!=username || is_empty(username)) {
		F.session('__error','用户名格式不正确或为空');
		F.goto(Mo.U('User/Create'));
		F.exit();
	}
	if (F.string.exp(pass,/^[a-zA-Z0-9_]{6,16}$/)!=pass || is_empty(pass)) {
		F.session('__error','密码格式不正确或为空');
		F.goto(Mo.U('User/Create'));
		F.exit();
	}
	var password = MD5(pass);
	var email = F.encodeHtml(F.post("email"));
	var mobile = F.encodeHtml(F.post("mobile"));
	var regtime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var vipexpire = F.timespan(F.post("vipexpire"));
	var ismobile = (F.post("ismobile")==1)?1:0;//是否验证1为是0为否
	var isemail = (F.post("isemail")==1)?1:0;
	var isvip = F.post("isvip")==1?1:0;
	var islogin = (F.post("islogin")==1)?1:0;
	var regip = ip2int(F.server("REMOTE_ADDR"));
	var anser=F.post("anser");
	var question=F.post("question");
	var questionanser;
	if (!is_empty(anser) && !is_empty(question)) {
		questionanser = '"question":"' + F.encodeHtml(question) +'","anser":"'+MD5(anser)+'",';
	}else{
		questionanser = "";
	}
	var Insertstr='{"username":"' + username +'","password":"' + password +'",'+ questionanser +'"email":"' + email +'","mobile":"' + mobile +'","regtime":"' + regtime +'","regip":"' + regip +'","vipexpire":"' + vipexpire +'","ismobile":' + ismobile +',"isemail":' + isemail +',"isvip":' + isvip +',"islogin":' + islogin +'}';
	var Insertstrjson=JSON.parse(Insertstr);//转换为对象数组
	M("User","id").Insert(Insertstrjson);//添加
	F.goto(Mo.U('User/Index'));//跳转注意必须写网站路径，不能只写控制器，会无法识别
});
//查看用戶
UserController.extend("Show", function() {
	var id=F.get("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('User/Index'));
		F.exit();
	}
	var str="id=" + id;
	var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).select();
	if (rs.count()==0) {
		F.session('__error','选择的用户不存在');
		F.goto(Mo.U('User/Index'));
		F.exit();
	}
	rs.assign("data");
	this.display("User:Show");
});
//編輯用戶信息
UserController.extend("Edit", function() {
	var id=F.get("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('User/Index'));
		F.exit();
	}
	this.assign("id",id);
	var str="id=" + id;
	var rs = M("User","id").where(str).orderby("id DESC").limit(1,1).select();
	if (rs.count()==0) {
		F.session('__error','选择的用户不存在');
		F.goto(Mo.U('User/Index'));
		F.exit();
	}
	rs.assign("data");
	this.display("User:Edit");
});
//更新用戶信息,對象增加了TRue的是POST方法,只接收數據
UserController.extend("Update", true, function(){
	var id=F.post("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('User/Index'));
		F.exit();
	}
	var str="id=" + id;
	var question = F.encodeHtml(F.post("question"));
	var email = F.encodeHtml(F.post("email"));
	var mobile = F.encodeHtml(F.post("mobile"));
	var vipexpire = F.timespan(F.post("vipexpire"));
	var ismobile = (F.post("ismobile")==1)?1:0;//是否验证1为是0为否
	var isemail = (F.post("isemail")==1)?1:0;
	var isvip = F.post("isvip")==1?1:0;
	var islogin = (F.post("islogin")==1)?1:0;
	var anser=F.post('anser');
	var questionanser;
	if (!is_empty(anser)) {
		questionanser = '"anser":"'+MD5(anser)+'",';
	}else{
		questionanser = "";
	}
	var updatestr='{"question":"' + question +'",'+ questionanser +'"email":"' + email +'","mobile":"' + mobile +'","vipexpire":"' + vipexpire +'","ismobile":' + ismobile +',"isemail":' + isemail +',"isvip":' + isvip +',"islogin":' + islogin +'}';
	var updatestrjson=JSON.parse(updatestr);//转换为对象数组
	M("User","id").where(str).Update(updatestrjson);//更新
	F.goto(Mo.U('User/Edit','id='+id));//跳转注意必须写网站路径，不能只写控制器，会无法识别
});
//删除用户
UserController.extend("Del", true,function() {
	var id=F.post("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('User/Index'));
		F.exit();
	}
	var str="id=" + F.post("id");
	M("User","id").where(str).Delete();//删除
	var page=F.get('page');
	if(!is_empty(page)){F.goto(Mo.U('User/Index','page='+page));}else{F.goto(Mo.U('User/Index'));}
});
</script>