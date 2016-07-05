<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page isELIgnored ="false" %>
<script type="text/javascript">
	//see http://jsfiddle.net/jayhilwig/hv8vU/
	$(document).ready(function ()
	{
		$('#manual_tree_div').jstree
		({
			  'core' : 
			  {
				    'multiple' : false,
				    'animation' : 0,
				    'data':
				    [
				     <%
				     	DataSource ds=(DataSource)application.getAttribute("dataSource");
						HvacManualsDao hvacManualsDao=new HvacManualsDao(ds);
						List<String> brands=hvacManualsDao.getBrandNames("where valid=true order by brand_name asc");
						
						//add company link from the enum
						for(int i=0; i<brands.size();i++)
						{
							String brand=brands.get(i);
							out.print("{	'id':     '"+brand+"', ");
							out.print("  	'parent': '#', ");
							out.print("  	'text':   '"+brand+"',");
							out.print("'state' : 'closed',");
							out.print("'children': true")	;						
							out.print("}");
							if((i+1)<brands.size()) out.print(",");
						}
				     %>
				    ],
				    'ajax':
				    {
				    	'url': 'jsp/menu_response/json_hvac/manuals_brands.jsp',
				    	'data': function(node)
				    	{
				    		log("node_id: "+node.id));
				    		return {'id': node.id};
				    	}
				    }
			  }
		});
		
		$('#manual_tree_div').on("changed.jstree", function (e, data) 
		{
			log(data.instance.get_node(data.selected).text); // newly selected
			var node=data.instance.get_node(data.selected);
			if(node.children.length==0)
			{
				log("It's a leaf with a parent ID="+node.parent);
			}
			else
			{
				log("It has children");
			}

		});
	});
</script>  
<% 
	//CarmClinicalSummaryEditBean eb=(CarmClinicalSummaryEditBean)request.getAttribute("carm_clincal_summary_bean");
//The following color is corresponding with energyblue
//style='background-color:#E0E9F5;
%>

<h4>Under Construction</h4>
<table style='table-layout: fixed'>
	<tr>
		<td style='width: 25%'>
			<div id="manual_tree_div" style="border-radius:0px 0px 0px 0px; border:0px solid #000000;">
				<ul>
				<%
					/*
					String sysList[]={"Heating", "Cooling", "Heating Cooling Combo", "Air Handler", "Humidifier"};
					for(HvacBrands brand : HvacBrands.values())
					{
						out.print("<li id='"+brand.toString()+"'>"+brand.ctoString()+"");
						out.print("<ul>");
						for(String sys : sysList)
						{
							out.print("<li data-jstree='{\"icon\":\"glyphicon glyphicon-leaf\"}'>"+sys.toString()+"");
								//out.print("<ul>");
								//	out.print("<li> <span><i class='glyphicon glyphicon-leaf'></i>Model Number</span>  <a href=''>direct link to pdf</a></li>");
								//out.print("</ul>");
							out.print("</li>");
						}
						out.print("</ul>");
						out.print("</li>");
					}
					*/
					/*
					DataSource ds=(DataSource)application.getAttribute("dataSource");
					HvacManualsDao hvacManualsDao=new HvacManualsDao(ds);
					List<String> brands=hvacManualsDao.getBrandNames("where valid=true order by brand_name asc");
					
					//add company link from the enum
					for(String brand : brands)
					{
						out.print("<li id='"+brand+"'>"+brand+"");
						out.print("</li>");
					}
					*/
				%>
				</ul>
			</div>
		</td>
		<td style='width: 75%; border-radius:0px 0px 0px 0px; border:1px solid #dddddd; border-style: hidden hidden hidden solid; vertical-align: top;'>
			hello
		</td>
	</tr>
</table>