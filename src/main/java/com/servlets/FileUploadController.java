package com.servlets;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class FileUploadController
 */
@WebServlet(name = "fileupload", urlPatterns = { "/fileupload" })
public class FileUploadController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUploadController() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		
		String callResponse = "from Server";
		//File uploadFile=null;
		
		try 
		{
			boolean isFileUpload=ServletFileUpload.isMultipartContent(request);
			if(isFileUpload)
				System.out.println("Yes, a file upload is requested ...");
			else
				System.out.println("No, a file upload is not requested ...");
			
			/*
			List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
			System.out.println("doGet() is called in FileUploadController, items.size()="+items.size());
			//String studyId="000000";
			for (FileItem item : items) 
			{
				System.out.println("item="+item.getFieldName());
				
				if (item.isFormField()) 
				{
					callResponse += "Field " + item.getFieldName() + " with value: " + item.getString() + " is successfully read\n\r";
					//if(item.getFieldName().equals("studyId")) studyId=item.getString();
				} 
				else 
				{
					System.out.println("non form field="+item.getFieldName()+" "+ item.getName());
					callResponse+=item.getFieldName()+" "+item.getName()+"\n\r";
					
					String doc_file_link="/";//from the root of the context such as 8080/exemplar/uploaded_files/ms_doc
					String loc=app.getRealPath(doc_file_link);
					
					File path=new File(System.getProperty("catalina.home")+"/uploaded_files/ms_doc");

					if(!path.exists()||!path.isDirectory()) path.mkdirs();
					uploadFile=rename(new File(path+"/"+item.getName()),"sid_"+studyId);
					item.write(uploadFile);//write the coming file with the given name
		
					doc_file_link="uploaded_files/ms_doc/"+uploadFile.getName();
					
					//callResponse += "File " + item.getName() + " is successfully uploaded to "+uploadFile.getPath()+"\n\r";
				}
			}
			*/
			//mssqlDao.updateInsertGenericSqlCmd(StringEscapeUtils.escapeJava("update ex_study set full_text_pdf1='"+uploadFile.getPath()+"' where study_id="+studyId));
		} 
		/*catch (FileUploadException e) 
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
			
			
		} */
		catch(Exception e)
		{	
			/*
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
			*/
		}
		
		response.getWriter().print(callResponse);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
