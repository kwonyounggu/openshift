<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>	

<%@ page import="com.common.*" %>

<%@ page import="java.util.*" %>
<style>
	nav ul li
	{
	    font-size: 260%;
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
	
	var op=getParameterByName('op');
	log("op="+op);
	switch(op)
	{
		case "phone_menu_hvac_system_manuals":
			$('#selectedItem').html("<b>System Manuals</b>");
			break;
		case "phone_menu_hvac_qa_forum":
			$('#selectedItem').html("<b>System Manuals</b>");
			break;
		case "phone_menu_hvac_blog":
			$('#selectedItem').html("<b>System Manuals</b>");
			break;
		case "phone_menu_hvac_estimates":
			$('#selectedItem').html("<b>System Manuals</b>");
			break;
		case "phone_menu_hvac_contractors":
			$('#selectedItem').html("<b>System Manuals</b>");
			break;
		case "phone_menu_hvac_buysell":
			$('#selectedItem').html("<b>System Manuals</b>");
			break;
		case "phone_menu_hvac_jobs":
			$('#selectedItem').html("<b>System Manuals</b>");
			break;
		default:
			$('#selectedItem').html("<b>Unknown</b>");
			break;	
	}
	
});


/* Useful when header remains without reloading
$(".nav a").on("click", function(){
	   $(".nav").find(".active").removeClass("active");
	   $(this).parent().addClass("active");
	});
*/

</script>

<!-- see http://www.w3schools.com/bootstrap/bootstrap_navbar.asp -->
<nav class="navbar navbar-inverse">
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
      	<li><span id="selectedItem" style="color: #f1f1f1">System Manuals</span><span style="color: #f4f4f4; font-size: 28px"> on HVAC in North America</span></li>	
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-menu-hamburger"></span></a>
          <ul class="dropdown-menu">
            <li><a href="<%= MenuLink.phone_menu_hvac_system_manuals %>" onfocus="this.blur()">System Manuals</a></li>
			<li><a href="<%= MenuLink.phone_menu_hvac_qa_forum %>" onfocus="this.blur()">Q&A Forum</a></li>
			<li><a href="<%= MenuLink.phone_menu_hvac_blog %>" onfocus="this.blur()">Blog</a></li>
			<li><a href="<%= MenuLink.phone_menu_hvac_estimates %>" onfocus="this.blur()">Estimates</a></li>
			<li><a href="<%= MenuLink.phone_menu_hvac_contractors %>" onfocus="this.blur()">Contractors</a></li>
			<li role="separator" class="divider"></li>
			<li><a href="<%= MenuLink.phone_menu_hvac_buysell %>" onfocus="this.blur()">Buy&Sell</a></li>
			<li><a href="<%= MenuLink.phone_menu_hvac_jobs %>" onfocus="this.blur()">Jobs</a></li>
          </ul>
        </li>
        
      </ul>
    </div>
  </div>
</nav>