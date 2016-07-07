<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
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
	
	System.out.println("currentId="+request.getParameter("id"));
	String currentId=request.getParameter("id");
	
	DataSource ds=(DataSource)application.getAttribute("dataSource");
	HvacManualsDao hvacManualsDao=new HvacManualsDao(ds);
	
	if(currentId.startsWith("ST:")) //provide model_number, manual_for, file_link
	{
		String parentId=request.getParameter("parent");
		System.out.println("parent.id="+request.getParameter("parent"));
		Map<String, Integer> sysTypes=hvacManualsDao.getKeysValues("select model_number, count(model_number) from hvac_manuals where brand_name='"+parentId+"' and system_type='"+currentId.substring(3)+"' and valid=true group by model_number order by model_number asc");
		Iterator<Map.Entry<String, Integer>> entries = sysTypes.entrySet().iterator();
		while(entries.hasNext())
		{
			Map.Entry<String, Integer> entry=entries.next();
			out.print("{	\"id\":     \""+entry.getKey()+"\", "); //model_number
			out.print("  	\"text\":   \""+entry.getKey()+" ("+entry.getValue()+")\",");//number of model_number
			if(entry.getValue()>0)
			{	
				out.print("		\"children\": [");					
				Map<String, Integer> manualFor=hvacManualsDao.getKeysValues("select manual_for, count(manual_for) from hvac_manuals where brand_name='"+parentId+"' and system_type='"+currentId.substring(3)+"' and model_number='"+entry.getKey()+"' and valid=true group by manual_for order by manual_for asc");
				Iterator<Map.Entry<String, Integer>> entriesManualFor = manualFor.entrySet().iterator();
				while(entriesManualFor.hasNext())
				{
					Map.Entry<String, Integer> manualEntry=entries.next();
					out.print("{	\"id\":     \""+manualEntry.getKey()+"\", "); //installation, owner_operation
					out.print("  	\"text\":   \""+manualEntry.getKey()+" ("+manualEntry.getValue()+")\",");//number of manualFor
					if(manualEntry.getValue()>0)
					{	/*
						out.print("		\"children\": [");	
						Map<String, Integer> fileMap=hvacManualsDao.getKeysValues("select file_seq_id from hvac_manuals where brand_name='CARRIER' and system_type='FURNACE' and model_number='58CTW_CTY' and manual_for='INSTALLATION' and valid=true order by file_seq_id asc");
						Iterator<Map.Entry<String, Integer>> fileEntries = fileMap.entrySet().iterator();
						while(fileEntries.hasNext())
						{
							Map.Entry<String, Integer> fileEntry=entries.next();
							out.print("{	\"id\":     \""+fileEntry.getKey()+"\", "); //installation, owner_operation
							out.print("  	\"text\":   \""+fileEntry.getKey()+" ("+fileEntry.getValue()+")\",");//number of manualFor
							out.print("}");
							if(fileEntries.hasNext()) out.print(",");
						}
						out.print("]");
						*/
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
	else if(!currentId.equals("#"))//provide system types
	{
		Map<String, Integer> sysTypes=hvacManualsDao.getKeysValues("select system_type, count(system_type) from hvac_manuals where brand_name='"+currentId+"' and valid=true group by system_type order by system_type asc");
		
		//Note: each property and value are expected double-quatationed
		Iterator<Map.Entry<String, Integer>> entries = sysTypes.entrySet().iterator();
		while(entries.hasNext())
		{
			Map.Entry<String, Integer> entry=entries.next();
			out.print("{	\"id\":     \"ST:"+entry.getKey()+"\", "); //ac, furnace, etc
			//out.print("  	\"parent\": \"#\", ");
			out.print("  	\"text\":   \""+entry.getKey()+" ("+entry.getValue()+")\",");//number of manuals
			if(entry.getValue()>0)
				out.print("		\"children\": true");						
			out.print("}");
			if(entries.hasNext()) out.print(",");
		}
	}
%>
]

