package com.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
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
import com.beans.HvacManualsBean;
import com.common.AuthData;
import com.common.Message;
import com.common.UAgentInfo;
import com.common.Utils;
import com.dao.EstimateRequestsDao;
import com.dao.FileUploadedToDropboxDao;
import com.dao.HvacManualsDao;
import com.dropbox.core.DbxException;
import com.dropbox.core.DbxRequestConfig;

import com.dropbox.core.v2.DbxClientV2;
import com.dropbox.core.v2.files.FileMetadata;
import com.dropbox.core.v2.files.UploadErrorException;
import com.dropbox.core.v2.files.WriteMode;
import com.dropbox.core.v2.sharing.SharedLinkMetadata;
import com.service.MailService;

/**
 * Servlet implementation class FileUploadController
 * see https://blog.openshift.com/multipart-forms-and-file-uploads-with-tomcat-7/
 * see http://docs.oracle.com/javaee/6/tutorial/doc/glraq.html
 * see for google dirve, http://www.coderanch.com/t/643263/Servlets/java/upload-file-Google-drive-java
 * see for free cloud like openshift, http://i-pholta.rhcloud.com/?p=168
 * dropbox info
 * App key: j40wegbajqatru8
 * App secret: 4c856im8xpvxkkp
 * App folder name: hvac_files
 * Access token: mey4fjRB1jAAAAAAAAAABz1DHDZLGWNoUvZRmtWTHKAEvf8OYuZ9Jj-1M5J10zMa
 * 
 * owner: myesl.education@gmail.com
 * pwd: korea안동
 */
/*
 * Temporary
 * Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'hvacManualType' and Parameter Value is 'SYSTEM'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'hvacBrands' and Parameter Value is 'AAON'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'hvacSpaceType' and Parameter Value is 'RESIDENTIAL'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'hvacSystemType' and Parameter Value is 'AIR_CONDITIONER'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'hvacSystemModel' and Parameter Value is 'KBS123'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'hvacManualFor' and Parameter Value is 'INSTALLATION'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'submittingCompanyId' and Parameter Value is '1'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'hvacFuelType' and Parameter Value is 'GAS'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'select_animal' and Parameter Value is 'a'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'animalGroup' and Parameter Value is '3'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'client_place' and Parameter Value is 'Toronto Ontario Canada'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'submitterName' and Parameter Value is 'Admin'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController doGet
INFO:  Parameter Name is 'dropboxDir' and Parameter Value is 'systemManuals'
Jun 22, 2016 5:15:08 PM com.servlets.HvacFileUploadController uploadToDropbox
INFO: uploadToDropbox is called ...
Jun 22, 2016 5:15:10 PM com.servlets.HvacFileUploadController uploadToDropbox
INFO: {
  ".tag" : "file",
  "name" : "Admin_Laplaya2_2016_06_22_17_15_08.jpg",
  "path_lower" : "/systemmanuals/admin_laplaya2_2016_06_22_17_15_08.jpg",
  "path_display" : "/systemManuals/Admin_Laplaya2_2016_06_22_17_15_08.jpg",
  "id" : "id:lnKvckdO7MAAAAAAAAAAAQ",
  "client_modified" : "2016-06-22T21:15:08Z",
  "server_modified" : "2016-06-22T21:15:10Z",
  "rev" : "44a30f50b",
  "size" : 77559
}
Jun 22, 2016 5:15:11 PM com.servlets.HvacFileUploadController uploadToDropbox
INFO: {
  ".tag" : "file",
  "url" : "https://www.dropbox.com/s/kczw3a2e85c7lnd/Admin_Laplaya2_2016_06_22_17_15_08.jpg?dl=0",
  "name" : "Admin_Laplaya2_2016_06_22_17_15_08.jpg",
  "link_permissions" : {
    "can_revoke" : true,
    "resolved_visibility" : "other",
    "requested_visibility" : "public"
  },
  "client_modified" : "2016-06-22T21:15:08Z",
  "server_modified" : "2016-06-22T21:15:10Z",
  "rev" : "44a30f50b",
  "size" : 77559,
  "id" : "id:lnKvckdO7MAAAAAAAAAAAQ",
  "path_lower" : "/systemmanuals/admin_laplaya2_2016_06_22_17_15_08.jpg"
}
Jun 22, 2016 5:15:11 PM com.servlets.HvacFileUploadController uploadToDropbox
INFO: File SeqID: -1
DropBox File Path: https://www.dropbox.com/s/kczw3a2e85c7lnd/Admin_Laplaya2_2016_06_22_17_15_08.jpg?dl=0
File Name Submitted: LaPlaya2.jpg
File Size (Kb): 77

 * */
