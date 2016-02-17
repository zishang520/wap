<script language="jscript" runat="server">
/*
** 这是一个Ajax文件上传控制器
** 语法：newController = IController.create([__construct[,__destruct]]);
** __construct：构造函数；
** __destruct：析构函数；
** ip2int：ip转为整型
** int2ip：同理
@@@@@@@@@@@X5111111111111111sssss111sri;;::,:;is11
@@@@@@@@@@X51111111111111sssrrrrrrssri;;;rsr;:;;is
@@@@@@@@@@555h11ssrrrrrriiiiiii;iiii;;;;s555hs;;;;
@@@@@@@@@@hri;;;;;;;;;;;;::;;::::::::;:ihh55S5sii;
@@@@@@    ,::;;;iiirrsssri:,,,,,.,,,,::s1hh5551irr
@@    .,:;;irs1hh5555hh11si,,,,.. ..,,;rs1hh551irr
@  .,:;is15S399933SSS55hh1si:,,,,...,,;irs11h1rirr
@  :is539GG88899933SSS55hh1r::::::,,,,irss1hh1;ii;
@ .:r98GGGGG888999S5SSS55hhi;;;;i;::,:irss1hhs;ri;
@  :r58GGGGG88935s1S3SSS55s;iiiiri;;:;ss111hhiir;i
@@ .:i1399Sh5hsi;s33333SSs;rr;rssrii;i11hhhhr;ri;i
@@@  ,;r1hhh5hsr5999933S1irr;is1srii;ihh5551irriis
@@@@@  .;15Shs198888995rrsr;;s111r;i;i55555hrrr;i1
@@@@@@  ,rsrsS8GGG889hrssi:ir111si;iii5SSSS5srr;r1
@@@@  .:rir59GGGGG85ss1s;,;iii;;;;iriiS3333Ssrr;i1
@@   ,iirh9GGGGG8S1shhs, .,,:::;ir11rrS399331rri;s
@  .;iis38GGGGG8hshSShsiiiiir1hhhhhh11399999Shsr:r
  ,iir58GGGGG9511SS51sssrr533S555S39999888883hsr,:
 .ii19GGGGG8Srir111hh53399G83398G8S5hh159GGG3hrs,,
 :i18GGGGGGShhSS3988GGGGGGGGGGG9Shshhh1s15S385ri. 
 ,rS8GGGGGGGGGGGGGGGGGG8933935hsrssi;;;iiiir11i,  
 .ih8GGGGGGGGGGGGGGG835h1ss1sri;:.   @@    .,.    
@ :rh98GGGGGGG893SS5hs1h1ri:.    @@@@@@@@@@@@@ @@@
@@ :i1555555hhhsssriii,.   @@@@@@@@@@@@@@@@@@@@@@@
@@  .;irrrrriiii;,    @@@@@@@@@@@@@@@@@@@@@@@@@@@@
*/
UploadController = IController.create(auth());
//缩略图
UploadController.extend("Thumb",true,function(){
	var __dir = F.mappath("../")+"\\WebIndex";//项目在系统中的物理地址
	var ldir = F.formatdate(new Date(),"yyyy") +'/'+ F.formatdate(new Date(),"MM") +'/'+ F.formatdate(new Date(),"dd");//用日期归类
	var pdir="/upload/Thumb/" + ldir;
	var upload = require("net/upload");//加载上传插件
	if(!upload){
		F.echo('{"error":"1","success":"模块net不存在，需要安装"}',true);
		return;
	}
	upload({
		AllowFileTypes : "*.jpg;*.png;*.gif;*.bmp", /*允许上床的文件类型，后坠不支持通配.*/
		AllowMaxSize : "1Mb", /*文件大小限制*/
		Charset : "utf-8", /*针对文本的编码方式，默认即可*/
		SavePath : __dir + pdir, /*文件保存目录.*/
		RaiseServerError : false, /* when it is false, don not push exception to Global ExceptionManager, just save in F.exports.upload.exception.*/
		OnError:function(e,cfg){ /*event, on some errors are raised. */
			F.echo('{"error":"1","success":"' + e + '"}');//出现储物则打印错误
		},
		OnSucceed:function(cfg){
			this.save(this("Thumb"), {
				OnError : function(e){
					F.echo('{"error":"1","success":"' + e + '"}');
				},
				OnSucceed : function(count,files){
					var json_str='{"error":"0","LocalName":"' + files[0].LocalName + '","Path":"' + pdir +"/"+ files[0].FileName + '","Size":"' + files[0].Size + '"}';
					F.echo(json_str);
				}
			});
		}
	});
});
//栏目缩略图
UploadController.extend("CThumb",true,function(){
	var __dir = F.mappath("../")+"\\WebIndex";
	var ldir = F.formatdate(new Date(),"yyyy") +'/'+ F.formatdate(new Date(),"MM") +'/'+ F.formatdate(new Date(),"dd");
	var pdir="/upload/CThumb/" + ldir;
	var upload = require("net/upload");
	if(!upload){
		F.echo('{"error":"1","success":"模块net不存在，需要安装"}',true);
		return;
	}
	upload({
		AllowFileTypes : "*.jpg;*.png;*.gif;*.bmp", /*only these extensions can be uploaded.*/
		AllowMaxSize : "1Mb", /*max upload-data size*/
		Charset : "utf-8", /*client text charset*/
		SavePath : __dir + pdir, /*dir that files will be saved in it.*/
		RaiseServerError : false, /* when it is false, don not push exception to Global ExceptionManager, just save in F.exports.upload.exception.*/
		OnError:function(e,cfg){ /*event, on some errors are raised. */
			F.echo('{"error":"1","success":"' + e + '"}');
		},
		OnSucceed:function(cfg){
			this.save(this("Thumb"), {
				OnError : function(e){
					F.echo('{"error":"1","success":"' + e + '"}');
				},
				OnSucceed : function(count,files){
					var json_str='{"error":"0","LocalName":"' + files[0].LocalName + '","Path":"' + pdir +"/"+ files[0].FileName + '","Size":"' + files[0].Size + '"}';
					F.echo(json_str);
				}
			});
		}
	});
});
//文章缩略图
UploadController.extend("File",true,function(){
	var __dir = F.mappath("../")+"\\WebIndex";
	var ldir = F.formatdate(new Date(),"yyyy") +'/'+ F.formatdate(new Date(),"MM") +'/'+ F.formatdate(new Date(),"dd"); 
	var pdir="/upload/content/" + ldir;
	var upload = require("net/upload");
	if(!upload){
		F.echo('{"error":"1","success":"模块net不存在，需要安装"}',true);
		return;
	}
	upload({
		AllowFileTypes : "*.swf;", /*only these extensions can be uploaded.*/
		AllowMaxSize : "1Mb", /*max upload-data size*/
		Charset : "utf-8", /*client text charset*/
		SavePath : __dir + pdir, /*dir that files will be saved in it.*/
		RaiseServerError : false, /* when it is false, don not push exception to Global ExceptionManager, just save in F.exports.upload.exception.*/
		OnError:function(e,cfg){ /*event, on some errors are raised. */
			F.echo('{"error":"1","success":"' + e + '"}');
		},
		OnSucceed:function(cfg){
			this.save(this("File"), {
				OnError : function(e){
					F.echo('{"error":"1","success":"' + e + '"}');
				},
				OnSucceed : function(count,files){
					var json_str='{"error":"0","LocalName":"' + files[0].LocalName + '","Path":"' + pdir +"/"+ files[0].FileName + '","Size":"' + files[0].Size + '"}';
					F.echo(json_str);
				}
			});
		}
	});
});
</script>