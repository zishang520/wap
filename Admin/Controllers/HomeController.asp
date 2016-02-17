<script language="jscript" runat="server">
/*
*仪表盘
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
HomeController = IController.create(function(){
	auth();
	MEM.errorReporting(E_NONE);
});
Mo.assign('method',Mo.Method);//注入单前控制器名称，以在模板判断是否选中
//默认Action
HomeController.extend("Console", function(){
	C("@.MO_COMPILE_CACHE", false);
	var mo_debug_mode = C("@.MO_DEBUG_MODE");
	if(mo_debug_mode != "SESSION" && mo_debug_mode!="APPLICATION"){
		F.echo(F.format("当前Debug模式为'{0}'，请修改为'SESSION'或'APPLICATION'才可以使用ExceptionManager控制台。<br />请修改配置项MO_DEBUG_MODE的值为'SESSION'或'APPLICATION'，正式上线后建议使用DIRECT模式。", mo_debug_mode));
		return;
	}
	this.display("Home:Console");
});
HomeController.extend("ConsoleShow", function(){
	F.echo(MEM.fromSession());
});
//
HomeController.extend("Index", function(){
	var rc = M("IpLog","id").limit(F.get.int("page", 1),10).orderby("num desc").select();
	rc.assign("data");
	this.display("Home:IpLog");
});
HomeController.extend("IpLog", function(){
	var rc = M("IpLog","id").limit(F.get.int("page", 1),10).orderby("num desc").select();
	rc.assign("data");
	this.display("Home:IpLog");
});
HomeController.extend("UpIp",true,function(){
	var id=F.post('id');
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('Home/IpLog'));
		F.exit();
	}
	var noopen=F.post('noopen')==1?1:0;
	var str='id='+id;
	M('IpLog').where(str).Update({"noopen":noopen});
	var page=F.get('page');
	if(!is_empty(page)){F.goto(Mo.U('Home/IpLog','page='+page));}else{F.goto(Mo.U('Home/IpLog'));}
});
HomeController.extend("DelIp",true,function(){
	var id=F.post('id');
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('Home/IpLog'));
		F.exit();
	}
	var str='id='+id;
	M('IpLog').where(str).Delete();
	var page=F.get('page');
	if(!is_empty(page)){F.goto(Mo.U('Home/IpLog','page='+page));}else{F.goto(Mo.U('Home/IpLog'));}
});
</script>