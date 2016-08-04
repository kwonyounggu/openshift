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

 <!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header">Nav header</li>
                <li><a href="#">Separated link</a></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li class="active"><a href="./">Fixed top <span class="sr-only">(current)</span></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>


<div style="padding-top: 25px; color: #ffff00;">
	<a href="http://www.webmonster.ca"><img src="images/wm_logo.png" width="250" height="26" alt="WM_LOGO" border="0"/></a>
	<h4>Freelance App Developer</h4>
</div>
