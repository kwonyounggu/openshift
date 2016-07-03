package com.enums;

import com.common.Utils;

public enum HvacManualFor
{
	INSTALLATION,
	INSTALLATION_OPERATION_SERVICE,
	OWNER_OPERATION,
	SERVICE,
	BROCHURE,
	PRODUCT_DATA,
	WARRANTY,
	SUPPLEMENT,
	WIRING_DIAGRAM;
	
	public String ctoString()
	{
		String sList[]=super.toString().split("_");
		String temp="";
		for(String s: sList)
		{
			temp+=Utils.getFirstCapitalString(s)+" ";
		}
		return temp.trim();
	}
}
