﻿/*
** File: session.js
** Usage: use session at some special situation
** About: 
**		support@mae.im
*/
module.exports = (function(driver){
	var $session=function(key,value)
	{
		if(value===undefined)
		{
			return driver.readSession($session.id, key);
		}
		driver.writeSession($session.id, key, value);
	};
	var newid = function(){return F.random.word(20);};
	$session.setTimeout = function(timeout)
	{
		driver.setTimeout($session.id, timeout);
		$session.timeout = timeout;
	};
	$session.timeout = 1200;
	$session.id = driver.getSessionid();
	if($session.id == "")
	{
		$session.id = newid();
	}
	else
	{
		var timeout = driver.getTimeout($session.id);
		if(typeof timeout=="number") $session.timeout = timeout;
		var time_start = driver.getStartTimeSpan($session.id);
		if(typeof time_start == "number")
		{
			if(F.timespan() - time_start >$session.timeout){
				driver.clearSession($session.id);
				$session.id = newid();
			}
		}
		else
		{
			$session.id = newid();
		}
	}
	driver.setStartTimeSpan($session.id, F.timespan());
	var badsession = driver.checkSession();
	while(badsession.length>0){
		driver.clearSession(badsession.pop());
	}
	return $session;
})((function(){
	/*session driver, you can use your own driver, such as IO, Database and so on...*/
	var driver = {};
	driver.writeSession = function(sessionid, key, value)
	{
		Application.Lock();
		Application(sessionid + ":" + key) = value;
		Application.UnLock();
	};

	driver.readSession = function(sessionid, key)
	{
		return Application(sessionid + ":" + key);
	};

	driver.checkSession = function()
	{
		var lists=[];
		F.each(Application.Contents, function(q) {
			if(F.string.endsWith(q,".timeout"))
			{
				var sessionid = q.substr(0,q.indexOf(".timeout"));
				if(F.timespan() - Application(sessionid) > Application(q)){
					lists.push(q);
				}
			}
		});
		return lists;
	};

	driver.clearSession = function(sessionid)
	{
		var lists=[];
		F.each(Application.Contents, function(q) {
			var l = q.substr(0,sessionid.length+1);
			if(q.length > sessionid.length+1 && (l == (sessionid + ":") || l == (sessionid + ".")))
			{
				lists.push(q);
			}
		});
		while(lists.length>0)
		{
			Application.Contents.Remove(lists.pop());
		}
		Application.Contents.Remove(sessionid);
	};
	
	driver.setTimeout = function(sessionid,timeout)
	{
		Application.Lock();
		Application(sessionid + ".timeout") = timeout;
		Application.UnLock();
	};
	
	driver.getTimeout = function(sessionid)
	{
		return Application(sessionid + ".timeout");
	};
	
	driver.getStartTimeSpan = function(sessionid)
	{
		return Application(sessionid);
	};
	
	driver.setStartTimeSpan = function(sessionid,timespan)
	{
		Application.Lock();
		Application(sessionid) = timespan;
		Application.UnLock();
	};
	
	driver.getSessionid = function()
	{
		return F.get("sessionid");
	};
	return driver;	
})());
