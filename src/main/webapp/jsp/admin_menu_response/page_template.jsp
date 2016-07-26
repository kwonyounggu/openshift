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
<meta name="viewport" content="width=device-width, initial-scale=1">
<META name=author content="Younggu Kwon">
<META name=email content="<%=AuthData.mycompany_email_address%>">

<link rel="SHORTCUT ICON" href="images/webmonster_logo.ico" />

<link rel="stylesheet" type="text/css" href="css/main.css" />
<link rel="stylesheet" type="text/css" href="css/waitMe.css" />
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/tooltipster/3.3.0/css/tooltipster.min.css" />

<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tooltipster/3.3.0/js/jquery.tooltipster.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>

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
		width:1000px;

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
	.showcase_rectangle 
	{
	    text-align:left;
	    padding:5px 5px 5px 5px; 
	    border:1px solid #555762;
		border-radius:0px 0px 0px 0px;
		background: #555762;
		color: white;
	}
	.hvac_rectangle 
	{
	    text-align:left;
	    padding:5px 5px 5px 5px; 
	    border:1px solid #000000;
		border-radius:0px 0px 0px 0px;
	}
	
	#menu_contents ul li
	{
	    list-style-type: disc;
	    list-style-position: inside;
	    padding: 10px 20px 5px 20px;
	    text-indent: -1em;
	}
	
</style>
</head>

<body>
<script>
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) 
  {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') 
    {
      // Logged into your app and Facebook.
      testAPI();
    } 
    else 
    {
    	if (response.status === 'not_authorized') 
	    {
	      // The person is logged into Facebook, but not your app.
	      document.getElementById('fbStatus').innerHTML = 'Please log ' + 'into this app.';
	      
	      
	    } 
	    else 
	    {
	      // The person is not logged into Facebook, so we're not sure if
	      // they are logged into this app or not.
	      document.getElementById('fbStatus').innerHTML = 'Please log ' + 'into Facebook.';
	    }
    	
    	document.getElementById('bodyDiv').style.visibility='hidden';
  	    document.getElementById('fbStatus').style.visibility='visible';
  	    document.getElementById('fbButton').style.visibility='visible';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() 
  {
    FB.getLoginStatus(function(response) 
    {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() 
  {
	  FB.init
	  ({
	    appId      : '1320010824683214',
	    cookie     : true,  // enable cookies to allow the server to access 
	                        // the session
	    xfbml      : true,  // parse social plugins on this page
	    version    : 'v2.5' // use graph api version 2.5
	  });

	  // Now that we've initialized the JavaScript SDK, we call 
	  // FB.getLoginStatus().  This function gets the state of the
	  // person visiting this page and can return one of three states to
	  // the callback you provide.  They can be:
	  //
	  // 1. Logged into your app ('connected')
	  // 2. Logged into Facebook, but not your app ('not_authorized')
	  // 3. Not logged into Facebook and can't tell if they are logged into
	  //    your app or not.
	  //
	  // These three cases are handled in the callback function.
	
	  FB.getLoginStatus(function(response) 
	  {
	    	statusChangeCallback(response);
	  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) 
  {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); 
    js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() 
  {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', 'GET', {fields: 'first_name, last_name, name, id'}, function(response) 
    {
      console.log('Successful login for: ' + response.name);
      console.log(response);
      
      if(response.id==="1073293919426764" && response.last_name==="Kwon")
      {
    	  log("success begin");
    	  document.getElementById('bodyDiv').style.visibility='visible';
    	  document.getElementById('fbStatus').style.visibility='hidden';
    	  document.getElementById('fbButton').style.visibility='hidden';
    	  log("success end");
      }
      else
      {
    	  log("not success");
    	  document.getElementById('fbStatus').innerHTML = 'Sorry! you are not allowed for this page, ' + response.name + '!';
    	  //document.getElementById('bodyDiv').style.visibility='hidden';
    	  //document.getElementById('fbDiv').style.visibility='hidden'; 
      }
    });
  }
</script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->

<div id="fbDiv">
<!-- The following statement is in the same way as in <div class="fb-login-button"> -->
<!-- https://developers.facebook.com/docs/facebook-login/web/login-button -->
    <fb:login-button scope="public_profile,email" onlogin="checkLoginState();" id="fbButton" data-auto-logout-link="true"></fb:login-button>
	<div id="fbStatus"></div>
<!-- 	<div id="fbButton" class="fb-login-button" data-max-rows="1" data-size="medium" data-show-faces="false" data-auto-logout-link="true" default_audience="only_me"></div> -->
</div>
<div id="bodyDiv" style="visibility: collapse" align="center">

	<div class="wrapper">
		
		<div class="header">
			<%@ include file="/jsp/admin_menu_response/header.jsp" %>
		</div>	
		<div class="contents">
			<div style="margin-top: .5cm; padding: 0px 20px 20px 20px">
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
</body>

</html>
						