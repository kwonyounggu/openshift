package com.servlets;
//Note: this servlet is not used for this app, May 24,, 2016
import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;
import org.apache.commons.fileupload.*;

import javax.servlet.ServletException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
//import org.apache.commons.lang.StringEscapeUtils;

//import com.sickkids.caliper.common.MenuLink;
//import com.sickkids.caliper.common.Message;
import com.common.Utils;

//import com.sickkids.caliper.dao.MedicationSafetySQLDao;
//import com.sickkids.caliper.database.ConnectionPool;
//import com.sickkids.caliper.service.FileUploadListener;
//import com.sickkids.caliper.service.MailInfo;

public class FileUploadServlet extends HttpServlet implements Servlet 
{
	private static final long serialVersionUID = 2740693677625051632L;

	private ServletConfig config=null;
	private ServletContext app=null;
	//private ConnectionPool cp = null;
	
	public static List<String> emailList=new ArrayList<String>();
	public static List<String> nameList=new ArrayList<String>();
	
	//private MedicationSafetySQLDao mssqlDao=null;

	public void init(ServletConfig config) 
	{
	    this.config = config;
	    app = config.getServletContext();
	    //cp=(ConnectionPool)app.getAttribute("connectionPool");
	    //mssqlDao=(MedicationSafetySQLDao)app.getAttribute("mssqlDao");
	}

	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
		super.doGet(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("doPost() in FileUploadServlet.java");
		String ajaxUpdateResult = "from Server";
		File uploadFile=null;
		
		try 
		{
			List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
			String studyId="000000";
			for (FileItem item : items) 
			{
				System.out.println("item="+item.getFieldName());
				
				if (item.isFormField()) 
				{
					ajaxUpdateResult += "Field " + item.getFieldName() + " with value: " + item.getString() + " is successfully read\n\r";
					if(item.getFieldName().equals("studyId")) studyId=item.getString();
				} 
				else 
				{
					System.out.println("non form field="+item.getFieldName()+" "+ item.getName());
					
					String doc_file_link="/";//from the root of the context such as 8080/exemplar/uploaded_files/ms_doc
					String loc=app.getRealPath(doc_file_link);
					//File path=new File(loc+"uploaded_files/ms_doc");//change to this if the following way to display back to the user is no good.
					File path=new File(System.getProperty("catalina.home")+"/uploaded_files/ms_doc");

					if(!path.exists()||!path.isDirectory()) path.mkdirs();
					uploadFile=rename(new File(path+"/"+item.getName()),"sid_"+studyId);
					item.write(uploadFile);//write the coming file with the given name
		
					doc_file_link="uploaded_files/ms_doc/"+uploadFile.getName();
					ajaxUpdateResult += "File " + item.getName() + " is successfully uploaded to "+uploadFile.getPath()+"\n\r";
				}
			}
			//mssqlDao.updateInsertGenericSqlCmd(StringEscapeUtils.escapeJava("update ex_study set full_text_pdf1='"+uploadFile.getPath()+"' where study_id="+studyId));
		} 
		catch (FileUploadException e) 
		{
			if(uploadFile!=null && uploadFile.exists()) 
			{
				uploadFile.delete();
			}

			//Utils.logger.severe("(op=exemplar/file_upload): msg="+e+",\nCustomer IP: "+request.getRemoteAddr()+",\nfrom FileUploadServlet.java");
			emailList.clear();
			nameList.clear();
			//emailList.add(Utils.csr_email_address);
			nameList.add("CSR-ADMIN");
			//new MailInfo(Utils.csr_email_address, emailList, nameList, Utils.smtp,"FileUpload Failed", "(op=exemplar/file_upload): "+e+"<br><br> Generated at "+Utils.currentTimestamp()+".");
			forwardErrorPage(request,response,e.toString());
		} 
		catch(Exception e)
		{			
			if(uploadFile!=null && uploadFile.exists()) 
			{
				uploadFile.delete();
			}

			//Utils.logger.severe("(op=exemplar/file_upload): msg="+e+",\nCustomer IP: "+request.getRemoteAddr()+",\nfrom FileUploadServlet.java");
			emailList.clear();
			nameList.clear();
			//emailList.add(Utils.csr_email_address);
			nameList.add("CSR-ADMIN");
			//new MailInfo(Utils.csr_email_address, emailList, nameList,Utils.smtp,"FileUpload Failed", "(op=exemplar/file_upload): "+e+"<br><br> Generated at "+Utils.currentTimestamp()+".");
			forwardErrorPage(request,response,e.toString());
		}
		
		response.getWriter().print(ajaxUpdateResult);
	}
	public void forwardWarningPage(HttpServletRequest request,HttpServletResponse response,String msg)throws ServletException, IOException
	{	
		request.setAttribute("warning_msg", msg+" at "+Utils.currentTimestamp()+"!!!");		
		request.setAttribute("body_panel", "error/servlet_warning_page.jsp");
		((RequestDispatcher)request.getRequestDispatcher("jsp/local_page_template.jsp")).forward(request,response);
	}
	public void forwardErrorPage(HttpServletRequest request,HttpServletResponse response,String msg)throws ServletException, IOException
	{	
		//request.setAttribute("error_msg", msg+" false: at "+Utils.currentTimestamp()+"!!!"+
		//					 "<br><br>"+Message.inform_to_admin_about_exception+"&nbsp;&nbsp;<a href='mailto:"+Utils.csr_email_address+"?subject=EXEMPLAR FILE UPLOAD ERROR NOTIFICATION' style='color: #FE5734;text-decoration: underline;'>E-MAIL</a>"+
		//					 "<br><br>Your IP Address: "+request.getRemoteAddr());		
		request.setAttribute("body_panel", "error/servlet_error_page.jsp");
		((RequestDispatcher)request.getRequestDispatcher("jsp/local_page_template.jsp")).forward(request,response);
	}
	public File rename(File f, String standard_file_name)
	{

		// Get the parent directory path as in h:/home/user or /home/user
		String parentDir = f.getParent();

		// Get filename without its path location, such as 'index.txt'
		String fname = f.getName();

		// Get the extension if the file has one
		String fileExt = "";
		int i = -1;
		if ((i = fname.indexOf(".")) != -1)
		{

			fileExt = fname.substring(i);
			fname = fname.substring(0, i);
		}

		fname = standard_file_name + "_"+Utils.getDateTimeForFileName();
		System.out.println("1st fname="+fname+" ext="+fileExt);
		fname = parentDir + System.getProperty("file.separator") + fname + fileExt;
		System.out.println("2nd fname="+fname+" ext="+fileExt);

		File temp = new File(fname);

		return temp;
	}
}