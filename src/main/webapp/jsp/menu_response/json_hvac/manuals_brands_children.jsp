<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="com.beans.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page isELIgnored ="false" %>

<% 
response.setContentType("application/json");
/*
[
	{	
		"id":1,
		"text": "Root node",
		"children":[{"id":2,"text":"Child node 1","children":true},{"id":3,"text":"Child node 2"}]}]
*/		
/*
webmonster=# select system_type, count(system_type) from hvac_manuals where brand_name='CARRIER' and valid=true group by system_type order by system_type;                                         system_type   | count
-----------------+-------
 AIR_CONDITIONER |   114
 FURNACE         |   146
(2 rows)

webmonster=# select model_number, count(model_number) from hvac_manuals where brand_name='CARRIER' and system_type='FURNACE' and valid=true group by model_number order by model_number;
model_number  | count
---------------+-------
58CTW_CTY     |     5
58CVA_CVX     |     7
58DLA_DLX     |     6
58PHA_PHX     |     6
58PHB_PHY     |     4
58STA_STX     |     6
59MN7         |    12
59SC2         |     7
59SC2A        |     2
59SC2B        |     3
59SC2C        |     2
59SC5         |    10
59SP2         |     6
59SP2A        |     2
59SP5         |     8
59SP5A        |     4
59TN6         |     8
59TN6A        |     4
59TP5         |     8
59TP5A        |     3
59TP6         |     5
59TP6A        |     1
CBL           |     3
CBM           |     3
CVM           |     3
OBL098_OVL098 |     2
OBL112_OVL112 |     2
OBL154_OVL154 |     1
OBL_OVL       |     3
OBM098_OVM098 |     2
OBM112_OVM112 |     2
OBM154_OVM154 |     1
OBM_OVM       |     5
(33 rows)
select manual_for, count(manual_for) from hvac_manuals where brand_name='CARRIER' and system_type='FURNACE' and model_number='58CTW_CTY' and valid=true group by manual_for order by manual_for;
manual_for           | count
--------------------------------+-------
BROCHURE                       |     1
INSTALLATION                   |     1
INSTALLATION_OPERATION_SERVICE |     1
PRODUCT_DATA                   |     1
WARRANTY                       |     1
(5 rows)

webmonster=# select file_seq_id from hvac_manuals where brand_name='CARRIER' and system_type='FURNACE' and model_number='58CTW_CTY' and manual_for='INSTALLATION' and valid=true order by file_seq_id;
file_seq_id
-------------
         22
(1 row)

*/

%>

[
<% 
	response.setContentType("application/json");
	
	System.out.println("currentId="+request.getParameter("id")+", hint:"+request.getParameter("hint")+", parentId="+request.getParameter("parent"));
	String currentId=request.getParameter("id");
	
	DataSource ds=(DataSource)application.getAttribute("dataSource");
	HvacManualsDao hvacManualsDao=new HvacManualsDao(ds);
	String parentId=request.getParameter("parent");
	
	if(parentId.equals("#"))//when brand names are clicked
	{
		Map<String, Integer> sysTypes=hvacManualsDao.getKeysValues("select system_type, count(system_type) from hvac_manuals where brand_name='"+currentId+"' and valid=true group by system_type order by system_type asc");
		
		//Note: each property and value are expected double-quatationed
		Iterator<Map.Entry<String, Integer>> entries = sysTypes.entrySet().iterator();
		while(entries.hasNext())
		{
			Map.Entry<String, Integer> entry=entries.next();
			out.print("{	\"id\":     \""+currentId+":"+entry.getKey()+"\", "); //brand:ac, furnace, etc
			//out.print("  	\"parent\": \"#\", ");
			out.print("  	\"text\":   \""+entry.getKey()+" ("+entry.getValue()+")\",");//number of manuals
			out.print("  	\"data\": {\"hint\":\"system types such as ac, furnance, etc\"}, ");
			if(entry.getValue()>0)
				out.print("		\"children\": true");						
			out.print("}");
			if(entries.hasNext()) out.print(",");
		}
	}
	
	else  //when ac, furnace is clicked 
	{		
		String sysType=currentId.split(":")[1];//only system type
		Map<String, Integer> sysTypes=hvacManualsDao.getKeysValues("select model_number, count(model_number) from hvac_manuals where brand_name='"+parentId+"' and system_type='"+sysType+"' and valid=true group by model_number order by model_number asc");
		Iterator<Map.Entry<String, Integer>> entries = sysTypes.entrySet().iterator();
		
		while(entries.hasNext())
		{
			Map.Entry<String, Integer> entry=entries.next();
			out.print("{	\"id\":     \""+currentId+":"+entry.getKey()+"\", "); //brand:ac:model_number
			out.print("  	\"text\":   \""+entry.getKey()+" ("+entry.getValue()+")\",");//number of model_number
			out.print("  	\"data\": {\"hint\":\"model number level\"} ");
			if(entry.getValue()>0)
			{	
				out.print(",		\"children\": [");					
				Map<String, Integer> manualFor=hvacManualsDao.getKeysValues("select manual_for, count(manual_for) from hvac_manuals where brand_name='"+parentId+"' and system_type='"+sysType+"' and model_number='"+entry.getKey()+"' and valid=true group by manual_for order by manual_for asc");
				Iterator<Map.Entry<String, Integer>> entriesManualFor = manualFor.entrySet().iterator();
				
				while(entriesManualFor.hasNext())
				{
					Map.Entry<String, Integer> manualEntry=entriesManualFor.next();
					out.print("{	\"id\":     \""+currentId+":"+entry.getKey()+":"+manualEntry.getKey()+"\", "); //brand:ac:model_number:owner_manual
					out.print("  	\"text\":   \""+manualEntry.getKey()+" ("+manualEntry.getValue()+")\",");//number of manualFor
					out.print("  	\"data\": {\"hint\":\"manuals for installation, owner_operation, wiring_diagram, etc\"} ");
					if(manualEntry.getValue()>0)
					{	
						out.print(",		\"children\": [");	
						Map<String, String> fileMap=hvacManualsDao.getKeysValuesForFiles("select file_seq_id from hvac_manuals where brand_name='"+parentId+"' and system_type='"+sysType+"' and model_number='"+entry.getKey()+"' and manual_for='"+manualEntry.getKey()+"' and valid=true order by file_seq_id asc");
						Iterator<Map.Entry<String, String>> fileEntries = fileMap.entrySet().iterator();
						
						while(fileEntries.hasNext())
						{
							Map.Entry<String, String> fileEntry=fileEntries.next();
							out.print("{	\"id\":     \""+fileEntry.getKey()+"\", "); //unique id
							//out.print("  	\"text\":   \""+fileEntry.getValue()+"\",");//original file name
							out.print("  	\"text\":   \"file.pdf\",");//original file name
							out.print("     \"icon\":   \"glyphicon glyphicon-leaf\",");
							out.print("  	\"data\": {\"hint\":\"pdf file link level, leaf level\"} ");
							out.print("}");
							if(fileEntries.hasNext()) out.print(",");
						}				
						out.print("]");					
					}
					out.print("}");
					if(entriesManualFor.hasNext()) out.print(",");
				}
				out.print("]");
			}
			out.print("}");
			if(entries.hasNext()) out.print(",");
		}
	}
%>
]

