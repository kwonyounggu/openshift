package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class PostgresServlet extends BaseServlet
{
	private static final long serialVersionUID = 1L;

	public PostgresServlet()
	{
		//jndiName="java:comp/env/jdbc/PostgreSQLDS", from G:\Dev\OpenShiftApps\webmonster\.openshift\config\context.xml
		super("java:comp/env/jdbc/PostgreSQLDS", "SELECT * FROM pg_catalog.pg_tables");
	}

	public PostgresServlet(String jndiName, String sqlStatment)
	{
		super(jndiName, sqlStatment);
	}
}
