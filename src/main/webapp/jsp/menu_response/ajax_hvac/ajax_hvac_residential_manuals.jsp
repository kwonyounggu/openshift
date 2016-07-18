<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page isELIgnored ="false" %>
<style>
	.tooltipster-default
	{
		border-radius: 1px;
		border: 1px solid #eee;

		background: #942724;
		color: #e4f1ff;
	}
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
	/*http://stackoverflow.com/questions/6112567/jstree-hide-checkbox*/
	.systemManualTree_noCheckbox > i.jstree-checkbox
	{
		display: none;
	}
	.typeahead { z-index: 1051; }
</style>
<script type="text/javascript">
	//see http://jsfiddle.net/jayhilwig/hv8vU/
	
	$(document).ready(function ()
	{
		var g_brandNode=null;
		var g_foundCount=0;
		var g_checkLoadNode=false;
		var g_typeahead=$('.typeahead');
		//Initialize the tooltips
		 $('div input').tooltipster
		 ({
				     trigger: 'custom',
				     onlyOne: false,
				     position: 'top',
				     multiple:false,
				     autoClose:true
		});
		$('#manual_tree_div').jstree
		({
			  'plugins': ['checkbox', 'search'],
			  'checkbox':
			  {
				//see http://stackoverflow.com/questions/35502382/jstree-checkbox-check-event
				 'three_state' : false // to avoid that fact that checking a node also check others
      			 //'whole_node' : false,  // to avoid checking the box just clicking the node 
      			 //'tie_selection' : false // for checking without selecting and selecting without checking
			  },
			  'search': 
			  { 
				  //'show_only_matches' : true,
				  //'show_only_matches_children' : true,
				  search_callback:function(str, node)
				  {
					  //log("search_callback: "+node.id+", "+node.text+", "+node.data.hint+", "+node.parent.split(":")[0]+", "+g_brandNode.selected[0]+", "+node.text.indexOf(str)!=-1);
					  //if(node.text===str) return true;
					  
					  if(node.data.hint==="model number level" && node.parent.split(":")[0]===g_brandNode.selected[0] && node.id.split(":")[2].search(new RegExp(str, "i"))!=-1) 
					  {
						  log("search_callback (bingog): "+node.id+", "+node.text+", "+node.data.hint+", "+node.parent.split(":")[0]+", "+g_brandNode.selected[0]+", "+node.text.indexOf(str)!=-1);
						  g_foundCount++;
						  return true;
					  }
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
		
		//this is called whenever node in any level is clicked
		$('#manual_tree_div').on("changed.jstree", function (e, data) 
		{
			log(data);
			g_brandNode=null;
			g_foundCount=0;
			if(data.node.data.hint!=null)
			{
				if(data.node.data.hint==="brand name level")
				{
					if(data.node.state.selected) 
					{	
						g_brandNode=data;
						
						$('#searchInput').tooltipster('hide');
					}
				}
				else if(data.node.data.hint.indexOf("leaf level") != -1)
				{
					//Do item - July 13
					//note: do not implement if the currently selected/displayed pdf is the same one as in the right hand side
					log("It's a leaf with a parent ID="+data.node.parent+", node.id="+data.node.id);
					//document.getElementById('pdfIfram').setAttribute('src', node.id);
					var pdfPath=data.node.id.replace("dl=0", "raw=1");
					document.getElementById('pdfIfram').setAttribute('src', "http://docs.google.com/gview?url="+pdfPath+"&embedded=true");
				}
			}


		});

		//the following two event functions are triggering a tree search function
		$('#searchInput').keydown(function (e) 
		{
			if(e.which==13) $('#searchButton').trigger('click');
		 });
		//$('#manual_tree_div').on('select_node.jstree', function (e, data) {
		//    data.instance.toggle_node(data.node);
		//});

		$('#manual_tree_div').on("ready.jstree", function (e, data) 
		{
			log("ready.jstree");
			log(data);
		});

		$('#manual_tree_div').on("load_node.jstree", function (e, data) 
		{ //if(data.rslt.status) { data.inst.open_node(data.rslt.obj); }
			/*log("load_node.jstree");
			log(data);
			if(g_checkLoadNode)
			{
				g_checkLoadNode=false;
				g_brandNode.node=$('#manual_tree_div').jstree(true).get_node(g_brandNode.node.id);
				$('#searchButton').trigger('click');
			}
			*/
		});
		$('#searchButton').click(function()
		{
			$('#searchInput').tooltipster('hide');
			
			log("lookup testing ...");
			log($("#searchInput").typeahead('getActive'));
			log($("#searchInput").typeahead('lookup'));
			//1. if searchValue == Selected Item then go ahead for search tree
			//2. else find it on the json list and go ahead for search tree
			
			var searchValue=$('#searchInput').val();
			
			//g_brandNode=$('#manual_tree_div').jstree(true).get_node("id")
			
			if(searchValue.length!=0)
			{
				if(g_brandNode==null)
				{
					log("----- here 0 -------------");
					//red tooltip to ask having a check of a brand name
					
					$('#searchInput').tooltipster('content', "Try again after checking a brand.");
					$('#searchInput').tooltipster('show');
				}
				else //eg: CARRIER is selected
				{
					log("----- here 1 -------------");
					log(g_brandNode);
					
					if(g_brandNode.node.children.length==0)
					{
						log("----- here 1-1 -------------");
						openNode(g_brandNode.node.id, true);
					}
					else for(var i=0; i<g_brandNode.node.children.length;i++)
					{
						log("child["+i+"]: "+g_brandNode.node.children[i]);
						//var level2Node=$('#manual_tree_div').jstree(true).get_node(g_brandNode.node.children[i])
						//if(level2Node.children.length==0) openNode(level2Node.id, false);
					}
					
					
					
					g_brandNode.instance.search(searchValue);
					//$('#searchInput').tooltipster('hide');
					//if children existing then search through it otherwise call it
					
					//if(g_brandNode.node.parents.length<3)  //bring more children progrmatically
				}
			}
			else if (g_brandNode!=null) //there exists a brand selected and a search value empty
			{
				//$('#searchInput').tooltipster('hide');
				// search all models for the brand
				//if children existing then search through it otherwise call it
				
				log("----- here 2 -------------");
				log(g_brandNode);
			}
			else //search value empty and brand not checked
			{
				//initial state of the tree
				$('#manual_tree_div').jstree(true).search(searchValue);
				
				log("----- here 3 -------------");
			}
			/*
			else //node existing
			{
				var v=$('#searchInput').val();
				log("search button is clicked, v="+v);
				$('#manual_tree_div').jstree(true).search(v);
				$('#searchInput').tooltipster('hide');
			}
			*/
			
			//testing
			
			 
		});
		//see https://github.com/bassjobsen/Bootstrap-3-Typeahead	
		//see http://tosbourn.com/setting-a-minimum-length-for-your-search-in-typeahead-js/
		$.get('http://www.webmonster.ca/jsp/menu_response/json_hvac/hvac_manuals_model_number.jsp', function(data)
		{
			//log(data);
		    $("#searchInput").typeahead(
		    { 
		    	source: data,
		    	autoSelect: true,
		    	updater: function(item)
		    	{
		    		log("updater is called");
		    		searchModelNumber(item);
		    		return item;
		    	}
		    });
		},'json');
		
		function searchModelNumber(item)
		{
			log(item);
			if(item.id==null)
			{
				//json search
			}
			else
			{
				if(g_brandNode!=null)//a node is already selected then
					$("#manual_tree_div").jstree("uncheck_node", g_brandNode.node.id);
				//fire an event, select_node, so that check_box of a corresponding brand will be checked
				$("#manual_tree_div").jstree("select_node", item.id.split(":")[0]);//this will call $('#manual_tree_div').on("changed.jstree" ...
			}
    		//1. Waiting sign
    		//2. event fire
    		//3. Waiting sign off when search tree is done.
		}
		function openNode(nodeId, checkLoadNode)
		{
			
			g_checkLoadNode=checkLoadNode;
			$("#manual_tree_div").jstree("open_node", nodeId);
		}
		
	});
	
</script>  
<% 
//to do, button->submit button->see contact for the button activation
%>

<h4>Under Construction</h4>
<table style='table-layout: fixed'>
	<tr>
		<td style='width: 25%; vertical-align: top'>
			  <div class="input-group">
			       <input id="searchInput" type="Search" placeholder="Model Number" class="form-control" data-provide="typeahead" />
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