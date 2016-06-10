<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>	
<%@ page import="com.common.*" %>

<%@ page import="java.util.*" %>
<style>
<!--
	.nav a
	{
	    font-size: 16px !important;
	}
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
			$('a[href="?op=menu_public_showcase"]').closest('li').addClass('active');
			break;
		case "menu_public_contact":
			$('a[href="?op=menu_public_contact"]').closest('li').addClass('active');
			break;
		case "menu_public_stockcharts":
			$('a[href="?op=menu_public_stockcharts"]').closest('li').addClass('active');
			break;
		case "menu_public_hvac":
			$('a[href="?op=menu_public_hvac"]').closest('li').addClass('active');
			break;
		case "menu_public_saxophone":
			$('a[href="?op=menu_public_saxophone"]').closest('li').addClass('active');
			break;
		default:
			$('a[href="/"]').closest('li').addClass('active');
			break;	
	}
});

</script>

<!-- see http://www.w3schools.com/bootstrap/bootstrap_navbar.asp -->
<nav class="navbar navbar-inverse navbar-fixed-top">
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
        <li><a href="<%= MenuLink.home %>" onfocus="this.blur()">Home</a></li>							
		<li><a href="<%= MenuLink.menu_public_showcase %>" onfocus="this.blur()">Showcase</a></li>
		<li><a href="<%= MenuLink.menu_public_contact %>" onfocus="this.blur()">Contact/Estimate</a></li>		
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-menu-hamburger"></span></a>
          <ul class="dropdown-menu">
            <li><a href="<%= MenuLink.menu_public_stockcharts %>" onfocus="this.blur()">Stock-Charts</a></li>
			<li><a href="<%= MenuLink.menu_public_hvac %>" onfocus="this.blur()">HVAC</a></li>
			<li><a href="<%= MenuLink.menu_public_saxophone %>" onfocus="this.blur()">Saxophone</a></li>
          </ul>
        </li>
        
      </ul>
    </div>
  </div>
</nav>

<!-- 
<div style="width:100%;height:80px;position:relative;">
	<div style="position:absolute; z-index:1;width:100%;">
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="1024" height="80">
		<param name="movie" value="header.swf" />
		<param name="quality" value="high" />
		<param name="wmode" value="transparent">
		<embed src="/swf/header.swf" quality="high" type="application/x-shockwave-flash" width="100%" height="80" wmode="transparent" pluginspage="http://www.macromedia.com/go/getflashplayer" />
		</object>
	</div>
	<div style="position:relative; z-index:2;width:100%; padding-top: 12px;">
		<div><font size="4" color="#ffda48">Freelance App Developer</font><br/><font size="2" color="#bad5fe"><a href="mailto:<%=AuthData.mycompany_email_address%>?Subject=Hello John KWON" style="color:inherit;text-decoration: none" target="_top">John KWON</a></font></div>
	</div>
</div>		
 -->