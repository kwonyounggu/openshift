<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<table align='center' border='0' cellpadding='0' cellspacing='0'>
	<tr height='10'><td></td></tr>
</table>
<table align='center' border='1' cellpadding='0' cellspacing='0' width='1000' class='error'>
	<tr height='28'><th >ERROR REPORT</th></tr>
	<tr><td align='left'><p>ERROR MESSAGE:</p><p><ul><li><%= request.getAttribute("error_msg") %></li></ul></p></td></tr>

	<tr><td><span class='small_text'>from servlet_error_page.jsp</span></td></tr>
</table>