@WebServlet(name = "hvacfileupload", urlPatterns = { "/hvacfileupload" })
@MultipartConfig(location = "/var/lib/openshift/56ddb9c10c1e66c9db000081/app-root/data")
public class HvacFileUploadController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private static final String ACCESS_TOKEN="mey4fjRB1jAAAAAAAAAABz1DHDZLGWNoUvZRmtWTHKAEvf8OYuZ9Jj-1M5J10zMa";
	//private static String DROPBOX_PATH="";//it can be either /system_manuals/filename.pdf or /anything/filename.pdf
	private DbxClientV2 _dbxClient=null;
	private Logger log = Logger.getLogger(this.getClass().getName());   
    
	private DataSource _ds=null;
	
    public HvacFileUploadController() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

    public void init(ServletConfig config) 
	{
        _dbxClient = new DbxClientV2(new DbxRequestConfig("webmonster.ca->system_manuals", Locale.getDefault().toString()), ACCESS_TOKEN);
        _ds=(DataSource) config.getServletContext().getAttribute("dataSource");
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String callResponse=Message.HVAC_UPLOAD_SUCCESS;
		
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
			
		    String dropboxDir=request.getParameter("dropboxDir");
			String submitterName=request.getParameter("submitterName").trim();
			
			//Default values for the followings, but change later if changed
			//String dropboxDir="systemManuals";
			//String submitterName="Admin";
			FileUploadedToDropboxBean fb=null;
	        Part filePart=request.getPart("file_to_upload");
	        
	        if(filePart.getSize()>0)
	        {
	        	//this is to write the file into the local repository, that is, app-root/data/client_file.pdf
	        	// filePart.write(getFileName(filePart)); 

	        	fb=uploadToDropbox(_dbxClient, filePart, dropboxDir, submitterName); //note_msg contains a dropbox path like estimates
	        	
	        	//insert into db table
	        	FileUploadedToDropboxDao fDao=new FileUploadedToDropboxDao(_ds);
	        	fb=fDao.create(fb);
	        }
	        
			//Insert bean data to the corresponding table
			
			if(dropboxDir.equals("systemManuals"))
			{
				HvacManualsBean hb=new HvacManualsBean();
				
				hb.setManualType(request.getParameter("hvacManualType"));
				hb.setBrandName(request.getParameter("hvacBrands"));
				hb.setSpaceType(request.getParameter("hvacSpaceType"));
				hb.setSystemType(request.getParameter("hvacSystemType"));
				hb.setModelNumber(((String)request.getParameter("hvacSystemModel")).toUpperCase());
				hb.setManualFor(request.getParameter("hvacManualFor"));
				hb.setFuelType(request.getParameter("hvacFuelType"));
				hb.setSubmittingCompanyId(Integer.parseInt(request.getParameter("submittingCompanyId")));
				if(filePart.getSize()>0)
				{
					hb.setFileSeqId(fb.getFileSeqId());
					hb.setFb(fb); //just for an additional information
				}
				hb.setOs(os);
				hb.setRemotePlace(request.getParameter("client_place"));
				hb.setSubmissionTime(Utils.currentTimestamp());
				hb.setValid(true);
				
				HvacManualsDao hDao=new HvacManualsDao(_ds);
				hDao.create(hb);
				
				//the following email can be for a customer upload this file
				//email("", "", "Contact/Estimate - Success", eb.toMyCompany());
				//email(eb.getSubmitterEmail(), eb.getSubmitterName(), "Contact/Estimate", eb.toClient());
			}
		}
		catch(Exception e)
		{	
			log.severe(e+", written in the catch block (Exception e) - 1st level");
			callResponse="ERROR: "+e.toString();
			
			try
			{
				email("", "", "UPLOAD -> HVAC - Failure", callResponse);	
			}
			catch(Exception e2)
			{
				log.severe(e2+", written in the catch block (Exception e) - 2nd level");
			}
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
        	//temporary
        	URL pdfUrl=new URL("http://www.utcccs-cdn.com/hvac/docs/1009/Public/00/58CV-13SI.pdf");
        	        	
        	log.info("uploadToDropbox is called ...");
        	FileUploadedToDropboxBean fb=new FileUploadedToDropboxBean();
        	fb.setFileNameSubmitted(getFileName(part));
        	String dropboxPath="/"+dropboxDir+"/"+renameFileName(fb.getFileNameSubmitted(), submitterName);//Submitter_File_name_2016_02_13_hh_mm_ss.ext
        	FileMetadata metaData = dbxClient.files().uploadBuilder(dropboxPath)
            										 .withMode(WriteMode.ADD)
									                 .withClientModified(new Date())
									                 .uploadAndFinish(pdfUrl.openStream());
									                 //.uploadAndFinish(part.getInputStream());

        	 //Uncomment if you want the file for preview later, june 23-2016
             //log.info(metaData.toStringMultiline());
             //fb.setDropboxFilePath("https://www.dropbox.com/home/Apps/webmonster/estimates?preview="+metaData.getName());
             
             
             fb.setFileSize(Math.round(part.getSize()/1000));
             
             //Uncomment if you need. June 2nd, 2016
             //The followings such as setting to share and its link are working when you want to send a shared link to people
             SharedLinkMetadata sharedData=dbxClient.sharing().createSharedLinkWithSettings(metaData.getPathLower());
             fb.setDropboxFilePath(sharedData.getUrl());
             log.info(sharedData.toStringMultiline());
             log.info(fb.toString());
             
             return null;
             //return fb;
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
	private String email(String recipientEmail, String recipientName, String subject, String msgBody) throws Exception
	{
		try
		{
			//log.info("email("+recipientEmail+", "+recipientName+", "+subject+", "+msgBody+")");
			if(recipientEmail.length()>0)
				new MailService(AuthData.email_id, Arrays.asList(recipientEmail), Arrays.asList(recipientName), AuthData.smtp, subject, msgBody,"");
			else //Message.toEmailList and Message.toEmailNameList are empty
			{
				if(!Message.toEmailList.isEmpty())
				{	
					Message.toEmailList.clear();
					Message.toEmailNameList.clear();
				}
				new MailService(AuthData.email_id, Message.toEmailList, Message.toEmailNameList, AuthData.smtp, subject, msgBody,"");
			}
		}
		catch(Exception e)
		{
			log.severe(e.getMessage());
			throw new Exception(e);
		}
		return "E-Mail SUCCESS";
	}
}
