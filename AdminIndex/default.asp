<%@Language="JSCRIPT" CodePage="65001"%>
<script language="jscript" runat="server" src="../MoLib/Mo.js"></script>
<script language="jscript" runat="server">
/*
** File: default.asp
** Usage: the entry.
** About: 
**	support@mae.im
*/
define("MO_DEBUG",true);//打开调试功能true未开启
define("MO_DEBUG_MODE","APPLICATION");//bug调试模式 APPLICATION SESSION 以及DIRECT(档前页面)
define("MO_APP_NAME", "Admin");//项目名称
define("MO_APP", "../Admin");//项目地址
define("MO_CORE", "../MoLib");//核心文件地址
define("MO_COMPILE_CACHE", true);//开启或关闭缓存
define("MO_ERROR_REPORTING", E_ALL);//异常显示级别，E_INFO, E_WARNING, E_ERROR, E_NOTICE, E_NONE可随意组合，上线后建议设置为E_NONE
define("MO_PRE_LIB",'Auth,Ip');//自动加载扩展
Mo.on("load", function(){
	IController = require("lib/dist.js").IController;
	IController.extend("empty", function(){
		Response.Status = "404 Not Found";
		F.echo("未找到方法");
	});
});
startup();//开始整个项目运行
</script>