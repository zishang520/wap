<script language="jscript" runat="server">
if(typeof Mo=="undefined"){Response.Write("invalid call.");Response.End();}
function _echo(src){if(src===undefined || src===null) src="";_contents += src;if(!__buffer && _contents.length>__buffersize) {Response.Write(_contents);_contents="";}}
function _end(){if(!__buffer)Response.Write(_contents);}
var _contents = "";
"UNSAFECONTENTS";
with($){
_contents += "<!DOCTYPE html>\r\n<html lang=\"zh-CN\">\r\n\t<!--\r\n\t@@@@@@@@@@@X5111111111111111sssss111sri;;::,:;is11\r\n\t@@@@@@@@@@X51111111111111sssrrrrrrssri;;;rsr;:;;is\r\n\t@@@@@@@@@@555h11ssrrrrrriiiiiii;iiii;;;;s555hs;;;;\r\n\t@@@@@@@@@@hri;;;;;;;;;;;;::;;::::::::;:ihh55S5sii;\r\n\t@@@@@@    ,::;;;iiirrsssri:,,,,,.,,,,::s1hh5551irr\r\n\t@@    .,:;;irs1hh5555hh11si,,,,.. ..,,;rs1hh551irr\r\n\t@  .,:;is15S399933SSS55hh1si:,,,,...,,;irs11h1rirr\r\n\t@  :is539GG88899933SSS55hh1r::::::,,,,irss1hh1;ii;\r\n\t@ .:r98GGGGG888999S5SSS55hhi;;;;i;::,:irss1hhs;ri;\r\n\t@  :r58GGGGG88935s1S3SSS55s;iiiiri;;:;ss111hhiir;i\r\n\t@@ .:i1399Sh5hsi;s33333SSs;rr;rssrii;i11hhhhr;ri;i\r\n\t@@@  ,;r1hhh5hsr5999933S1irr;is1srii;ihh5551irriis\r\n\t@@@@@  .;15Shs198888995rrsr;;s111r;i;i55555hrrr;i1\r\n\t@@@@@@  ,rsrsS8GGG889hrssi:ir111si;iii5SSSS5srr;r1\r\n\t@@@@  .:rir59GGGGG85ss1s;,;iii;;;;iriiS3333Ssrr;i1\r\n\t@@   ,iirh9GGGGG8S1shhs, .,,:::;ir11rrS399331rri;s\r\n\t@  .;iis38GGGGG8hshSShsiiiiir1hhhhhh11399999Shsr:r\r\n\t  ,iir58GGGGG9511SS51sssrr533S555S39999888883hsr,:\r\n\t .ii19GGGGG8Srir111hh53399G83398G8S5hh159GGG3hrs,,\r\n\t :i18GGGGGGShhSS3988GGGGGGGGGGG9Shshhh1s15S385ri. \r\n\t ,rS8GGGGGGGGGGGGGGGGGG8933935hsrssi;;;iiiir11i,  \r\n\t .ih8GGGGGGGGGGGGGGG835h1ss1sri;:.   @@    .,.    \r\n\t@ :rh98GGGGGGG893SS5hs1h1ri:.    @@@@@@@@@@@@@ @@@\r\n\t@@ :i1555555hhhsssriii,.   @@@@@@@@@@@@@@@@@@@@@@@\r\n\t@@  .;irrrrriiii;,    @@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\n-->\r\n<head>\r\n\t<meta charset=\"utf-8\">\r\n\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\" />\r\n\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\r\n\t<meta name=\"_token\" content=\"";
_echo(__csrf);
_contents += "\" />\r\n\t<title>";
_echo(web_title);
_contents += "-会员管理-";
_echo(web_name);
_contents += "</title>\r\n\t<link rel=\"shortcut icon\" href=\"/favicon.ico\" />\r\n\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap.min.css\" />\r\n\t<!-- <link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap-theme.min.css\" /> -->\r\n\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap-datetimepicker.min.css\" />\r\n\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap-toggle.min.css\" />\r\n\t<link rel=\"stylesheet\" type=\"text/css\" href=\"css/select2.min.css\" />\r\n\t<script type=\"text/javascript\" src=\"js/jquery-2.1.0.js\"></script>\r\n\t<script type=\"text/javascript\" src=\"js/bootstrap.min.js\"></script>\r\n\t<script type=\"text/javascript\" src=\"js/bootstrap-datetimepicker.js\"></script>\r\n\t<script type=\"text/javascript\" src=\"js/locales/bootstrap-datetimepicker.zh-CN.js\"></script>\r\n\t<script type=\"text/javascript\" src=\"js/bootstrap-toggle.js\"></script>\r\n\t<script type=\"text/javascript\" src=\"js/select2.min.js\"></script>\r\n\t<script type=\"text/javascript\">\r\n\t\t$(function() {\r\n\t\t\t$.ajaxSetup({\r\n\t\t\t\theaders: {\r\n\t\t\t\t\t'X-CSRF-Token': $('meta[name=\"_token\"]').attr('content')\r\n\t\t\t\t}\r\n\t\t\t});\r\n\t\t});\r\n\t</script>\r\n\t\r\n</head>\r\n<body>\r\n\t<nav class=\"navbar navbar-default\">\r\n\t\t<div class=\"container-fluid\">\r\n\t\t\t<!-- Brand and toggle get grouped for better mobile display -->\r\n\t\t\t<div class=\"navbar-header\">\r\n\t\t\t\t<button type=\"button\" class=\"navbar-toggle collapsed\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\" aria-expanded=\"false\">\r\n\t\t\t\t\t<span class=\"sr-only\">切换导航</span>\r\n\t\t\t\t\t<span class=\"icon-bar\"></span>\r\n\t\t\t\t\t<span class=\"icon-bar\"></span>\r\n\t\t\t\t\t<span class=\"icon-bar\"></span>\r\n\t\t\t\t</button>\r\n\t\t\t\t<a class=\"navbar-brand\" href=\"";
_echo(Mo.U('Home/Index'));
_contents += "\">管理系统</a>\r\n\t\t\t</div>\r\n\t\t\t<div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\">\r\n\t\t\t\t<ul class=\"nav navbar-nav\">\r\n\t\t\t\t\t<li";
if(method == 'Home'){
_contents += " class=\"active\"";
}
_contents += "><a href=\"";
_echo(Mo.U('Home/Index'));
_contents += "\">仪表盘<span class=\"sr-only\">(current)</span></a></li>\r\n\t\t\t\t\t<li";
if(method == 'User'){
_contents += " class=\"active\"";
}
_contents += "><a href=\"";
_echo(Mo.U('User/Index'));
_contents += "\">用户管理</a></li>\r\n\t\t\t\t\t<li";
if(method == 'Class'){
_contents += " class=\"active\"";
}
_contents += "><a href=\"";
_echo(Mo.U('Class/Index'));
_contents += "\">栏目管理</a></li>\r\n\t\t\t\t\t<li";
if(method == 'Article'){
_contents += " class=\"active\"";
}
_contents += "><a href=\"";
_echo(Mo.U('Article/Index'));
_contents += "\">内容管理</a></li>\r\n\t\t\t\t\t<li";
if(method == 'New'){
_contents += " class=\"active\"";
}
_contents += "><a href=\"";
_echo(Mo.U('New/Index'));
_contents += "\">新闻中心</a></li>\r\n\t\t\t\t\t<li";
if(method == 'Notice'){
_contents += " class=\"active\"";
}
_contents += "><a href=\"";
_echo(Mo.U('Notice/Index'));
_contents += "\">用户公告</a></li>\r\n\t\t\t\t\t<li class=\"dropdown";
if(method == 'Basics'){
_contents += " active";
}
_contents += "\">\r\n\t\t\t\t\t\t<a class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">基础信息 <span class=\"caret\"></span></a>\r\n\t\t\t\t\t\t<ul class=\"dropdown-menu\">\r\n\t\t\t\t\t\t\t<li role=\"separator\" class=\"divider\"></li>\r\n\t\t\t\t\t\t\t<li><a href=\"";
_echo(Mo.U('Basics/Service'));
_contents += "\">服务条款</a></li>\r\n\t\t\t\t\t\t\t<li><a href=\"";
_echo(Mo.U('Basics/About'));
_contents += "\">关于我们</a></li>\r\n\t\t\t\t\t\t\t<li><a href=\"";
_echo(Mo.U('Basics/Registration'));
_contents += "\">注册协议</a></li>\r\n\t\t\t\t\t\t\t<li role=\"separator\" class=\"divider\"></li>\r\n\t\t\t\t\t\t</ul>\r\n\t\t\t\t\t</li>\r\n\t\t\t\t\t<li class=\"dropdown";
if(method == 'SysWeb'){
_contents += " active";
}
_contents += "\">\r\n\t\t\t\t\t\t<a class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">系统设置 <span class=\"caret\"></span></a>\r\n\t\t\t\t\t\t<ul class=\"dropdown-menu\">\r\n\t\t\t\t\t\t\t<li role=\"separator\" class=\"divider\"></li>\r\n\t\t\t\t\t\t\t<li><a href=\"";
_echo(Mo.U('SysWeb/Webinfo'));
_contents += "\">网站信息</a></li>\r\n\t\t\t\t\t\t\t<li role=\"separator\" class=\"divider\"></li>\r\n\t\t\t\t\t\t\t<li><a href=\"";
_echo(Mo.U('SysWeb/Email'));
_contents += "\">邮箱设置</a></li>\r\n\t\t\t\t\t\t\t<li role=\"separator\" class=\"divider\"></li>\r\n\t\t\t\t\t\t\t<li><a href=\"";
_echo(Mo.U('SysWeb/EmailTemplate','id=1'));
_contents += "\">邮件模板</a></li>\r\n\t\t\t\t\t\t\t<li><a href=\"";
_echo(Mo.U('SysWeb/SmsTemplate'));
_contents += "\">短信模板</a></li>\r\n\t\t\t\t\t\t\t<li role=\"separator\" class=\"divider\"></li>\r\n\t\t\t\t\t\t</ul>\r\n\t\t\t\t\t</li>\r\n\t\t\t\t</ul>\r\n\t\t\t\t<ul class=\"nav navbar-nav navbar-right\">\r\n\t\t\t\t\t<li role=\"presentation\"><a href=\"";
_echo(Mo.U('Msg/Index'));
_contents += "\">网站留言 <span class=\"badge\">";
_echo(Msglook);
_contents += "</span></a></li>\r\n\t\t\t\t\t<li class=\"dropdown\">\r\n\t\t\t\t\t\t<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">";
_echo(adminname);
_contents += "<span class=\"caret\"></span></a>\r\n\t\t\t\t\t\t<ul class=\"dropdown-menu\">\r\n\t\t\t\t\t\t\t<li><a href=\"";
_echo(Mo.U('Login/Logout'));
_contents += "\">注销</a></li>\r\n\t\t\t\t\t\t</ul>\r\n\t\t\t\t\t</li>\r\n\t\t\t\t</ul>\r\n\t\t\t</div><!-- /.navbar-collapse -->\r\n\t\t</div><!-- /.container-fluid -->\r\n\t</nav>\r\n\t\r\n\t<div class=\"container-fluid\">\r\n\t\t<div class=\"row\">\r\n\t\t\t<div class=\"col-md-2\">\r\n\t\t\t\t<div class=\"panel-group\" role=\"tablist\">\r\n\t\t\t\t\t<div class=\"panel panel-default\">\r\n\t\t\t\t\t\t<a class=\"panel-heading btn btn-default btn-block\" role=\"button\" data-toggle=\"collapse\" href=\"#collapseListGroup1\" aria-expanded=\"true\" aria-controls=\"collapseListGroup1\">\r\n\t\t\t\t\t\t\t用户管理\r\n\t\t\t\t\t\t</a>\r\n\t\t\t\t\t\t<div id=\"collapseListGroup1\" class=\"panel-collapse collapse in\" role=\"tabpanel\" aria-labelledby=\"collapseListGroupHeading1\" aria-expanded=\"true\">\r\n\t\t\t\t\t\t\t<ul class=\"nav nav-pills nav-stacked\">\r\n\t\t\t\t\t\t\t\t<li role=\"presentation\" class=\"active\">\r\n\t\t\t\t\t\t\t\t\t<a href=\"";
_echo(Mo.U('User/Index'));
_contents += "\" class=\"btn btn-link btn-block\">全部用户</a>\r\n\t\t\t\t\t\t\t\t</li>\r\n\t\t\t\t\t\t\t\t<li role=\"presentation\">\r\n\t\t\t\t\t\t\t\t\t<a href=\"";
_echo(Mo.U('User/Create'));
_contents += "\" class=\"btn btn-link btn-block\">添加用户</a>\r\n\t\t\t\t\t\t\t\t</li>\r\n\t\t\t\t\t\t\t\t<li role=\"presentation\">\r\n\t\t\t\t\t\t\t\t\t<a href=\"";
_echo(Mo.U('User/VipLog'));
_contents += "\" class=\"btn btn-link btn-block\">充值记录</a>\r\n\t\t\t\t\t\t\t\t</li>\r\n\t\t\t\t\t\t\t</ul>\r\n\t\t\t\t\t\t</div>\r\n\t\t\t\t\t</div>\r\n\t\t\t\t</div>\r\n\t\t\t</div>\r\n\t\t\t<div class=\"col-md-10\">\r\n\t\t\t\t<div class=\"panel panel-default\">\r\n\t\t\t\t\t<ol class=\"breadcrumb\">\r\n\t\t\t\t\t\t<li class=\"active\">会员列表</li>\r\n\t\t\t\t\t</ol>\r\n\t\t\t\t\t<div class=\"panel-body\">\r\n\t\t\t\t\t\t";
if( !(typeof error == "undefined" || is_empty(error))){
_contents += "\t\t\t\t\t\t\t<div class=\"alert alert-warning alert-dismissible fade in\" role=\"alert\">\r\n\t\t\t\t\t\t\t\t<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button>\r\n\t\t\t\t\t\t\t\t<strong>出现错误：</strong>";
_echo(error);
_contents += "\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t";
}
_contents += "\t\t\t\t\t\t<div class=\"table-responsive\">\r\n\t\t\t\t\t\t\t<table class=\"table table-striped table-hover\">\r\n\t\t\t\t\t\t\t\t<thead>\r\n\t\t\t\t\t\t\t\t\t<tr>\r\n\t\t\t\t\t\t\t\t\t\t<th class=\"col-md-1\">ID</th>\r\n\t\t\t\t\t\t\t\t\t\t<th>状态</th>\r\n\t\t\t\t\t\t\t\t\t\t<th>用户昵称</th>\r\n\t\t\t\t\t\t\t\t\t\t<th>邮箱地址</th>\r\n\t\t\t\t\t\t\t\t\t\t<th>手机号码</th>\r\n\t\t\t\t\t\t\t\t\t\t<th>注册日期</th>\r\n\t\t\t\t\t\t\t\t\t\t<th>操作</th>\r\n\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\t\t</thead>\r\n\t\t\t\t\t\t\t\t<tbody>\r\n\t\t\t\t\t\t\t\t\t";
data.reset();
data.each(function(item){
_contents += "\t\t\t\t\t\t\t\t\t\t<tr>\r\n\t\t\t\t\t\t\t\t\t\t\t<td scope=\"row\">";
_echo(item.id);
_contents += "</td>\r\n\t\t\t\t\t\t\t\t\t\t\t<td>";
if(item.islogin == 0){
_contents += "正常";
}else{
_contents += "禁登";
}
_contents += "</td>\r\n\t\t\t\t\t\t\t\t\t\t\t<td><a href=\"";
_echo(Mo.U('User/Show','id='+item.id));
_contents += "\">";
_echo(item.username);
_contents += "</a></td>\r\n\t\t\t\t\t\t\t\t\t\t\t<td>";
if( !(typeof item.email == "undefined" || is_empty(item.email))){
_echo(item.email);
_contents += " ";
if(item.isemail == 1){
_contents += "已认证";
}else{
_contents += "未认证";
}
}else{
_contents += "未填写";
}
_contents += "</td>\r\n\t\t\t\t\t\t\t\t\t\t\t<td>";
if( !(typeof item.mobile == "undefined" || is_empty(item.mobile))){
_echo(item.mobile);
_contents += " ";
if(item.ismobile == 1){
_contents += "已认证";
}else{
_contents += "未认证";
}
}else{
_contents += "未填写";
}
_contents += "</td>\r\n\t\t\t\t\t\t\t\t\t\t\t<td>";
_echo(F.untimespan(item.regtime));
_contents += "</td>\r\n\t\t\t\t\t\t\t\t\t\t\t<td>\r\n\t\t\t\t\t\t\t\t\t\t\t\t<a href=\"";
_echo(Mo.U('User/Edit','id='+item.id));
_contents += "\" class=\"btn btn-success btn-xs\">编辑</a>\r\n\t\t\t\t\t\t\t\t\t\t\t\t<button type=\"button\" class=\"btn btn-danger btn-xs\" data-toggle=\"modal\" data-target=\"#exampleModal\"  onclick=\"Del('";
_echo(item.id);
_contents += "');\">删除</button>\r\n\t\t\t\t\t\t\t\t\t\t\t</td>\r\n\t\t\t\t\t\t\t\t\t\t</tr>\r\n\t\t\t\t\t\t\t\t\t";
});
_contents += "\t\t\t\t\t\t\t\t</tbody>\r\n\t\t\t\t\t\t\t</table>\r\n\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t";
_echo($CreatePageList("",data.recordcount,data.pagesize,data.currentpage));
_contents += "\t\t\t\t\t</div>\r\n\t\t\t\t</div>\r\n\t\t\t</div>\r\n\t\t</div>\r\n\t</div>\r\n\t\r\n\t<div class=\"Del\"></div>\r\n\t<script type=\"text/javascript\">\r\n\t\tfunction Del(id){\r\n\t\t\tvar str='<div class=\"modal fade\" id=\"exampleModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\">' + '<div class=\"modal-dialog\" role=\"document\">' + '<div class=\"modal-content\">' + '<div class=\"modal-header\">' + '<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button>' + '<h4 class=\"modal-title\" id=\"exampleModalLabel\">提示信息</h4>' + '</div>' + '<form action=\"";
_echo(Mo.U('User/Del'));
_contents += "\" method=\"post\">' + '<input type=\"hidden\" name=\"__csrf\" value=\"";
_echo(__csrf);
_contents += "\">' + '<div class=\"modal-body\">' + '<input type=\"hidden\"name=\"id\" value=\"'+id+'\">' + '<div class=\"alert alert-danger\" role=\"alert\">删除该用户信息且不可恢复，确认继续？？</div>' + '</div>' + '<div class=\"modal-footer\">' + '<button type=\"button\" class=\"btn btn-primary btn-sm\" data-dismiss=\"modal\">关闭窗口</button>' + '<button type=\"submit\" class=\"btn btn-danger btn-sm\">确认删除</button>' + '</div>' + '</form>' + '</div>' + '</div>' + '</div>';\r\n\t\t\t$('.Del').html(str);\r\n\t\t}\r\n\t</script>\r\n\t<div class=\"container\" style=\"margin-top: 20px;\">\r\n\t\t<div id=\"footer\" style=\"text-align: center; border-top: dashed 3px #eeeeee; padding: 20px;\">\r\n\t\t\t©2015 <a href=\"http://zishang520.com\">win紫殇</a>\r\n\t\t</div>\r\n\t</div>\r\n</body>\r\n<script type=\"text/javascript\">\r\n\t$('select').select2();\r\n</script>\r\n</html>";
}
_end();delete _end;delete _echo;if(__buffer) return _contents;
</script>