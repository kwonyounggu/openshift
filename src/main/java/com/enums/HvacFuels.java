package com.enums;

import com.common.Utils;

public enum HvacFuels
{
	GAS,
	ELECTRIC,
	GEOTHERMAL,
	REFRIGERANT,
	REFRIGERANT_R22,
	REFRIGERANT_R410A,
	GAS_ELECTRIC,
	GAS_GEOTHERMAL,
	GEOTHERMAL_REFRIGERANT_R22,
	GEOTHERMAL_REFRIGERANT_R410A,
	OIL,
	WOOD,
	ETC;
	
	//Return like Refrigenrant R22
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
