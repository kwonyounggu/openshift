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
import com.common.Utils;

public class SmartPhoneController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
    public SmartPhoneController() 
    {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		log.info("doGet() is called in SmartPhoneController.java");

		request.setCharacterEncoding("UTF-8");//put this otherwise UNI-Code characters will be broken.
		
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control","no-store,no-cache, must-revalidate, post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		HttpSession session = request.getSession(true);//if(session.isNew())
		
		String op=(String)request.getParameter("op");
		log.info("op="+op+" in SmartPhoneController.java");
		
		try
		{
			//Here, first check if the person is logged-in, otherwise go back to the public home
			Object webmonsterBean=(Object)session.getAttribute("webmonsterBean"); //check this for the user if logged in or not, with 'if(webmonsterBean==null)'
			
			request.setAttribute("header_panel", "/jsp/menu_response_smartphone/header.jsp");
			
			if(op==null || op.equals("") || op.equals("home"))
			{
				request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_home_body.jsp");
				((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response_smartphone/jqx_page_template.jsp")).forward(request,response);
			}
			else if(op.indexOf("menu")!=-1)
			{
				if(op.equals("menu_public_showcase"))
				{
					request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_showcase.jsp");
				}
				else if(op.equals("menu_public_contact"))
				{
					request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_contact.jsp");
				}
				else if(op.equals("menu_public_stockcharts"))
				{
					request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_stockcharts.jsp");
				}
				else if(op.indexOf("_hvac")!=-1)
				{
					request.setAttribute("header_panel", "/jsp/menu_response_smartphone/hvac/hvac_header.jsp");
					if(op.equals("phone_menu_hvac_system_manuals"))
					{
						request.setAttribute("body_panel", "/jsp/menu_response_smartphone/hvac/hvac_system_manuals.jsp");
					}
					else if(op.equals("phone_menu_hvac_qa_forum"))
					{
						request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_hvac.jsp");
					}
					else if(op.equals("phone_menu_hvac_estimates"))
					{
						request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_hvac.jsp");
					}
					else if(op.equals("phone_menu_hvac_contractors"))
					{
						request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_hvac.jsp");
					}
					else if(op.equals("phone_menu_hvac_buysell"))
					{
						request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_hvac.jsp");
					}
					else if(op.equals("phone_menu_hvac_jobs"))
					{
						request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_hvac.jsp");
					}
					else //if(op.equals("menu_public_hvac"))//calling from main menu of the smartphone
					{
						//the file, 'jqx_public_hvac.jsp', will call eventually ajax_hvac_residential_manuals.jsp
						//the reason why is for the further extension like hvac home
						//request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_hvac.jsp");
						
						request.setAttribute("body_panel", "/jsp/menu_response_smartphone/hvac/hvac_system_manuals.jsp");
					}
				}
				else if(op.equals("menu_public_saxophone"))
				{
					request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_public_saxophone.jsp");
				}
				else //unknown, so display the home page
				{
					request.setAttribute("body_panel", "/jsp/menu_response_smartphone/jqx_home_body.jsp");
				}
				//common to all the menu listed above, such as menu_public ...
				((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response_smartphone/jqx_page_template.jsp")).forward(request,response);
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
			log.severe("(op="+op+"): msg="+e+",\nCustomer IP: "+request.getRemoteAddr()+",\n"+all_params+"from SmartPhoneController.java");
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
		((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response_smartphone/jqx_page_template.jsp")).forward(request,response);
	}
	public void forwardErrorPage(HttpServletRequest request,HttpServletResponse response,String msg)throws ServletException, IOException
	{
		request.setAttribute("error_msg", msg+" at "+Utils.currentTimestamp()+"!!!"+
							 "<br><br>"+Message.inform_to_admin_about_exception+"&nbsp;&nbsp;<a href='mailto:"+AuthData.mycompany_email_address+"?subject=("+System.getenv("OPENSHIFT_APP_NAME")+") ERROR NOTIFICATION&body="+msg+"' style='color: #FE5734;text-decoration: underline;'>E-MAIL by Click and Click</a>"+
							 "<br><br>Your IP Address: "+request.getRemoteAddr());
		request.setAttribute("body_panel", "/jsp/error/servlet_error_page.jsp");
		((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response_smartphone/jqx_page_template.jsp")).forward(request,response);
	}

}
