<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>	

<%@ page import="com.common.*" %>

<%@ page import="java.util.*" %>

<script type="text/javascript">
     $(document).ready(function () {

        $("#jqxMenu").jqxMenu({ width: 'auto', height: '30px', autoOpen: false, autoCloseOnMouseLeave: false, showTopLevelArrows: true, 
        						theme: 'metro'
        					  });
        $("#jqxMenu").css('visibility', 'visible');               
    }); 
</script>

<div id="jqxMenu" style="visibility: hidden; margin-left: 0px;">
	<ul>
	    <li><a href="<%= MenuLink.home %>" onfocus="this.blur()">Home</a></li>							
		<li><a href="<%= MenuLink.menu_public_showcase %>" onfocus="this.blur()">Showcase</a></li>
		<li><a href="<%= MenuLink.menu_public_contact %>" onfocus="this.blur()">Contact</a></li>
		<li style='list-style: none; width: 53.666%;' ignoretheme='true'></li>
		<li><a href="<%= MenuLink.menu_public_stockcharts %>" onfocus="this.blur()">Stock-Charts</a></li>
		<li><a href="<%= MenuLink.menu_public_hvac %>" onfocus="this.blur()">냉난방</a></li>
		<li><a href="<%= MenuLink.menu_public_saxophone %>" onfocus="this.blur()">색소폰</a></li>
	</ul>
	
</div>