<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>	

<%@ page import="com.common.*" %>

<%@ page import="java.util.*" %>
<style>
	nav ul li
	{
	    /*font-size: 260%;*/
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
		case "menu_public_showcase":
			$('a[href="/smartphoneController?op=menu_public_showcase"]').closest('li').addClass('active');
			$('#currentMenu').html("Showcase");
			break;
		case "menu_public_contact":
			$('a[href="/smartphoneController?op=menu_public_contact"]').closest('li').addClass('active');
			$('#currentMenu').html("Contact/Estimate");
			break;
		case "menu_public_stockcharts":
			$('a[href="/smartphoneController?op=menu_public_stockcharts"]').closest('li').addClass('active');
			$('#currentMenu').html("Stockcharts");
			break;
		case "menu_public_hvac":
			$('a[href="/smartphoneController?op=menu_public_hvac"]').closest('li').addClass('active');
			break;
			
			case "phone_menu_hvac_system_manuals":
				$('#currentMenu').html("HVAC->Manuals");
				break;
			case "phone_menu_hvac_qa_forum":
				$('#currentMenu').html("HVAC->Forum");
				break;
			case "phone_menu_hvac_blog":
				$('#currentMenu').html("HVAC->Blog");
				break;
			case "phone_menu_hvac_estimates":
				$('#currentMenu').html("HVAC->Estimates");
				break;
			case "phone_menu_hvac_contractors":
				$('#currentMenu').html("HVAC->Contractors");
				break;
			case "phone_menu_hvac_buysell":
				$('#currentMenu').html("HVAC->Buy&Sell");
				break;
			case "phone_menu_hvac_jobs":
				$('#currentMenu').html("HVAC->Jobs");
				break;
			
			
		case "menu_public_saxophone":
			$('a[href="/smartphoneController?op=menu_public_saxophone"]').closest('li').addClass('active');
			$('#currentMenu').html("Saxophone");
			break;
	
		default:
			$('a[href="/smartphoneController"]').closest('li').addClass('active');
			$('#currentMenu').html("Home");
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

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
	<a class="navbar-brand" href="http://www.webmonster.ca"><span style='color: #ffda48'>W</span><span style='color: #ffda48; font-size: 50%'>eb</span><span style='color: #bad5fe'>M</span><span style='color: #bad5fe; font-size: 50%'>onster</span><span id="currentMenu" style="padding-left: 10px; font-weight: bold; color: white">Home</span></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="<%= MenuLink.phone_home %>" onfocus="this.blur()">Home</a></li>							
		<li><a href="<%= MenuLink.phone_menu_public_showcase %>" onfocus="this.blur()">Showcase</a></li>
		<li><a href="<%= MenuLink.phone_menu_public_contact %>" onfocus="this.blur()">Contact/Estimate</a></li>	
		
		<li><a href="<%= MenuLink.phone_menu_public_stockcharts %>" onfocus="this.blur()">Stock-Charts</a></li>
		<li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="<%= MenuLink.phone_menu_public_hvac %>">HVAC
	        <span class="caret"></span></a>
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
		
		
<%-- 		<li><a href="<%= MenuLink.phone_menu_public_hvac %>" onfocus="this.blur()">HVAC</a></li> --%>
		<li><a href="<%= MenuLink.phone_menu_public_saxophone %>" onfocus="this.blur()">Saxophone</a></li>	
      </ul>
    </div>
  </div>
</nav>
 