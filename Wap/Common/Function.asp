<script language="jscript" runat="server">
	//ip转整型
	ip2int=function (ip) {
		var num = 0;
		ip = ip.split(".");
		num = Number(ip[0]) * 256 * 256 * 256 + Number(ip[1]) * 256 * 256 + Number(ip[2]) * 256 + Number(ip[3]);
		num = num >>> 0;
		return num;
	}
	//整型解析为IP地址
	int2ip=function (num) {
		var str;
		var tt = new Array();
		tt[0] = (num >>> 24) >>> 0;
		tt[1] = ((num << 8) >>> 24) >>> 0;
		tt[2] = (num << 16) >>> 24;
		tt[3] = (num << 24) >>> 24;
		str = String(tt[0]) + "." + String(tt[1]) + "." + String(tt[2]) + "." + String(tt[3]);
		return str;
	}
	//判断对象是否为空
	empty=function (obj){
		for(var name in obj){
			return false;
		}
		return true;
	}
	//中文转实体
	convert2Entity=function (str) {
		var len = str.length;
		var re = [];
		for (var i = 0; i < len; i++) {
			var code = str.charCodeAt(i);
			if (code > 256) {
				re.push('&#' + code + ';');
			} else {
				re.push(str.charAt(i));
			}
		}
		return re.join('');
	}
	//随机字符串
	randomString=function (len) {
		　　len = len || 32;
		　　var $chars = 'ABC1DEFGH2IJK3LMNOQP4RSTU5VWXYZab6cdef8ghij7kmlnopq9rest0uvwxyz';
		　　var maxPos = $chars.length;
		　　var pwd = '';
		　　for (i = 0; i < len; i++) {
			　　　　pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
		　　}
		　　return pwd;
	}
</script>