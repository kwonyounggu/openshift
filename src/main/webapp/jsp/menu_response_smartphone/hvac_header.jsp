<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>	

<%@ page import="com.common.*" %>

<%@ page import="java.util.*" %>
<style>
	nav ul li
	{
	    font-size: 260%;
	}
	
	.navbar-fixed-side-left {
	  left: 0;
	}
	.navbar-fixed-side-right {
	  right: 0;
	}
	.navbar-fixed-side {
	  position: fixed;
	  border-width: 0;
	  z-index: 1030;
	  min-height: 5px;
	  min-width: 5px;
	  max-width: 200px;
	  margin-bottom: 0;
	  border: 0px solid transparent;
	}
	.navbar-fixed-side .navbar-toggle {
	  float: none;
	  margin: 0;
	}
	.navbar-fixed-side .nav > li > a {
	  width: 100%;
	  padding: 5px;
	}
	.navbar-fixed-side .dropdown-menu > li > a {
	  padding: 5px;
	}
	.navbar-fixed-side .dropdown-header {
	  padding: 5px;
	}
	.navbar-fixed-side .navbar-nav {
	  margin: 0;
	}
	.navbar-fixed-side .navbar-nav > li {
	  float: none;
	}
	.navbar-fixed-side .navbar-nav > li > a {
	  padding: 5px;
	  line-height: 20px;
	}
	.navbar-fixed-side .navbar-nav .open .dropdown-menu > li > a,
	.navbar-fixed-side .navbar-nav .open .dropdown-menu .dropdown-header {
	  padding: 3px 5px 3px 15px;
	}
	.navbar-fixed-side .container {
	  width: 100%;
	  padding: 0;
	}
	.navbar-fixed-side .navbar-header {
	  float: none;
	  margin: 0;
	}
	.navbar-fixed-side .navbar-collapse {
	  padding: 0 2px;
	}
	.navbar-fixed-side .container .navbar-collapse {
	  margin: 0;
	}
	.navbar-fixed-side .container .navbar-brand {
	  margin: 0;
	}
	.navbar-fixed-side .navbar-brand {
	  float: none;
	  height: 100%;
	  padding: 5px 3px;
	  font-size: 18px;
	  line-height: 20px;
	}
</style>

<script type="text/javascript">
//http://stackoverflow.com/questions/901115/how-can-i-get-query-string-values-in-javascript
function getParameterByName(name, url) 
{
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
$(document).ready(function ()
{
	/*
	var op=getParameterByName('op');
	log("op="+op);
	switch(op)
	{
		case "menu_public_showcase":
			$('a[href="/smartphoneController?op=menu_public_showcase"]').closest('li').addClass('active');
			break;
		case "menu_public_contact":
			$('a[href="/smartphoneController?op=menu_public_contact"]').closest('li').addClass('active');
			break;
		case "menu_public_stockcharts":
			$('a[href="/smartphoneController?op=menu_public_stockcharts"]').closest('li').addClass('active');
			break;
		case "menu_public_hvac":
			$('a[href="/smartphoneController?op=menu_public_hvac"]').closest('li').addClass('active');
			break;
		case "menu_public_saxophone":
			$('a[href="/smartphoneController?op=menu_public_saxophone"]').closest('li').addClass('active');
			break;
		default:
			$('a[href="/smartphoneController"]').closest('li').addClass('active');
			break;	
	}
	*/
});


/* Useful when header remains without reloading
$(".nav a").on("click", function(){
	   $(".nav").find(".active").removeClass("active");
	   $(this).parent().addClass("active");
	});
*/

</script>
<!-- <div style="padding-top: 25px; color: #ffff00;">
	<a href="<%= MenuLink.phone_home %>" onfocus="this.blur()"><img src="images/wm_logo.png" width="250" height="26" alt="WM_LOGO" border="0"/></a>
	<h4>HVAC in North America</h4>
</div> -->

<div style="padding-top: 25px; color: #ffff00;">
	<a href="http://www.webmonster.ca"><img src="images/wm_logo.png" width="250" height="26" alt="WM_LOGO" border="0"/></a>
	<h4>Freelance App Developer</h4>
</div>
<!-- see http://www.w3schools.com/bootstrap/bootstrap_navbar.asp -->
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
<!-- 	  <a class="navbar-brand" href="http://www.webmonster.ca"><img src="images/wm_logo.png" width="150" height="26" alt="WM_LOGO" border="0"/></a> -->
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="<%= MenuLink.phone_home %>" onfocus="this.blur()">System Manuals</a></li>							
		<li><a href="<%= MenuLink.phone_menu_public_showcase %>" onfocus="this.blur()">Q&A Forum</a></li>
		<li><a href="<%= MenuLink.phone_menu_public_contact %>" onfocus="this.blur()">Blog</a></li>	
		<li><a href="<%= MenuLink.phone_home %>" onfocus="this.blur()">Estimates</a></li>							
		<li><a href="<%= MenuLink.phone_menu_public_showcase %>" onfocus="this.blur()">Contractors</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">

			<li><a href="<%= MenuLink.phone_menu_public_hvac %>" onfocus="this.blur()">Buy & Sell</a></li>
			<li><a href="<%= MenuLink.phone_menu_public_saxophone %>" onfocus="this.blur()">Jobs</a></li>
        
      </ul>
    </div>
  </div>
</nav>

 