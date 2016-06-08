<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>	

<%@ page import="com.common.*" %>

<%@ page import="java.util.*" %>
<style>
	li
	{
		font-size: 200%;
	}
</style>
<div style="padding-top: 4px; color: #ffff00;">
	<h2>Freelance App Developer</h2>
	<h4>
		<a href="mailto:<%=AuthData.mycompany_email_address%>?Subject=Hello John KWON" style="color:inherit;text-decoration: none" target="_top">John KWON</a>
	</h4>
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
<!--       <a class="navbar-brand" href="http://www.webmonster.ca">WebMonster</a> -->
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="<%= MenuLink.home %>" onfocus="this.blur()">Home</a></li>							
		<li><a href="<%= MenuLink.menu_public_showcase %>" onfocus="this.blur()">Showcase</a></li>
		<li><a href="<%= MenuLink.menu_public_contact %>" onfocus="this.blur()">Contact/Estimate</a></li>		
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-user"></span></a>
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
 