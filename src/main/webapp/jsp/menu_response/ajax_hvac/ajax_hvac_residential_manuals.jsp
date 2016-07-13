<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page isELIgnored ="false" %>
<style>
	.embed-container 
	{ 
		position: relative; 
		/*padding-bottom: 56.25%; */
		padding-bottom: 120%;
		height: 0; 
		overflow: hidden; 
		max-width: 100%; 
	} 
	.embed-container iframe, .embed-container object, .embed-container embed 
	{ 
		position: absolute; 
		top: 0; 
		left: 0; 
		width: 100%; 
		height: 100%; 
	}
	#manual_tree_div .jstree-closed > .jstree-anchor > .jstree-checkbox, 
#manual_tree_div .jstree-open > .jstree-anchor > .jstree-checkbox { display:none; }
	
	
</style>
<script type="text/javascript">
	//see http://jsfiddle.net/jayhilwig/hv8vU/
	$(document).ready(function ()
	{
		$('#manual_tree_div').jstree
		({
			  'plugins': ['checkbox', 'search'],
			  'search': 
			  { 
				  //'show_only_matches' : true,
				  //'show_only_matches_children' : true,
				  search_callback:function(str, node)
				  {
					  log("search_callback: "+node.id+", "+node.text);
					  if(node.text===str) return true;
				  }
			  },
			  'core' : 
			  {
				    'multiple' : false,
				    //'cache': false,
				    //'check_callback' : true,
    				//'themes' : { 'stripes' : true },
				    //'animation' : 0,
				    'data':
				    {
				    	'url': function(node)
				    	{
				    		//log("url: node_id: "+node.id);
				    		//return '//www.jstree.com/fiddle/?lazy';
				    		return (node.id==='#' ? '//www.webmonster.ca/jsp/menu_response/json_hvac/manuals_brands.jsp' : '//www.webmonster.ca/jsp/menu_response/json_hvac/manuals_brands_children.jsp');
				    	},
				    	'type': 'post',
				    	'dataType': 'json',
				    	'data': function(node)
				    	{
				    		//log(node);
				    		if(node.id==='#') return {'id' : node.id, 'parent': node.parent};
				    		else return {'id' : node.id, 'parent': node.parent, 'hint': node.data.hint};
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
				log("It's a leaf with a parent ID="+node.parent+", node.id="+node.id);
				//document.getElementById('pdfIfram').setAttribute('src', node.id);
				var pdfPath=node.id.replace("dl=0", "raw=1");
				document.getElementById('pdfIfram').setAttribute('src', "http://docs.google.com/gview?url="+pdfPath+"&embedded=true");
			}
			else
			{
				log("It has children");
			}

		});
		//see https://github.com/vakata/jstree/issues/668
		$('#manual_tree_div').on("search.jstree before_open.jstree", function (e, data) 
		{
			log("--1---");
			if(data.instance.settings.search.show_only_matches) 
			{
				log("--2---");
		        data.instance._data.search.dom.find('.jstree-node')
		            .show().filter('.jstree-last').filter(function() { return this.nextSibling; }).removeClass('jstree-last')
		            .end().end().end().find(".jstree-children").each(function () { $(this).children(".jstree-node:visible").eq(-1).addClass("jstree-last"); });
		    }

		});

		//the following two event functions are triggering a tree search function
		$('#searchInput').keydown(function (e) 
		{
			if(e.which==13) $('#searchButton').trigger('click');
		 });
		$('#searchButton').click(function()
		{
			
			var v=$('#searchInput').val();
			log("search button is clicked, v="+v);
			$('#manual_tree_div').jstree(true).search(v);
		});
	});
	function resizeIframe(obj) 
	{
	    //obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
	}
</script>  
<% 
	//CarmClinicalSummaryEditBean eb=(CarmClinicalSummaryEditBean)request.getAttribute("carm_clincal_summary_bean");
//The following color is corresponding with energyblue
//style='background-color:#E0E9F5;
%>

<h4>Under Construction</h4>
<table style='table-layout: fixed'>
	<tr>
		<td style='width: 25%; vertical-align: top'>
			  <div class="input-group">
			       <input id="searchInput" type="Search" placeholder="Search..." class="form-control" />
			       <div class="input-group-btn">
			           <button id="searchButton" class="btn btn-info">
			           <span class="glyphicon glyphicon-search"></span>
			           </button>
			       </div>
			  </div>
			  <div style="width: 250px; height: 100%; overflow: auto">
				<div id="manual_tree_div" style="border-radius:0px 0px 0px 0px; border:0px solid #000000;">
				</div>
			  </div>
		</td>
		<td width='10'></td>
		<td style='width: 75%; border-radius:0px 0px 0px 0px; border:1px solid #dddddd; border-style: hidden hidden hidden solid; vertical-align: top;'>
			<!-- see http://embedresponsively.com/ and select Generic iFrame and google to display pdf with hint from http://stackoverflow.com/questions/8262278/supplying-an-embedable-pdf  -->
			<div class='embed-container'>
				<iframe id='pdfIfram' src='http://docs.google.com/gview?url=https://www.dropbox.com/s/h3n5ukq6cjf6uyz/Scheduled_admin_carrier_air_conditioner_warranty_24aaa5_49004dp172_2016_07_03_15_06_10.pdf?raw=1&embedded=true' style='border:0'></iframe>
<!-- 				<iframe id='pdfIfram' src='https://www.dropbox.com/s/h3n5ukq6cjf6uyz/Scheduled_admin_carrier_air_conditioner_warranty_24aaa5_49004dp172_2016_07_03_15_06_10.pdf?raw=1#zoom=78&view=FitH' style='border:0'></iframe> -->
			</div>
			<!-- The followings are good with a pdf without any restrictions (dropbox pdfs are restricted in showing)
			<div class="embed-responsive embed-responsive-16by9">
			  <iframe class="embed-responsive-item" id="bootstrapIframe"></iframe>
			</div> -->
		</td>
	</tr>
</table>