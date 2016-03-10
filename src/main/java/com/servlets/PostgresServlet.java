package com.servlets;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class PostgresServlet extends BaseServlet
{
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	public PostgresServlet()
	{
		//jndiName="java:comp/env/jdbc/PostgreSQLDS", from G:\Dev\OpenShiftApps\webmonster\.openshift\config\context.xml
		super("java:comp/env/jdbc/PostgreSQLDS", "SELECT * FROM pg_catalog.pg_tables");
		log.info("Debug: PostgresServlet() constructor is called now");
	}

	public PostgresServlet(String jndiName, String sqlStatment)
	{
		super(jndiName, sqlStatment);
	}
}
