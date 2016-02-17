/*debug*/
/*
** tar package��Old-Style Archive Format
*/
var string2buffer = Utf8.getByteArray, buffer2string = Utf8.getString;

function zipfolder(zip,path){
	IO.directory.directories(path,function(f){
		zipfolder(zip.folder(f.name),f.path);
	});
	IO.directory.files(path,function(f){
		zip.file(f.name,f.path);
	});
}

function $manager(files, options){
	if(this.constructor!==$manager){
		return Function.Create(arguments.length).apply($manager, arguments);
	}
	this.options = options || {};
	if(typeof files == "string"){
		this.files = {};
		this.loader = {path : files, fp : -1, offset : 0};
		this.load(files);
	}else{
		this.files = files || {};
	}
}
var OUTPUTS = [
	function(fp){
		IO.file.flush(fp);
		return true
	},
	function(fp){
		IO.file.seek(fp, 0);
		return IO.binary2buffer(IO.file.read(fp));
	},
	function(fp){
		IO.file.seek(fp, 0);
		return IO.file.read(fp);
	}
];
$manager.helper = zipfolder;
$manager.prototype.folder = function(name){
	this.files[name] = {};
	return new $manager(this.files[name]);
};
$manager.prototype.file = function(name, path){
	this.files[name] = path;
	return this;
};
$manager.prototype.generate = function(path, output){
	var fp = IO.file.open(path, {forText : false});
	if(output===undefined) output = 0;
	if(output!=0 && output!=1 && output!=2) output = 0;
	dogenerate(fp, "", this.files);
	var ending = [];
	for(var i=0;i<1024;i++) ending.push(0);
	IO.file.write(fp, IO.buffer2binary(ending));
	var result = OUTPUTS[output](fp);
	IO.file.close(fp);
	return result;
};
$manager.prototype.load = function(files){
	var size = IO.file.get(files).size, offset = 0;
	if(size<1536) {
		ExceptionManager.put(0x2d2e,"Tar.load","invalid filetype.");
		return;
	}
	var fp = IO.file.open(files, {forRead : true, forText : false});
	this.loader.fp = fp;
	IO.file.seek(fp, size-1024);
	var ending = IO.binary2buffer(IO.file.read(fp)),filechecksum=0;
	for(var i=0;i<1024;i++){
		filechecksum += ending[i];
	}
	if(filechecksum>0){
		IO.file.close(fp);
		ExceptionManager.put(0x2d2e,"Tar.load","invalid filetype.");
		this.loader.fp=-1;
		return;
	}
	if(this.options.loadall!==false){
		while(this.read(function(header,file){
			IO.file.seek(file, header.offset);
			header.data = IO.file.read(file, header.filesize);
			this.files[header.name] = header;
		})){}
		this.close();
		this.loader.fp=-1;
	}
};
$manager.prototype.read = function(fn){
	if(this.loader.fp<0) return false;
	var fp = this.loader.fp;
	IO.file.seek(fp, this.loader.offset);
	var header = IO.binary2buffer(IO.file.read(fp,512));
	if(header.length<512){
		return false;
	}
	if(header[0]==0) return false;
	var checksum_new=0;
	this.loader.offset+=512;
	var filename = readstringbuffer(header,0, 100);
	filename = buffer2string(filename);
	var prefix = readstringbuffer(header,345, 500)
	prefix = buffer2string(prefix);
	if(prefix.length>0){
		if(prefix.substr(prefix.length-1)!="\\") prefix += "\\";
	}
	var linkflag = header[156];
	var headerobj = new tarHeader(prefix+filename, '', linkflag == 0x35);
	var size = parseOtc(header.slice(124, 136));
	headerobj.filesize = size;
	headerobj.offset = this.loader.offset;
	this.loader.offset+=size;
	if(size % 512 !=0) this.loader.offset += 512 - (size % 512);
	headerobj.createdate = parseOtc(header.slice(136, 148));
	var checksum = header.slice(148, 156);
	checksum.pop();
	headerobj.checksum = parseOtc(checksum);
	for(var i=0;i<8;i++){
		header[148+i] = 0x20;
	}
	for(var i=0;i<512;i++) checksum_new+=header[i];
	if(checksum_new != headerobj.checksum){
		ExceptionManager.put(0x2d2e,"Tar.read","checksum error.");
	}else{
		if(typeof fn == "function")fn.call(this, headerobj, fp);
	}
	return true;
};
$manager.prototype.close = function(){
	IO.file.close(this.loader.fp);
};
function dogenerate(fp, name, files){
	for(var i in files){
		if(!files.hasOwnProperty(i)) continue;
		var file = files[i];
		if(typeof file == "string"){
			var fp2 = IO.file.open(file, {forText:false,forRead:true}),
				header = tarHeader(name + i, file, false);
			header.generate(IO.get_filesize(fp2));
			IO.file.write(fp, IO.buffer2binary(header.data));
			if(header.filesize>0){
				IO.file.writeTo(fp2, fp);
			}
			IO.file.close(fp2);
			var padding= header.filesize % 512;
			if(padding>0){
				var pad = [];
				for(var i=0;i<512-padding;i++) pad.push(0);
				IO.file.write(fp, IO.buffer2binary(pad));
			}
		}else{
			var header = tarHeader(name + i, "", true);
			header.generate(0);
			IO.file.write(fp, IO.buffer2binary(header.data));
			dogenerate(fp, name + i + "\\", file);
		}
	}
}
$manager.setNames = function(){
	if(typeof GBK != "undefined"){
		string2buffer = GBK.getByteArray;
		buffer2string = GBK.getString;
	}
};
$manager.packFolder = function(path, target, output){
	var zip = new $manager();
	try{
		zipfolder(zip,path);
		return zip.generate(target, output);
	}catch(ex){
		return false;
	}
}
$manager.packFile = function(file, target, option){
	option = F.extend({filename:null},option);
	var filename = option.filename || file.substr(file.lastIndexOf("\\")+1);
	var zip = new $manager();
	try{
		zip.file(filename,file);
		return zip.generate(target, option.output);
	}catch(ex){
		return false;
	}
}
$manager.unpack = function(srcfile,dest){
	var zip = new $manager(srcfile);
	var files = zip.files;
	for(var i in files){
		if(!files.hasOwnProperty(i)) continue;
		var file = files[i];
		if(file.dir){
			IO.directory.create(IO.build(dest,file.name));
		}else{
			var destfile = IO.build(dest,file.name),parentDir=IO.parent(destfile);
			if(!IO.directory.exists(parentDir))IO.directory.create(parentDir);
			if(file.filesize>0){
				IO.file.writeAllBytes(destfile,file.data);
			}else{
				IO.file.writeAllText(destfile,"","iso-8859-1");
			}
		}
	}
	return true;
};
var ArrayPush = Array.prototype.push;
var formatOtc = function(num, len){
	var numstr = num.toString(8)+" ", _len = numstr.length;
	len = len || 12;
	while(_len < len){
		numstr = " " + numstr;
		_len++;
	}
	return string2buffer(numstr);
};
var readstringbuffer = function(buffer, start, end){
	var buff=[],chr=0;
	for(var i=start;i<end;i++){
		chr = buffer[i];
		if(chr==0) break;
		buff.push(chr);
	}
	return buff;
};
var parseOtc = function(ary){
	ary.pop();
	var i=0;
	while(ary[i]==0x20){
		ary.shift();
	}
	return parseInt(buffer2string(ary),8);
};
function push(src , dest){
	var _len = src.length;
	for(var i=0 ;i<_len;i++){
		dest.checksum += src[i];
	}
	ArrayPush.apply(dest.data, src);
}
function set(src, start, dest){
	var _len = src.length;
	for(var i=0 ;i<_len;i++){
		dest.data[start+i] = src[i];
	}
}
var tarHeader = function(name, file, isdir) {
	if(this.constructor != tarHeader){
		return new tarHeader(name, file, isdir);
	}
	this.name = name;
	this.filesize = 0;
	this.file= file;
	this.dir = !!isdir;
	this.data = [];
	this.checksum=0;
	this.offset=0;
	this.createdate=0;
};
var total=0;
tarHeader.prototype.generate = function(filesize){
	var filename_byt = string2buffer(this.name),prefix=[], _len = filename_byt.length, createdate,Header = this.data;
	if(_len>99){
		var _index = this.name.indexOf("\\"), last=0, chrcode, counts=0;
		if(_index>0){
			for(var i=_len-1;i>=0;i--){
				if(filename_byt[i]==0x5c && i<155) {
					last = i;
					break;
				}
			}
			prefix = filename_byt.slice(0,last)
			filename_byt = filename_byt.slice(last+1);
		}else{
			filename_byt = filename_byt.slice(_len-99);
		}
	}
	while(filename_byt.length<100) filename_byt.push(0);
	push(filename_byt, this);
	if(this.dir){
		ArrayPush.apply(Header, [0x20,0x34]);
		this.checksum += 84;
		createdate = +new Date();
	}else{
		ArrayPush.apply(Header, [0x31,0x30]);
		this.checksum += 97;
		createdate = +new Date(+IO.file.get(this.file).DateLastModified);
	}
	ArrayPush.apply(Header, [0x30,0x37,0x37,0x37,0x20,0, /*mode*/ 0x20,0x20,0x20,0x20,0x20,0x30,0x20,0,0x20,0x20,0x20,0x20,0x20,0x30,0x20,0]); //uid,gid
	this.checksum += 725;
	
	var linkflag=0x35;
	if(!this.dir) {
		this.filesize = filesize;
		linkflag = 0x30;
	}
	push(formatOtc(filesize), this); //size
	push(formatOtc((createdate - createdate % 1000)/1000), this); //mtime
	
	ArrayPush.apply(Header, [0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20]); //checksum
	this.checksum += 256;
	
	Header.push(linkflag); //linkflah
	this.checksum += linkflag;
	for(var i=0;i<100;i++) Header.push(0); //linkname
	
	ArrayPush.apply(Header, [0x75,0x73,0x74,0x61,0x72,0,0x30,0x30]); //magic //version
	this.checksum += 655;
	
	for(var i=0;i<80;i++) Header.push(0); //uname, gname,devmajor, devminor
	push(prefix, this); //prefix
	for(var i=0;i<167-prefix.length;i++) Header.push(0); //prefix ending and pad
	
	set(formatOtc(this.checksum,7),148, this); //set checksum
	Header[155] = 0;
};
module.exports = $manager;
Tar = $manager;
Tar.getTotal = function(){return total;};