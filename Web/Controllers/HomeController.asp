<script language="jscript" runat="server">
	HomeController = IController.create();
	HomeController.extend("Index", function(){
		var rc = M("Class","id").where('grap=1 AND isdisplay=1').orderby("did asc").select();
		var basics=M("Basics").where('id=1').select().getArray();
		var about=F.replace(F.decodeHtml(basics[0]['about']),/<.*?>/ig,'');
		var news=M('New').limit(1,6).orderby("id desc").select();
		var notice=M('Notice').limit(1,3).orderby("id desc").select();
		var parent=M('Parent').limit(1,3).orderby("id desc").select();
		parent.assign('parent');
		news.assign('news');
		notice.assign('notice');
		this.assign('about',about);
		rc.assign('data');
		this.display("Home:Index");
	});
</script>