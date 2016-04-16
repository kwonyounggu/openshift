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
		<li><a href="#">Showcase</a></li>
		<li><a href="#">Contact</a></li>
		<li style='list-style: none; width: 16.666%; '  ignoretheme='true'></li>
		<li><a href="#">HVAC</a></li>
		<li><a href="#">Saxophone</a></li>
	</ul>
	
</div>