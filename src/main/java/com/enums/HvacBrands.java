package com.enums;

import com.common.Utils;

/*
Trane, which also makes American Standard
Carrier, which owns Bryant, Payne and Tempstar
Lennox, which owns Ducane, Armstrong, Concord, Allied and AirEase
Rheem, which owns Ruud
Goodman, which makes Amana and Janitrol
York, which makes Coleman and Luxaire
Nortek Global HVAC, which makes Maytag, Westinghouse, Frigidaire, Kelvinator and others
 * */
public enum HvacBrands
{
	AAON,
	ADDISON,
	AIR_EASE,
	AIRE_FLO,
	AIRQUEST,
	ALLIED,
	AMANA,
	AMERICAN_STANDARD,
	ARCO,
	ARKLA,
	ARMSTRONG,
	BARD,
	BOHN,
	BRYANT,
	CARRIER,
	CENTURY,
	CLIMATEMASTER,
	COLEMAN,
	COMFORTAIRE,
	COMFORTMAKER,
	COMMAND_AIRE,
	CONCORD,
	CONSOLIDATED,
	COOLERATOR,
	CRANE,
	CUMBERLAND,
	DAIKIN_US,
	DAY_NIGHTDELCO,
	DUCANE,
	DUNHAM_BUSH,
	DUOMATIC_OLSEN,
	ELECTRIC_FURNACE_MAN,
	EUBANK,
	FANDAIRE,
	FEDDERS,
	FRASER_JOHNSTON,
	FRIEDRICH,
	FRIGIDAIRE,
	GAFFERS_SATTLER,
	GENERAL_ELECTRIC,
	GOODMAN,
	GREEN_COLONIAL,
	HALL_NEAL_FURNACE,
	HASTINGS,
	HEIL_QUAKER,
	HENRY_FURNACE,
	HOME_FURNACE,
	INTERNATIONAL_COMFORT,
	INTERNATIONAL_OIL_BURNER,
	INTERTHERM,
	IRON_FIREMAN ,
	JANITROL,
	JOHNSON,
	KELVINATOR,
	LENNOX,
	LUXAIRE,
	MAGIC_CHEF,
	MAYFLOWER,
	MAYTAG,
	McGRAW_EDISON,
	McQUAY,
	McQuay,
	MILLER,
	MITCHELL,
	MONCRIEF,
	MUELLER_CLIMATROL,
	NATIONAL_US_RADIATOR_CAPITOLAIRE,
	NESBITT,
	NIAGRA,
	NORTEK,
	OLSEN,
	ONEIDA_ROYAL,
	PAYNE,
	PEERLESS_HEATER,
	PERFECTION,
	RHEEM,
	ROUND_OAK,
	RUUD,
	RYBOLT,
	SILENT_AUTOMATIC,
	SINGER,
	SOUTHWEST_MFG,
	SPACE_CONDITIONER,
	SQUARE_D,
	STEWART_WARNER,
	TAPPAN,
	TEMPSTAR,
	THERMOPRODUCTS,
	TORRIDHEET,
	TRANE,
	WATERBURY,
	WATERFURNACE,
	WEATHERKING,
	WESTINGHOUSE,
	WHIRLPOOL,
	WILLIAMS_OIL_O_MATIC,
	WILLIAMSON,
	WORTHINGTON,
	YORK,
	ETC;
	
	//Return like Oneida Royal
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
