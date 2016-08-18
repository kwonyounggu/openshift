package com.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;
import java.util.logging.Logger;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import javax.sql.DataSource;

import org.postgresql.ds.PGPoolingDataSource;

import com.scheduled.UploadHvacManualsTask;

import it.sauronsoftware.cron4j.Scheduler;

/*
 * OK, ServletContext and InitialContext are very different things. 
 * In a web container, each web application is associated with a context, and all resources contained within a web application exist relative to its context. For example if we have a store application, it could exist under the context /store. Therefore if the application contained a file called cart.jsp if would be accessible at http://localhost:8080/store/cart.jsp.
 * Each context that exists in a web container, has a special object called a ServletContext associated with it. The ServletContext represents the web applications view on the container that it is deployed within. The ServletContext allows servlets to access resources available to them in the container. The ServletContext can be thought of as a Sandbox for a web application. This sandbox allows us to have all of the benefits of isolating web applications that we mentioned above (no name clashes, and efficient easy classloading without having to set a classpath.) 
 * The servlet context can be used to accomplish many tasks in a web application, but perhaps its primary uses are for sharing attributes between all of the servlets in an application, and for loading resources for use within the application. We also define application initialization parameters using the ServletContext, this is discussed in the section relating to deployment descriptors.

 * On the other hand, the InitialContext allows you to get a reference to the JNDI (or other naming service) naming service that is running on a given server (specified when you create the initial context.) This allows you to look up EJBs and other resources (JMS queues etc) that are stored in the JNDI (or other naming service)tree.
 * The <resource-ref> tag is used to abstract the name used in an EJB to reference anothe EJB from the JNDI name under which the bean is deployed. Check this thread for more details.
 * Hope this helps
 * Cheers
 * Sam
 */
public class MainContextListener implements ServletContextListener
{
	private Logger log = Logger.getLogger(this.getClass().getName());
	private Scheduler uploadHvacManualsScheduler=null;
	
	public MainContextListener()
	{		
	}
	
	public void contextInitialized(ServletContextEvent event)
	{
		log.info("MainContextListener started initializing ...");
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String jndiName = "java:comp/env/jdbc/PostgreSQLDS";
		String showTablesSQL = "SELECT * FROM pg_catalog.pg_tables";

		try
		{
			con = getConnection(jndiName);
			stmt = con.createStatement();
			rs = stmt.executeQuery(showTablesSQL);
			int totalRows = 0;

			log.info("Connected to DB of webmonster");
			while (rs.next())
			{
				totalRows++;
			}
			log.info("Number of tables in posgresql database of webmonster: " + totalRows);
			
			/*
			 * Not working
			Connection asCon = null;
			try
			{
				PGPoolingDataSource asgraphDs=new PGPoolingDataSource();
				
				asgraphDs.setDataSourceName("asgraphDs");
				asgraphDs.setServerName("ex-std-node589.prod.rhcloud.com");
				asgraphDs.setDatabaseName("asgraph");
				asgraphDs.setUser("adminns4nu3h");
				asgraphDs.setPassword("lP9jb_ekZHI9");
				asgraphDs.setMaxConnections(10);
				
				
				asCon=asgraphDs.getConnection();
				
				closeResultSet(rs);
				closeStatement(stmt);

				stmt = asCon.createStatement();
				rs = stmt.executeQuery(showTablesSQL);
				totalRows = 0;

				log.info("Connected to DB of asgraph");
				while (rs.next())
				{
					totalRows++;
				}
				log.info("Number of tables in posgresql database of asgraph: " + totalRows);
			}
			catch(SQLException e)
			{
				log.severe(e.toString());
			}
			catch(Exception e)
			{
				log.severe(e.toString());
			}
			finally
			{
				if(asCon!=null && !asCon.isClosed())
					try { asCon.close(); } catch (SQLException e) {}
			}
			*/
			//from here, codes are for webmonster app
			ServletContext context=event.getServletContext();
			context.setAttribute("dataSource", (DataSource)new InitialContext().lookup(jndiName));
			
			//This is to get additional DEs if being existed due to the addition from remote hospitals
			uploadHvacManualsScheduler = new Scheduler();
	    	//The following will be executed once a day at 0:00AM
			//uploadHvacManualsScheduler.schedule("10 0 * * *", new UploadHvacManualsTask((DataSource)context.getAttribute("dataSource")));//"10 0 * * *" at 00:10am
			uploadHvacManualsScheduler.schedule("33 13 * * *", new UploadHvacManualsTask((DataSource)context.getAttribute("dataSource")));//"10 0 * * *" at 00:10am
			//uploadHvacManualsScheduler.schedule("*/20 * * * *", new UploadHvacManualsTask((DataSource)context.getAttribute("dataSource")));//every 20 minute for testing.

			uploadHvacManualsScheduler.start();
			
		}
		catch(NamingException e)
		{
			log.severe("JNDI Naming Exception: "+e.toString());
		}
		catch (Exception e)
		{
			log.info("Can Not connect to Database.");
			Map<String, String> env = System.getenv();
			for (String envName : env.keySet())
			{
				log.severe("" + envName + ":" + env.get(envName));
			}
			e.printStackTrace();
		}
		finally
		{
			log.info("Connection to DB closed.");
			closeResultSet(rs);
			closeStatement(stmt);
			closeConnection(con);
			
			log.info("MainContextListener finished initializing !!!");
		}
	}



	public static void closeResultSet(ResultSet rs)
	{
		try
		{
			if(rs!=null && !rs.isClosed()) rs.close();
		}
		catch (Exception e)
		{
		}
	}

	public static void closeConnection(Connection con)
	{
		try
		{
			if(con!=null && !con.isClosed()) con.close();
		}
		catch (Exception e)
		{
		}
	}

	public static void closeStatement(Statement stmt)
	{
		try
		{
			if(stmt!=null && !stmt.isClosed())stmt.close();
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

	public void contextDestroyed(ServletContextEvent event)
	{
		log.info("MainContextListener started being destroyed ...");
		ServletContext context=event.getServletContext();		
		context.removeAttribute("dataSource");
		
		if(uploadHvacManualsScheduler!=null && uploadHvacManualsScheduler.isStarted()) uploadHvacManualsScheduler.stop();
	}
}
