package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


public abstract class BaseServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
	private String jndiName;
	private String sqlStatement;
	
    public BaseServlet(String jndiName, String sqlStatment) 
	{
		this.jndiName = jndiName;
		this.sqlStatement = sqlStatment;
		
		System.out.println("Debug: BaseServlet(String jndiName, String sqlStatment) is called now");
	}
	
	public void init(ServletConfig config) throws ServletException
	{
		System.out.println("Debug: init(ServletConfig config) of BaseServlet.java is called now");
	}
	
	private List<String> showTables() throws Exception
	{
		// the database name is tomcat configured in META-INF/context.xml
		List<String> tableNames = new ArrayList<String>();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		try
		{
			con = getConnection(jndiName);
			stmt = con.createStatement();
			rs = stmt.executeQuery(sqlStatement);
			int totalRows = 0;

			while (rs.next())
			{
				totalRows++;
				System.out.println("Table in tomcat database: " + rs.getString(1));
				tableNames.add(rs.getString(1));
			}
			System.out.println("Number of tables in tomcat database: " + totalRows);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw e;
		}
		finally
		{
			closeResultSet(rs);
			closeStatement(stmt);
			closeConnection(con);
		}
		return tableNames;
	}

	public static void closeResultSet(ResultSet rs)
	{
		try
		{
			rs.close();
		}
		catch (Exception e)
		{
		}
	}

	public static void closeConnection(Connection con)
	{
		try
		{
			con.close();
		}
		catch (Exception e)
		{
		}
	}

	public static void closeStatement(Statement stmt)
	{
		try
		{
			stmt.close();
		}
		catch (Exception e)
		{
		}
	}

	public static Connection getConnection(String dataSourceJNDI) throws SQLException, Exception
	{
		try
		{
			InitialContext jndiCntx = new InitialContext();
			DataSource ds = (DataSource) jndiCntx.lookup(dataSourceJNDI);
			return ds.getConnection();
		}
		catch (NamingException ne)
		{
			throw new Exception(ne);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " + "Transitional//EN\">\n");

		try
		{
			List<String> tableNames = showTables();
			out.println("<html>");
			out.println("<body>");
			for (String tableName : tableNames)
				out.println("table: " + tableName);

		}
		catch (Exception e)
		{
			e.printStackTrace(out);
		}

		out.println("</body>");
		out.println("</html>");
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}

}
