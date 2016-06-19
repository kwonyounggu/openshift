package com.common;


public class MenuLink 
{
	////// ADMIN MENUS ///////
	public static final String ADMIN_CONTEXT="/adminController"; //use it later in this way April-19-2016
	
	public static final String admin_home="/adminController";

	public static final String admin_menu_hvac_upload=ADMIN_CONTEXT+"?op=admin_menu_hvac_upload";

	public static final String admin_login=ADMIN_CONTEXT+"?op=admin_login&sm=0";
	public static final String admin_logout=ADMIN_CONTEXT+"?op=admin_logout&sm=0";
	
	//------------------------------------------------------------------------------------------------------------------------------
	public static final String PC_CONTEXT="/controller"; //www.webmonster.ca ->this is calling http://www.webmonster.ca/controller
	
	//Home
	public static final String pc_home="/controller";
	
	//Showcase
	public static final String pc_menu_public_showcase=PC_CONTEXT+"?op=menu_public_showcase";
	//Contact
	public static final String pc_menu_public_contact=PC_CONTEXT+"?op=menu_public_contact";
	//Stock-Charts
	public static final String pc_menu_public_stockcharts=PC_CONTEXT+"?op=menu_public_stockcharts";
	//HVAC
	public static final String pc_menu_public_hvac=PC_CONTEXT+"?op=menu_public_hvac";
	//Saxophone
	public static final String pc_menu_public_saxophone=PC_CONTEXT+"?op=menu_public_saxophone";

	public static final String webmonster_login=PC_CONTEXT+"?op=webmonster_login&sm=0";
	public static final String webmonster_logout=PC_CONTEXT+"?op=webmonster_logout&sm=0";
	
	//----------------------------------------------------------------------------------------------------------------------------------------//
	
	public static final String PHONE_CONTEXT="/smartphoneController"; //www.webmonster.ca ->this is calling http://www.webmonster.ca/controller
	
	//Home
	public static final String phone_home="/smartphoneController";
	
	//Showcase
	public static final String phone_menu_public_showcase=PHONE_CONTEXT+"?op=menu_public_showcase";
	//Contact
	public static final String phone_menu_public_contact=PHONE_CONTEXT+"?op=menu_public_contact";
	//Stock-Charts
	public static final String phone_menu_public_stockcharts=PHONE_CONTEXT+"?op=menu_public_stockcharts";
	//HVAC
	public static final String phone_menu_public_hvac=PHONE_CONTEXT+"?op=menu_public_hvac";
	//Saxophone
	public static final String phone_menu_public_saxophone=PHONE_CONTEXT+"?op=menu_public_saxophone";
	
	//----------------------------------------------------------------------------------------------------------------------------------------//
	
	public static final String TABLET_CONTEXT="/tabletController"; //www.webmonster.ca ->this is calling http://www.webmonster.ca/controller
	
	//Home
	public static final String tablet_home="/tabletController";
	
	//Showcase
	public static final String tablet_menu_public_showcase=TABLET_CONTEXT+"?op=menu_public_showcase";
	//Contact
	public static final String tablet_menu_public_contact=TABLET_CONTEXT+"?op=menu_public_contact";
	//Stock-Charts
	public static final String tablet_menu_public_stockcharts=TABLET_CONTEXT+"?op=menu_public_stockcharts";
	//HVAC
	public static final String tablet_menu_public_hvac=TABLET_CONTEXT+"?op=menu_public_hvac";
	//Saxophone
	public static final String tablet_menu_public_saxophone=TABLET_CONTEXT+"?op=menu_public_saxophone";
}
