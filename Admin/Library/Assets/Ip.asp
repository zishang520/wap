<script language="jscript" runat="server">
Ip = IClass.create();
Ip.extend("Index", function(){
	var mun=F.session('num');
	if(is_empty(mun)){
		var qqwry = require("qqwry");//引入qqwry扩展
		var ip=F.server("REMOTE_ADDR");//获取客户端ip
		var str='ip='+ip2int(ip);//转换为整型查询字符串
		var times=F.formatdate(new Date(),"yyyy-MM-dd HH:mm:ss");
		var time=F.timespan(times);//获取时间
		var rc=M('IpLog','id').find(str);//查询ip
			if (rc) {//判断是否在数据库存在,存在则更新，不存在则插入
				var lasttime=F.formatdate(F.untimespan(rc.lasttime),"dd");
				var intime=F.formatdate(times,"dd");
				if (intime>lasttime) {
					M('IpLog').where(str).limit(1,1).increase("num").Update({"lasttime":time});//存在则在num字段加1，且更新时间
				}
			}else{
				var ipinfo=qqwry(ip);//获取ip信息
				var location=ipinfo['location'];//获取ip地址
				var address=is_empty(ipinfo['address'])?'暂无数据':ipinfo['address'];//获取ip供应商
				if(ipinfo['code']==200){//判断ip是否有效
					var insetstr={
						"ip":ip2int(ip),
						"city":location,
						"address":address,
						"num":1,
						"noopen":0,
						"firsttime":time,
						"lasttime":time
					};
				M('IpLog').Insert(insetstr);//插入ip到数据库
			}
		}
		F.session('num',1);
	}
});
</script>