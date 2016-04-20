<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>

<style>
/*for Resume*/
ul li
{
    list-style-type: disc;
    list-style-position: inside;
    padding: 10px 20px 5px 20px;
    text-indent: -1em;
}
</style>

<table style='width: 90%; padding-top: 20px; padding-bottom: 20px; table-layout: fixed'>
   <tr>
    <td style='background-color: #555762; color: #ffffff; width: 50%'>
    	<ul style='font-size: 14px'>
    		<h3 style='color: #f9d548;'>Contact</h3>
    		<br/>
    		If you are interested in growing your business and building a positive brand expirience for your customers/patients, then we should talk:
    		<br/><br/>
    		<li>By Phone: <%=AuthData.company_phone %>
    			<br/>
    			from 9:00am to 5:00pm (EST)
    		</li>
    		<li>By Skype: <%=AuthData.skype_id %> (appointment required)</li>
    		<li>By Visiting primary place: 
    			<br/>
    			- <%=AuthData.company_address %>
    			<br/>
    			(appointment required)
    			<br/>
    			- TBD for the seconday place (appointment required)
    		</li>
    		<li>By Email: <a href="mailto:<%=AuthData.mycompany_email_address%>?Subject=Hello Younggu KWON" style="color:inherit;text-decoration: none" target="_top"><%=AuthData.mycompany_email_address%></a></li>
    	</ul>
    </td>	
    <td style='width: 20px'></td>
    <td style='background-color: #555762; color: #ffffff; width: 50%'>
    	<ul style='font-size: 14px'><h3 style='color: #f9d548;'>Developement Technologies</h3>
    		<li>Java, C/C++</li>
    		<li>Actionscript 3.0 including Starling, Feathers UI</li>
    		<li>HTML/CSS/Javascript including JQuery</li>
    		<li>Oracle, PostgreSQL, MySql, Ms Access</li>
    		<li>Tomcat 5.x, 6.x, 7.x, 8.x and JBoss</li>
    		<li style='list-style-type: none' />
    		<li style='list-style-type: none' />
    		<li style='list-style-type: none' />
    	</ul>
    </td>
  </tr>
  <tr>
	<td colspan='3' style='border: 0px solid gray'>
		
		
	</td>
  <tr>
</table>