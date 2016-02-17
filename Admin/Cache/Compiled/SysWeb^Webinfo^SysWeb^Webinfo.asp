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
_contents += "-网站信息-";
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
_contents += "\">注销</a></li>\r\n\t\t\t\t\t\t</ul>\r\n\t\t\t\t\t</li>\r\n\t\t\t\t</ul>\r\n\t\t\t</div><!-- /.navbar-collapse -->\r\n\t\t</div><!-- /.container-fluid -->\r\n\t</nav>\r\n\t\r\n\t<div class=\"container-fluid\">\r\n\t\t<div class=\"row\">\r\n\t\t\t<div class=\"col-md-2\">\r\n\t\t\t\t<div class=\"panel-group\" role=\"tablist\">\r\n\t\t\t\t\t<div class=\"panel panel-default\">\r\n\t\t\t\t\t\t<a class=\"panel-heading btn btn-default btn-block\" role=\"button\" data-toggle=\"collapse\" href=\"#collapseListGroup1\" aria-expanded=\"true\" aria-controls=\"collapseListGroup1\">\r\n\t\t\t\t\t\t\t系统设置\r\n\t\t\t\t\t\t</a>\r\n\t\t\t\t\t\t<div id=\"collapseListGroup1\" class=\"panel-collapse collapse in\" role=\"tabpanel\" aria-labelledby=\"collapseListGroupHeading1\" aria-expanded=\"true\">\r\n\t\t\t\t\t\t\t<ul class=\"nav nav-pills nav-stacked\">\r\n\t\t\t\t\t\t\t\t<li role=\"presentation\" class=\"active\">\r\n\t\t\t\t\t\t\t\t\t<a href=\"";
_echo(Mo.U('SysWeb/Webinfo'));
_contents += "\" class=\"btn btn-link btn-block\">网站信息</a>\r\n\t\t\t\t\t\t\t\t</li>\r\n\t\t\t\t\t\t\t\t<li role=\"presentation\">\r\n\t\t\t\t\t\t\t\t\t<a href=\"";
_echo(Mo.U('SysWeb/Email'));
_contents += "\" class=\"btn btn-link btn-block\">邮箱设置</a>\r\n\t\t\t\t\t\t\t\t</li>\r\n\t\t\t\t\t\t\t\t<li role=\"presentation\">\r\n\t\t\t\t\t\t\t\t\t<a href=\"";
_echo(Mo.U('SysWeb/EmailTemplate','id=1'));
_contents += "\" class=\"btn btn-link btn-block\">邮箱模板</a>\r\n\t\t\t\t\t\t\t\t</li>\r\n\t\t\t\t\t\t\t\t<li role=\"presentation\">\r\n\t\t\t\t\t\t\t\t\t<a href=\"";
_echo(Mo.U('SysWeb/SmsTemplate'));
_contents += "\" class=\"btn btn-link btn-block\">短信模板</a>\r\n\t\t\t\t\t\t\t\t</li>\r\n\t\t\t\t\t\t\t</ul>\r\n\t\t\t\t\t\t</div>\r\n\t\t\t\t\t</div>\r\n\t\t\t\t</div>\r\n\t\t\t</div>\r\n\t\t\t<div class=\"col-md-10\">\r\n\t\t\t\t<div class=\"panel panel-default\">\r\n\t\t\t\t\t<ol class=\"breadcrumb\">\r\n\t\t\t\t\t\t<li class=\"active\">网站信息</li>\r\n\t\t\t\t\t</ol>\r\n\t\t\t\t\t<div class=\"panel-body\">\r\n\t\t\t\t\t\t";
if( !(typeof error == "undefined" || is_empty(error))){
_contents += "\t\t\t\t\t\t\t<div class=\"alert alert-warning alert-dismissible fade in\" role=\"alert\">\r\n\t\t\t\t\t\t\t\t<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button>\r\n\t\t\t\t\t\t\t\t<strong>出现错误：</strong>";
_echo(error);
_contents += "\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t";
}
_contents += "\t\t\t\t\t\t";
data.reset();
data.each(function(item){
_contents += "\t\t\t\t\t\t\t<form action=\"";
_echo(Mo.U('SysWeb/Webinfo'));
_contents += "\" method=\"post\" class=\"form-horizontal\">\r\n\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"__csrf\" value=\"";
_echo(__csrf);
_contents += "\">\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<label for=\"inputTitle3\" class=\"col-sm-2 control-label\">网站标题</label>\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-6\">\r\n\t\t\t\t\t\t\t\t\t\t<input name=\"web_title\" type=\"text\" class=\"form-control\" id=\"inputTitle3\" placeholder=\"网站标题 整个网站的最开始标题\" value=\"";
_echo(item.web_title);
_contents += "\">\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<label for=\"pic\" class=\"col-sm-2 control-label\">LOGO</label>\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-3\">\r\n\t\t\t\t\t\t\t\t\t\t<input name=\"web_logo\" type=\"text\" class=\"form-control\" id=\"pic\" placeholder=\"缩略图\" value=\"";
_echo(item.web_logo);
_contents += "\">\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t\t<script type=\"text/javascript\" src=\"js/jquery.form.js\"></script>\r\n<div class=\"row\">\r\n\t<div class=\"col-md-3\">\r\n\t\t<div class=\"bt\">\r\n\t\t\t<input type=\"file\" name=\"Thumb\">\r\n\t\t\t<input class=\"button btn btn-default btn-sm\" type=\"button\" value=\"文件上传\">\r\n\t\t\t<span class=\"info\"></span>\r\n\t\t</div>\r\n\t</div>\r\n\t<div class=\"col-md-3\">\r\n\t\t<div class=\"progress\">\r\n\t\t\t<div class=\"bar_CThumd progress-bar progress-bar-striped\" role=\"progressbar\" aria-valuenow=\"60\" aria-valuemin=\"0\" aria-valuemax=\"100\">\r\n\t\t\t</div>\r\n\t\t</div>\r\n\t</div>\r\n</div>\r\n<script type=\"text/javascript\">\r\n\t$(function() {\r\n\t\tvar bar = $('.bar_CThumd');\r\n\t\tvar progress = $(\".progress\");\r\n\t\tvar btn = $(\".button\");\r\n\t\tvar info = $(\".info\");\r\n\t\t$(\".bt\").wrap(\"<form id='Cupload' class='form-inline' action='";
_echo(Mo.U('Upload/CThumb'));
_contents += "' method='post' enctype='multipart/form-data'></form>\");\r\n\t\t$(\".button\").click(function(){\r\n\t\t\t$(\"#Cupload\").ajaxSubmit({\r\n\t\t\t\tdataType:  'json',\r\n\t\t\t\tbeforeSend: function() {\r\n\t\t\t\t\tprogress.show();\r\n\t\t\t\t\tvar percentVal = '0%';\r\n\t\t\t\t\tbar.addClass(\"active\");\r\n\t\t\t\t\tbar.width(percentVal);\r\n\t\t\t\t\tbar.html(percentVal);\r\n\t\t\t\t\tbtn.val(\"上传中...\");\r\n\t\t\t\t},\r\n\t\t\t\tuploadProgress: function(event, position, total, percentComplete) {\r\n\t\t\t\t\tvar percentVal = percentComplete + '%';\r\n\t\t\t\t\tbar.width(percentVal);\r\n\t\t\t\t\tbar.html(percentVal);\r\n\t\t\t\t},\r\n\t\t\t\tsuccess: function(data) {\r\n\t\t\t\t\tif (data.error==1) {\r\n\t\t\t\t\t\tbar.width('0');\r\n\t\t\t\t\t\tbar.html('0%');\r\n\t\t\t\t\t\tbar.removeClass(\"active\");\r\n\t\t\t\t\t\tbtn.val(\"文件上传\");\r\n\t\t\t\t\t\tinfo.html(data.success);\r\n\t\t\t\t\t\treturn false;\r\n\t\t\t\t\t}else{\r\n\t\t\t\t\t\t$(\"#pic\").val(data.Path);\r\n\t\t\t\t\t\tbar.removeClass(\"active\");\r\n\t\t\t\t\t\tinfo.html(\"文件\" + data.LocalName + \"上传成功\");\r\n\t\t\t\t\t\tbtn.val(\"文件上传\");\r\n\t\t\t\t\t}\r\n\t\t\t\t},\r\n\t\t\t\terror:function(xhr){\r\n\t\t\t\t\tbtn.val(\"上传失败\");\r\n\t\t\t\t\tbar.width('0');\r\n\t\t\t\t\tbar.html('0%');\r\n\t\t\t\t\tinfo.html(xhr.responseText);\r\n\t\t\t\t}\r\n\t\t\t});\r\n\t\t});\r\n\t});\r\n</script>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<label for=\"inputName3\" class=\"col-sm-2 control-label\">网站名称</label>\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-6\">\r\n\t\t\t\t\t\t\t\t\t\t<input name=\"web_name\" type=\"text\" class=\"form-control\" id=\"inputName3\" placeholder=\"网站名称 显示与标题最后面\" value=\"";
_echo(item.web_name);
_contents += "\">\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<label for=\"inputUrl3\" class=\"col-sm-2 control-label\">网站链接</label>\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-6\">\r\n\t\t\t\t\t\t\t\t\t\t<input name=\"web_url\" type=\"url\" class=\"form-control\" id=\"inputUrl3\" placeholder=\"网站链接 要加上http://\" value=\"";
_echo(item.web_url);
_contents += "\">\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<label for=\"inputKey3\" class=\"col-sm-2 control-label\">网站关键词</label>\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-6\">\r\n\t\t\t\t\t\t\t\t\t\t<input name=\"keywords\" type=\"text\" class=\"form-control\" id=\"inputKey3\" placeholder=\"关键词 空格分割\" value=\"";
_echo(item.keywords);
_contents += "\">\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<label for=\"inputDes3\" class=\"col-sm-2 control-label\">网站描述</label>\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-6\">\r\n\t\t\t\t\t\t\t\t\t\t<textarea name=\"description\" type=\"text\" class=\"form-control\" rows=\"5\" id=\"inputDes3\" placeholder=\"网站描述 网站的描述内容\">";
_echo(item.description);
_contents += "</textarea>\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<label for=\"inputRecord3\" class=\"col-sm-2 control-label\">网站备案号</label>\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-6\">\r\n\t\t\t\t\t\t\t\t\t\t<input name=\"record\" type=\"text\" class=\"form-control\" id=\"inputRecord3\" placeholder=\"备案号 如:瑜12号 123456-2b\" value=\"";
_echo(item.record);
_contents += "\">\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<label for=\"inputBuinformation3\" class=\"col-sm-2 control-label\">底部信息</label>\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-6\">\r\n\t\t\t\t\t\t\t\t\t\t<textarea name=\"buinformation\" type=\"text\" class=\"form-control\" rows=\"5\" id=\"inputBuinformation3\" maxlength=\"500\" placeholder=\"底部信息 支持HTML\">";
_echo(item.buinformation);
_contents += "</textarea>\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<label for=\"inputCopyright3\" class=\"col-sm-2 control-label\">版权信息</label>\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-6\">\r\n\t\t\t\t\t\t\t\t\t\t<input name=\"copyright\" type=\"text\" class=\"form-control\" id=\"inputCopyright3\" placeholder=\"版权信息 用于底部显示\" value=\"";
_echo(item.copyright);
_contents += "\">\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t<div class=\"form-group\">\r\n\t\t\t\t\t\t\t\t\t<div class=\"col-sm-offset-2 col-sm-10\">\r\n\t\t\t\t\t\t\t\t\t\t<button type=\"submit\" class=\"btn btn-info\">更新信息</button>\r\n\t\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t</form>\r\n\t\t\t\t\t\t";
});
_contents += "\t\t\t\t\t</div>\r\n\t\t\t\t</div>\r\n\t\t\t</div>\r\n\t\t</div>\r\n\t</div>\r\n\t\r\n\t<div class=\"container\" style=\"margin-top: 20px;\">\r\n\t\t<div id=\"footer\" style=\"text-align: center; border-top: dashed 3px #eeeeee; padding: 20px;\">\r\n\t\t\t©2015 <a href=\"http://zishang520.com\">win紫殇</a>\r\n\t\t</div>\r\n\t</div>\r\n</body>\r\n<script type=\"text/javascript\">\r\n\t$('select').select2();\r\n</script>\r\n</html>";
}
_end();delete _end;delete _echo;if(__buffer) return _contents;
</script>