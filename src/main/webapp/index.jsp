<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>webmonster.ca redirect</title>
<script src="//cdn.jsdelivr.net/mobile-detect.js/1.3.2/mobile-detect.min.js"></script>
<script>
//http://webmonster-younggu.rhcloud.com/favicon.ico 404 (Not Found)
	var md = new MobileDetect(window.navigator.userAgent);
	if(md.mobile())
	{	
		if(md.phone())
		{
			console.log("The browser is calling from a phone");
			window.location.href = "http://www.webmonster.ca/smartphoneController";
		}
		else if(md.tablet())
		{
			console.log("The browser is calling from a tablet");
			window.location.href = "http://www.webmonster.ca/tabletController";
		}
		else
		{
			console.log("The browser is calling from an unknown device");
			window.location.href = "http://www.webmonster.ca/tabletController";
		}
	}
	else
	{
		//pc, linux, unix, other version
		if(md.os()==='webOS') //LG-TV
		{
			console.log("The browser is calling from the webOS");
			window.location.href = "http://www.webmonster.ca/controller";
		}
		else
		{
			console.log("The browser is calling from the desk-top such as Windows, Linux, UNIX, etc");
			window.location.href = "http://www.webmonster.ca/controller";
		}
	}	
	console.log("window.location.hostname: "+window.location.hostname);
	console.log("window.location.href: "+window.location.href);
</script>
</head>
<body>
	Please wait while redirecting to smartphoneController, tabletController or controller servlet
</body>
</html>