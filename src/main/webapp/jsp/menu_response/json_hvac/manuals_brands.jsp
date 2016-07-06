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
	Map<String, Integer> brands=hvacManualsDao.getKeysValues("select brand_name, count(*) from hvac_manuals where valid=true group by brand_name order by brand_name asc");
	
	//Note: each property and value are expected double-quatationed
	Iterator<Map.Entry<String, Integer>> entries = brands.entrySet().iterator();
	while(entries.hasNext())
	{
		Map.Entry<String, Integer> entry=entries.next();
		out.print("{	\"id\":     \""+entry.getKey()+"\", "); //brand
		out.print("  	\"parent\": \"#\", ");
		out.print("  	\"text\":   \""+entry.getKey()+" ("+entry.getValue()+")\",");//brand (number of manuals)
		out.print("		\"children\": true")	;						
		out.print("}");
		if(entries.hasNext()) out.print(",");
	}
%>
]
