<script language="jscript" runat="server">
/*
** 这是一个用户管理控制器
** 语法：newController = IController.create([__construct[,__destruct]]);
** __construct：构造函数；
** __destruct：析构函数；
** ip2int：ip转为整型
** int2ip：同理
*/
ParentController = IController.create(function(){
	// if(!auth()){
	// 	var ctrl = Mo.A("Login");
	// 	ctrl.Index(); //调用Login控制器的Index方法
	// 	F.exit();
	// }else{
	// 	var user=new USERINFO();//获取用户名，缓存在session
	// 	id=user.id();//加載為控制器全域變量
	// 	username=user.username();//加載為控制器全域變量
	// 	email=user.email();//加載為控制器全域變量
	// }
});//控制器命名//auth()为验证状态
ParentController.extend("Index", function(){
	if(!auth()){
		var ctrl = Mo.A("Login");
		ctrl.Index(); //调用Login控制器的Index方法
		F.exit();
	}
	this.display("Parent:Index");
});
ParentController.extend("Index", true,function(){
	if(!auth()){
		var ctrl = Mo.A("Login");
		ctrl.Index(); //调用Login控制器的Index方法
		F.exit();
	}else{
		var user=new USERINFO();//获取用户名，缓存在session
		var id=user.id();//加載為控制器全域變量
	}
	var title=F.encodeHtml(F.post('title'));
	var body=F.encodeHtml(F.post('body'));
	var releasetime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var ip=ip2int(F.server("REMOTE_ADDR"));
	var Insertstr={
		"title":title,
		"body":body,
		"uid":id,
		"releasetime":releasetime,
		"exptime":releasetime,
		"ip":ip,
		"isdisplay":1
	}
	M("Parent").Insert(Insertstr);
	F.goto(Mo.U('Parent/List'));
});
ParentController.extend("List", function(){
	var data=M("Parent").where("isdisplay=1").limit(F.get.int("page", 1),10).orderby("id desc").select();
	data.each(function(item){
		item.subitems=M("User","id").find('id='+item.uid);
	});
	data.assign("data");
	this.display("Parent:List");
});
ParentController.extend("IndexShow", function(){
	var id=F.all.int("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','Id不正确');
		F.goto(Mo.U('Parent/Index'));
		F.exit();
	}
	var str='id='+id;
	var data = M("Parent","id").find(str);
	if (data) {
		data.subitems=M("User","id").find('id='+data.uid);
		this.assign('data',data);
	}
	this.display("Parent:IndexShow");
});
ParentController.extend("Notice", function(){
	var str='isdisplay=1';
	var data = M("Notice","id").where(str).limit(F.get.int("page", 1),10).orderby("id desc").select();
	this.assign('data',data);
	this.display("Parent:Notice");
});
ParentController.extend("NoticeShow", function(){
	var id=F.all.int("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','Id不正确');
		F.goto(Mo.U('Parent/Notice'));
		F.exit();
	}
	var str='id='+id;
	var data = M("Notice","id").find(str);
	if (data) {
		this.assign('data',data);
	}
	this.display("Parent:NoticeShow");
});
ParentController.extend("New", function(){
	var str='isdisplay=1';
	var data = M("New","id").where(str).limit(F.get.int("page", 1),10).orderby("id desc").select();
	this.assign('data',data);
	this.display("Parent:New");
});
ParentController.extend("NewShow", function(){
	var id=F.all.int("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','Id不正确');
		F.goto(Mo.U('Parent/New'));
		F.exit();
	}
	var str='id='+id;
	var data = M("New","id").find(str);
	if (data) {
		this.assign('data',data);
	}
	this.display("Parent:NewShow");
});
</script>