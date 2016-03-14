<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>	
<%@ page session="true" errorPage="/jsp/error/jsp_error_page.jsp" %>
<%@ page import="com.common.*" %>

<%@ page import="java.util.*" %>

<script type="text/javascript">
     $(document).ready(function () {

        $("#jqxMenu").jqxMenu({ width: '100%', height: '30px', autoOpen: false, autoCloseOnMouseLeave: false, showTopLevelArrows: true, 
        						theme: 'fresh'
        					  });
        $("#jqxMenu").css('visibility', 'visible');               
    }); 
</script>
<div>
	<img src="/images/webmonster_logo.png" style="width: 77px; height: 61px;"/>
	<font size="6" color="#ffda48">Freelance App Developer</font><br/><font size="4" color="#bad5fe"><a href="mailto:kwon.younggu@gmail.com?Subject=Hello Younggu KWON" style="color:inherit;text-decoration: none" target="_top">Younggu KWON</a></font>
</div>


<%-- <div id="jqxMenu" style="width:100%; visibility: hidden; margin-left: 0px;">
	<ul>
	    <li><a href="<%= MenuLink.home %>" onfocus="this.blur()">Home</a></li>				
			
			<li style='list-style: none; width: 100%; '  ignoretheme='true'></li>	
	</ul>
	
</div> --%>
 