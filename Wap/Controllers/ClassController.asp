<script language="jscript" runat="server">

	ClassController = IController.create(auth());
	var Session = require("session");
	ClassController.extend("Index",function(){
		var rc = M("Class","id").where('grap=1').orderby("id asc").select();
		var html='{"type":"200","link":"'+Mo.U()+'&sessionid='+Session.id+'","cget":"'+Mo.U('Class/Class','cid={data.cid}')+'&sessionid='+Session.id+'","aget":"'+Mo.U('Article/Index','cid={data.cid}')+'&sessionid='+Session.id+'","count":"'+rc.count()+'","data":[';
		var json='';
		var rsarray=rc.getArray();
		for (var i = 0; i < rc.count(); i++) {
			var str='uid='+rsarray[i]['cid'];
			var stra='cid='+rsarray[i]['cid'];
			var rcs = M("Class","id").where(str).orderby("id asc").select().count();
			var acount = M("Article","id").where(stra).orderby("id asc").select().count();
			var content=F.replace(F.decodeHtml(rsarray[i]['content']),/<.*?>/ig,'');
			var rid=rsarray[i]['rid'];
			var cid=rsarray[i]['cid'];
			var id=rsarray[i]['id'];
			var rca=rsarray[i]['rca'];
			var pic='http://'+F.server('HTTP_HOST')+rsarray[i]['pic'];
			var ismenu=rsarray[i]['ismenu'];
			var isdisplay=rsarray[i]['isdisplay'];
			var classname=rsarray[i]['classname'];
			var grap=rsarray[i]['grap'];
			json+='{"classname":"'+classname+'","cid":"' + cid +'","pic":"' + pic +'","content":"' + content +'","grap":"'+ grap +'","ismenu":"'+ ismenu +'","isdisplay":"'+ isdisplay +'","count":"'+rcs+'","acount":"'+acount+'"}';
		}
		var jsonp=F.replace(json, /"}{"/ig, "\"},{\"");
		html+=jsonp+']}'
		F.echo(html);
	});
ClassController.extend('Class',function(){
	var str='uid='+F.all('cid');
	var rc = M("Class","id").where(str).orderby("id asc").select();
	var html='{"type":"200","link":"'+Mo.U()+'&sessionid='+Session.id+'","cget":"'+Mo.U('Class/Class','cid={data.cid}')+'&sessionid='+Session.id+'","aget":"'+Mo.U('Article/Index','cid={data.cid}')+'&sessionid='+Session.id+'","count":"'+rc.count()+'","data":[';
	var json='';
	var rsarray=rc.getArray();
	for (var i = 0; i < rc.count(); i++) {
		var str='uid='+rsarray[i]['cid'];
		var stra='cid='+rsarray[i]['cid'];
		var rcs = M("Class","id").where(str).orderby("id asc").select().count();
		var acount = M("Article","id").where(stra).orderby("id asc").select().count();
		var content=F.replace(F.decodeHtml(rsarray[i]['content']),/<.*?>/ig,'');
		var rid=rsarray[i]['rid'];
		var cid=rsarray[i]['cid'];
		var id=rsarray[i]['id'];
		var rca=rsarray[i]['rca'];
		var pic='http://'+F.server('HTTP_HOST')+rsarray[i]['pic'];
		var ismenu=rsarray[i]['ismenu'];
		var isdisplay=rsarray[i]['isdisplay'];
		var classname=rsarray[i]['classname'];
		var grap=rsarray[i]['grap'];
		json+='{"classname":"'+classname+'","cid":"' + cid +'","pic":"' + pic +'","content":"' + content +'","grap":"'+ grap +'","ismenu":"'+ ismenu +'","isdisplay":"'+ isdisplay +'","count":"'+rcs+'","acount":"'+acount+'"}';
	}
	var jsonp=F.replace(json, /"}{"/ig, "\"},{\"");
	html+=jsonp+']}'
	F.echo(html);
});

</script>