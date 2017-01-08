<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.common.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page isELIgnored ="false" %>
<!doctype html>
<html>
<head>
<!-- Order: meta, script, base, link, title -->
<!-- validation: see http://validator.w3.org/ -->
<!-- Google has explicitly told us they are not great ideas (such as redirects at the page level). -->

<!-- <META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW"> -->
<!-- This means: “Do not Index this page. Do not follow the links on the page.” Your page will drop OUT of the search index AND your links to other pages 
     will not be followed. This will break the link path on your site from this page to other pages.
	 This tag is most often used when a site is in development. A developer will noindex/nofollow the pages of the site to keep them from being picked up 
	 by the search engines, then forget to remove the tag. When launching your new website, do not trust it has been removed. DOUBLE CHECK! 
-->

<!-- <META NAME="ROBOTS" CONTENT="INDEX, NOFOLLOW"> -->
<!-- This means: “Do Index this page. Do not follow the links on the page.” Your page WILL be in the index AND your links to other pages will not be followed. 
     This will break the link path on your site from this page to other pages.
-->

<!-- <META NAME="ROBOTS" CONTENT="NOINDEX, FOLLOW"> -->
<!-- This means: “Do not Index this page. Do follow the links on the page.” Your page will drop OUT of the index BUT your links to other pages will be followed. 
     This will NOT break the link path on your site from this page to other pages.
-->

<!-- <META NAME="ROBOTS" CONTENT="INDEX, FOLLOW"> -->
<!-- This means: “Do Index this page. Do follow the links on the page.” This means your page WILL be in the index AND your links to other pages will be followed. 
	 This will NOT break the link path on your site from this page to other pages.K! 
-->

<!-- Note: The robots tag may be ignored by less scrupulous spiders -->
<title>${title}</title>

<!-- Finally, all sites must validate charset. In the U.S., that is the UTF-8 tag. Just make sure this is on your page if you’re delivering HTML using English characters. -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<META name="author" content="Younggu Kwon">
<META name="generator" content="<%=AuthData.mycompany_email_address%>">

<!-- Description tells the search engine what your page or site is about -->
<!-- It is a description below the web url after google search, see example in https://searchenginewatch.com/sew/how-to/2067564/how-to-use-html-meta-tags -->
<!-- Use single quotes if needed -->
<meta name="description" content="${description}"><!-- upto 155 characters (including spaces) -->

<!-- Keywords -->
<!-- The only search engine that looks at the keywords anymore is Microsoft’s Bing – and they use it to help detect spam. To avoid hurting your site,
     your best option is to never add this tag. Or, if that’s too radical for you to stomach, at least make sure you haven’t stuffed 300 keywords in 
     the hopes of higher search rankings. It won’t work. Sorry.
	 If you already have keyword meta tags on your website, but they aren’t spammy, there’s no reason to spend the next week hurriedly taking them out. 
	 It’s OK to leave them for now – just take them out as you’re able, to reduce page weight and load time 
-->
<meta name="keywords" content="${keywords}">
<!-- base tag: see http://www.w3schools.com/tags/tryit.asp?filename=tryhtml_base_test -->
<link rel="icon" href="images/webmonster_logo.ico" /><!-- 16x16 pixels -->

<link rel="stylesheet" type="text/css" href="css/main.css" />
<link rel="stylesheet" type="text/css" href="css/waitMe.css" />
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/tooltipster/3.3.0/css/tooltipster.min.css" />
<!-- <link rel="stylesheet" type="text/css" href="css/jayhilwigTree.css" /> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />


<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tooltipster/3.3.0/js/jquery.tooltipster.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-3-typeahead/4.0.1/bootstrap3-typeahead.min.js"></script>

<script type="text/javascript" src="js/waitMe.js" ></script>
<script type="text/javascript" src="js/swfobject.js"></script>
<script type="text/javascript" src="js/validation.js" ></script>

<script type="text/javascript" src="js/common.js" ></script>

<script type="text/javascript" src="js/utils.js"></script>


<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-46029072-2', 'auto');
  ga('send', 'pageview');

</script>
<script language="Javascript" type="text/javascript">
	if (!isCanvasSupported())
	{
		log("ERROR: your browser does not support HTML5!!!\n\nPlease upgrade your browser with the latest version.\n\nOtherwise it won't work properly!!!");
	}
</script>

<style>
	body
	{
		background-color: #818493;
		leftmargin: 0;
		topmargin: 0;
		marginheight: 0;
		marginwidth: 0;
		
		font-family: verdana;
	}
	.wrapper
	{
		
		margin-top:2px;
		width:1100px;

	}
	.header 
	{
		width: 100%;
		height: 100%;
	}
	
	.contents
	{
		background-color:#ffffff;
		border: 1px solid #e9e9ea;
		height: 100%;
		margin-top: -15px;
	}
	.footer 
	{
		margin-top: 4px;
		margin-bottom: 5px;
	    color:#8a8a8a;
	    clear:both;
	    text-align:center;
	    padding:5px 5px 5px 5px; 
	    border:1px solid #000000;
	    box-shadow: 10px 10px 5px #888888;
		background:#353743;
		height:100%;
		border-radius:0px 0px 0px 0px;
		font-size: 11px;
	}
	#menu_contents ul li
	{
	    list-style-type: disc;
	    list-style-position: inside;
	    padding: 10px 20px 5px 20px;
	    text-indent: -1em;
	}
	.showcase_rectangle 
	{
	    text-align:left;
	    padding:5px 5px 5px 5px; 
	    border:1px solid #555762;
		border-radius:5px 5px 0px 0px;
		background: #555762;
		color: white;
	}
	.hvac_rectangle 
	{
	    text-align:left;
	    padding:5px 5px 5px 10px; 
	    border:1px solid #555762;
		border-radius:5px 5px 0px 0px;
		background: #555762;
		color: white;
	}
	
	
</style>
</head>

<body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v2.7&appId=1320010824683214";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>
<div align="center">

	<div class="wrapper">
		
		<div class="header">
			<%@ include file="/jsp/menu_response/header.jsp" %>
		</div>	
		<div class="contents">
			<div style="margin-top: .5cm; padding-bottom: 20px">
				<jsp:include page='${body_panel}' flush='true'/>	
			</div>		
		</div>
		<div class="footer">
			<div>555 University Avenue, Toronto, Ontario, Canada M1S5C2</div>
			<div>Copyright &copy; 2016 WebMonster Technology Ltd. All Rights Reserved</div>
			<div>Registered in Toronto, Ontario, Canada</div>
		</div>
	</div>
</div>	
<script id="dsq-count-scr" src="//webmonster-ca.disqus.com/count.js" async></script>
</body>

</html>
						