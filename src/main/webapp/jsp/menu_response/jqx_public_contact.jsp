<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>

<table style='width: 90%; padding-top: 20px; padding-bottom: 20px; table-layout: fixed'>
   <tr>
    <td style='background-color: #555762; color: #ffffff; width: 50%'>
    	<ul style='font-size: 14px'><h3 style='color: #f9d548;'>Contact</h3><br/> 
    		If you are interested in growing your business and building a positive brand expirience for your customers/patients, then we should talk:
    		<li>By Phone: <%=AuthData.company_phone %> between 9:00 am and 5:00 pm (EST)</li>
    		<li>By Skype: <%=AuthData.skype_id %> (appointment required)</li>
    		<li>By Visiting (primary place): <%=AuthData.company_address %> (appointment required)<br/>
    				(seconday place): TBD - (appointment required)
    		</li>
    		<li>By Email: <%=AuthData.mycompany_email_address %></li>
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