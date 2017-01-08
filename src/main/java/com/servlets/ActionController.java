package com.servlets;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.common.AuthData;
import com.common.Message;
import com.common.UAgentInfo;
import com.common.Utils;

public class ActionController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
    public ActionController() 
    {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		log.info("doGet() is called in ActionController.java");

		/*
		UAgentInfo detector = new UAgentInfo(request.getHeader("User-Agent"), request.getHeader("Accept"));
	   
	    if(detector.detectTierTablet())  
	    {
	    	((RequestDispatcher)request.getRequestDispatcher("/tabletController")).forward(request,response);
	    	return;
	    }
	    else if(detector.detectTierIphone())
	    {
	    	((RequestDispatcher)request.getRequestDispatcher("/smartphoneController")).forward(request,response);
	    	return;
	    }
	    */
		
		/*Jan 08-2017: four lines commented in just for checking anychange
		request.setCharacterEncoding("UTF-8");//put this otherwise UNI-Code characters will be broken.		
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control","no-store,no-cache, must-revalidate, post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		*/
		
		HttpSession session = request.getSession(true);//if(session.isNew())
		
		String op=(String)request.getParameter("op");
		log.info("op="+op+" in ActionController.java");
		
		
		try
		{
			//Here, first check if the person is logged-in, otherwise go back to the public home
			Object webmonsterBean=(Object)session.getAttribute("webmonsterBean"); //check this for the user if logged in or not, with 'if(webmonsterBean==null)'
			if(op==null || op.equals("") || op.equals("home"))
			{
				request.setAttribute("title", "WebMonster-SW Freelancer Site");
				request.setAttribute("description", "SW Freelancer - Providing sw solutions for desktop apps, tablet apps and mobile phone apps");
				request.setAttribute("keywords", "SW Freelancer, Java, Action Script, HTML/JQuery/Bootstrap, JSP, HVAC, Stock-Charts, Saxophone");
				
				request.setAttribute("body_panel", "/jsp/menu_response/jqx_home_body.jsp");
				((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response/jqx_page_template.jsp")).forward(request,response);
	
			}
			else if(op.indexOf("menu")!=-1)
			{
				if(op.equals("menu_public_showcase"))
				{
					request.setAttribute("title", "WebMonster-Showcase Site");
					request.setAttribute("description", "SW Freelancer - Providing samples of web applications");
					request.setAttribute("keywords", "SickKids, Research Application, Caliper, EPOCH, Reference Interval, Accouting Managment, Remote English Education");
					
					request.setAttribute("body_panel", "/jsp/menu_response/jqx_public_showcase.jsp");
				}
				else if(op.equals("menu_public_contact"))
				{
					request.setAttribute("title", "WebMonster-Contact/Estimate");
					request.setAttribute("description", "SW Freelancer - Contact/Estimate Information");
					request.setAttribute("keywords", "SW Freelancer, Contact information and estimate information");
					
					request.setAttribute("body_panel", "/jsp/menu_response/jqx_public_contact.jsp");
				}
				else if(op.equals("menu_public_stockcharts"))
				{
					request.setAttribute("title", "WebMonster, Stock-Charts Site");
					request.setAttribute("description", "SW Freelancer - Providing stock-charts that are customizable");
					request.setAttribute("keywords", "Stock-charts, moving average, technical analysis, etc");
					
					request.setAttribute("body_panel", "/jsp/menu_response/jqx_public_stockcharts.jsp");
				}
				else if(op.indexOf("menu_public_hvac")!=-1)
				{
					if(op.equals("menu_public_hvac"))
					{
						request.setAttribute("title", "WebMonster-HVAC Site");
						request.setAttribute("description", "HVAC - Providing hvac manuals, contractor information, system manuals, service manuals, owner manuals, how to be a HVAC technician and how to get HVAC licences");
						request.setAttribute("keywords", "HVAC, furnace, air conditioner, boiler, hot water tank, split, combination, system manuals, service manuals, owner manuals, troubleshooting");
						
						request.setAttribute("body_panel", "/jsp/menu_response/jqx_public_hvac.jsp");
					}					
					else if(op.equals("menu_public_hvac_ajax_residential_manuals"))
					{
						((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response/ajax_hvac/ajax_hvac_residential_manuals.jsp")).forward(request,response);
					}
					else if(op.equals("menu_public_hvac_ajax_commercial_manuals"))
					{
						((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response/ajax_hvac/ajax_hvac_commercial_manuals.jsp")).forward(request,response);
					}
					else if(op.equals("menu_public_hvac_ajax_industrial_manuals"))
					{
						((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response/ajax_hvac/ajax_hvac_industrial_manuals.jsp")).forward(request,response);
					}
				}
				else if(op.equals("menu_public_saxophone"))
				{
					request.setAttribute("title", "WebMonster-Saxophone Site");
					request.setAttribute("description", "Saxophon - Providing all about saxophone music");
					request.setAttribute("keywords", "Saxophone, tutorials, you-tube, lessons");
					
					request.setAttribute("body_panel", "/jsp/menu_response/jqx_public_saxophone.jsp");
				}
				else //unknown, so display the home page
				{
					request.setAttribute("title", "WebMonster-SW Freelancer Site");
					request.setAttribute("description", "SW Freelancer - Providing sw solutions for desktop apps, tablet apps and mobile phone apps");
					request.setAttribute("keywords", "SW Freelancer, Java, Action Script, HTML/JQuery/Bootstrap, JSP, HVAC, Stock-Charts, Saxophone");
					
					request.setAttribute("body_panel", "/jsp/menu_response/jqx_home_body.jsp");
				}
				//common to all the menu listed above, such as menu_public ...
				((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response/jqx_page_template.jsp")).forward(request,response);
			}
			
			
			
		}
		catch(Exception e)
		{
			Map params = request.getParameterMap();
		    Iterator i = params.keySet().iterator();
		    String all_params="";
		    while ( i.hasNext() )
	        {
		    	String key = (String) i.next();
		    	String value = ((String[]) params.get( key ))[ 0 ];
		    	all_params+=key+"="+value+"<br>";
	        }
			log.severe("(op="+op+"): msg="+e+",\nCustomer IP: "+request.getRemoteAddr()+",\n"+all_params+"from ActionController.java");
			/*emailList.clear();
			nameList.clear();
			emailList.add(Utils.csr_email_address);
			nameList.add("ADMIN");
			new MailInfo(Utils.csr_email_address,emailList, nameList,Utils.smtp,Message.error_report_subject, "(op="+op+"): "+e+"<br><br>"+all_params+" Generated at "+Utils.currentTimestamp()+".");
			*/
			forwardErrorPage(request,response,e.toString());
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public void forwardWarningPage(HttpServletRequest request,HttpServletResponse response,String msg)throws ServletException, IOException
	{
		request.setAttribute("warning_msg", msg+" at "+Utils.currentTimestamp()+"!!!");
		request.setAttribute("body_panel", "/jsp/error/servlet_warning_page.jsp");
		((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response/jqx_page_template.jsp")).forward(request,response);
	}
	public void forwardErrorPage(HttpServletRequest request,HttpServletResponse response,String msg)throws ServletException, IOException
	{
		request.setAttribute("error_msg", msg+" at "+Utils.currentTimestamp()+"!!!"+
							 "<br><br>"+Message.inform_to_admin_about_exception+"&nbsp;&nbsp;<a href='mailto:"+AuthData.mycompany_email_address+"?subject=("+System.getenv("OPENSHIFT_APP_NAME")+") ERROR NOTIFICATION&body="+msg+"' style='color: #FE5734;text-decoration: underline;'>E-MAIL by Click and Click</a>"+
							 "<br><br>Your IP Address: "+request.getRemoteAddr());
		request.setAttribute("body_panel", "/jsp/error/servlet_error_page.jsp");
		((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response/jqx_page_template.jsp")).forward(request,response);
	}

}
