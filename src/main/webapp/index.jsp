<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>webmonster.ca redirect</title>
<script src="//cdn.jsdelivr.net/mobile-detect.js/1.3.2/mobile-detect.min.js"></script>
<script>
	var md = new MobileDetect(window.navigator.userAgent);
	if(md.mobile())
	{	
		console.log("It's mobile ---1");
		if(md.phone())
		{
			console.log("It's phone --- 2");
			if(md.is('iPhone')) console.log("--- 2 - 1");
			else if(md.is('bot')) console.log("--- 2 - 2");
			console.log("os 2-3: "+md.os());
		}
		else if(md.tablet())
		{
			console.log("It's tablet --- 3 ");
			console.log("os 3-1: "+md.os());
		}
		console.log("os 4-1: "+md.os());
	}
	console.log(md.mobile);
	console.log("window.location.hostname: "+window.location.hostname);
	console.log("window.location.href: "+window.location.href);
	window.location.href = "http://www.webmonster.ca/controller?op=menu_public_showcase";
</script>
</head>
<body>
	Please wait while redirecting to www.webmonster.ca from webmonster-younggu.rhcloud.com
</body>
</html>