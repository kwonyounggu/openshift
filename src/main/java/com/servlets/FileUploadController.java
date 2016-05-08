package com.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;
import java.util.Map.Entry;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.dropbox.core.DbxException;
import com.dropbox.core.DbxRequestConfig;
import com.dropbox.core.v1.DbxClientV1;
import com.dropbox.core.v1.DbxWriteMode;
import com.dropbox.core.v2.DbxClientV2;
import com.dropbox.core.v2.files.FileMetadata;
import com.dropbox.core.v2.files.UploadErrorException;
import com.dropbox.core.v2.files.WriteMode;

/**
 * Servlet implementation class FileUploadController
 * see https://blog.openshift.com/multipart-forms-and-file-uploads-with-tomcat-7/
 * see http://docs.oracle.com/javaee/6/tutorial/doc/glraq.html
 * see for google dirve, http://www.coderanch.com/t/643263/Servlets/java/upload-file-Google-drive-java
 * see for free cloud like openshift, http://i-pholta.rhcloud.com/?p=168
 * dropbox info
 * App key 9l70upjz1cjocwc
 * App secret 2j7mrali5k07ykf
 * App folder name: webmonster
 * Access token: b3c4WiWzNgAAAAAAAAAAB7OVomREroFuSCcV-xJWdvLJrJ8271YWPv3W7w8OLALb
 */
@WebServlet(name = "fileupload", urlPatterns = { "/fileupload" })
@MultipartConfig(location = "/var/lib/openshift/56ddb9c10c1e66c9db000081/app-root/data")
public class FileUploadController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private static final String ACCESS_TOKEN="b3c4WiWzNgAAAAAAAAAAB7OVomREroFuSCcV-xJWdvLJrJ8271YWPv3W7w8OLALb";
	private DbxClientV2 _dbxClient=null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUploadController() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

    public void init(ServletConfig config) 
	{
        _dbxClient = new DbxClientV2(new DbxRequestConfig("webmonster.ca->estimates", Locale.getDefault().toString()), ACCESS_TOKEN);
	    //this.config = config;
	    //app = config.getServletContext();
	    //cp=(ConnectionPool)app.getAttribute("connectionPool");
	    //mssqlDao=(MedicationSafetySQLDao)app.getAttribute("mssqlDao");
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		
		String callResponse = "from Server";
		//File uploadFile=null;
		
		try 
		{
			Enumeration<String> params=request.getParameterNames();
			 
			while(params.hasMoreElements())
			{
				Object o=params.nextElement();
				String param=(String)o;
				String value=request.getParameter(param);
				System.out.println("Parameter Name is '"+param+"' and Parameter Value is '"+value+"'");
			}		
			//PrintWriter out = response.getWriter();
			 
	        //Collection<Part> parts = request.getParts();
	        Part filePart=request.getPart("file_to_upload");
	        if(filePart.getSize()>0)
	        {
	        	//filePart.write(getFileName(filePart));//this is to write the file into the local repository, that is, data
	        	uploadToDropbox(_dbxClient, filePart);
	        }
      
	        //out.write("<h2> Total parts : " + parts.size() + "</h2>");
	 /*
	        for (Part part : parts) 
	        {
	        	
	            printEachPart(part, out);
	            System.out.println("part.getHeaderNames()"+part.getHeaderNames());
	            for (String header : part.getHeaderNames()) 
	            {
	            	System.out.println(header+ " : "+ part.getHeader(header));
	            }
	            System.out.println("part.getName()"+part.getName());
	            System.out.println("part.getSize()"+part.getSize());
	            
	            if(part.getName().equals("file_to_upload") && part.getSize()>0) part.write(getFileName(part));
	        }
				*/
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
		{	//error handling, see, http://docs.oracle.com/javaee/6/tutorial/doc/glraq.html
			
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
	private void printEachPart(Part part, PrintWriter pw) 
	{
        StringBuffer sb = new StringBuffer();
        sb.append("<p>");
        sb.append("Name : " + part.getName());
        sb.append("<br>");
        sb.append("Content Type : " + part.getContentType());
        sb.append("<br>");
        sb.append("Size : " + part.getSize());
        sb.append("<br>");
        for (String header : part.getHeaderNames()) 
        {
            sb.append(header + " : " + part.getHeader(header));
            sb.append("<br>");
        }
        sb.append("</p>");
        pw.write(sb.toString());
 
    }
 
    private String getFileName(Part part) 
    {
    	
        String partHeader = part.getHeader("content-disposition");
        for (String cd : partHeader.split(";")) 
        {
            if (cd.trim().startsWith("filename")) 
            {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
    private void uploadToDropbox(DbxClientV2 dbxClient, Part part) 
    {
        try
        {
        	System.out.println("uploadToDropbox is called ...");
        	
        	String clientFileName=getFileName(part);
        	String dropboxPath="/estimates/"+clientFileName;
            FileMetadata metadata = dbxClient.files().uploadBuilder(dropboxPath)
                .withMode(WriteMode.ADD)
                .withClientModified(new Date())
                .uploadAndFinish(part.getInputStream());

            System.out.println(metadata.toStringMultiline());
        } 
        catch (UploadErrorException ex) 
        {
            System.err.println("Error uploading to Dropbox: " + ex.getMessage());
            //System.exit(1);
        } 
        catch (DbxException ex) 
        {
            System.err.println("Error uploading to Dropbox: " + ex.getMessage());
            //System.exit(1);
        } 
        catch (IOException ex) 
        {
            System.err.println("Error reading from file \"" + getFileName(part) + "\": " + ex.getMessage());
            //System.exit(1);
        }
    }
    /*
    public void uploadToDropbox (Part part, String fileName, DbxClientV1 dbxClient) throws IOException 
    {

        try 
        {
        	System.out.println("uploadToDropbox is called ...");
            dbxClient.uploadFile(fileName, DbxWriteMode.add(), part.getSize(), part.getInputStream());
        } 

        catch (DbxException e) 
        {
            e.printStackTrace();
            //uploadFIS.close();
            System.err.println("Error in upload(): " + e.getMessage());
            //System.exit(1);
            //return;         
        }
    }
    */
}
