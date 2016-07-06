<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page isELIgnored ="false" %>

[
<% 
	response.setContentType("application/json");
	
	System.out.println("brands, id="+request.getParameter("id")+", (expected #)");

	DataSource ds=(DataSource)application.getAttribute("dataSource");
	HvacManualsDao hvacManualsDao=new HvacManualsDao(ds);
	List<String> brands=hvacManualsDao.getBrandNames("where valid=true order by brand_name asc");
	
	//Note: each property and value are expected double-quatationed
	for(int i=0; i<brands.size();i++)
	{
		String brand=brands.get(i);
		out.print("{	\"id\":     \""+brand+"\", ");
		out.print("  	\"parent\": \"#\", ");
		out.print("  	\"text\":   \""+brand+"\",");
		out.print("		\"children\": true")	;						
		out.print("}");
		if((i+1)<brands.size()) out.print(",");
	}
%>
]
