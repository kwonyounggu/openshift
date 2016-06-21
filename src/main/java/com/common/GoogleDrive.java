package com.common;

import java.io.IOException;

import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletContext;

import com.exceptions.GoogleCredentialFailureException;
import com.exceptions.GoogleInvalidClientSecretException;
import com.google.api.client.auth.oauth2.Credential;

import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;

import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.drive.Drive;

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

public class GoogleDrive
{	
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

    public static final String CLIENT_SECRETS_FILE_PATH = "/client_secret.json";
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

    private static GoogleClientSecrets getClientSecret() throws GoogleInvalidClientSecretException
    {
    	try
    	{
    		return GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(GoogleDrive.class.getResourceAsStream(CLIENT_SECRETS_FILE_PATH)));
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    		throw new GoogleInvalidClientSecretException("client_secrets.json is missing or invalid");
    	}
    }
    public static Credential authorize() throws GoogleInvalidClientSecretException, GoogleCredentialFailureException
    {
    	try
    	{
	    	return new GoogleCredential.Builder()
	                .setClientSecrets(getClientSecret())
	                .setTransport(HTTP_TRANSPORT)
	                .setJsonFactory(JSON_FACTORY)
	                .build();
    	}
    	catch(GoogleInvalidClientSecretException e)
    	{
    		throw new GoogleInvalidClientSecretException(e);
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    		throw new GoogleCredentialFailureException("Failed in building GoogleCredential");
    	}
    }
    public static Drive getDrive() throws Exception
    {
    	return new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, authorize()).setApplicationName("webmonster").build();
    }
   
}
