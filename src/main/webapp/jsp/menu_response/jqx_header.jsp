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
<div style="width:100%;height:80px;position:relative;">
	<div style="position:absolute; z-index:1;width:100%;">
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="1024" height="80">
		<param name="movie" value="header.swf" />
		<param name="quality" value="high" />
		<param name="wmode" value="transparent">
		<embed src="/swf/header.swf" quality="high" type="application/x-shockwave-flash" width="100%" height="80" wmode="transparent" pluginspage="http://www.macromedia.com/go/getflashplayer" />
		</object>
	</div>
	<div style="position:relative; z-index:2;width:100%;">
		<div id="header"><font size="6" color="#ffda48">Freelance App Developer</font><br/><font size="4" color="#bad5fe"><a href="mailto:kwon.younggu@gmail.com?Subject=Hello Younggu KWON" style="color:inherit;text-decoration: none" target="_top">Younggu KWON</a></font></div>
	</div>
</div>		


<%-- <div id="jqxMenu" style="width:100%; visibility: hidden; margin-left: 0px;">
	<ul>
	    <li><a href="<%= MenuLink.home %>" onfocus="this.blur()">Home</a></li>				
			
			<li style='list-style: none; width: 100%; '  ignoretheme='true'></li>	
	</ul>
	
</div> --%>
 