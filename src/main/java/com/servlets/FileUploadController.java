package com.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import java.util.Date;
import java.util.Enumeration;

import java.util.Locale;

import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import com.beans.EstimateRequestsBean;
import com.beans.FileUploadedToDropboxBean;
import com.common.Message;
import com.common.UAgentInfo;
import com.common.Utils;
import com.dao.EstimateRequestsDao;
import com.dao.FileUploadedToDropboxDao;
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
    
	private DataSource _ds=null;
	
    public FileUploadController() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

    public void init(ServletConfig config) 
	{
        _dbxClient = new DbxClientV2(new DbxRequestConfig("webmonster.ca->estimates", Locale.getDefault().toString()), ACCESS_TOKEN);
        _ds=(DataSource) config.getServletContext().getAttribute("dataSource");
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String callResponse=Message.CONTACT_SUCCESS;
		
		try 
		{
			//See what is coming
			Enumeration<String> params=request.getParameterNames();
			while(params.hasMoreElements())
			{
				Object o=params.nextElement();
				String param=(String)o;
				String value=request.getParameter(param);
				log.info(request.getContextPath()+" Parameter Name is '"+param+"' and Parameter Value is '"+value+"'");
			}	
			//detect OS
			UAgentInfo detector = new UAgentInfo(request.getHeader("User-Agent"), request.getHeader("Accept"));
			byte os=0;//0: PC, 1: TABLET, 2: MOBILE/SMART-PHONE
			if(detector.detectTierTablet())  os=1;
		    else if(detector.detectTierIphone()) os=2;
			
			//This is to get all items including the form field and file
	        // Collection<Part> parts = request.getParts(); 
			String typeOfMsg=request.getParameter("note_msg");
			FileUploadedToDropboxBean fb=null;
	        Part filePart=request.getPart("file_to_upload");
	        if(filePart.getSize()>0)
	        {
	        	//this is to write the file into the local repository, that is, app-root/data/client_file.pdf
	        	// filePart.write(getFileName(filePart)); 

	        	fb=uploadToDropbox(_dbxClient, filePart, typeOfMsg, request.getParameter("submitter_name")); //note_msg contains a dropbox path like estimates
	        	
	        	//insert into db table
	        	FileUploadedToDropboxDao fDao=new FileUploadedToDropboxDao(_ds);
	        	fb=fDao.create(fb);
	        }
	        
			//Insert bean data to the corresponding table
			
			if(typeOfMsg.equals("estimates"))
			{
				EstimateRequestsBean eb=new EstimateRequestsBean();
				//eb.setEstimateSeqId(-1);
				String names[]=((String)request.getParameter("submitter_name")).split("\\s+");
				for(String name: names) //Capital for the 1st and 2nd
				{
					eb.setSubmitterName(eb.getSubmitterName()+" "+Utils.getFirstCapitalString(name));
				}
				eb.setSubmitterName(eb.getSubmitterName().trim());//trim left and right
				eb.setSubmitterPhone(request.getParameter("submitter_phone"));
				eb.setSubmitterEmail(request.getParameter("submitter_email"));
				eb.setSubmitterNote(request.getParameter("submitter_note"));
				eb.setSelectAnimal((byte) Integer.parseInt(request.getParameter("animalGroup")));
				if(filePart.getSize()>0)
				{
					eb.setFileSeqId(fb.getFileSeqId());
				}
				
				eb.setOs(os);
				eb.setRemotePlace(request.getParameter("place"));
				eb.setSubmittedTime(Utils.currentTimestamp());
				
				EstimateRequestsDao eDao=new EstimateRequestsDao(_ds);
				eDao.create(eb);
			}

		}
		catch(Exception e)
		{	
			log.severe(e.getMessage());
			callResponse="ERROR: "+e.getMessage();
			
			//email to me for notification
			
		}
		finally //always return with either ERROR or SUCCESS
		{
			response.getWriter().print(callResponse);
		}
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

    private FileUploadedToDropboxBean uploadToDropbox(DbxClientV2 dbxClient, Part part, String dropboxDir, String submitterName) throws Exception
    {
        try
        {
        	log.info("uploadToDropbox is called ...");
        	FileUploadedToDropboxBean fb=new FileUploadedToDropboxBean();
        	fb.setFileNameSubmitted(getFileName(part));
        	String dropboxPath="/"+dropboxDir+"/"+renameFileName(fb.getFileNameSubmitted(), submitterName);//Submitter_File_name_2016_02_13_hh_mm_ss.ext
        	FileMetadata metaData = dbxClient.files().uploadBuilder(dropboxPath)
            										 .withMode(WriteMode.ADD)
									                 .withClientModified(new Date())
									                 .uploadAndFinish(part.getInputStream());

             log.info(metaData.toStringMultiline());
             fb.setDropboxFilePath(dropboxPath);
             fb.setFileSize(Math.round(part.getSize()/1000));
             return fb;
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
