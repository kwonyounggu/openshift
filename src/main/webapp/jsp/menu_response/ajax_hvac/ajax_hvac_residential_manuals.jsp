<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>
 
<% 
	//CarmClinicalSummaryEditBean eb=(CarmClinicalSummaryEditBean)request.getAttribute("carm_clincal_summary_bean");
//The following color is corresponding with energyblue
//style='background-color:#E0E9F5;
%>
<script type="text/javascript">
	//see http://www.jqueryscript.net/layout/Nice-Tree-View-Plugin-with-jQuery-Bootstrap-3-Easy-Tree.html
	$(document).ready(function ()
	{
		$('.easy-tree').EasyTree
		({
			selectable: true,
			addable: false,
	        editable: false,
	        deletable: false
	    });
	});
</script>

<h4>Under Construction</h4>
<div class="easy-tree">
<ul>
<%
	for(HvacBrands brand : HvacBrands.values())
	{
		out.print("<li class='li_selected'>"+Utils.getFirstCapitalString(brand.toString()));
		out.print("<ul>");
		for(HvacSystems sys : HvacSystems.values())
		{
			out.print("<li>"+Utils.getFirstCapitalString(sys.toString())+"</li>");
		}
		out.print("</ul>");
		out.print("</li>");
	}
%>
</ul>
</div>
