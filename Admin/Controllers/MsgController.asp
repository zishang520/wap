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
MsgController = IController.create(auth());//控制器命名//auth()为验证状态
Mo.assign('method',Mo.Method);//注入单前控制器名称，以在模板判断是否选中
//默认Action
MsgController.extend("Index", function(){
	var rc = M("Msg","id").limit(F.get.int("page", 1),10).orderby("id desc").select();
	rc.assign("data");
	this.display("Msg:Index");
});
//編輯
MsgController.extend("Look", function(){
	var id=F.get("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('Msg/Index'));
		F.exit();
	}
	this.assign("id",id);
	var str="id=" + id;
	var rs = M("Msg","id").where(str).orderby("id desc").limit(1,1).select();
	if (rs.count()==0) {
		F.session('__error','选择的留言不存在');
		F.goto(Mo.U('Msg/Index'));
		F.exit();
	}
	rs.assign("data");
	M('Msg','id').where(str).Update({"islook":1});
	this.display("Msg:Look");
});
//未查看留言
MsgController.extend("UnLook", function(){
	var rc = M("Msg","id").where('islook=0').limit(F.get.int("page", 1),10).orderby("id desc").select();
	rc.assign("data");
	this.display("Msg:UnLook");
});
//未查看留言
MsgController.extend("UnReplay", function(){
	var rc = M("Msg","id").where('isreplay=0').limit(F.get.int("page", 1),10).orderby("id desc").select();
	rc.assign("data");
	this.display("Msg:UnReplay");
});
//查看留言以及反饋
MsgController.extend("Replay",true,function(){
	var id=F.post("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('Msg/Index'));
		F.exit();
	}
	var str="id=" + id;
	var aptime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var msgreplay=F.encodeHtml(F.post('msgreplay'));
	var isdisplay=(F.post('isdisplay')==1)?1:0;
	if (!is_empty(msgreplay)) {
		var updatestr={"msgreplay":msgreplay,"isdisplay":isdisplay,"isreplay":1,"aptime":aptime};
		M('Msg','id').where(str).Update(updatestr);
		var page=F.get('page');
		if(!is_empty(page)){F.goto(Mo.U('Msg/Index','page='+page));}else{F.goto(Mo.U('Msg/Index'));}
	}else{
		F.session('__error','回复内容不能为空');
		F.goto(Mo.U('Msg/Look','id='+id));
		F.exit();
	}
});
//刪除
MsgController.extend("Del", function(){
	var str="id=" + F.post("id");
	M("Msg","id").where(str).Delete();
	var page=F.get('page');
	if(!is_empty(page)){F.goto(Mo.U('Msg/Index','page='+page));}else{F.goto(Mo.U('Msg/Index'));}
});
//打印创建页面
</script>