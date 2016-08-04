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
<div style="padding-top: 25px; color: #ffff00;">
	<a href="<%= MenuLink.phone_home %>" onfocus="this.blur()"><img src="images/wm_logo.png" width="250" height="26" alt="WM_LOGO" border="0"/></a>
	<h4>HVAC in North America</h4>
</div>

<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">HVAC in North America </a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">System Manuals</a></li>
        <li><a href="#about">Q&A Forum</a></li>
        <li><a href="#contact">Blog</a></li>
        <li><a href="#contact">Estimates</a></li>
        <li><a href="#contact">Contractors</a></li>
        <li><a href="#contact">Jobs</a></li>
        <li><a href="#contact">Buy & Sell</a></li>

    </div><!--/.nav-collapse -->
  </div>
</nav>

 