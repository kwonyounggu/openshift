<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>	
<%@ page import="com.common.*" %>

<%@ page import="java.util.*" %>
<style>
<!--
	#header_nav a
	{
	    font-size: 16px !important;
	}
	/*
	.navbar .navbar-nav 
	{
    	display: inline-block;
    	float: none;
	}

	.navbar .navbar-collapse 
	{
    	text-align: left;
	}
	*/
-->
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
	var op=getParameterByName('op');
	log("op="+op);
	switch(op)
	{
		case "menu_public_showcase":
			$('a[href="/controller?op=menu_public_showcase"]').closest('li').addClass('active');
			break;
		case "menu_public_contact":
			$('a[href="/controller?op=menu_public_contact"]').closest('li').addClass('active');
			break;
		case "menu_public_stockcharts":
			$('a[href="/controller?op=menu_public_stockcharts"]').closest('li').addClass('active');
			break;
		case "menu_public_hvac":
			$('a[href="/controller?op=menu_public_hvac"]').closest('li').addClass('active');
			break;
		case "menu_public_saxophone":
			$('a[href="/controller?op=menu_public_saxophone"]').closest('li').addClass('active');
			break;
		default:
			$('a[href="/controller"]').closest('li').addClass('active');
			break;	
	}
});

</script>

<!-- see http://www.w3schools.com/bootstrap/bootstrap_navbar.asp -->

<nav class="navbar navbar-inverse" style="border-radius: 0px;" id="header_nav">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="http://www.webmonster.ca"><img src="images/wm_logo.png" width="150" height="26" alt="WM_LOGO" border="0"/></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="<%= MenuLink.pc_home %>" onfocus="this.blur()">Home</a></li>							
		<li><a href="<%= MenuLink.pc_menu_public_showcase %>" onfocus="this.blur()">Showcase</a></li>
		<li><a href="<%= MenuLink.pc_menu_public_contact %>" onfocus="this.blur()">Contact/Estimate</a></li>		
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-th"></span></a>
          <ul class="dropdown-menu">
            <li><a href="<%= MenuLink.pc_menu_public_stockcharts %>" onfocus="this.blur()">Stock-Charts</a></li>
			<li><a href="<%= MenuLink.pc_menu_public_hvac %>" onfocus="this.blur()">HVAC</a></li>
			<li><a href="<%= MenuLink.pc_menu_public_saxophone %>" onfocus="this.blur()">Saxophone</a></li>
          </ul>
        </li>
        
      </ul>
    </div>
  </div>
</nav>
