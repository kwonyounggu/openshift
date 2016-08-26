package com.enums;

import com.common.Utils;

public enum HvacManualFor
{
	 BROCHURE,
	 INSTALLATION,
	 OWNER_MANUAL,
	 PRODUCT_DATA,
	 SERVICE,
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
