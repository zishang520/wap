<script language="jscript" runat="server">
	Auth = IClass.create();
	Auth.extend("Index", function(){
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
	//auth验证
	auth=function (){
		var ctrl = Mo.A("Login");
		if (!empty(cookie("Z_Cookies")) && !empty(F.session.parse("admin"))) {
			var adminsession = F.session.parse("admin");
			var admincookie = cookie("Z_Cookies");
			if (cookie('__csrf')!==F.session('__csrf') || adminsession['__Hash']!==admincookie.__Hash || adminsession['__token']!==admincookie.__token) {
				cookie("Z_Cookies",'');
				F.session.destroy(true);
				ctrl.Index();
				F.exit();
			}else{
				var adminsessioninfo=F.json(AES_EN(adminsession['__Hash'],2));
				var admincookiesinfo=F.json(AES_EN(admincookie.__Hash,2));
				if (is_empty(adminsessioninfo) || is_empty(admincookiesinfo)) {
					cookie("Z_Cookies",'');
					F.session.destroy(true);
					ctrl.Index();
					F.exit();
				}
				Mo.assign("adminname",adminsessioninfo['username']); //模板中直接可以用{ $r.name}引用
				if(int2ip(adminsessioninfo['ip'])!==F.server("REMOTE_ADDR") || adminsessioninfo['username']!==admincookiesinfo['username'] || adminsessioninfo['password']!==admincookiesinfo['password']){
					cookie("Z_Cookies",'');
					F.session.destroy(true);
					ctrl.Index();
					F.exit();
				}
			}
		}else{
			ctrl.Index();
			F.exit();
		}
	}
	authinfo=function (){
		if (!empty(cookie("Z_Cookies")) && !empty(F.session.parse("admin"))) {
			var adminsession = F.session.parse("admin");
			var admincookie = cookie("Z_Cookies");
			if (cookie('__csrf')!==F.session('__csrf') || adminsession['__Hash']!==admincookie.__Hash || adminsession['__token']!==admincookie.__token) {
				cookie("Z_Cookies",'');
				F.session.destroy(true);
				return false;
				F.exit();
			}else{
				var adminsessioninfo=F.json(AES_EN(adminsession['__Hash'],2));
				var admincookiesinfo=F.json(AES_EN(admincookie.__Hash,2));
				if (is_empty(adminsessioninfo) || is_empty(admincookiesinfo)) {
					cookie("Z_Cookies",'');
					F.session.destroy(true);
					return false;
					F.exit();
				}
				Mo.assign("adminname",adminsessioninfo['username']); //模板中直接可以用{ $r.name}引用
				if(int2ip(adminsessioninfo['ip'])!==F.server("REMOTE_ADDR") || adminsessioninfo['username']!==admincookiesinfo['username'] || adminsessioninfo['password']!==admincookiesinfo['password']){
					cookie("Z_Cookies",'');
					F.session.destroy(true);
					return false;
					F.exit();
				}
				return true;
			}
			return true;
		}else{
			return false;
			F.exit();
		}
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
	if (!is_empty(F.session('__csrf'))) {
		Mo.assign('__csrf',F.session('__csrf'));
	}else{
		var __csrf = AES_EN(ip2int(F.server("REMOTE_ADDR"))+F.formatdate(new Date(),"HH:mm:ss"),1);
		cookie('__csrf',__csrf);
		F.session('__csrf',__csrf);
		Mo.assign('__csrf',__csrf);
	}
	//把错误注入模板
	if (!is_empty(F.session('__error'))) {
		Mo.assign('error',F.session('__error'));
		F.session.destroy("__error");
	}
	var WebConfigs=M('WebConfig','id').find(1);
	var Msg=M('Msg','id').where('islook=0').select().count();
	if (WebConfigs || Msg){
		Mo.assign('Msglook',Msg);
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
</script>