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

import com.common.Message;
import com.common.Utils;

public class TabletController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
    public TabletController() 
    {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		log.info("doGet() is called in TabletController.java");

		request.setCharacterEncoding("UTF-8");//put this otherwise UNI-Code characters will be broken.
		
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control","no-store,no-cache, must-revalidate, post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		HttpSession session = request.getSession(true);//if(session.isNew())
		
		String op=(String)request.getParameter("op");
		log.info("op="+op+" in TabletController.java");
		
		try
		{if(true) throw new Exception("ERROR TESTING ...............................................");
			//Here, first check if the person is logged-in, otherwise go back to the public home
			Object webmonsterBean=(Object)session.getAttribute("webmonsterBean");
			if(webmonsterBean==null)
			{
				if(op==null || op.equals("") || op.equals("home"))
				{
					request.setAttribute("body_panel", "/jsp/menu_response_tablet/jqx_home_body.jsp");
					((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response_tablet/jqx_page_template.jsp")).forward(request,response);
		
				}
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
			log.severe("(op="+op+"): msg="+e+",\nCustomer IP: "+request.getRemoteAddr()+",\n"+all_params+"from TabletController.java");
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
		((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response_tablet/jqx_page_template.jsp")).forward(request,response);
	}
	public void forwardErrorPage(HttpServletRequest request,HttpServletResponse response,String msg)throws ServletException, IOException
	{
		request.setAttribute("error_msg", msg+" at "+Utils.currentTimestamp()+"!!!"+
							 "<br><br>"+Message.inform_to_admin_about_exception+"&nbsp;&nbsp;<a href='mailto:"+"webmonster.ca@gmail.com"+"?subject=("+System.getenv("OPENSHIFT_APP_NAME")+") ERROR NOTIFICATION&body="+msg+"' style='color: #FE5734;text-decoration: underline;'>E-MAIL by Click and Click</a>"+
							 "<br><br>Your IP Address: "+request.getRemoteAddr());
		request.setAttribute("body_panel", "/jsp/error/servlet_error_page.jsp");
		((RequestDispatcher)request.getRequestDispatcher("jsp/menu_response_tablet/jqx_page_template.jsp")).forward(request,response);
	}

}
