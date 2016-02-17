<script language="jscript" runat="server">
/*
** 创建一个新的Controller对象；
** 语法：
** __construct：构造函数；
** __destruct：析构函数；
*/
WxVipController = IController.create();
//验证码
WxVipController.extend("Index",function(){
	if (F.server("REMOTE_HOST")!='127.0.0.1') {
		F.echo('fail');
	}else{
		var orders=!is_empty(F.get('out_trade_no'))?F.get('out_trade_no'):false;
		var money=!is_empty(F.get('cash_fee'))?F.get('cash_fee'):false;
		if(orders && money){
			var str="orders='"+orders+"' AND money="+money;
			var rc=M("VipLog").find(str);
			if(rc){
				if (rc.isbuy==1) {
					var uid=rc.uid;
					var username=rc.username;
					var goods=rc.goods;
					var userstr="id="+uid+" AND username='"+username+"'";
					var userrc=M("User").find(userstr);
					var viptime,vipovertime;
					if (userrc) {
						if (userrc.isvip==1) {
							viptime=F.untimespan(userrc.vipexpire);
							vipovertime=F.timespan(F.formatdate(F.date.dateadd("M",goods,viptime),"yyyy-MM-dd HH:mm:ss"));
						}else{
							vipovertime=F.timespan(F.formatdate(F.date.dateadd("M",goods,times),"yyyy-MM-dd HH:mm:ss"));
						}
					}
					M("User").where(userstr).Update({"vipexpire":vipovertime,"isvip":1});
					M("VipLog").where(str).Update({"isbuy":2,"rebuys":"微信支付"});
					F.echo('success');
				}else{
					F.echo('success');
				}
			}else{
				F.echo('fail');
			}
		}else{
			F.echo('fail');
		}
	}
});
</script>