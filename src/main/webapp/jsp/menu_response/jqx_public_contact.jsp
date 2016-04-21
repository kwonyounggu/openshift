<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>

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
    			- TBD for the seconday place
    			<br/>
    			- appointment required
    		</li>
    		<li>By Email: <a href="mailto:<%=AuthData.mycompany_email_address%>?Subject=Hello WebMonster.CA" style="color:inherit;text-decoration: none" target="_top"><%=AuthData.mycompany_email_address%></a></li>
    		<li>What did you have in mind? Suggestions to include: competitor's websites, designs that you like, some initial ideas for your brand, what kind of niches you'd like to explore, and anything to get the conversation going!</li>
    	</ul>
    </td>	
    <td style='width: 20px'></td>
    <td style='background-color: #555762; color: #ffffff; width: 50%; padding: 5px 20px 5px 20px;'>

    	<h3 style='color: #f9d548;'>Estimate(under construction)</h3>
    		
  			Your payment is not required until you are satisfied.
  			<div id='estimate_body'> 
			   	<table  id='login_table' style='width: 100%; border-spacing: 4px;' style="padding: 20px 0px 20px 60px;"> 	
					<tr><td colspan=4>LoginID <span style="font-size: .95em;">(eg: jennifer.pinto.00)</span></td></tr> 		
																
						<tr> 
						<td colspan=4 align="left"> 
			 				<input type=text id="login_id" size=38 value='' maxlength="80" class=input_text style='imemode:inactive' onKeyDown="if(event.keyCode==13) loginConfirm();"/> 						
						</td> 
					</tr> 
				
					<tr><td colspan=4>Password</td></tr> 													
						<tr> 
						<td colspan=4 align="left"> 
			 				<input type='password' id="login_password" size=38 value='' maxlength="20" class=input_text style='imemode:inactive' onKeyDown="if(event.keyCode==13) loginConfirm();"/> 						
						</td> 
					</tr> 					
										 
					<tr> 
						<td colspan=4 align="left"><br/> 
							<input type=button style='cursor:pointer;' value='Login' onclick="loginConfirm();" />	
							<br/><br/>
							<p ><a onfocus='this.blur()' href="#" onclick="get_forgot_pwd_page(); return false;" >Did you forget your password?</a></p>
							<p ><a onfocus='this.blur()' href="#" onclick="get_forgot_pwd_page(); return false;" >Did you forget your loginID?</a></p>
						</td> 
					</tr> 
			 </table>
		 </div>				
    </td>
  </tr>
  <tr>
	<td colspan='3' style='border: 0px solid gray'>
		
		
	</td>
  <tr>
</table>