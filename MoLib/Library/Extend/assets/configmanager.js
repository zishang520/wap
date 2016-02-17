/*
* configmanager.js
* by anlige @ 2015-6-9
*/

function ConfigManager(src){
	if(src===undefined){
		MEM.put(0xcaae0001, "ConfigManager", "argument '1' error");
		return null;
	}
	var path = "", config = {}, instance = function(key, value){
		if(value === undefined){
			if(typeof key == "string"){
				return config[key];
			}else{
				for(var k in key){
					if(key.hasOwnProperty(k)){
						config[k] = key[k];
					}
				}
				return instance;
			}
		}
		config[key] = value;
		return instance;
	};
	if(src.length>2 && src.substr(1,1)==":") path = src;
	else path = IO.build(Mo.C("@.MO_APP"), "Conf/" + src + ".asp");
	if(IO.file.exists(path)){
		config = (new Function(IO.file.readAllScript(path)))();
	}
	instance.path = path;
	instance.config = config;
	instance.save = function(pathas){
		JSON.encodeUnicode(false);
		IO.file.writeAllText(pathas || path, "\u003cscript language=\"jscript\" runat=\"server\"\u003ereturn ({\r\n  \"__conf__\" : " + JSON.stringify(config) + "\r\n})['__conf__'];\u003c/script\u003e");
	};
	return instance;
}
module.exports = ConfigManager;