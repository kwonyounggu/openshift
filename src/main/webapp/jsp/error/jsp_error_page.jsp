<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@page import="com.common.Utils"%>
<%@page import="com.common.Message"%>
<table width='1000' align='center' border='0' cellpadding='0' cellspacing='0'>
	<tr height='10'>
		<td>
			<%
				out.println("<!--");
				StringWriter sw = new StringWriter();
				PrintWriter pw = new PrintWriter(sw);
				exception.printStackTrace(pw);
				out.print(sw);
				sw.close();
				pw.close();
				
				Map params = request.getParameterMap();
			    Iterator i = params.keySet().iterator();
			    String all_params="";
			    while ( i.hasNext() )
		        {
			    	String key = (String) i.next();
			    	String value = ((String[]) params.get( key ))[ 0 ];
			    	all_params+=key+"="+value+"<br>";
		        }
			    all_params+="Customer IP="+request.getRemoteAddr()+"<br>";
			    //Uncomment later when ready after correction
			    //Utils.emailList.clear();
			    //Utils.nameList.clear();
			    //Utils.emailList.add(Utils.csr_email_address);
			    //Utils.nameList.add("ADMIN");
				//new MailInfo(Utils.csr_email_address,Utils.emailList,Utils.nameList,Utils.smtp,Message.error_report_subject, "(op="+request.getParameter("op")+"): "+exception.toString()+"<br><br>"+all_params+" Generated at "+Utils.currentTimestamp()+".");
				
				out.println("-->");
			%>		
		</td>
	</tr>
</table>

<table align='center' border='1' cellpadding='0' cellspacing='0' width='100%' class='error'>
	<tr height='28'><th >ERROR REPORT</th></tr>
	<tr><td align='left'><p>ERROR CONTENTS:</p><p><ul><li><%= exception.toString() %>
										 <%
										 out.print(" at "+Utils.currentTimestamp()+"!!!<br><br>"+Message.inform_to_admin_about_exception+"&nbsp;&nbsp;<a href='mailto:"+System.getenv("OPENSHIFT_LOGIN")+"?subject=("+System.getenv("OPENSHIFT_APP_NAME")+") ERROR NOTIFICATION' style='color: #FE5734;text-decoration: underline;''>EMAIL</a>"+"<br><br>CUSTOMER IP ADDRESS: "+request.getRemoteAddr());
										 %></li></ul></p></td></tr>

	<tr><td><span class='small_text'>from jsp_error_page.jsp</span></td></tr>
</table>

