<script language="jscript" runat="server">
/*
** 这是一个系统设置控制器
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
SysWebController = IController.create(auth());
Mo.assign('method',Mo.Method);//注入单前控制器名称，以在模板判断是否选中
//默认Action
//网站信息编辑
SysWebController.extend("Webinfo",function(){
	var rc=M('WebConfig','id').where('id=1').select();
	rc.assign('data');
	this.display("SysWeb:Webinfo");
});
//网站信息
SysWebController.extend("Webinfo",true,function(){
	var web_name=F.encodeHtml(F.post('web_name'));//网站名，将显示与title后面
	var web_url=F.encodeHtml(F.post('web_url'));//网站地址
	var web_logo=F.encodeHtml(F.post('web_logo'));//网站logo
	var web_title=F.encodeHtml(F.post('web_title'));//网站title
	var keywords=F.encodeHtml(F.post('keywords'));//关键词
	var description=F.encodeHtml(F.post('description'));//描述
	var record=F.encodeHtml(F.post('record'));//备案
	var buinformation=F.encodeHtml(F.post('buinformation'));//底部信息
	var copyright=F.encodeHtml(F.post('copyright'));//版权
	if(is_empty(web_name) || is_empty(web_url) || is_empty(web_title)){
		F.session('__error','名称,链接,名称均不能为空');
		F.goto(Mo.U('SysWeb/Webinfo'));
		F.exit();
	}
	var updatestr={"web_title":web_title,"web_logo":web_logo,"web_url":web_url,"web_name":web_name,"keywords":keywords,"description":description,"record":record,"buinformation":buinformation,"copyright":copyright};
	M('WebConfig','id').where('id=1').Update(updatestr);
	F.goto(Mo.U('SysWeb/Webinfo'));
});
//邮箱设置
SysWebController.extend("Email",function(){
	var rc=M('Mail','id').where('id=1').select();
	rc.assign('data');
	this.display("SysWeb:Email");
});
SysWebController.extend("Email",true,function(){
	var smtp=F.safe(F.post('smtp'));//smtp、
	var email=F.safe(F.post('email'));//user
	var password=F.safe(F.post('password'));//password
	var isopen=(F.post('isopen')==1)?1:0;//isopen server
	var updatestr={"smtp":smtp,"email":email,"password":password,"isopen":isopen};//update str
	M('Mail','id').where('id=1').Update(updatestr);// update to data
	F.goto(Mo.U('SysWeb/Email'));
});
//邮箱模板
SysWebController.extend("EmailTemplate",function(){
	var rc=M('Mail','id').where('id=1').select();
	rc.assign('data');
	this.display("SysWeb:EmailTemplate");
});
SysWebController.extend("EmailTemplate",true,function(){
	var id=F.get.int('id');
	if (F.string.exp(id,/^[1|2|3|4]$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('SysWeb/EmailTemplate'));
		F.exit();
	}
	switch(id) {
		case 1:
		var welcometitle=F.safe(F.post('welcometitle'));
		var welcome=F.encodeHtml(F.post('welcome'));
		var updatestr_a={"welcometitle":welcometitle,"welcome":welcome};
		M('Mail','id').where('id=1').Update(updatestr_a);
		F.goto(Mo.U('SysWeb/EmailTemplate','id='+id));
		break;
		case 2:
		var authtitle=F.safe(F.post('authtitle'));
		var authbody=F.encodeHtml(F.post('authbody'));
		var updatestr_b={"authtitle":authtitle,"authbody":authbody};
		M('Mail','id').where('id=1').Update(updatestr_b);
		F.goto(Mo.U('SysWeb/EmailTemplate','id='+id));
		break;
		case 3:
		var rpasswordtitle=F.safe(F.post('rpasswordtitle'));
		var rpassword=F.encodeHtml(F.post('rpassword'));
		var updatestr_c={"rpasswordtitle":rpasswordtitle,"rpassword":rpassword};
		M('Mail','id').where('id=1').Update(updatestr_c);
		F.goto(Mo.U('SysWeb/EmailTemplate','id='+id));
		break;
		case 4:
		var keytitle=F.safe(F.post('keytitle'));
		var keybody=F.encodeHtml(F.post('keybody'));
		var updatestr_d={"keytitle":keytitle,"keybody":keybody};
		M('Mail','id').where('id=1').Update(updatestr_d);
		F.goto(Mo.U('SysWeb/EmailTemplate','id='+id));
		break;
	}
});
//短信模板
SysWebController.extend("SmsTemplate",function(){
	var rc=M('Sms','id').where('id=1').select();
	rc.assign('data');
	this.display("SysWeb:SmsTemplate");
});
SysWebController.extend("SmsTemplate",true,function(){
	var authbody=F.safe(F.post('authbody'));
	if (!is_empty(authbody)) {
		var updatestr={"authbody":authbody};
		M('Sms','id').where('id=1').Update(updatestr);
		F.goto(Mo.U('SysWeb/SmsTemplate'));
	}else{
		F.session('__error','短信内容不能为空');
		F.goto(Mo.U('SysWeb/SmsTemplate'));
		F.exit();
	}
});
</script>