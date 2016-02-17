<script language="jscript" runat="server">
/*
** 这是一个栏目管理控制器
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
ClassController = IController.create(auth());//控制器命名//auth()为验证状态
Mo.assign('method',Mo.Method);//注入单前控制器名称，以在模板判断是否选中
//私有方法
ClassController.extend('Class',function(cid){
	var html='';
	var str='uid='+cid;
	var rc = M("Class","id").where(str).orderby("did asc").select();//获取当前栏目的下属栏目
	var rcarray=rc.getArray();
	for (var i = 0; i < rc.count(); i++) {
		var str='uid='+rcarray[i]['cid'];
		var rcs = M("Class","id").where(str).orderby("did asc").select().count();//获取上一级栏目的下属栏目
		var rid=rcarray[i]['rid'];
		var cid=rcarray[i]['cid'];
		var id=rcarray[i]['id'];
		var classname=rcarray[i]['classname'];
		var did=rcarray[i]['did'];
		var grap=rcarray[i]['grap']+1;//为后面添加栏目直接插入栏目级数
		var isdisplay=(rcarray[i]['isdisplay']==1)?'bg-success text-success':'bg-danger text-danger';
		var ismenu=(rcarray[i]['ismenu']==1)?'单页':'列表';
		//下属栏目存在时，执行私有方法
		if (rcs>0) {
			html+='<ol><li style="padding-right: 0px; border-top: dashed 1px #eeeeee;"><span class="'+isdisplay+'"><i class="glyphicon glyphicon-minus-sign"></i> '+classname+'</span>  <nobr style="float: right;"><strong style="padding-right: 50px;">'+ismenu+'</strong><input name="did" type="checkbox" id="inlineCheckbox2" value="'+id+'"> <input name="'+id+'" type="text" class="form-control input-sm" value="'+did+'" placeholder="Text input" style="text-align: center; width: 40px; display: initial;"><a class="btn btn-link btn-xs" href="'+Mo.U('Class/Cadd','id='+id)+'"> <i class="glyphicon glyphicon-log-in" aria-hidden="true"></i>添加</a> <a class="btn btn-link btn-xs" href="'+Mo.U('Class/Edit','id='+id)+'"> <i class="glyphicon glyphicon-pencil" aria-hidden="true"></i>编辑</a> <a class="btn btn-link btn-xs disabled"><i class="glyphicon glyphicon-trash" aria-hidden="true"></i>删除</a></nobr>';
			html+=this.Class(cid);
			//下属栏目存在时，继续执行循环自身，，知道没有下属栏目
		}else{
			html+='<ol><li style="padding-right: 0px; border-top: dashed 1px #eeeeee;"><span class="'+isdisplay+'"><i class="glyphicon glyphicon-leaf"></i> '+classname+'</span> <nobr style="float: right;"><strong style="padding-right: 50px;">'+ismenu+'</strong><input name="did" type="checkbox" id="inlineCheckbox2" value="'+id+'"> <input name="'+id+'" type="text" class="form-control input-sm" value="'+did+'" placeholder="Text input" style="text-align: center; width: 40px; display: initial;"><a class="btn btn-link btn-xs" href="'+Mo.U('Class/Cadd','id='+id)+'"> <i class="glyphicon glyphicon-log-in" aria-hidden="true"></i>添加</a> <a class="btn btn-link btn-xs" href="'+Mo.U('Class/Edit','id='+id)+'"> <i class="glyphicon glyphicon-pencil" aria-hidden="true"></i>编辑</a> <a onclick="Cdelete(\''+id+'\',\''+rid+'\',\''+cid+'\')" class="btn btn-link btn-xs" data-toggle="modal" data-target="#myModal'+id+'"><i class="glyphicon glyphicon-trash" aria-hidden="true"></i>删除</a></nobr>';
		}
		html+='</li></ol>';
	}
	return html;
}).AsPrivate();//这是定义私有方法的
//默认方法
ClassController.extend("Index",function(){
	var html='';
	var rc = M("Class","id").where('grap=1').orderby("did asc").select();//首先获取一级栏目
	var rcarray=rc.getArray();
	for (var i = 0; i < rc.count(); i++) {
		var str='uid='+rcarray[i]['cid'];
		var rcs = M("Class","id").where(str).orderby("did asc").select().count();//获取下属栏目数量
		var rid=rcarray[i]['rid'];
		var cid=rcarray[i]['cid'];
		var id=rcarray[i]['id'];
		var classname=rcarray[i]['classname'];
		var did=rcarray[i]['did'];
		var grap=rcarray[i]['grap']+1;//为后面添加栏目直接插入栏目级数
		var isdisplay=(rcarray[i]['isdisplay']==1)?'bg-success text-success':'bg-danger text-danger';
		var ismenu=(rcarray[i]['ismenu']==1)?'单页':'列表';
		//下属栏目存在时，执行私有方法
		if (rcs>0) {
			html+='<ol><li><span class="'+isdisplay+'"><i class="glyphicon glyphicon-minus-sign"></i> '+classname+'</span> <nobr style="float: right;"><strong style="padding-right: 50px;">'+ismenu+'</strong><input name="did" type="checkbox" id="inlineCheckbox2" value="'+id+'"> <input name="'+id+'" type="text" class="form-control input-sm" value="'+did+'" placeholder="Text input" style="text-align: center; width: 40px; display: initial;"><a class="btn btn-link btn-xs" href="'+Mo.U('Class/Cadd','id='+id)+'"> <i class="glyphicon glyphicon-log-in" aria-hidden="true"></i>添加</a> <a class="btn btn-link btn-xs" href="'+Mo.U('Class/Edit','id='+id)+'"> <i class="glyphicon glyphicon-pencil" aria-hidden="true"></i>编辑</a> <a onclick="Cdelete(\''+id+'\',\''+rid+'\',\''+cid+'\')" class="btn btn-link btn-xs" data-toggle="modal" data-target="#myModal'+id+'"><i class="glyphicon glyphicon-trash" aria-hidden="true"></i>删除</a></nobr>';
			html+=this.Class(cid);
			//把值传递给html
		}else{
			html+='<ol><li><span class="'+isdisplay+'"><i class="glyphicon glyphicon-leaf"></i> '+classname+'</span>  <nobr style="float: right;"><strong style="padding-right: 50px;">'+ismenu+'</strong><input name="did" type="checkbox" id="inlineCheckbox2" value="'+id+'"> <input name="'+id+'" type="text" class="form-control input-sm" value="'+did+'" placeholder="Text input" style="text-align: center; width: 40px; display: initial;"><a class="btn btn-link btn-xs" href="'+Mo.U('Class/Cadd','id='+id)+'"> <i class="glyphicon glyphicon-log-in" aria-hidden="true"></i>添加</a> <a class="btn btn-link btn-xs" href="'+Mo.U('Class/Edit','id='+id)+'"> <i class="glyphicon glyphicon-pencil" aria-hidden="true"></i>编辑</a> <a onclick="Cdelete(\''+id+'\',\''+rid+'\',\''+cid+'\')" class="btn btn-link btn-xs" data-toggle="modal" data-target="#myModal'+id+'"><i class="glyphicon glyphicon-trash" aria-hidden="true"></i>删除</a></nobr>';
		}
		//这里的else是为切换图标所写的。你可以想宁一个好办法节约代码
		html+='</li></ol>';
		//至此无限循环分级栏目结束读取进程
	}
	this.assign('list',html);
	this.display("Class:Index");
});
//栏目创建
ClassController.extend("Create",function(){
	var rc = M("Class","id").orderby("did asc").select();
	rc.assign('data');
	this.display('Class:Create');
});
//check
ClassController.extend("Did",function(){
	var info=F.string.matches(F.post('did'),/\d+/ig);
	for (var i = 0; i < info.length; i++) {
		var id=info[i][0];
		var did=F.post(id);
		var str='id='+id;
		M('Class').where(str).Update({"did":did});//
	}
	F.goto(Mo.U('Class/Index'));
});
//这个方法是添加
ClassController.extend("Cadd",function(){
	var id=F.all("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('Class/Index'));
		F.exit();
	}
	var str="id=" + id;
	var rs = M("Class","id").where(str).orderby("id DESC").select();
	if (rs.count()==0) {
		F.session('__error','选择的栏目不存在');
		F.goto(Mo.U('Class/Index'));
		F.exit();
	}
	rs.assign("data");
	this.display("Class:Cadd");
});
//添加和创建都是由这个方法接收数据
ClassController.extend("Stroe",true,function(){
	var content;
	var info=F.string.matches(F.post('info'),/\d+/ig);//F.post('info')数据格式//1[这个是RID],1[这个是UID],1[这是栏目等级] rid：顶级栏目的id，uid：父级栏目的id
	//判断传入栏目id是否为有效数据
	if (is_empty(info[0])){
		F.session('__error','未选择栏目');
		F.goto(Mo.U('Class/Create'));
		F.exit();
	}
	if(info[2][0]>1){
		var str='cid in ('+info[1][0]+','+info[0][0]+')';
		var rc=M("Class","id").where(str).orderby("id asc").query().count();
		if(rc==0){
			F.session('__error','父级栏目不存在');
			F.goto(Mo.U('Class/Create'));
			F.exit();
		}
	}
	var classname=F.encodeHtml(F.post("classname"));//栏目名称
	if (is_empty(classname)) {
		F.session('__error','栏目名不能为空');
		F.goto(Mo.U('Class/Create'));
		F.exit();
	}
	var pic=F.safe(F.post("pic"));//栏目缩略图
	var leftpic=F.safe(F.post("leftpic"));//栏目缩略图
	var rightpic=F.safe(F.post("rightpic"));//栏目缩略图
	var ismenu=(F.post('ismenu')==1)?1:0;//单页还是列表
	if (ismenu==1) {
		content='"ismenu":'+ismenu+',"content":"'+F.encodeHtml(F.post("content"))+'",';
	}else{
		content='"ismenu":'+ismenu+',';
	}
	//为创建的栏目添加cid，这个用做外链
	var cid=F.random.initialize("139125678345678912346782459",3)+F.formatdate(new Date(),"s")//随机种子，保证栏目的随机性
	//判断顶级是否为零，是的话就是顶级栏目
	var rid=(info[0][0]==0)?cid:info[0];
	var uid=info[1][0];//上级栏目id
	var grap=info[2][0];
	var isdisplay=(F.post("isdisplay")==1)?1:0;
	var releasetime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var insertstr='{"classname":"' + classname +'","pic":"' + pic +'","leftpic":"' + leftpic +'","rightpic":"' + rightpic +'","cid":' + cid +',"rid":' + rid +',"uid":' + uid +','+content+'"isdisplay":' + isdisplay +',"grap":' + grap +',"releasetime":"' + releasetime +'","exptime":"' + releasetime +'"}';
	var insertstrjson=JSON.parse(insertstr);//转为对象数组
	M("Class","id").Insert(insertstrjson);//插入
	F.goto(Mo.U('Class/Index'));
});
//编辑页面
ClassController.extend("Edit",function(){
	var id=F.all("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('Class/Index'));
		F.exit();
	}
	var str='id='+id;
	var data = M("Class","id").where(str).select();
	if (data.count()==0) {
		F.session('__error','选择的栏目不存在');
		F.goto(Mo.U('Class/Index'));
		F.exit();
	}
	data.each(function(item){
		item.subitems=M("Class","id").where('grap<'+item.grap).orderby("id asc").select().getArray();
	})
	this.assign('data',data);
	this.display('Class:Edit');
});
//更新栏目内容
ClassController.extend("Update",true,function(){
	var content;
	var infoid;
	var id=F.post('id');
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','id格式不正确');
		F.goto(Mo.U('Class/Index'));
		F.exit();
	}
	var info=F.string.matches(F.post('info'),/\d+/ig);//F.post('info')数据格式//0[这个是RID],1[这个是UID],2[这是栏目等级] rid：顶级栏目的id，uid：父级栏目的id
	//判断传入栏目id是否为有效数据
	var str='id='+id;
	var classname=F.encodeHtml(F.post("classname"));
	if (is_empty(classname)) {
		F.session('__error','栏目名不能为空');
		F.goto(Mo.U('Class/Edit','id='+id));
		F.exit();
	}
	var pic=F.safe(F.post("pic"));
	var leftpic=F.safe(F.post("leftpic"));//栏目缩略图
	var rightpic=F.safe(F.post("rightpic"));//栏目缩略图
	var ismenu=(F.post('ismenu')==1)?1:0;
	if (ismenu==1) {
		content='"ismenu":'+ismenu+',"content":"'+F.encodeHtml(F.post("content"))+'",';
	}else{
		content='"ismenu":'+ismenu+',';
	}
	if (!is_empty(info[0])){
		var rid=info[0][0];
		var uid=info[1][0];//上级栏目id
		var grap=info[2][0];
		if(grap>1){
			var stru='cid in ('+uid+','+rid+')';
			var rc=M("Class","id").where(stru).orderby("id asc").query().count();
			if(rc==0){
				F.session('__error','父级栏目不存在');
				F.goto(Mo.U('Class/Edit'));
				F.exit();
			}
		}
		infoid='"rid":' + rid +',"uid":' + uid +',"grap":' + grap +',';
	}else{
		infoid='';
	}
	var isdisplay=(F.post("isdisplay")==1)?1:0;
	var exptime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var updatestr='{"classname":"' + classname +'","pic":"' + pic +'","leftpic":"' + leftpic +'","rightpic":"' + rightpic +'",'+content+infoid+'"isdisplay":' + isdisplay +',"exptime":"' + exptime +'"}';
	var updatestrjson=JSON.parse(updatestr);
	M("Class","id").where(str).Update(updatestrjson);
	F.goto(Mo.U('Class/Index'));
});
//删除栏目
ClassController.extend("Del",true,function(){
	var cid=F.post('cid');
	var rid=F.post('rid');
	var str="rid=" + rid;
	var stra="cid=" + cid;
	var rcc=M("Class","id").where(str);
	var rca=M("Class","id").where(stra);
	if (rcc.count()>0 && rca.count()>0) {
		//判断是否顶级栏目和外链栏目相等，相等则是顶级栏目
		if (cid===rid) {
			var str="rid=" + F.post("rid");
			var stra="cid=" + F.post("cid");
			rcc.Delete();//先删除下属栏目
			rca.Delete();//再删除自身
			F.goto(Mo.U('Class/Index'));
		}else{
			rca.Delete();
			F.goto(Mo.U('Class/Index'));
		}
	}else{
		F.session('__error','栏目不存在或已被删除');
		F.goto(Mo.U('Class/Index'));
	}
});
</script>