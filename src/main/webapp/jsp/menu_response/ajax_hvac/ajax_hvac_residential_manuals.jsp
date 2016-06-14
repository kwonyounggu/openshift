<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
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
<div class="easy-tree">
<ul>
<li>Example 1</li>
<li>Example 2</li>
<li>Example 3
<ul>
<li>Example 1</li>
<li>Example 2
<ul>
<li>Example 1</li>
<li>Example 2</li>
<li>Example 3</li>
<li>Example 4</li>
</ul>
</li>
<li>Example 3</li>
<li>Example 4</li>
</ul>
</li>
<li>Example 0
<ul>
<li>Example 1</li>
<li>Example 2</li>
<li>Example 3</li>
<li>Example 4
<ul>
<li>Example 1</li>
<li>Example 2</li>
<li>Example 3</li>
<li>Example 4</li>
</ul>
</li>
</ul>
</li>
</ul>
</div>
</div>