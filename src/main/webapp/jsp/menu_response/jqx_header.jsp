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
	<div>
		<script type="text/javascript"> 
			var params={allowfullscreen : "true"};						
			var flashvars = 
			{	
					userId : 			"${trb.userId}",
					firstName : 		"${trb.firstName}",  
					lastName : 			"${trb.lastName}",
					loginLevel : 		"${trb.loginLevel}",  
					hospitalId : 		"${trb.hospitalId}",  
					email : 			"${trb.email}",
					hospitalName : 		"${trb.hospitalName}",  
					courseNumber : 		"${curriculum_bean.courseNumber}",
					courseName : 		"${curriculum_bean.courseName}",  
					lecturerId : "${curriculum_bean.courseNumber}_LECTURER_${curriculum_bean.lecturerId}",
					teachingAssistantId :"${curriculum_bean.courseNumber}_TEACHING_ASSISTANT_${curriculum_bean.taId}",
					activeParticipantId1:"${curriculum_bean.courseNumber}_INTERACTIVE_VIEWER1_${curriculum_bean.interactiveSiteViewer1Id}",
					activeParticipantId2:"${curriculum_bean.courseNumber}_INTERACTIVE_VIEWER2_${curriculum_bean.interactiveSiteViewer2Id}",
					passiveParticipantId1:"${curriculum_bean.courseNumber}_ONEWAY_VIEWER1_${curriculum_bean.onewaySiteViewer1Id}",
					passiveParticipantId2:"${curriculum_bean.courseNumber}_ONEWAY_VIEWER2_${curriculum_bean.onewaySiteViewer2Id}",
					passiveParticipantId3:"${curriculum_bean.courseNumber}_ONEWAY_VIEWER3_${curriculum_bean.onewaySiteViewer3Id}",
					passiveParticipantId4:"${curriculum_bean.courseNumber}_ONEWAY_VIEWER4_${curriculum_bean.onewaySiteViewer4Id}",
					passiveParticipantId5:"${curriculum_bean.courseNumber}_ONEWAY_VIEWER5_${curriculum_bean.onewaySiteViewer5Id}",
					passiveParticipantId6:"${curriculum_bean.courseNumber}_ONEWAY_VIEWER6_${curriculum_bean.onewaySiteViewer6Id}"
			};
			swfobject.embedSWF("/swf/header.swf", "myContent", "1024", "80", "10.0.0", "playerProductInstall.swf", flashvars, params);
			
		</script>
	</div>
	<div id="myContent"> 
		<h1>Alternative content</h1> 
		<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p> 
	</div> 			
</div>
<div style="position:relative; z-index:2;width:100%;">
	<div id="header"><font size="6" color="#ffda48">Freelance App Developer</font><br/><font size="4" color="#bad5fe"><a href="mailto:kwon.younggu@gmail.com?Subject=Hello Younggu KWON" style="color:inherit;text-decoration: none" target="_top">Younggu KWON</a></font></div>
</div>
<!--
<div id='jqxMenu' style='visibility: hidden; margin-left: 0px;'>
<ul>
    <li><a href="<%= MenuLink.home %>" onfocus="this.blur()">Home</a></li>				
		
		<li style='list-style: none; width: 85%; '  ignoretheme='true'>

	        <table width='100%' height='100%'>
				<tr>
					<td align='right' width='80%'  height='100%' valign='top'>
						
						&nbsp;&nbsp;<img src='images/common/carm_logo_small.png' width='52' height='24'/>
					</td>	
				</tr>		
			</table>

	    </li>	
    </ul>
	
</div>
  -->