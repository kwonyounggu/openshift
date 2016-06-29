<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>
<script type="text/javascript">
	//see http://jsfiddle.net/jayhilwig/hv8vU/
	$(document).ready(function ()
	{
		$('#residential_manual_tree_div').jstree();
		
		$('#residential_manual_tree_div').on("changed.jstree", function (e, data) {
			  log(data.selected);
			});
	});
</script>  
<% 
	//CarmClinicalSummaryEditBean eb=(CarmClinicalSummaryEditBean)request.getAttribute("carm_clincal_summary_bean");
//The following color is corresponding with energyblue
//style='background-color:#E0E9F5;
%>

<h4>Under Construction</h4>
<div class="container">
	<div class="row">
		<div class="col-md-3" style="background-color:pink; overflow: auto;">
			<div id="residential_manual_tree_div">
				<ul>
				<%
					String sysList[]={"Heating", "Cooling", "Heating Cooling Combo", "Air Handler", "Humidifier"};
					for(HvacBrands brand : HvacBrands.values())
					{
						out.print("<li>"+brand.ctoString()+"");
						out.print("<ul>");
						for(String sys : sysList)
						{
							out.print("<li>"+sys.toString()+"");
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
		</div>
		<div class="col-md-9" style="background-color:yellow;">
			hello here
		</div>
	</div>
</div>