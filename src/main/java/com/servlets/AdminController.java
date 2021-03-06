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

/*
 * see http://stackoverflow.com/questions/16235399/upload-file-into-google-drive-using-java-api
 * see http://www.codejava.net/java-ee/servlet/webservlet-annotation-examples, ref: about how to handle comments and their quote
 * */

@WebServlet(name = "admin", urlPatterns = { "/adminController" })
public class AdminController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
    public AdminController() 
    {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		log.info("doGet() is called in AdminController.java");
		
		request.setCharacterEncoding("UTF-8");//put this otherwise UNI-Code characters will be broken.
		
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control","no-store,no-cache, must-revalidate, post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		HttpSession session = request.getSession(true);//if(session.isNew())
		
		String op=(String)request.getParameter("op");
		log.info("op="+op+" in AdminController.java");
		
		
		try
		{
			//Here, first check if the person is logged-in, otherwise go back to the public home
			Object adminBean=(Object)session.getAttribute("adminBean"); //check this for the user if logged in or not, with 'if(adminBean==null)'
			if(op==null || op.equals("") || op.equals("home"))
			{
				request.setAttribute("body_panel", "/jsp/admin_menu_response/home_body.jsp");
				//((RequestDispatcher)request.getRequestDispatcher("jsp/admin_menu_response/page_template.jsp")).forward(request,response);
	
			}
			else if(op.indexOf("menu")!=-1)
			{
				if(op.equals("admin_menu_hvac_upload"))
				{
					request.setAttribute("body_panel", "/jsp/admin_menu_response/hvac_upload.jsp");
				}
				/*else if(op.equals("menu_public_contact"))
				{
					request.setAttribute("body_panel", "/jsp/menu_response/jqx_public_contact.jsp");
				}
				else if(op.equals("menu_public_stockcharts"))
				{
					request.setAttribute("body_panel", "/jsp/menu_response/jqx_public_stockcharts.jsp");
				}
				else if(op.indexOf("menu_public_hvac")!=-1)
				{
					if(op.equals("menu_public_hvac"))
						request.setAttribute("body_panel", "/jsp/menu_response/jqx_public_hvac.jsp");
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
					request.setAttribute("body_panel", "/jsp/menu_response/jqx_public_saxophone.jsp");
				}
				*/
				
				//common to all the menu listed above, such as menu_public ...
				//((RequestDispatcher)request.getRequestDispatcher("jsp/admin_menu_response/page_template.jsp")).forward(request,response);
			}
			else if(op.equals("admin_login"))
			{
				request.setAttribute("body_panel", "/jsp/admin_menu_response/home_body.jsp");
			}
			else if(op.equals("admin_logout"))
			{
				request.setAttribute("body_panel", "/jsp/admin_menu_response/home_body.jsp");
			}
			else 
			{
				request.setAttribute("body_panel", "/jsp/admin_menu_response/home_body.jsp");
			}
			((RequestDispatcher)request.getRequestDispatcher("jsp/admin_menu_response/page_template.jsp")).forward(request,response);
			
			
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
			log.severe("(op="+op+"): msg="+e+",\nCustomer IP: "+request.getRemoteAddr()+",\n"+all_params+"from AdminController.java");
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
