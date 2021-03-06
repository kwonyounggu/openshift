<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.common.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page isELIgnored ="false" %>
<!doctype html>
<html>
<head>
<title>WebMonster</title>
<meta charset="utf-8">
<META name=author content="Younggu Kwon">
<META name=email content="<%=AuthData.mycompany_email_address%>">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="SHORTCUT ICON" href="images/webmonster_logo.ico" />

<link rel="stylesheet" type="text/css" href="css/main.css" />
<link rel="stylesheet" type="text/css" href="css/waitMe.css" />
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/tooltipster/3.3.0/css/tooltipster.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />


<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tooltipster/3.3.0/js/jquery.tooltipster.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-3-typeahead/4.0.1/bootstrap3-typeahead.min.js"></script>


<script type="text/javascript" src="js/waitMe.js" ></script>
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
		
		font-family: verdana;
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
		width: 100%;
		margin-top: 55px;
	}
	
	.footer 
	{
		margin-top: 2px;
		margin-bottom: 5px;
	    color:#8a8a8a;
	    clear:both;
	    text-align:center;
	    padding:5px 5px 5px 5px; 
	    border:1px solid #000000;
	    box-shadow: 10px 10px 5px #888888;
		background:#353743;
		height:auto;
		width: 100%;
		border-radius:0 0 0px 0px;
		font-size: 70%;
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
	
	#contents ul li
	{
	    /*list-style-type: disc;*/
	    list-style-position: inside;
	    padding: 0px 0px 0px 0px;
	    text-indent: -1em;
	    margin-left: -15px;
	}
	#resume_div ul li
	{
		
	}
</style>
</head>

<body>

<div>
	<div class="header">
		<jsp:include page='${header_panel}' flush='true'/>
	</div>	
	<div class="contents">	
		<div style="padding: 5px 5px 5px 5px">
			<jsp:include page='${body_panel}' flush='true'/>	
		</div>		
	</div>
	<div class="footer">
		<div>555 University Avenue, Toronto, Ontario, Canada M1S5C2</div>
		<div>Copyright &copy; 2016 WebMonster Technology Ltd. All Rights Reserved</div>
		<div>Registered in Toronto, Ontario, Canada</div>
	</div>
</div>

<script id="dsq-count-scr" src="//webmonster-ca.disqus.com/count.js" async></script>
</body>

</html>
						