<script language="jscript" runat="server">
/*
** 这是一个用户管理控制器
** 语法：newController = IController.create([__construct[,__destruct]]);
** __construct：构造函数；
** __destruct：析构函数；
** ip2int：ip转为整型
** int2ip：同理
*/
UserController = IController.create(function(){
	if(!auth()){
		var ctrl = Mo.A("Login");
		ctrl.Index(); //调用Login控制器的Index方法
		F.exit();
	}else{
		var user=new USERINFO();//获取用户名，缓存在session
		id=user.id();//加載為控制器全域變量
		username=user.username();//加載為控制器全域變量
		email=user.email();//加載為控制器全域變量
	}
});//控制器命名//auth()为验证状态
UserController.extend("Index", function(){
	var str='id='+id;
	var rc = M("User").where(str).select();
	rc.assign("data");
	this.display("User:Index");
});
UserController.extend("Edit", function(){
	var str='id='+id;
	var rc = M("User").where(str).select();
	rc.assign("data");
	this.display("User:Edit");
});
UserController.extend("Edit",true,function(){
	if (F.post("safe").toLocaleLowerCase()!==F.session("safe").toLocaleLowerCase() || is_empty(F.post("safe")) || is_empty(F.session("safe"))) {
		F.session('__error','验证码不正确');
		F.goto(Mo.U('User/Edit'));
		F.exit();
	}
	F.session.destroy("safe");//销毁验证码
	var fullname=F.encodeHtml(F.post('fullname'));
	if (F.string.exp(fullname,/^[\u4e00-\u9fa5]{1,12}$/)!=fullname || is_empty(fullname)) {
		F.session('__error','姓名格式不正确');
		F.goto(Mo.U('User/Edit'));
		F.exit();
	}
	var sex=(F.post.int('sex')==1)?1:2;
	var qq=!is_empty(F.post.int('qq'))?F.post.int('qq'):'';
	if (F.string.exp(qq,/^[1-9][0-9]{4,10}$/)!=qq && !is_empty(qq)) {
		F.session('__error','QQ格式不正确');
		F.goto(Mo.U('User/Edit'));
		F.exit();
	}
	var adress=!is_empty(F.post('adress'))?F.encodeHtml(F.post('adress')):'';
	var str='id='+id;
	var updatestr={
		"fullname":fullname,
		"sex":sex,
		"qq":qq,
		"adress":adress
	}
	M('User').where(str).Update(updatestr);
	F.goto(Mo.U('User/Index'));
});
UserController.extend("Buy", function(){
	var str='uid='+id;
	var rc = M("VipLog").where(str).limit(F.get.int("page", 1),6).orderby("id desc").select();
	rc.assign("data");
	this.display("User:Buy");
});
UserController.extend("Vip", function(){
	var str='id='+id;
	var rc = M("User").where(str).select();
	rc.assign("data");
	this.display("User:Vip");
});
UserController.extend("Vip",true,function(){
	var buy=F.post.int('buy');
	if (F.string.exp(buy,/^[1|2|3|4]$/)!=buy || is_empty(buy)) {
		F.session('__error','请求参数不正确');
		F.goto(Mo.U('User/Vip'));
		F.exit();
	}
	var money,car,gooods;
	switch(buy) {
		case 1:
		goods=1;
		money=28;
		car='会员一个月';
		break;
		case 2:
		goods=3;
		money=68;
		car='会员三个月';
		break;
		case 3:
		goods=6;
		money=108;
		car='会员六个月';
		break;
		case 4:
		goods=12;
		money=168;
		car='会员十二个月';
		break;
	}
	var time=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
	var orders=randomString(3)+F.formatdate(time,"yyyyMMddHHmmss");
	var spantime=F.timespan(F.formatdate(time,"yyyy-MM-dd HH:mm:ss"));
	var jsonstr='{"time":"'+time+'","orders":"'+orders+'","car":"'+car+'","money":"'+money+'","username":"'+username+'","email":"'+email+'"}';
	F.session("buysession",jsonstr);
	var lasttime = spantime;
	var rc=M("User").where("id="+id).select().getArray();
	var state=(rc[0]['isvip']==1)?1:0;
	var insetstr={
		"orders":orders,
		"uid":id,
		"username":username,
		"email":email,
		"log":car,
		"goods":goods,
		"money":money,
		"isbuy":1,
		"state":state,
		"buytime":spantime
	}
	M("VipLog").Insert(insetstr);
	this.assign('time',time);
	this.assign('orders',orders);
	this.assign('car',car);
	this.assign('money',money);
	this.assign('username',username);
	this.display("User:VipBuy");
});
UserController.extend("BuyVip",true,function(){
	var httprequest = require("net/http/request");
	if(!httprequest){
		F.echo("模块net不存在，需要安装。",true);
		return;
	}
	var buy=F.post.int('aplay');
	if (F.string.exp(buy,/^[1|2|3]$/)!=buy || is_empty(buy)) {
		F.session('__error','请求参数不正确');
		F.goto(Mo.U('User/Vip'));
		F.exit();
	}else{
		var buyinfo=JSON.parse(F.session("buysession"));
		if (!is_empty(buyinfo)) {
			var ip=F.server("REMOTE_ADDR");//获取客户端ip
			var csrf=F.session('__csrf');
			if (buy==1) {
				var text = httprequest.create(
					"http://127.0.0.1:"+F.server("SERVER_PORT")+"/Pay/alipay/alipayapi.asp",//本地回环
					{
						method : "POST",
						headers : [
						"X-CSRF-Token:"+csrf
						],
						data : "__csrf="+csrf+"&WIDout_trade_no="+buyinfo['orders']+"&WIDsubject="+buyinfo['car']+"&WIDtotal_fee="+buyinfo['money']+"&WIDbody="+buyinfo['username']+buyinfo['car']+"&WIDshow_url="+Mo.U('User/Vip')+"&Ip="+ip,
						charset : "utf-8"
					}
					).send().gettext("utf-8");
				F.goto(text);//跳转到支付页面
			}else if(buy==2){
				var text = httprequest.create(
					"http://127.0.0.1:"+F.server("SERVER_PORT")+"/Pay/tenpay/tenpay.asp",//本地回环
					{
						method : "POST",
						headers : [
						"X-CSRF-Token:"+csrf
						],
						data : "__csrf="+csrf+"&order_price="+buyinfo['money']+"&product_name="+buyinfo['car']+"&remarkexplain="+buyinfo['username']+buyinfo['car']+"&order_no="+buyinfo['orders']+"&trade_mode=1&ip="+ip,
						charset : "utf-8"
					}
					).send().gettext("utf-8");
				F.goto(text);//跳转到支付页面
			}else if(buy==3){
				var text = httprequest.create(
					"http://127.0.0.1/wxapi/example/native.php",//本地回环
					{
						method : "POST",
						headers : [
						"REMOTE_ADDR:"+ip,
						"X-CSRF-Token:"+csrf
						],
						data : "__csrf="+csrf+"&WIDout_trade_no="+buyinfo['orders']+"&WIDsubject="+buyinfo['car']+"&WIDtotal_fee="+buyinfo['money']+"&WIDbody="+buyinfo['username']+buyinfo['car'],
						charset : "utf-8"
					}
					).send().gettext("utf-8");
				var jsonstr='{"url":"'+F.encode(text)+'"}';
				F.echo(jsonstr);//前端js
			}
		}
	}
});
UserController.extend("Server", function(){
	var data = M("Basics","id").where('id=1').select();
	this.assign('data',data);
	this.display("User:Service");
});
UserController.extend("About", function(){
	var data = M("Basics","id").where('id=1').select();
	this.assign('data',data);
	this.display("User:About");
});
</script>