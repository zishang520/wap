<script language="jscript" runat="server">
/*
** 这是一个内容管理控制器
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
NewController = IController.create(auth());
Mo.assign('method',Mo.Method);//注入单前控制器名称，以在模板判断是否选中
//默認Action
//內容列表頁
NewController.extend("Index",function(){
	var data = M("New","id").limit(F.get.int("page", 1),10).orderby("id desc").select();
	this.assign('data',data);
	this.display("New:Index");
});
//內容創建
NewController.extend("Create",function(){
	var rc = M("Class","id").where('grap>1').orderby("did asc").select();
	rc.assign('data');
	this.display("New:Create");
});
//內容顯示
NewController.extend("Show",function(){
	var id=F.all("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('New/Index'));
		F.exit();
	}
	var str="id=" + id;
	var rs = M("New","id").where(str).orderby("id DESC").select();
	if (rs.count()==0) {
		F.session('__error','选择的内容不存在');
		F.goto(Mo.U('New/Index'));
		F.exit();
	}
	rs.assign('data');
	this.display("New:Show");
});
//創建內容Post地址,true為只接受Post請求
NewController.extend("Stroe",true,function(){
	var title=F.encodeHtml(F.post("title"));
	if (is_empty(title)) {
		F.session('__error','内容标题不能为空');
		F.goto(Mo.U('New/Create'));
		F.exit();
	}
	var pic=F.safe(F.post("pic"));
	var des=F.encodeHtml(F.post("des"));
	var content=F.encodeHtml(F.post("content"));
	var isdisplay=(F.post("isdisplay")==1)?1:0;
	var releasetime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var insertstr={
		"title":title,
		"pic":pic,
		"des":des,
		"content":content,
		"isdisplay":isdisplay,
		"releasetime":releasetime,
		"exptime":releasetime
	};
	M("New","id").Insert(insertstr);
	F.goto(Mo.U('New/Index'));
});
//內容編輯
NewController.extend("Edit",function(){
	var id=F.all("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('New/Index'));
		F.exit();
	}
	var str="id=" + id;
	var data = M("New","id").where(str).orderby("id DESC").select();
	if (data.count()==0){
		F.session('__error','选择的内容不存在');
		F.goto(Mo.U('New/Index'));
		F.exit();
	}
	this.assign('data',data);
	this.display("New:Edit");
});
//內容更新地址，描述同上
NewController.extend("Update",true,function(){
	var id=F.post("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('New/Index'));
		F.exit();
	}
	var str = "id=" + id;
	var title=F.encodeHtml(F.post("title"));
	if (is_empty(title)) {
		F.session('__error','内容标题不能为空');
		F.goto(Mo.U('New/Edit','id='+id));
		F.exit();
	}
	var pic=F.safe(F.post("pic"));
	var des=F.encodeHtml(F.post("des"));
	var content=F.encodeHtml(F.post("content"));
	var exptime=F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var isdisplay=(F.post("isdisplay")==1)?1:0;
	var updatestr={
		"title":title,
		"pic":pic,
		"des":des,
		"content":content,
		"isdisplay":isdisplay,
		"exptime":exptime
	};
	M("New","id").where(str).Update(updatestr);
	var page=F.get('page');
	if(!is_empty(page)){F.goto(Mo.U('New/Index','page='+page));}else{F.goto(Mo.U('New/Index'));}
});
//内容删除
NewController.extend("Del",true,function(){
	var str="id=" + F.post("id");
	M("New","id").where(str).Delete();
	var page=F.get('page');
	if(!is_empty(page)){F.goto(Mo.U('New/Index','page='+page));}else{F.goto(Mo.U('New/Index'));}
});
</script>