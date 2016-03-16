package com.filters;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/*
import com.sickkids.caliper.common.Utils;
import com.sickkids.caliper.dao.HitCountBean;
import com.sickkids.caliper.dao.HitCountDao;
import com.sickkids.caliper.dao.UserAccessBean;
import com.sickkids.caliper.dao.UserAccessDao;
import com.sickkids.caliper.database.ConnectionPool;
import com.sickkids.caliper.exceptions.DAOException;
*/

public class CommonRoleFilter implements Filter
{	private FilterConfig filterConfig = null;
	private static long hitCounter=0;
	//private ConnectionPool cp = null;
	//private HitCountDao hDao=null;
	//private UserAccessDao uDao=null;
	private ServletContext ctx=null;
	private String sessionId="";
	
	public void destroy()
	{	
		filterConfig=null;
		//cp=null;
		//hDao=null;
		//uDao=null;
		ctx=null;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{	
		/*
		if (filterConfig == null) 
		{ 	//Utils.logger.severe("ERROR: filterConfig is null in doFilter(..)");
			chain.doFilter(request, response);
			return; 
		}
		HttpServletRequest hr=(HttpServletRequest)request;
		try
		{										
			UserAccessBean ub=new UserAccessBean();
			ub.setIdx(0);
			String op=hr.getParameter("op");
			ub.setOperation(((op==null)?"HOME":op));
			ub.setRemoteIP(hr.getRemoteAddr());
			ub.setRemoteHost(hr.getRemoteHost());
			ub.setLocale(hr.getLocale().getCountry());
			if(hr.getHeader("user-agent").length()>150)
				ub.setEncoding(hr.getHeader("user-agent").substring(0, 150));//changed into user-agent not accept-encoding	
			else
				ub.setEncoding(hr.getHeader("user-agent"));
						
			chain.doFilter(request, response);//going to the servlets
			
			Timestamp ct=new Timestamp(new Date().getTime());
			if(hr.getSession().getId().equals(sessionId)) ub.setHitCounter(hitCounter);
			else //different session or a new session
			{
				ub.setHitCounter(++hitCounter); //increase if and only if different sessionId 
				hDao.update(new HitCountBean(1,hitCounter,ct), null, null);//internally increase the counter
			}
			
			sessionId=hr.getSession().getId();
			ub.setSessionID(sessionId);						
			ub.setHitTimestamp(ct);
			uDao.create(ub);
			
		}
		catch(DAOException e)
		{
			ctx.log("ERROR: DAOException in doFilter(..) of CommonRoleFilter, msg="+e);
		}
		*/
	}

	public void init(FilterConfig filterConfig) throws ServletException
	{	/*
		this.filterConfig=filterConfig;
		ctx=filterConfig.getServletContext();
		try
		{	cp = (ConnectionPool)ctx.getAttribute("connectionPool");
			hDao=new HitCountDao(cp);
			hitCounter=hDao.getHitCounter(1).getHitCounter();
			uDao=new UserAccessDao(cp);
		}
		catch(DAOException e)
		{
			ctx.log("ERROR: DAOException in init(..) of CommonRoleFilter, msg="+e);
		}
		*/
	}

}
