package com.common;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Message 
{
	//webmonster.ca
	public static final String CONTACT_SUCCESS="Thank you for contacting me - I will get back to you soon!";
	
	//webmonster admin mail information in default
	public static List<String> toEmailList=new ArrayList<String>();
	public static List<String> toEmailNameList=new ArrayList<String>();
	
	
	//csr
	public static final String check_usage_agreement="You must check up on the agreement.";
	
	public static final String login_false="Either your email or password is wrong.";
	public static final String logout_false="An error has occurred.";
	public static final String session_out="Your session is timed out. Please login and try again.";
	
	public static final String incorrect_email_password="Niether your email or password is correct.";
	
	public static final String check_email="Please check your email.";
	public static final String non_existing_email="Your email is not existing in the database system.";
	public static final String emailed_password="Your password has been emailed to the given email address.\n\nPlease check your password and try to login again!";
	public static final String incorrect_email="It's not a right email.";
	public static final String correct_email="Your email is usable.";
	public static final String email_in_use="It is being used by one.\n(※ Use 'Forgot password' if you forogt.)";
	
	public static final String check_password="Please check your password one more time.\nBoth passwords are not identical or empty";
	public static final String incorrect_password="Your password is not correct. Please check if [Caps Lock] is turned on.";
	public static final String incorrect_delete_password="It is not a right password to erase.";
	
	public static final String check_korean_name="---.";
	
	public static final String check_eng_name="Please check your name.";
	public static final String incorrect_eng_name="It's not a right name.";
	public static final String correct_eng_name="It's is usable.";
	public static final String eng_name_in_use="It is being used by one.";
	
	public static final String check_phone_number="Please check your phone number.";
	
	public static final String check_address="Please check your address.";
	public static final String check_security_code="Your secure code is not matching.";
	public static final String check_security_code2="Your secure code is not matching.";
	
	public static final String check_search_word="Please check your search word.";
	public static final String check_subject="Please check the title.";
	public static final String check_text_msg="Please check the contents of your writing.";
	
	public static final String general_error_msg="An error has occurred.";
	public static final String inform_to_admin_about_exception="Please email to the admin of this web site.";
	public static final String inform_to_admin_about_exception_en="Please let us know about this error.";
	public static final String inform_to_admin_about_exception2="We will try to fix the problem as soon as possible.";
	
	
	
}
