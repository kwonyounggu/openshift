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
<div style="position:absolute; z-index:1;width:100%;">
	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="1024" height="80">
	<param name="movie" value="header.swf" />
	<param name="quality" value="high" />
	<param name="wmode" value="transparent">
	<embed src="header.swf" quality="high" type="application/x-shockwave-flash" width="100%" height="80" wmode="transparent" pluginspage="http://www.macromedia.com/go/getflashplayer" />
	</object>
</div>
<div style="position:relative; z-index:2;width:100%;">
	<div id="header"><font size="6" color="#ffda48">Freelance App Developer</font><br/><font size="4" color="#bad5fe"><a href="mailto:kwon.younggu@gmail.com?Subject=Hello Younggu KWON" style="color:inherit;text-decoration: none" target="_top">Younggu KWON</a></font></div>
</div>
<div id='jqxMenu' style='visibility: hidden; margin-left: 0px;'>
<ul>
    <li><a href="<%= MenuLink.home %>" onfocus="this.blur()">Home</a></li>				
		<%
						/*
							AllRegisteredUserBean crb=(AllRegisteredUserBean)session.getAttribute("crb");						
								if(crb.getLogin_level()<3)
								{
									out.print("<li>Admin");
										out.print("<ul style='width: 185px;'>");
											out.print("<li><a onfocus='this.blur()' href='"+MenuLink.menu_carm_central_admin_create_login_account+"'>Create Login Account</a></li>");
											out.print("<li><a onfocus='this.blur()' href='"+MenuLink.menu_carm_central_admin_update_login_account+"'>Update Login Account</a></li>");
											out.print("<li><a onfocus='this.blur()' href='"+MenuLink.menu_carm_central_admin_group_management+"'>Group Management</a></li>");
											out.print("<li><a onfocus='this.blur()' href='"+MenuLink.menu_carm_central_admin_map_event_group_reviewer+"'>Map Reviewers to Items</a></li>");
											out.print("<li><a onfocus='this.blur()' href='"+MenuLink.menu_carm_central_admin_clinical_summary+"'>Edit Clinical Summary</a></li>");
										out.print("</ul>");
									out.print("</li>");	
								}
							*/
						%>	
		<li style='list-style: none; width: 85%; '  ignoretheme='true'>

	        <table width='100%' height='100%'>
				<tr>
					<td align='right' width='80%'  height='100%' valign='top'>
						<%
						/*
							AllRegisteredUserBean crb1=(AllRegisteredUserBean)session.getAttribute("crb");
											
							if(crb1!=null) 
							{
								List<AllLoginLevelBean> loginLevelList1=(List<AllLoginLevelBean>)application.getAttribute("cloginLevelList");
								out.print("<span style='vertical-align: top; font-family: arial;'>[C] ");		
								out.print(loginLevelList1.get(crb1.getLogin_level()-1).getLoginLevelDescription()+":</span> <b><span style='vertical-align: top; color: #768596;font-family: arial;'>"+crb1.getFirst_name()+"&nbsp;&nbsp;|&nbsp;&nbsp;</span></b>");
								out.print("<a onfocus='this.blur()' href='"+MenuLink.carm_central_logout+"'><span style='vertical-align: top; color: #768596;font-family: arial;'>Logout</span></a>");
							}
							*/
						%>		
						&nbsp;&nbsp;<img src='images/common/carm_logo_small.png' width='52' height='24'/>
					</td>	
				</tr>		
			</table>

	    </li>	
    </ul>
	
</div>