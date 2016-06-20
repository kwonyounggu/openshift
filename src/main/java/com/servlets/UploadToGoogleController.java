package com.servlets;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;

import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
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
import com.common.AuthData;
import com.common.GoogleDrive;
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
import com.dropbox.core.v2.sharing.SharedLinkMetadata;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.InputStreamContent;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.FileList;
import com.service.MailService;

/**
 * Servlet implementation class UploadToGoogleController
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
@WebServlet(name = "uploadToGoogleController", urlPatterns = { "/uploadToGoogleController" })
@MultipartConfig(location = "/var/lib/openshift/56ddb9c10c1e66c9db000081/app-root/data")
public class UploadToGoogleController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	//**** Google Drive ****//
	private static String googleErrorMsg = "Google Error in ";
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
    private static HttpTransport HTTP_TRANSPORT;
    public static final List<String> SCOPES = Arrays.asList
    (
        // Required to access and manipulate files.
        "https://www.googleapis.com/auth/drive.file",
        // Required to identify the user in our data store.
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/userinfo.profile"
    );
    
    //public static final String CLIENT_SECRETS_FILE_PATH = "/client_secret_drive_api_quickstart.json";
    public static final String CLIENT_SECRETS_FILE_PATH = "/client_secret_WebMonster-Upload-To-Google-Drive.json";
    //public static final String CLIENT_SECRETS_FILE_PATH = "/WEB-INF/classes/client_secret_WebMonster-Upload-To-Google-Drive.json";
    static 
    {
        try 
        {
            HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        } 
        catch (Throwable t) 
        {
            t.printStackTrace();
            System.err.println("ERROR: failed in getting HTTP_TRANSPORT, msg="+t);
            googleErrorMsg+=t;
        }
    }
    private static final String GOOGLE_ACCESS_TOKEN="ya29.Ci8HA_f3lCb8WLyjP8cTYIuY2C3-YNkxK5ILdfuajHqTdIt3n1AXbnJKADmshRkWFg";
    private static final String GOOGLE_REFRESH_TOKEN="1/PA7qcR_rplwgog0T6eWQaxdM81GP6f1uNMOY1KvpaVc";
	private static final String ACCESS_TOKEN="b3c4WiWzNgAAAAAAAAAAB7OVomREroFuSCcV-xJWdvLJrJ8271YWPv3W7w8OLALb";
	//private static String DROPBOX_PATH="";//it can be either /estimates/filename.pdf or /anything/filename.pdf
	private DbxClientV2 _dbxClient=null;
	private Logger log = Logger.getLogger(this.getClass().getName());   
    
	private DataSource _ds=null;
	private GoogleCredential _googleCredential=null;
    public UploadToGoogleController() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

    public void init(ServletConfig config) 
	{
        _dbxClient = new DbxClientV2(new DbxRequestConfig("webmonster.ca->estimates", Locale.getDefault().toString()), ACCESS_TOKEN);
        _ds=(DataSource) config.getServletContext().getAttribute("dataSource");
        
        try
		{
			_googleCredential=authorize(config.getServletContext()); 
		}
		catch (Exception e)
		{
			log.severe("Exeption with +"+e);
			e.printStackTrace();
			googleErrorMsg+=e+" in calling authorize(ctx)";
		}
     
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
			/*
			String typeOfMsg=request.getParameter("note_msg");
			String submitterName=request.getParameter("submitter_name").trim();
			FileUploadedToDropboxBean fb=null;
			*/
	        Part filePart=request.getPart("file_to_upload");
	        
	        //log.info("GoogleCredential: "+ (_googleCredential==null));
	        
	        if(filePart!=null && filePart.getSize()>0)
	        {
	        	//this is to write the file into the local repository, that is, app-root/data/client_file.pdf
	        	// filePart.write(getFileName(filePart)); 

	        	////->fb=uploadToDropbox(_dbxClient, filePart, "typeOfMsg", "submitterName"); //note_msg contains a dropbox path like estimates
	        	
	        	//insert into db table
	        	////->FileUploadedToDropboxDao fDao=new FileUploadedToDropboxDao(_ds);
	        	////->fb=fDao.create(fb);
	        	if(_googleCredential!=null)
	        		uploadToGoogleDrive(_googleCredential, filePart.getName(), "", "image/jpeg", filePart.getInputStream());
	        	else
	        		throw new Exception(googleErrorMsg);
	        }
	        /*
			//Insert bean data to the corresponding table
			
			if(typeOfMsg.equals("estimates"))
			{
				EstimateRequestsBean eb=new EstimateRequestsBean();
				
				String names[]=submitterName.split("\\s+");
				for(String name: names) //Capital for the 1st and 2nd
				{
					eb.setSubmitterName(eb.getSubmitterName()+" "+Utils.getFirstCapitalString(name));
				}
				eb.setSubmitterName(eb.getSubmitterName().trim());//remove the 1st white space inserted from the above for loop
				eb.setSubmitterPhone(request.getParameter("submitter_phone"));
				eb.setSubmitterEmail(request.getParameter("submitter_email"));
				eb.setSubmitterNote(request.getParameter("submitter_note"));
				eb.setSelectAnimal((byte) Integer.parseInt(request.getParameter("animalGroup")));
				if(filePart.getSize()>0)
				{
					eb.setFileSeqId(fb.getFileSeqId());
					eb.setFb(fb); //just for an additional information
				}
				
				eb.setOs(os);
				eb.setRemotePlace(request.getParameter("client_place"));
				eb.setSubmittedTime(Utils.currentTimestamp());
				
				EstimateRequestsDao eDao=new EstimateRequestsDao(_ds);
				eDao.create(eb);
				
				email("", "", "Contact/Estimate - Success", eb.toMyCompany());
				email(eb.getSubmitterEmail(), eb.getSubmitterName(), "Contact/Estimate", eb.toClient());
			}
			*/
		}
		catch(Exception e)
		{	
			e.printStackTrace();
			log.severe(e+", written in the catch block (Exception e) - 1st level");
			callResponse="ERROR: "+e.toString();
			
			try
			{
				email("", "", "Contact/Estimate - Failure", callResponse);	
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
    //https://developers.google.com/drive/v2/reference/files/insert#examples
    //parentId ID folder drive
    
    //Login, webmonster.ca@gmail.com with koreaandong
    //Google Authentication information from https://console.developers.google.com/iam-admin/serviceaccounts/project?project=webmonster-0001
    //Service account name: webmonster
    //Key ID: c3052a87df08fee5cbcb47ac101beddf063306a3
    //Service Account ID: webmonster@webmonster-0001.iam.gserviceaccount.com
    
    //from playground
    //Content-type: application/json; charset=UTF-8
    //{
    //		  "access_token": "ya29.Ci8FA1yMytGjXM3QexGwqucDMYiQvV6DW9EhsN32OS7scsIZE3bXENNcvH4Bvr4VTg", 
    //		  "token_type": "Bearer", 
    //		  "expires_in": 3600, 
    //		  "refresh_token": "1/qKdriHaaN-2ooX8Ve-AZqxh2lL9ZUxpIGfSUmhioxgQ"
    //}
    

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
             fb.setDropboxFilePath("https://www.dropbox.com/home/Apps/webmonster/estimates?preview="+metaData.getName());
             fb.setFileSize(Math.round(part.getSize()/1000));
             
             //Uncomment if you need. June 2nd, 2016
             //The followings such as setting to share and its link are working when you want to send a shared link to people
             //SharedLinkMetadata sharedData=dbxClient.sharing().createSharedLinkWithSettings(metaData.getPathLower());
             //fb.setDropboxFilePath(sharedData.getUrl());
             //log.info(sharedData.toStringMultiline());
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
	
	//***** Google Drive Management *****//
    private GoogleClientSecrets getClientSecret(ServletContext ctx) throws IOException, Exception
    {

    	try 
    	{
    		return GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(UploadToGoogleController.class.getResourceAsStream(CLIENT_SECRETS_FILE_PATH)));
    	    //  return GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(ctx.getResourceAsStream(CLIENT_SECRETS_FILE_PATH)));    	    	
    	} 
    	catch (IOException e) 
    	{
    		log.severe("***** IOExeption with +"+e.getMessage()+" ************");
    		e.printStackTrace();
    	    throw new IOException("IOException, client_secrets.json is missing or invalid.\n"+e);
    	}
    	catch(Exception e)
    	{
    		log.severe("***** Exeption with +"+e.getMessage()+" ************");
    		e.printStackTrace();
    		throw new Exception("Exception, client_secrets.json is missing or invalid.\n"+e);
    	}
    }
    
    public GoogleCredential authorize(ServletContext ctx) throws IOException, Exception
    {
    	GoogleCredential googleCredential=new GoogleCredential.Builder()
                .setClientSecrets(getClientSecret(ctx))
                .setTransport(HTTP_TRANSPORT)
                .setJsonFactory(JSON_FACTORY)
                //.setServiceAccountId( "webmonster@webmonster-0001.iam.gserviceaccount.com" )
                //.setServiceAccountScopes(Arrays.asList(DriveScopes.DRIVE))
                .build();
    	//googleCredential.setRefreshToken(GOOGLE_REFRESH_TOKEN);
    	
    	return googleCredential;
    }
    public File uploadToGoogleDrive(GoogleCredential credential,String title, String parentId, String mimeType, InputStream stream) throws IOException, Exception
    {
    	System.out.println("----------- 1 -----------credential="+credential.getAccessToken());
    	Drive driveService = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, null).setHttpRequestInitializer(credential).setApplicationName("DRIVE_TEST").build();
        // File's metadata.
        File body = new File();
        body.setName(title);
        body.setMimeType(mimeType);
        System.out.println("----------- 2 -----------");
        // Set the parent folder.
        if (parentId != null && parentId.length() > 0) 
        {
          //body.setParents(
          //    Arrays.asList(new ParentReference().setId(parentId)));
        }

        // File's content.
        InputStreamContent mediaContent = new InputStreamContent(mimeType, new BufferedInputStream(stream));  
        try 
        {
     	   //return driveService.files().create(body, mediaContent).execute();
        	FileList result = driveService.files().list()
   	             .setPageSize(100)
   	             .setFields("nextPageToken, files(id, name)")
   	             .execute();
   	        System.err.println("----------------------  4  -----------------------------");
   	        List<File> files = result.getFiles();
   	        if (files == null || files.size() == 0) 
   	        {
   	            System.out.println("No files found.");
   	        } 
   	        else 
   	        {
   	            System.out.println("------------- Files: ------------------");
   	            for (File file : files) 
   	            {
   	                System.out.printf("%s (%s)\n", file.getName(), file.getId());
   	            }
   	        }
   	        return null;
        } 
        catch (IOException e) 
        {	System.out.println("----------- 3 -----------");
          log.severe("Uploading "+body.getName()+" has been failed!");
          throw new IOException(e);
        }    
     }
    /*
     private File uploadFile(Part part) throws IOException 
     {
        File fileMetadata = new File();
        fileMetadata.setName(getFileName(part));
        fileMetadata.setMimeType("image/jpeg");

        FileContent mediaContent = new FileContent("image/jpeg", part.);

        Drive.Files.Insert insert = drive.files().insert(fileMetadata, mediaContent);
        MediaHttpUploader uploader = insert.getMediaHttpUploader();
        uploader.setDirectUploadEnabled(true);
        return insert.execute();
      }
      */
}
