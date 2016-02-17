<script language="jscript" runat="server">
/*
** 创建一个新的Controller对象；
** 语法：
** __construct：构造函数；
** __destruct：析构函数；
*/
ArticleController = IController.create(auth());
var Session = require("session");//引入session扩展
ArticleController.extend("Index",function(){
	var str="cid=" + F.all("cid");
	var rc = M("Article","id").where(str).orderby("id asc").select();
	var html='{"type":"200","link":"'+Mo.U()+'&sessionid='+Session.id+'","count":"'+rc.count()+'","data":[';
	var json='';
	var rsarray=rc.getArray();
	for (var i = 0; i < rc.count(); i++) {
		var id=rsarray[i]['id'];
		var title=rsarray[i]['title'];
		var content=F.replace(F.decodeHtml(rsarray[i]['content']),/<.*?>/ig,'');
		var file='http://'+F.server('HTTP_HOST')+rsarray[i]['file'];
		var pic='http://'+F.server('HTTP_HOST')+rsarray[i]['pic'];
		var cid=rsarray[i]['cid'];
		var rid=rsarray[i]['rid'];
		var isvip=rsarray[i]['isvip'];
		var releasetime=rsarray[i]['releasetime'];
		var exptime=rsarray[i]['exptime'];
		var isdisplay=rsarray[i]['isdisplay'];
		var m=Mo.U('Article/Show','id='+id)+'&sessionid='+Session.id;
		var l=Mo.U('Article/Content','id='+id)+'&sessionid='+Session.id;
		json+='{"id":"'+id+'","title":"' + title +'","pic":"' + pic +'","content":"' + content +'","curl":"' + l +'","file":"'+ file +'","furl":"'+ m +'","cid":"'+cid+'","rid":"'+rid+'","isvip":"'+isvip+'","releasetime":"'+ releasetime +'","exptime":"'+exptime+'","isdisplay":"'+ isdisplay +'"}';
	}
	var jsonp=F.replace(json, /"}{"/ig, "\"},{\"");
	html+=jsonp+']}'
	F.echo(html);
});
//内容简介
ArticleController.extend("Content",function(){
	var str="id=" + F.all("id");
	var rc = M("Article","id").where(str).orderby("id asc").select();
	var rsarray=rc.getArray();
	for (var i = 0; i < rc.count(); i++) {
		F.echo(F.decodeHtml(rsarray[i]['content']));
	}
});
//内容附件
ArticleController.extend("Show",function(){
	var str="id=" + F.all("id");
	var rc = M("Article","id").where(str).orderby("id asc").limit(1,1).select();
	var rsarray=rc.getArray();
	for (var i = 0; i < rc.count(); i++) {
		var title=rsarray[i]['title'];
		var file='http://'+F.server('HTTP_HOST')+rsarray[i]['file'];
		var pic='http://'+F.server('HTTP_HOST')+rsarray[i]['pic'];
		this.assign('title',title);
		this.assign('url','http://'+F.server('HTTP_HOST'));
		this.assign('file',file);
		this.assign('pic',pic);
	}
	this.display('Article:Show');
});
</script>