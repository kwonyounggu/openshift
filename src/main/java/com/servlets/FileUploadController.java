package com.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import java.util.Date;
import java.util.Enumeration;

import java.util.Locale;

import java.util.logging.Logger;

import javax.servlet.ServletConfig;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;



import com.common.Message;
import com.common.Utils;
import com.dropbox.core.DbxException;
import com.dropbox.core.DbxRequestConfig;

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
	//private static String DROPBOX_PATH="";//it can be either /estimates/filename.pdf or /anything/filename.pdf
	private DbxClientV2 _dbxClient=null;
	private Logger log = Logger.getLogger(this.getClass().getName());   
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
		String callResponse=Message.CONTACT_SUCCESS;
		
		try 
		{
			Enumeration<String> params=request.getParameterNames();
			 
			while(params.hasMoreElements())
			{
				Object o=params.nextElement();
				String param=(String)o;
				String value=request.getParameter(param);
				log.info(request.getContextPath()+" Parameter Name is '"+param+"' and Parameter Value is '"+value+"'");
			}		

			 
			//This is to get all items including the form field and file
	        // Collection<Part> parts = request.getParts(); 
	        Part filePart=request.getPart("file_to_upload");
	        
	        if(filePart.getSize()>0)
	        {
	        	//this is to write the file into the local repository, that is, app-root/data/client_file.pdf
	        	// filePart.write(getFileName(filePart)); 
	        	
	        	FileMetadata metaData=null;
	        	uploadToDropbox(_dbxClient, filePart, metaData, request.getParameter("note_msg"), request.getParameter("submitter_name")); //note_msg contains a dropbox path like estimates
	        	//if(metaData!=null)
	        	//{
	        		//update database using json tag
	        	//}
	        }
	        else
	        {
	        	//update database
	        }
		}
		catch(Exception e)
		{	
			log.severe(e.getMessage());
			callResponse="ERROR: "+e.getMessage();
			
			//email to me for notification
			
		}
		//finally
		//{
			response.getWriter().print(callResponse);
		//}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
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

    private void uploadToDropbox(DbxClientV2 dbxClient, Part part, FileMetadata metaData, String dropboxDir, String submitterName) throws Exception
    {
        try
        {
        	log.info("uploadToDropbox is called ...");

        	String dropboxPath="/"+dropboxDir+"/"+renameFileName(getFileName(part), submitterName);//Submitter_File_name_2016_02_13_hh_mm_ss.ext
            metaData = dbxClient.files().uploadBuilder(dropboxPath)
            										 .withMode(WriteMode.ADD)
									                 .withClientModified(new Date())
									                 .uploadAndFinish(part.getInputStream());

             log.info(metaData.toStringMultiline());
        } 
        catch (UploadErrorException e) 
        {
        	log.severe(e.toString());
            throw new Exception(e.getMessage());
        } 
        catch (DbxException e) 
        {
        	log.severe(e.toString());
            throw new Exception(e.getMessage());
        } 
        catch (IOException e) 
        {
        	log.severe(e.toString());
            throw new Exception(e.getMessage());
        }
    }
	private String renameFileName(String initialFileName, String submitterName)
	{
		// Get the extension if the file has one
		initialFileName=initialFileName.replaceAll("\\s+", "_");
		submitterName=submitterName.replaceAll("\\s+", "_");
		String fileExt = "";
		int i = -1;
		if ((i = initialFileName.indexOf(".")) != -1)
		{
			fileExt = initialFileName.substring(i);
			initialFileName = initialFileName.substring(0, i);
		}

		return Utils.getFirstCapitalString(submitterName)+"_"+Utils.getFirstCapitalString(initialFileName) + "_"+Utils.getDateTimeForFileName()+fileExt;
	}

}
