<script language="jscript" runat="server">
	HomeController = IController.create(auth());
	HomeController.extend("Index", function(){
		var rc = M("Class","id").where('grap=1').orderby("id asc").query().fetch();
		rc.assign('data');
		var html='{"type":"200","link":"'+Mo.U()+'","cget":"'+Mo.U('Class/Class','cid={data.cid}')+'","aget":"'+Mo.U('Article/Index','cid={data.cid}')+'","count":"'+rc.count()+'","data":[';
		var json='';
		for (var i = 0; i < rc.count(); i++) {
			var str='uid='+rc.LIST__[i]['cid'];
			var stra='cid='+rc.LIST__[i]['cid'];
			var rcs = M("Class","id").where(str).orderby("id asc").query().count();
			var acount = M("Article","id").where(stra).orderby("id asc").query().count();
			var content=rc.LIST__[i]['content'];
			var rid=rc.LIST__[i]['rid'];
			var cid=rc.LIST__[i]['cid'];
			var id=rc.LIST__[i]['id'];
			var rca=rc.LIST__[i]['rca'];
			var pic='http://'+F.server('HTTP_HOST')+rc.LIST__[i]['pic'];
			var ismenu=rc.LIST__[i]['ismenu'];
			var isdisplay=rc.LIST__[i]['isdisplay'];
			var classname=rc.LIST__[i]['classname'];
			var grap=rc.LIST__[i]['grap'];
			json+='{"classname":"'+classname+'","cid":"' + cid +'","pic":"' + pic +'","content":"' + content +'","grap":"'+ grap +'","ismenu":"'+ ismenu +'","isdisplay":"'+ isdisplay +'","count":"'+rcs+'","acount":"'+acount+'"}';
		}
		var jsonp=F.replace(json, /"}{"/ig, "\"},{\"");
		html+=jsonp+']}'
		F.echo(html);
		// this.display("Index");
	});
HomeController.extend("Safecode", function(name){
	Safecode("sessionname", {length:4, padding:5, odd:3, font:'yahei'});
});
HomeController.extend("Home", function(){
	this.assign("title","MAE");
	this.assign("name",null);
	this.assign("Version",Mo.Version);
	this.assign("appname","MoAspEnginer");
	this.assign("birthday",new Date());
	this.assign("address","杭州");
	this.assign("list",["a","2","v","f","sds","cghf"]);
	this.assign("args","<span style=\"color:red\">我是变量参数！</span>");
	var data = new DataTable([
	{
		"name":"标题",
		"age":23
	},
	{"name":"标题2","age":34},
	{"name":"标题3","age":45}
	],2);
	this.assign("data",data); //只有DataTable对象才能用于loop，DataTable对象常由Model自动生成，这里手动构造
	this.assign("age",24);
	this.assign("jsobject",{
		a:"1",
		b:"2",
		c:"3",
		d:"4"
	});
	F.get("name",1);
	F.post("name",2);
	F.session("name","艾恩");
	F.cookie("name","艾恩");
	F.cookie("person.age",28);
	this.assign("Debug",JSON.stringify(F.date.parse("1986-9-2 21:23:45.234"),null,"  "));
	this.display("Home");
});
HomeController.extend("clearcache", function(){
	Mo.ClearCompiledCache();
	Mo.ModelCacheClear();
	if(F.server("HTTP_REFERER")!="")F.goto(F.server("HTTP_REFERER")); else F.goto("/");
});
</script>