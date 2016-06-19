package com.common;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

public class GoogleDrive
{
	private  Logger log = Logger.getLogger(this.getClass().getName());
	
	/** Global instance of the JSON factory. */
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
    /** Global instance of the HTTP transport. */
    private static HttpTransport HTTP_TRANSPORT;
    
    /**
     * Scopes for which to request access from the user.
     */
    public static final List<String> SCOPES = Arrays.asList
    (
        // Required to access and manipulate files.
        "https://www.googleapis.com/auth/drive.file",
        // Required to identify the user in our data store.
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/userinfo.profile"
    );

    public static final String CLIENT_SECRETS_FILE_PATH = "/WEB-INF/classes/webmonster-c3052a87df08.json";
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
        }
    }

    private GoogleClientSecrets getClientSecret(ServletContext ctx) throws IOException, Exception
    {
    	log.info("realPath: "+ctx.getRealPath("")+": "+ctx.getResource(CLIENT_SECRETS_FILE_PATH));
    	GoogleClientSecrets secrets=null;
    	try 
    	{
    	      secrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(ctx.getResourceAsStream(CLIENT_SECRETS_FILE_PATH)));
    	      if(secrets!=null)
    	    	  System.out.println("************ Not NULL ***************");
    	      else
    	    	  System.out.println("************ NULL ***************");
    	    	
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
    	return secrets;
    }
    public Credential authorize(ServletContext ctx) throws IOException, Exception
    {
    	return new GoogleCredential.Builder()
                .setClientSecrets(getClientSecret(ctx))
                .setTransport(HTTP_TRANSPORT)
                .setJsonFactory(JSON_FACTORY)
                .build();
    }
}
