package com.filters;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.common.UAgentInfo;


public class SmartPhoneFilter implements Filter
{

	private Logger log = Logger.getLogger(this.getClass().getName());
	
	public void destroy()
	{
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{
		try
		{	
			UAgentInfo detector = new UAgentInfo(((HttpServletRequest)request).getHeader("User-Agent"), ((HttpServletRequest)request).getHeader("Accept"));
		    /*
		     * The quick way to detect for a tier of devices. This method detects for the new generation of HTML 5 capable, larger screen tablets. 
		     * Includes iPad, Android (e.g., Xoom), BB Playbook, WebOS, etc.
		     * */
		    if(detector.detectTierTablet())  
		    	((RequestDispatcher)request.getRequestDispatcher("/tabletController")).forward(request,response);
		    else if(detector.detectTierIphone())
		    	((RequestDispatcher)request.getRequestDispatcher("/smartphoneController")).forward(request,response);
		    else chain.doFilter(request, response);//going to the normal servlets		
								
		}
		catch(Exception e)
		{
			log.severe("Exception in doFilter(..) of SmartPhoneFilter, msg="+e);
		}

	}

	public void init(FilterConfig arg0) throws ServletException
	{
		// TODO Auto-generated method stub

	}

}
