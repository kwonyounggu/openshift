<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>	

<%@ page import="com.common.*" %>

<%@ page import="java.util.*" %>

<script type="text/javascript">
     $(document).ready(function () {

        $("#jqxMenu").jqxMenu({ width: 'auto', height: 'auto', autoOpen: false, autoCloseOnMouseLeave: false, showTopLevelArrows: true, 
        						theme: 'metro'
        					  });
        $("#jqxMenu").css('visibility', 'visible');               
    }); 
</script>


<div style="width:100%;">
	<div style="float:left; width:15%">
		<div id="jqxMenu" style="visibility: hidden; margin-left: 0px;">
			<ul>
			    <li><a href="<%= MenuLink.home %>" onfocus="this.blur()">Home</a></li>							
				<li><a href="<%= MenuLink.menu_public_showcase %>" onfocus="this.blur()">Showcase</a></li>
				<li><a href="<%= MenuLink.menu_public_contact %>" onfocus="this.blur()">Contact/Estimate</a></li>
				<li style='list-style: none; width: 510px;' ignoretheme='true'></li>
				<li><a href="<%= MenuLink.menu_public_stockcharts %>" onfocus="this.blur()">Stock-Charts</a></li>
				<li><a href="<%= MenuLink.menu_public_hvac %>" onfocus="this.blur()">HVAC</a></li>
				<li><a href="<%= MenuLink.menu_public_saxophone %>" onfocus="this.blur()">Saxophone</a></li>
			</ul>			
		</div>
	</div>
	<div style="float:right; width:85%; padding-top: 4px;">
		<font size="6" color="#ffda48">Freelance App Developer</font><br/>
		<font size="4" color="#bad5fe" style="margin-top: 2px;">
			<a href="mailto:<%=AuthData.mycompany_email_address%>?Subject=Hello John KWON" style="color:inherit;text-decoration: none" target="_top">John KWON</a>
		</font>
	</div>
</div>
 