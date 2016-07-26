package com.enums;

import com.common.Utils;

public enum HvacSystems
{
	AC_COIL,
	AIR_CLEANER,
	AIR_CONDITIONER,
	AIR_HANDLER,
	FIREPLACE,
	FURNACE,
	HEAT_PUMP,
	HUMIDIFIER,
	ROOFTOP,
	BOILER,
	PACKAGED_UNIT,
	WATER_HEATER,
	COMBI_BOILER;
	
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
