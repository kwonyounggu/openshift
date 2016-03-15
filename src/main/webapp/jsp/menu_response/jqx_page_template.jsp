<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page isELIgnored ="false" %>
<!doctype html>
<html>
<head>
<title>${app_symbol}</title>
<META name=author content="Younggu Kwon">
<META name=department content="CCM at the Hospital for Sick Children in Toronto">
<META name=email content="younggu.kwon@sickkids.ca">

<link rel="SHORTCUT ICON" href="ico/favicon.ico" />


<link rel="stylesheet" type="text/css" href="css/menu/ddsmoothmenu.css" /> 
<link rel="stylesheet" href="css/dhtmlwindow.css" type="text/css" />

<link rel="stylesheet" type="text/css" href="css/csr.css" />

<!-- about calendar program -->
<link rel="stylesheet" type="text/css" href="js/epoch_v202_en/epoch_styles.css" /> 
<script type="text/javascript" src="js/epoch_v202_en/epoch_classes.js"></script> 

<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="https://jqwidgets.com/jquery-widgets-demo/jqwidgets/jqx-all.js"></script>
<link rel="stylesheet" type="text/css" href="https://jqwidgets.com/jquery-widgets-demo/jqwidgets/styles/jqx.base.css" />    
<link rel="stylesheet" type="text/css" href="https://jqwidgets.com/jquery-widgets-demo/jqwidgets/styles/jqx.fresh.css" />    
<link rel="stylesheet" type="text/css" href="https://jqwidgets.com/jquery-widgets-demo/jqwidgets/styles/jqx.energyblue.css" />    

<script type="text/javascript" src="js/swfobject.js"></script>
<script type="text/javascript" src="js/validation.js" ></script>
<script type="text/javascript" src="js/httpRequest.js" ></script>
<script type="text/javascript" src="js/common.js" ></script>

<script type="text/javascript" src="js/menu/ddsmoothmenu.js"></script>

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
		alert("ERROR: your browser is not supporting HTML5!!!\n\nPlease upgrade your browser with recent version.\n\nOtherwise it won't work properly!!!");
	}
</script>

<style>
	body
	{
		bgcolor: "#818493";
		leftmargin: "0";
		topmargin: "0";
		marginheight: "0";
		marginwidth: "0";
	}
	.wrapper
	{
		
		margin-top:5px;
		width:1024px;

	}
	.header 
	{
		
	}
	
	.contents
	{
		background-color:#ffffff;
		border: 1px solid #e9e9ea;
		width: 100%;
		height: 100%;
		margin-top: 5px;
	}
	.footer 
	{
		margin-top: 5px;
		margin-bottom: 5px;
	    color:#8a8a8a;
	    clear:both;
	    text-align:center;
	    padding:5px 5px 5px 5px; 
	    border:1px solid #000000;
	    box-shadow: 10px 10px 5px #888888;
		background:#353743;
		width: 100%;
		height:100%;
		border-radius:0 0 15px 15px;

	}
	ul li
	{
	    list-style-type: disc;
	    list-style-position: inside;
	    padding: 10px 20px 5px 20px;
	    text-indent: -1em;
	}
</style>
</head>

<body>

<div align="center">

	<div class="wrapper">
		
		<div class="header">
			<%@ include file="/jsp/menu_response/jqx_header.jsp" %>
		</div>	
		<div class="contents">
			<jsp:include page='${body_panel}' flush='true'/>			
		</div>
		<div class="footer">
			<div>555 University Avenue, Toronto, Ontario, Canada M1S5C2</div>
			<div>Copyright &copy; 2016 WebMonster Technology Ltd. All Rights Reserved</div>
			<div>Registered in Toronto, Ontario, Canada</div>
		</div>
	</div>
</div>	
</body>

</html>
						