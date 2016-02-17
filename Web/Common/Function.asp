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
	int2ipm=function (num) {
		var str;
		var tt = new Array();
		tt[0] = (num >>> 24) >>> 0;
		tt[1] = ((num << 8) >>> 24) >>> 0;
		tt[2] = (num << 16) >>> 24;
		tt[3] = (num << 24) >>> 24;
		str = String(tt[0]) + ".*.*." + String(tt[3]);
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
	function deEntity(src) {
		src = src || "";
		var ret = src.replace(/&amp;/igm, "&");
		ret = ret.replace(/&gt;/igm, ">");
		ret = ret.replace(/&lt;/igm, "<");
		ret = ret.replace(/&nbsp;/igm, " ");
		ret = ret.replace(/&quot;/igm, "\"");
		ret = ret.replace(/&copy;/igm, "\u00a9");
		ret = ret.replace(/&reg;/igm, "\u00ae");
		ret = ret.replace(/&plusmn;/igm, "\u00b1");
		ret = ret.replace(/&times;/igm, "\u00d7");
		ret = ret.replace(/&sect;/igm, "\u00a7");
		ret = ret.replace(/&cent;/igm, "\u00a2");
		ret = ret.replace(/&yen;/igm, "\u00a5");
		ret = ret.replace(/&middot;/igm, "\u2022");
		ret = ret.replace(/&euro;/igm, "\u20ac");
		ret = ret.replace(/&pound;/igm, "\u00a3");
		ret = ret.replace(/&trade;/igm, "\u2122");
		return ret
	};
	removeHTMLTag=function (str,leng) {
		str=deEntity(str) || "";
		leng=leng || "";
        str = str.replace(/<.*?>/ig,''); //去除HTML tag
        str = str.replace(/[ |　]*\n/g,'\n'); //去除行尾空白
        //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
        // str=str.replace(/&nbsp;/ig,'');//去掉&numＤＫＳＬＡＪＤＦＬＷＩＨＥＦＩＵＤＪＮＣＪＳＨＤＵＩＦＣＨＮＡＺ　ＪＶＧＷＤＩＳＣＮＺＳＫＪＮＣ　，．ＤＦＪＧＬＫＦＣＭＳＤＧＨＳＥＬＤＫＮＶ　ＫＦＸＤＬＫＭＶ　．ＫＦＣＪＧＬＳＤＫ　ＶＪＫＸＦＤＮＶＪＫＦＸＢＧＨＩＵＳＤＺＤＭＮ　ＮＪＶＤＦＶＣＩＬＫＶＮＸＩＦＮＭＣＸＤＮＧＦＫＣＮＪＣＫＨＧＤＫＺＸ　ＢＶＨＪＳＤＨＶＣ　ＳS 是    bsp;
        if(str.length > leng) {
        	str = str.substring(0,leng);
        }
        return str;
    }
    Html2Ubb = function (str) {
    	str = str.replace(/<br[^>]*>/ig, '\n');
    	str = str.replace(/<p[^>\/]*\/>/ig, '\n');
    	str = str.replace(/\son[\w]{3,16}\s?=\s*([\'\"]).+?\1/ig, '');
    	str = str.replace(/<hr[^>]*>/ig, '[hr]');
    	str = str.replace(/<(sub|sup|u|strike|b|i|pre)>/ig, '[$1]');
    	str = str.replace(/<\/(sub|sup|u|strike|b|i|pre)>/ig, '[/$1]');
    	str = str.replace(/<(\/)?strong>/ig, '[$1b]');
    	str = str.replace(/<(\/)?em>/ig, '[$1i]');
    	str = str.replace(/<(\/)?blockquote([^>]*)>/ig, '[$1blockquote]');
    	str = str.replace(/<img[^>]*smile=\"(\d+)\"[^>]*>/ig, '[s:$1]');
    	str = str.replace(/<img[^>]*src=[\'\"\s]*([^\s\'\"]+)[^>]*>/ig, '[img]' + '$1' + '[/img]');
    	str = str.replace(/<a[^>]*href=[\'\"\s]*([^\s\'\"]*)[^>]*>(.+?)<\/a>/ig, '[url=$1]' + '$2' + '[/url]');
    	str = str.replace(/<[^>]*?>/ig, '');
    	str = str.replace(/&amp;/ig, '&');
    	str = str.replace(/&lt;/ig, '<');
    	str = str.replace(/&gt;/ig, '>');
    	return str;
    }

    Ubb2Html = function (str) {
    	str = str.replace(/</ig, '&lt;');
    	str = str.replace(/>/ig, '&gt;');
    	str = str.replace(/\[\n\]/ig, '<br />');
    	str = str.replace(/\[code\](.+?)\[\/code\]/ig, '<pre>$1</pre>');
    	str = str.replace(/\[hr\]/ig, '<hr />');
    	str = str.replace(/\[\/(size|color|font|backcolor)\]/ig, '</font>');
    	str = str.replace(/\[(sub|sup|u|i|strike|b|blockquote|li)\]/ig, '<$1>');
    	str = str.replace(/\[\/(sub|sup|u|i|strike|b|blockquote|li)\]/ig, '</$1>');
    	str = str.replace(/\[\/align\]/ig, '</p>');
    	str = str.replace(/\[(\/)?h([1-6])\]/ig, '<$1h$2>');
    	str = str.replace(/\[align=(left|center|right|justify)\]/ig, '<p align="$1">');
    	str = str.replace(/\[size=(\d+?)\]/ig, '<font size="$1">');
    	str = str.replace(/\[color=([^\[\<]+?)\]/ig, '<font color="$1">');
    	str = str.replace(/\[backcolor=([^\[\<]+?)\]/ig, '<font style="background-color:$1">');
    	str = str.replace(/\[font=([^\[\<]+?)\]/ig, '<font face="$1">');
    	str = str.replace(/\[list=(a|A|1)\](.+?)\[\/list\]/ig, '<ol type="$1">$2</ol>');
    	str = str.replace(/\[(\/)?list\]/ig, '<$1ul>');
    	str = str.replace(/\[img\]([^\[]*)\[\/img\]/ig, '<img src="$1" border="0" />');
    	str = str.replace(/\[url=([^\]]+)\]([^\[]+)\[\/url\]/ig, '<a href="$1">' + '$2' + '</a>');
    	str = str.replace(/\[url\]([^\[]+)\[\/url\]/ig, '<a href="$1">' + '$1' + '</a>');
    	return str;
    }
</script>