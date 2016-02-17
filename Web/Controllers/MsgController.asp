<script language="jscript" runat="server">
/*
** 这是一个用户管理控制器
** 语法：newController = IController.create([__construct[,__destruct]]);
** __construct：构造函数；
** __destruct：析构函数；
** ip2int：ip转为整型
** int2ip：同理
*/
MsgController = IController.create(function(){
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
MsgController.extend("Index", function(){
	this.display("Msg:Index");
});
MsgController.extend("Index",true,function(){
	if (F.post("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || is_empty(F.post("safe")) || is_empty(F.session("safe"))) {
		F.session('__error','验证码不正确');
		F.goto(Mo.U('Msg/Index'));
		F.exit();
	}
	F.session.destroy("safe");//销毁验证码
	var name=F.post.safe('name');
	if (F.string.exp(name,/^[\u4e00-\u9fa5]{1,12}$/)!=name || is_empty(name)) {
		F.session('__error','姓名格式不正确');
		F.goto(Mo.U('Msg/Index'));
		F.exit();
	}
	var email=F.post.email('email');
	if(F.string.email(email)!=email){//判断是否是邮箱
		F.session('__error','邮箱格式不正确');
		F.goto(Mo.U('Msg/Index'));
		F.exit();
	}
	var content1=F.post('content');
	var content=F.encodeHtml(content1);
	if (content1.length>500) {
		F.session('__error','内容不能超过500个字');
		F.goto(Mo.U('Msg/Index'));
		F.exit();
	}
	var msgtime = F.timespan(F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss"));
	var msgip=ip2int(F.server("REMOTE_ADDR"));
	var Insertstr={
		"msgname":name,
		"msgemail":email,
		"msgbody":content,
		"msgtime":msgtime,
		"msgip":msgip
	}
	M('Msg').Insert(Insertstr);
	this.assign('error','留言成功');
	this.display("Msg:Index");
});
MsgController.extend("List", function(){
	var str='isdisplay=1';
	var rc=M('Msg').where(str).limit(F.get.int("page", 1),10).orderby("id desc").select();
	rc.assign('data');
	this.display("Msg:List");
});
MsgController.extend("Show", function(){
	var id=F.all.int("id");
	if (F.string.exp(id,/^\d+$/)!=id) {
		F.session('__error','Id不正确');
		F.goto(Mo.U('Parent/New'));
		F.exit();
	}
	var str='id='+id;
	var data = M("Msg","id").find(str);
	if (data) {
		this.assign('data',data);
	}
	this.display("Msg:Show");
});
</script>