package com.service;
import java.security.Security;
import java.util.*;
import java.util.logging.Logger;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;

import com.common.AuthData;


public class MailService extends Authenticator implements Runnable
{
	private Logger log = Logger.getLogger(this.getClass().getName());
      private String fromAddr;
      private List<String> toAddr;
      private List<String> name;
      private String serverAddr;
      private String subject;
      private String message;
      protected PasswordAuthentication authentication;
      private String _fileName="";
         
      public MailService(String from, List<String> to, List<String> name, String server, String subject, String message, String fileName) 
      {
    	  	this.fromAddr = from;
	        this.toAddr = to;
	        this.name = name;
	        this.serverAddr = server;
	        this.subject = subject;
	        this.message = message;
	        this._fileName=fileName;
	        	        
	        Thread t = new Thread(this);
	  		t.start();
      }
      public void sendMail() 
      {
        try 
        {
        	  //authentication = new PasswordAuthentication("misoon.lim@1mm.primus.ca", "misoon4");
        	  authentication = new PasswordAuthentication(AuthData.email_id, AuthData.email_password);
		    
        	
        	  Properties prop = new Properties();
	          prop.put("mail.smtp.host", serverAddr);
	          Session session = Session.getDefaultInstance(prop, null);
	          session.setDebug(false);
	          // Create a message
	          MimeMessage mimeMsg = new MimeMessage(session);
	          // Set the from and to address
	          Address addressFrom = new InternetAddress(fromAddr,"WEBMONSTER-ADMIN","UTF-8");
	          mimeMsg.setFrom(addressFrom);
	          Address[] to = new InternetAddress[toAddr.size()];
	          for(int i = 0; i < toAddr.size(); i++) to[i] = new InternetAddress((String) toAddr.get(i),name.get(i)+"","UTF-8");
	          mimeMsg.addRecipients(Message.RecipientType.TO, to);//OK
 	          
	          
	          //The following two lines for information to csr administrator every time with every kind of email: added April 24 2013
	          Address[] bcc = {new InternetAddress(AuthData.mycompany_email_address, "WEBMONSTER-ADMIN BCC","UTF-8")};
        	  mimeMsg.addRecipients(Message.RecipientType.BCC, bcc);
	          
	          // ---A Multipart Body Begin ---
	          BodyPart bodyPart1=new MimeBodyPart();
	          bodyPart1.setContent(message, "text/html");
	          
	          BodyPart bodyPart2=null;
	          
	          if(_fileName.length()>0)
	          {
	        	  bodyPart2=new MimeBodyPart();
	        	  bodyPart2.setDataHandler(new DataHandler(new FileDataSource(_fileName)));
		          bodyPart2.setFileName(_fileName.substring(_fileName.lastIndexOf("/")+1));
	          }	          
	          
	          Multipart multipart=new MimeMultipart();
	          multipart.addBodyPart(bodyPart1);
	          if(bodyPart2!=null) multipart.addBodyPart(bodyPart2);
	          // ---A Multipart Body End ---
	          
	          mimeMsg.setSubject(subject,"UTF-8");
	          //mimeMsg.setContent(message, "text/html;charset=UTF-8");
	          mimeMsg.setContent(multipart);
	          
	          Transport.send(mimeMsg);
	          log.info("EMail from "+fromAddr+" to "+toAddr+" was sent successfully.");
        } 
        catch (Exception e) 
        {
        	  log.severe("Unable to send email in sendMail() of MailService.java");
        	  throw new RuntimeException(e);
        }
      }

