<script language="jscript" runat="server">
	OnStart = IClass.create();
	OnStart.extend("Index", function(){
	var __LATE = '2#3cad56a8c/a642e99b/3391bfd/5b2b659';//加密密钥
	var __IV = '3#14519/15797/35521/17123/14627/39041';//质数
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
	if (!empty(cookie("USER_Cookies")) && !empty(F.session.parse("USER"))) {
		var usersession = F.session.parse("USER");
		var usercookie = cookie("USER_Cookies");
		if (cookie('__csrf')!==F.session('__csrf') || usersession['__Hash']!==usercookie.__Hash || usersession['__token']!==usercookie.__token) {
			cookie("USER_Cookies",'');
			F.session.destroy(true);
			return false;
		}else{
			var usersessioninfo=JSON.parse(AES_EN(usersession['__Hash'],2));
			var usercookiesinfo=JSON.parse(AES_EN(usercookie.__Hash,2));
			if (!empty(usersessioninfo) && !empty(usercookiesinfo)) {
				if(int2ip(usersessioninfo['lastip'])!==F.server("REMOTE_ADDR") || usersessioninfo['username']!==usercookiesinfo['username'] || usersessioninfo['password']!==usercookiesinfo['password'] || MD5(JSON.stringify(usersessioninfo)+usersession['__Hash'])!==usercookie.__token){
					cookie("USER_Cookies",'');
					F.session.destroy(true);
					return false;
				}else{
					return true;
				}
			}else{
				cookie("USER_Cookies",'');
				F.session.destroy(true);
				return false;
			}
		}
	}else{
		return false;
	}
}
USERINFO=function(){
	var username,id,email;
	if (!empty(F.session.parse("USER"))) {
		var usersession = F.session.parse("USER");
		var usersessioninfo=F.json(AES_EN(usersession['__Hash'],2));
		if (!empty(usersessioninfo)) {
			username=!is_empty(usersessioninfo)?usersessioninfo['username']:false;
			id=!is_empty(usersessioninfo)?usersessioninfo['id']:false;
			email=!is_empty(usersessioninfo)?usersessioninfo['email']:false;
		}else{
			username=false;
			id=false;
			email=false;
		}
	}else{
		username=false;
		id=false;
		email=false;
	}
	this.id=function(){
		return id;
	}
	this.username=function(){
		return username;
	}
	this.email=function(){
		return email;
	}
}
if (!is_empty(F.session('__csrf'))) {
	Mo.assign('__csrf',F.session('__csrf'));
}else{
	var __csrf = AES_EN(ip2int(F.server("REMOTE_ADDR"))+F.formatdate(new Date(),"HH:mm:ss"),1);
	cookie('__csrf',__csrf);
	F.session('__csrf',__csrf);
	Mo.assign('__csrf',__csrf);
}
if (F.server('HTTP_X_REQUESTED_WITH')=='XMLHttpRequest'){
	if(F.server('HTTP_X_CSRF_TOKEN')!==F.session('__csrf') || F.server('HTTP_X_CSRF_TOKEN')!==cookie('__csrf') || F.session('__csrf')!==cookie('__csrf')){
		var ctrl = Mo.A("Error");
		ctrl.Index(); //调用Home控制器的Index方法
		F.exit();
	}
}else{
	if (F.server('REQUEST_METHOD')=='POST') {
		if(F.post('__csrf')!==F.session('__csrf') || F.post('__csrf')!==cookie('__csrf') || F.session('__csrf')!==cookie('__csrf')){
			var ctrl = Mo.A("Error");
			ctrl.Index(); //调用Home控制器的Index方法
			F.exit();
		}
	}
}
//把错误注入模板
if (!is_empty(F.session('__error'))) {
	Mo.assign('error',F.session('__error'));
	F.session.destroy("__error");
}
var WebConfigs=M('WebConfig','id').find(1);
if(WebConfigs){
	Mo.assign('web_logo',WebConfigs['web_logo']);
	Mo.assign('web_title',WebConfigs['web_title']);//网站标题
	Mo.assign('web_name',WebConfigs['web_name']);//网站名称
	Mo.assign('web_url',WebConfigs['web_url']);//网站
	Mo.assign('keywords',WebConfigs['keywords']);//关键词
	Mo.assign('description',WebConfigs['description']);//描述
	Mo.assign('record',WebConfigs['record']);//备案号
	Mo.assign('buinformation',WebConfigs['buinformation']);//底部信息
	Mo.assign('copyright',WebConfigs['copyright']);//版权
}
});
// Mo.ClearCompiledCache();
// Mo.ModelCacheClear();
</script>