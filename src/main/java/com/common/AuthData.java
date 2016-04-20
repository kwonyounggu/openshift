package com.common;

import java.util.ResourceBundle;

public class AuthData
{
	public static String database_name;
	public static String user_name;
	public static String password;
	public static String host_name;
	
	public static String email_id;
	public static String email_password;
	public static String smtp;
	public static String smtp_debug;
	public static String error_email_address;
	public static String log_dir_file;
	public static String log_file;
	public static String my_home_page;
	public static String mycompany_email_address;
	public static String mycompany_owner_email_address;
	
	static 
    {
        try 
        {
            ResourceBundle bundle = ResourceBundle.getBundle("database");
            database_name=bundle.getString("database_name");
            user_name=bundle.getString("user_name");  
            password=bundle.getString("password");
            host_name=bundle.getString("host_name");
            
            bundle = ResourceBundle.getBundle("general_information");            
            email_id=bundle.getString("smtp_email_id");
            email_password=bundle.getString("smtp_email_password");
            smtp=bundle.getString("smtp");
            smtp_debug=bundle.getString("smtp_debug");
            mycompany_email_address=bundle.getString("mycompany_email_address");
            error_email_address=bundle.getString("error_email_address");
            mycompany_owner_email_address=bundle.getString("mycompany_owner_email_address");
            log_dir_file=bundle.getString("log_dir_file");
            log_file=bundle.getString("log_file");
            my_home_page=bundle.getString("my_home_page");
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    }
}