      public void googleSSLSMTP()
      {
    	  try
    	  {
    		  log.info("Entry point before sending email");
	    	  Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());  
	    	   
	    	  Properties props = new Properties();  
	    	  props.setProperty("mail.transport.protocol", "smtp");  
	    	     
	    	  props.setProperty("mail.host", AuthData.smtp);  
	    	  props.put("mail.smtp.auth", "true");  
	    	  props.put("mail.smtp.port", "465");  
	    	  props.put("mail.debug", "false");  
	    	  props.put("mail.smtp.socketFactory.port", "465");  
	    	  props.put("mail.smtp.socketFactory.class",  "javax.net.ssl.SSLSocketFactory");  
	    	  props.put("mail.smtp.socketFactory.fallback", "false");
	    	  props.put("mail.smtp.quitwait", "false");
	    	    
	    	  Session session = Session.getDefaultInstance(props,  
		    	  new javax.mail.Authenticator() 
		    	  {  
		    		  protected PasswordAuthentication getPasswordAuthentication() 
			    	  {  
			    		  return new PasswordAuthentication(AuthData.email_id, AuthData.email_password);  //this will be return address for delivery failure
			    	  }  
		    	  }
		    	  );  
	    	     
	    	  session.setDebug(AuthData.smtp_debug.equalsIgnoreCase("true"));  
	    	     	    	    
	    	  Transport transport = session.getTransport();  
	    	  
	    	  Address addressFrom = new InternetAddress(fromAddr,"WEBMONSTER-ADMIN","UTF-8");
	    	     
	    	  MimeMessage mimeMsg = new MimeMessage(session);    
	    	  mimeMsg.setFrom(addressFrom);
	    	  
	    	  Address[] to = new InternetAddress[toAddr.size()];
	          for(int i = 0; i < toAddr.size(); i++) to[i] = new InternetAddress((String) toAddr.get(i),name.get(i)+"","UTF-8");
	          mimeMsg.addRecipients(Message.RecipientType.TO, to);//OK  
	          
	          //The following two lines for information to csr administrator every time with every kind of email: added April 18 2013
	          Address[] bcc = {new InternetAddress(AuthData.mycompany_email_address, "WEBMONSTER-ADMIN BCC","UTF-8")};
        	  mimeMsg.addRecipients(Message.RecipientType.BCC, bcc);
	          
	          
	         // ---A Multipart Body Begin ---
	          BodyPart bodyPart1=new MimeBodyPart();
	          bodyPart1.setContent(message, "text/html");
	          
	          BodyPart bodyPart2=null;
	          
	          if(_fileName.length()>0)
	          {
	        	  bodyPart2=new MimeBodyPart();
	        	  bodyPart2.setDataHandler(new DataHandler(new FileDataSource(_fileName)));
	        	  bodyPart2.setFileName(_fileName.substring(_fileName.lastIndexOf("/")+1));
	          }
	          
	          Multipart multipart=new MimeMultipart();
	          multipart.addBodyPart(bodyPart1);
	          if(bodyPart2!=null) multipart.addBodyPart(bodyPart2);
	          // ---A Multipart Body End ---
	          
	          mimeMsg.setSubject(subject,"UTF-8");
	          //mimeMsg.setContent(message, "text/html;charset=UTF-8");
	          mimeMsg.setContent(multipart);

	    	  transport.connect();  
	    	  Transport.send(mimeMsg);  
	    	  transport.close();  
	    	  log.info("EMail from "+fromAddr+" to "+toAddr+" was sent successfully.");

 	     }
 	     catch (Exception e) 
 	     {
 	    	 log.severe("Unable to email to "+toAddr+" in googleSSLSMTP() of MailService.java");
        	 throw new RuntimeException(e);
 	     }
      }
      public void run()
	  {
		  try
		  {	  
			  if(AuthData.smtp.equalsIgnoreCase("smtp.gmail.com")) googleSSLSMTP();
			  else sendMail();
		  }
		  catch(Exception e)
		  {
			  log.severe("emailing to "+toAddr+" has been failed for subject:"+subject+".\nCause:"+e.getMessage());
		  }
		  
	  }
      public PasswordAuthentication getPasswordAuthentication()
	  {		
    	  return authentication;
	  }
}
