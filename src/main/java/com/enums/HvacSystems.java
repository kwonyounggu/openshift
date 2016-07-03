package com.enums;

import com.common.Utils;

public enum HvacSystems
{
	AIR_CLEANER,
	AIR_CONDITIONER,
	AIR_HANDLER,
	COOLING,
	DUCTLESS_AIR_CONDITIONER,
	DUSTLESS_HEAT_PUMP,
	FIREPLACE,
	FURNACE,
	HEAT_PUMP,
	HEATING,
	HUMIDIFIER,
	ROOFTOP,
	SPLIT_AIR_CONDITIONER,
	SPLIT_HEAT_PUMP,
	STANDING_BOILER,
	TANKED_WATER_HEATER,
	TANKLESS_WATER_HEATER,
	WALLHUNG_BOILER,
	WATER_HEATER,
	ETC;
	
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
