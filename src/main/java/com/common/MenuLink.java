package com.common;

public class MenuLink 
{
	////// PUBLIC MENUS ///////
	public static final String ADMIN_CONTEXT="/admin_controller"; //use it later in this way April-19-2016
	public static final String PUBLIC_CONTEXT="/controller"; //www.webmonster.ca ->this is calling http://www.webmonster.ca/controller
	
	//Home
	public static final String home="";
	
	//Showcase
	public static final String menu_public_showcase=PUBLIC_CONTEXT+"?op=menu_public_showcase";
	//Contact
	public static final String menu_public_contact=PUBLIC_CONTEXT+"?op=menu_public_contact";
	//Stock-Charts
	public static final String menu_public_stockcharts=PUBLIC_CONTEXT+"?op=menu_public_stockcharts";
	//HVAC
	public static final String menu_public_hvac=PUBLIC_CONTEXT+"?op=menu_public_hvac";
	//Saxophone
	public static final String menu_public_saxophone=PUBLIC_CONTEXT+"?op=menu_public_saxophone";

	public static final String webmonster_login=PUBLIC_CONTEXT+"?op=webmonster_login&sm=0";
	public static final String webmonster_logout=PUBLIC_CONTEXT+"?op=webmonster_logout&sm=0";
}
