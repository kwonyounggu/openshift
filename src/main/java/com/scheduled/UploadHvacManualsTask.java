package com.scheduled;

import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.logging.Logger;

import javax.servlet.http.Part;
import javax.sql.DataSource;

import com.beans.FileUploadedToDropboxBean;
import com.beans.HvacManualsBean;
import com.beans.HvacManualsScheduledBean;
import com.common.AuthData;
import com.common.Message;
import com.common.Utils;
import com.dao.FileUploadedToDropboxDao;
import com.dao.HvacManualsDao;
import com.dao.HvacManualsScheduledDao;
import com.dropbox.core.DbxException;
import com.dropbox.core.DbxRequestConfig;
import com.dropbox.core.v2.DbxClientV2;
import com.dropbox.core.v2.files.FileMetadata;
import com.dropbox.core.v2.files.UploadErrorException;
import com.dropbox.core.v2.files.WriteMode;
import com.dropbox.core.v2.sharing.SharedLinkMetadata;
import com.service.MailService;

import it.sauronsoftware.cron4j.Task;
import it.sauronsoftware.cron4j.TaskExecutionContext;

public class UploadHvacManualsTask extends Task
{
	private static final long serialVersionUID = 1L;
	private static final String ACCESS_TOKEN="mey4fjRB1jAAAAAAAAAABz1DHDZLGWNoUvZRmtWTHKAEvf8OYuZ9Jj-1M5J10zMa";
	//private static String DROPBOX_PATH="";//it can be either /system_manuals/filename.pdf or /anything/filename.pdf
	private DbxClientV2 _dbxClient=null;
	private Logger log = Logger.getLogger(this.getClass().getName()); 
	private DataSource _ds=null;
	
	public UploadHvacManualsTask(DataSource ds)
	{
		_dbxClient = new DbxClientV2(new DbxRequestConfig("webmonster.ca->system_manuals", Locale.getDefault().toString()), ACCESS_TOKEN);
		_ds=ds;
	}
	@Override
	public void execute(TaskExecutionContext arg0) throws RuntimeException
	{
		HvacManualsScheduledDao sDao=new HvacManualsScheduledDao(_ds);
		FileUploadedToDropboxDao fDao=new FileUploadedToDropboxDao(_ds);
		HvacManualsDao hDao=new HvacManualsDao(_ds);
		
		List<HvacManualsScheduledBean> listToUpload=sDao.getRecordsToUpload("where is_uploaded=false and valid=true;");
		for(HvacManualsScheduledBean sb : listToUpload)
		{
			try
			{
				// read the table hvac_manuals_scheduled
				// upload, update tables file_uploaded_to_dropbox, hvac_manuals			
				FileUploadedToDropboxBean fb=uploadToDropboxFromURL(_dbxClient, sb, "systemManuals", "Scheduled_admin_"+sb.getBrandName()+"_"+sb.getSystemType()+"_"+sb.getManualFor());
				fb=fDao.create(fb);
	        	
	        	HvacManualsBean hb=new HvacManualsBean();
				
				hb.setManualType(sb.getManualType());
				hb.setBrandName(sb.getBrandName());
				hb.setSpaceType(sb.getSpaceType());
				hb.setSystemType(sb.getSystemType());
				hb.setModelNumber(sb.getModelNumber());
				hb.setManualFor(sb.getManualFor());
				hb.setFuelType(sb.getFuelType());
				hb.setSubmittingCompanyId(sb.getSubmittingCompanyId());
				
				hb.setFileSeqId(fb.getFileSeqId());
				hb.setFb(fb); //just for an additional information
				
				hb.setOs((byte) 0);
				hb.setRemotePlace("Scheduled Task");
				hb.setSubmissionTime(Utils.currentTimestamp());
				hb.setValid(true);
				
				
				hDao.create(hb);
				
				// update table, hvac_manuals_scheduled
				sDao.update("update hvac_manuals_scheduled set is_uploaded=true, uploaded_time='"+Utils.currentTimestamp()+"' where hvac_manual_scheduled_seq_id="+sb.getHvacManualScheduledSeqId()+";");
			}
			catch (Exception e)
			{
				e.printStackTrace();
				try
				{
					email("", "", "Upload Hvac Manuals in Scheduled time - Failure", e.getMessage());
				}
				catch (Exception e1)
				{
					e1.printStackTrace();
				}
				
			}
		}
		
	}
    private FileUploadedToDropboxBean uploadToDropboxFromURL(DbxClientV2 dbxClient, HvacManualsScheduledBean hb, String dropboxDir, String submitterName) throws Exception
    {
        try
        {
        	//http://stackoverflow.com/questions/4797593/java-io-ioexception-server-returned-http-response-code-403-for-url
        	URL pdfUrl=new URL(hb.getFileUrl());
        	//if you don't put the property, uc.addRequestProperty, then there will be  an error, 403 for URL
            URLConnection uc=pdfUrl.openConnection();
            uc.addRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");
            
        	        	
        	log.info("uploadToDropboxFromURL is called ...");
        	FileUploadedToDropboxBean fb=new FileUploadedToDropboxBean();
        	fb.setFileNameSubmitted(getFileName(hb.getFileUrl()));
        	String dropboxPath="/"+dropboxDir+"/"+renameFileName(fb.getFileNameSubmitted(), submitterName);//Submitter_File_name_2016_02_13_hh_mm_ss.ext
        	FileMetadata metaData = dbxClient.files().uploadBuilder(dropboxPath)
            										 .withMode(WriteMode.ADD)
									                 .withClientModified(new Date())
									                 .uploadAndFinish(uc.getInputStream());

        	 //Uncomment if you want the file for preview later, june 23-2016
             //log.info(metaData.toStringMultiline());
             //fb.setDropboxFilePath("https://www.dropbox.com/home/Apps/webmonster/estimates?preview="+metaData.getName());
             
             
             fb.setFileSize(Math.round(uc.getContentLength()/1000));
             
             //Uncomment if you need. June 2nd, 2016
             //The followings such as setting to share and its link are working when you want to send a shared link to people
             SharedLinkMetadata sharedData=dbxClient.sharing().createSharedLinkWithSettings(metaData.getPathLower());
             fb.setDropboxFilePath(sharedData.getUrl());
             log.info(sharedData.toStringMultiline());
             log.info(fb.toString());
             
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
    private String getFileName(String url) 
    {
    	return url.substring( url.lastIndexOf('/')+1, url.length() );
    }
    private String getFileNameWithoutExtension(String url) 
    {
    	String fileName=getFileName(url);
    	return fileName.substring(0, fileName.lastIndexOf('.'));
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
