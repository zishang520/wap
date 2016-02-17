<script language="jscript" runat="server">
/*
** File: Function.asp
** Usage: common functions for global. 
**		if you add some functions, you should add the names to exports.
**		or you can not use then in your business.
** About: 
**		support@mae.im
*/
$IsEmpty = is_empty = function(variable){
	return variable===""||variable===null||variable===undefined;
}

$CreatePageList = function(URL, RecordCount, PageSize, CurrentPage){
	var PageCount ,PageStr="";
	if(URL==""){
		F.object.toURIString.clearFilter();
		F.object.toURIString.filter.push("!page");
		URL=("?" + F.get.toURIString() + "&page={#page}").replace("?&","?");
		F.object.toURIString.clearFilter();
	}
	CurrentPage = parseInt(CurrentPage);
	RecordCount = parseInt(RecordCount);
	PageSize = parseInt(PageSize);
	var rp=RecordCount % PageSize;
	PageCount = (RecordCount-rp) / PageSize + (rp==0?0:1);
	// PageStr = "共[" + RecordCount + "]条记录 [" + PageSize + "]条/页 当前[" + CurrentPage + "/" + PageCount + "]页&nbsp; ";
	PageStr = '<nav><ul class="pagination">';
	if(CurrentPage == 1 || PageCount == 0){
		PageStr += '<li class="disabled"><a aria-label="Previous"><span aria-hidden="true">首页</span></a></li>';
		PageStr += '<li class="disabled"><a aria-label="Previous"><span aria-hidden="true">上页</span></a></li>'
	}else{
		PageStr += '<li><a href="' + URL.replace("{#page}", 1) + '" aria-label="Previous"><span aria-hidden="true">首页</span></a></li>';
		PageStr += '<li><a href="' + URL.replace("{#page}", CurrentPage-1) + '" aria-label="Previous"><span aria-hidden="true">上页</span></a></li>';
	}
    //bootstrap风格分页
    if (PageCount>5) {
    	if (CurrentPage>2) {
    		for (var i = CurrentPage-2; i < CurrentPage; i++) {
    			var active=(CurrentPage==i)?' class="active"':'';
    			PageStr += '<li'+active+'><a href="'+ URL.replace("{#page}", i) +'">'+i+'</a></li>';
    		}
    	}
    	PageStr += '<li class="active"><a>'+CurrentPage+'</a></li>';
    	if ((PageCount-CurrentPage)>2) {
    		for (var i = CurrentPage+1; i <= CurrentPage+2; i++) {
    			var active=(CurrentPage==i)?' class="active"':'';
    			PageStr += '<li'+active+'><a href="'+ URL.replace("{#page}", i) +'">'+i+'</a></li>';
    		}
    	}
    }else{
    	for (var i = 1; i <= PageCount; i++) {
    		var active,href;
    		if(CurrentPage==i){
    			active=' class="active"';
    			href='';
    		}else{
    			active='';
    			href=' href="'+ URL.replace("{#page}", i) +'"';
    		}
    		PageStr += '<li'+active+'><a'+href+'>'+i+'</a></li>';
    	}
    }
    if(CurrentPage == PageCount || PageCount == 0){
    	PageStr += '<li class="disabled"><a aria-label="Next"><span aria-hidden="true">下页</span></a></li>';
    	PageStr += '<li class="disabled"><a aria-label="Next"><span aria-hidden="true">尾页</span></a></li>';
    }else{
    	PageStr += '<li><a href="'+ URL.replace("{#page}", CurrentPage + 1) +'" aria-label="Next"><span aria-hidden="true">下页</span></a></li>';
    	PageStr += '<li><a href="'+ URL.replace("{#page}", PageCount) +'" aria-label="Next"><span aria-hidden="true">尾页</span></a></li>';
    }
    PageStr+='</ul></nav>';
    return PageStr;
}

ReCompileForDebug = function(content, add, add2){
	add = add || 0;
	add2 = add2 || 2;
	var newline= content.indexOf("\r\n")>=0 ? "\r\n" : (content.indexOf("\r")>=0 ? "\r":"\n");
	
	var lines = content.split(newline), _content = "", compileLineNumber=0, lastendingisd=false;
	for(var i=0;i<lines.length;i++){
		var line = F.string.trim(lines[i]);
		
		if(
			F.string.trim(line)=="" || 
			F.string.endsWith(line,"*\/") || 
			/^(\/\/|\/\*|\*\*|\)|\])/i.test(line) ||
			/^(\w+)(\s*)\:/i.test(line) || 
		/^"(.*?)"(\s*)\:/i.test(line) || 
		/^'(.*?)'(\s*)\:/i.test(line) || 
		/^([^\w]+)$/i.test(line.replace(/\b(if|else|function|switch|case|default|break|var|for|in|return|try|catch|finally|true|false|new|null|typeof)\b/ig,"")) || 
		/^(catch|case|else|_contents \+\= ")/i.test(line) || 
		/^(\w+)Controller\.extend\(/i.test(line) || lastendingisd){
			_content += lines[i] + "\r\n";
			compileLineNumber++;
		}else{
			compileLineNumber+=2;
			_content += lines[i].replace(/^(\s*)(.+?)$/ig,"$1") + "Mo.Debug(" + (i+add2) + ",__filename, " + (compileLineNumber+add) + ",__scripts);\r\n " + lines[i] + "\r\n";
		}
		lastendingisd = /(,|\(|\[)$/i.test(line) || /^(\w+)(\s*)\:/i.test(line) || /^"(.*?)"(\s*)\:/i.test(line) || /^'(.*?)'(\s*)\:/i.test(line);
	}
	return F.string.trim(_content,"\r\n");
};
STRstr = function(str) {
	if (is_empty(str)) return "";
	var i, c, es=[], ret = "", len = str.length, buffer=[];
	es[8]='b';es[9]='t';es[10]='n';es[12]='f';es[13]='r';es[34]='"';es[47]='\/';es[92]='\\';
	for (i = 0; i < len; i++) {
		c = str.charCodeAt(i);
		if(es[c]!==undefined){
			buffer.push(92, c);
			continue;
		}
		if (c > 31 && c < 127) {
			buffer.push(c);
			continue;
		}
		if(buffer.length>0){
			ret += String.fromCharCode.apply(null, buffer);
			buffer.length = 0;
		}
		ret += "\\u" + ("0000" + c.toString(16)).slice(-4);
	}
	if(buffer.length>0){
		ret += String.fromCharCode.apply(null, buffer);
		buffer.length = 0;
	}
	return ret;
};
</script>