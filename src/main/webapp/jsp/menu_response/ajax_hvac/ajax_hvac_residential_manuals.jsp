<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>
<script type="text/javascript">
	//see http://jsfiddle.net/jayhilwig/hv8vU/
	$(document).ready(function ()
	{
		$('#residential_manual_tree_div').jstree
		({
			  "core" : 
			  {
				    "multiple" : false,
				    "animation" : 0
			  }
		});
		
		$('#residential_manual_tree_div').on("changed.jstree", function (e, data) 
		{
			log(data.changed.selected); // newly selected
		    log(data.changed.deselected); // newly deselected
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
			<div id="residential_manual_tree_div" style="border-radius:0px 0px 0px 0px; border:0px solid #000000;">
				<ul>
				<%
					String sysList[]={"Heating", "Cooling", "Heating Cooling Combo", "Air Handler", "Humidifier"};
					for(HvacBrands brand : HvacBrands.values())
					{
						out.print("<li>"+brand.ctoString()+"");
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
				%>
				</ul>
			</div>
		</td>
		<td style='width: 1px; background-color: #00ffff;'></td>
		<td style='width: 75%; border-radius:0px 0px 0px 0px; border:0px solid #dddddd; vertical-align: top;'>
			hello
		</td>
	</tr>
</table>