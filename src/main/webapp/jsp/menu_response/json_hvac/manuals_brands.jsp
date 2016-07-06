<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page isELIgnored ="false" %>

<% 
response.setContentType("application/json");
/*
[
	{	
		"id":1,
		"text": "Root node",
		"children":[{"id":2,"text":"Child node 1","children":true},{"id":3,"text":"Child node 2"}]}]
*/		
	System.out.println("brands, id="+request.getParameter("id"));
out.print("[{'id':'CARRIER','text':'CARRIER','children':true}]");
%>

