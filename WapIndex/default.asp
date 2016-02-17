<%@Language="JSCRIPT" CodePage="65001"%>
<script language="jscript" runat="server" src="../MoLib/WMo.js"></script>
<script language="jscript" runat="server">
/*
** File: default.asp
** Usage: the entry.
** About: 
**	support@mae.im
*/
define("MO_DEBUG",true);//打开调试功能true未开启
define("MO_DEBUG_MODE","APPLICATION");//bug调试模式 APPLICATION SESSION 以及DIRECT(档前页面)
define("MO_APP_NAME", "Wap");//项目名称
define("MO_APP", "../Wap");//项目地址
define("MO_CORE", "../MoLib");//核心文件地址
define("MO_ERROR_REPORTING", E_ALL);//异常显示级别，E_INFO, E_WARNING, E_ERROR, E_NOTICE, E_NONE可随意组合，上线后建议设置为E_NONE
define("MO_PRE_LIB",'OnStart,Ip');//自动加载扩展
define("MO_COMPILE_CACHE", false);//开启或关闭缓存
startup();//开始整个项目运行
</script>