<script language="jscript" runat="server">

ClassController = IController.create();
var Session = require("session");
ClassController.extend("Index",function(){
	var id=F.all.int("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		var ctrl = Mo.A("Error");
		ctrl.Index(); //调用Home控制器的Index方法
		F.exit();
	}
	var free=F.get.exists('free')?' AND isvip=0':'';
	var str='isdisplay=1 AND id='+id;
	var rca=M('Class').where(str).select();
	if(rca.count()>0){
		var rc=rca.getArray();
		var rcstr='grap=2 AND isdisplay=1 AND uid='+rc[0]['cid'];
		var articlestr='isdisplay=1 AND rid='+rc[0]['cid']+free;
		var article=M('Article').where(articlestr).limit(F.get.int("page", 1),12).orderby("exptime desc").select();
		var rcarray=M('Class').where(rcstr).orderby("did desc").select();
		var leftpic=rc[0]['leftpic'];
		var rightpic=rc[0]['rightpic'];
		var classname=rc[0]['classname'];
		rcarray.assign('data');
		article.assign('article');
		this.assign('id',id);
		this.assign('leftpic',leftpic);
		this.assign('rightpic',rightpic);
		this.assign('classname',classname);
		this.display("Class:Index");
	}else{
		var ctrl = Mo.A("Error");
		ctrl.Index(); //调用Home控制器的Index方法
	}
});
ClassController.extend("AllIndex",function(){
	var str='isdisplay=1 AND grap=1';
	var nume=M('Class').where(str).select();
	var article=M('Article').where('isdisplay=1').limit(F.get.int("page", 1),12).orderby("exptime desc").select();
	nume.assign('nume');
	article.assign('article');
	this.display("Class:AllIndex");
});
ClassController.extend("FreeIndex",function(){
	var str='isdisplay=1 AND grap=1';
	var nume=M('Class').where(str).select();
	var article=M('Article').where('isdisplay=1 AND isvip=0').limit(F.get.int("page", 1),12).orderby("exptime desc").select();
	nume.assign('nume');
	article.assign('article');
	this.display("Class:FreeIndex");
});
ClassController.extend("VipIndex",function(){
	var str='isdisplay=1 AND grap=1';
	var nume=M('Class').where(str).select();
	var article=M('Article').where('isdisplay=1 AND isvip=1').limit(F.get.int("page", 1),12).orderby("exptime desc").select();
	nume.assign('nume');
	article.assign('article');
	this.display("Class:FreeIndex");
});
ClassController.extend('Class',function(){
	var cid=F.all.int("id");
	if (F.string.exp(cid,/^\d+$/)!=cid) {
		var ctrl = Mo.A("Error");
		ctrl.Index(); //调用Home控制器的Index方法
		F.exit();
	}
	var free=F.get.exists('free')?' AND isvip=0':'';
	var str='isdisplay=1 AND cid='+cid;
	var rca=M('Class').where(str).select();
	if(rca.count()>0){
		var article=M('Article').where(str+free).limit(F.get.int("page", 1),12).orderby("exptime desc").select();
		var rc=rca.getArray();
		var rcstr='grap=2 AND isdisplay=1 AND uid='+rc[0]['uid'];
		var rcstrc='cid='+rc[0]['uid'];
		var rcarray=M('Class').where(rcstr).orderby("did desc").select();
		var rcarrayc=M('Class').where(rcstrc).select().getArray();
		var leftpic=rcarrayc[0]['leftpic'];
		var rightpic=rcarrayc[0]['rightpic'];
		var id=rcarrayc[0]['id'];
		var classname=rcarrayc[0]['classname'];
		var nclassname=rc[0]['classname'];
		rcarray.assign('data');
		article.assign('article');
		this.assign('id',id);
		this.assign('cid',cid);
		this.assign('leftpic',leftpic);
		this.assign('rightpic',rightpic);
		this.assign('classname',classname);
		this.assign('nclassname',nclassname);
		this.display("Class:Class");
	}else{
		var ctrl = Mo.A("Error");
		ctrl.Index(); //调用Home控制器的Index方法
	}
});
</script>