<script language="jscript" runat="server">
	OnStart = IClass.create();
	var Session = require("session");
	OnStart.extend("Index", function(){
var __LATE = '2#a642e99b/5b2b659/3cad56a8c/3391bfd';//加密密钥
var __IV = '3#14519/14627/15797/17123/35521/39041';//质数
var CryptoJS = require("cryptojs");
AES_EN = function (str,condition){
	CryptoJS.require.Padding().Mode();
	CryptoJS.require['AES']().Format.Hex();
	var key = CryptoJS.enc.Utf8.parse(__LATE);   
	var iv  = CryptoJS.enc.Utf8.parse(__IV);
	var cfg={ 
		iv: iv,
		mode:CryptoJS.mode['ECB'],//加密模式
		padding:CryptoJS.pad['AnsiX923'],//补丁算法
		format:CryptoJS.format.Hex
	};
	if (condition==1) {//加密
		var srcs = CryptoJS.enc.Utf8.parse(str);
		return CryptoJS['AES'].encrypt(srcs, key, cfg).toString();
	}else if (condition==2) {//解密
		var srcs = CryptoJS.enc.Hex.parse(str);
		var decryptdata = CryptoJS['AES'].decrypt(CryptoJS.lib.CipherParams.create({ ciphertext:srcs}), key,cfg);
		return decryptdata.toString(CryptoJS.enc.Utf8);
	}
}
//验证
auth=function (){
	if (F.all("sessionid")!='') {
		if (typeof(Session('USER__Hash'))!='undefined' || is_empty(Session('USER__Hash'))) {
			if (is_empty(Session('USER__Hash'))) {
				var usersessioninfo=F.json(AES_EN(Session('USER__Hash'),2));
				if (typeof(usersessioninfo)!='undefined' || is_empty(usersessioninfo)) {
					if(int2ip(usersessioninfo['lastip'])!==F.server("REMOTE_ADDR")){
						Session("USER__Hash",'');
						Session.setTimeout(-1);
						F.echo('{"type":"205","error":"ip null"}');//用户存在异常登录
						F.exit();
					}
				}else{
					Session("USER__Hash",'');
					Session.setTimeout(-1);
					F.echo('{"type":"206","error":"info null"}');//用户信息不存在
					F.exit();
				}
			}else{
				Session("USER__Hash",'');
				Session.setTimeout(-1);
				F.echo('{"type":"206","error":"info null"}');//用户信息不存在
				F.exit();
			}
		}else{
			F.echo('{"type":"206","error":"info null"}');//用户信息不存在
			F.exit();
		}
	}else{
		F.echo('{"type":"207","error":"user not Login"}');//用户未登录
		F.exit();
	}
}
USERINFO=function(){
	var username;
	if (typeof(Session('USER__Hash'))!='undefined' || is_empty(Session('USER__Hash'))) {
		if (is_empty(Session('USER__Hash'))) {
			var usersessioninfo=F.json(AES_EN(Session('USER__Hash'),2));
			if (typeof(usersessioninfo)!='undefined' || is_empty(usersessioninfo)) {
				username=usersessioninfo['username'];
			}else{
				username=false;
			}
		}else{
			username=false;
		}
	}else{
		username=false;
	}
	this.name=function(){
		return username;
	}
}
});
Mo.ClearCompiledCache();
Mo.ModelCacheClear();
</script>