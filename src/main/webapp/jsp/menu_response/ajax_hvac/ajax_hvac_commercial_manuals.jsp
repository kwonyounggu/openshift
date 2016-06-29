<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>

<script type="text/javascript">
	//see http://jsfiddle.net/jayhilwig/hv8vU/
	$(document).ready(function ()
	{
	    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');

	    $('.tree li.parent_li > span').on('click', function (e) 
	    {
	        var children = $(this).parent('li.parent_li').find(' > ul > li');
	        if (children.is(":visible")) 
	        {
	            children.hide('fast');
	            $(this).attr('title', 'Expand').find(' > i').addClass('glyphicon-plus-sign').removeClass('glyphicon-minus-sign');
	        } 
	        else 
	        {
	            children.show('fast');
	            $(this).attr('title', 'Collapse').find(' > i').addClass('glyphicon-minus-sign').removeClass('glyphicon-plus-sign');
	        }
	        e.stopPropagation();
	    });
	    $(".glyphicon-folder-open").trigger("click");
	});
</script> 
<% 
	//CarmClinicalSummaryEditBean eb=(CarmClinicalSummaryEditBean)request.getAttribute("carm_clincal_summary_bean");
//The following color is corresponding with energyblue
//style='background-color:#E0E9F5;
%>
<p>
	<h1>Commercial Under Construction</h1>
</p>
<div class="container">
	<div class="row">
		<div class="col-md-3">
			<div class="tree well">
				<ul>
				<%
					String sysList[]={"Heating", "Cooling", "Heating Cooling Combo", "Air Handler", "Humidifier"};
					for(HvacBrands brand : HvacBrands.values())
					{
						out.print("<li><span><i class='glyphicon glyphicon-folder-open'></i> "+brand.ctoString()+"</span>");
						out.print("<ul>");
						for(String sys : sysList)
						{
							out.print("<li><span><i class='glyphicon glyphicon-minus-sign'></i> "+sys.toString()+"</span><a href=''>list</a>");
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
		<div class="col-md-9">
		</div>
	</div>
</div>