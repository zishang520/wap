<script language="jscript" runat="server">
	UploadController = IController.create(auth());
	UploadController.extend("Thumb",true,function(){
		var __dir = F.server("APPL_PHYSICAL_PATH");
		var ldir = F.formatdate(new Date(),"yyyy") +'/'+ F.formatdate(new Date(),"MM") +'/'+ F.formatdate(new Date(),"dd");
		var upload = require("net/upload");
		if(!upload){
			F.echo('{"error":"1","success":"模块net不存在，需要安装"}',true);
			return;
		}
		upload({
			AllowFileTypes : "*.jpg;*.png;*.gif;*.bmp", /*only these extensions can be uploaded.*/
			AllowMaxSize : "1Mb", /*max upload-data size*/
			Charset : "utf-8", /*client text charset*/
			SavePath : __dir + "Public/upload/Thumb/" + ldir, /*dir that files will be saved in it.*/
			RaiseServerError : false, /* when it is false, don not push exception to Global ExceptionManager, just save in F.exports.upload.exception.*/
			OnError:function(e,cfg){ /*event, on some errors are raised. */
				Mo.assign("exception", e);
			},
			OnSucceed:function(cfg){
				this.save(this("Thumb"), {
					OnError : function(e){
						F.echo('{"error":"1","success":"' + e + '"}');
					},
					OnSucceed : function(count,files){
						var json_str='{"error":"0","LocalName":"' + files[0].LocalName + '","Path":"' + files[0].Path + files[0].FileName + '","Size":"' + files[0].Size + '"}';
						F.echo(json_str);
					}
				});
			}
		});
	});
UploadController.extend("CThumb",true,function(){
	var __dir = F.server("APPL_PHYSICAL_PATH");
	var ldir = F.formatdate(new Date(),"yyyy") +'/'+ F.formatdate(new Date(),"MM") +'/'+ F.formatdate(new Date(),"dd");
	var upload = require("net/upload");
	if(!upload){
		F.echo('{"error":"1","success":"模块net不存在，需要安装"}',true);
		return;
	}
	upload({
		AllowFileTypes : "*.jpg;*.png;*.gif;*.bmp", /*only these extensions can be uploaded.*/
		AllowMaxSize : "1Mb", /*max upload-data size*/
		Charset : "utf-8", /*client text charset*/
		SavePath : __dir + "Public/upload/CThumb/" + ldir, /*dir that files will be saved in it.*/
		RaiseServerError : false, /* when it is false, don not push exception to Global ExceptionManager, just save in F.exports.upload.exception.*/
		OnError:function(e,cfg){ /*event, on some errors are raised. */
			Mo.assign("exception", e);
		},
		OnSucceed:function(cfg){
			this.save(this("Thumb"), {
				OnError : function(e){
					F.echo('{"error":"1","success":"' + e + '"}');
				},
				OnSucceed : function(count,files){
					var json_str='{"error":"0","LocalName":"' + files[0].LocalName + '","Path":"' + files[0].Path + files[0].FileName + '","Size":"' + files[0].Size + '"}';
					F.echo(json_str);
				}
			});
		}
	});
});
UploadController.extend("File",true,function(){
	var __dir = F.server("APPL_PHYSICAL_PATH");
	var ldir = F.formatdate(new Date(),"yyyy") +'/'+ F.formatdate(new Date(),"MM") +'/'+ F.formatdate(new Date(),"dd"); 
	var upload = require("net/upload");
	if(!upload){
		F.echo('{"error":"1","success":"模块net不存在，需要安装"}',true);
		return;
	}
	upload({
		AllowFileTypes : "*.css;", /*only these extensions can be uploaded.*/
		AllowMaxSize : "1Mb", /*max upload-data size*/
		Charset : "utf-8", /*client text charset*/
		SavePath : __dir + "Public/upload/content/" + ldir, /*dir that files will be saved in it.*/
		RaiseServerError : false, /* when it is false, don not push exception to Global ExceptionManager, just save in F.exports.upload.exception.*/
		OnError:function(e,cfg){ /*event, on some errors are raised. */
			Mo.assign("exception", e);
		},
		OnSucceed:function(cfg){
			this.save(this("File"), {
				OnError : function(e){
					F.echo('{"error":"1","success":"' + e + '"}');
				},
				OnSucceed : function(count,files){
					var json_str='{"error":"0","LocalName":"' + files[0].LocalName + '","Path":"' + files[0].Path + files[0].FileName + '","Size":"' + files[0].Size + '"}';
					F.echo(json_str);
				}
			});
		}
	});
});
</script>