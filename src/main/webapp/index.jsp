<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>webmonster.ca redirect</title>
<script src="//cdn.jsdelivr.net/mobile-detect.js/1.3.2/mobile-detect.min.js"></script>
<script>
	var md = new MobileDetect(window.navigator.userAgent);
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