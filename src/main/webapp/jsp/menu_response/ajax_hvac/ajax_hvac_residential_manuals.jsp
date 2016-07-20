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
		var g_modelList=[];
		
		
		var g_foundCount=0;
		var g_checkLoadNode=false;
		//var g_typeahead=$('.typeahead');
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
			  'plugins': ['search'],
			  'search': 
			  { 
				  //'show_only_matches' : false,
				  search_callback:function(str, node)
				  {
					  if(node.data.hint.indexOf("model number level")!=-1 && node.id.split(":")[2].search(new RegExp(str, "i"))!=-1) 
					  {
						  log("search_callback (bingog): "+node.id+", "+node.text+", "+node.data.hint+", "+node.parent.split(":")[0]+", "+node.text.indexOf(str)!=-1);
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
				    		//log("url: node_id: "+node.id+" is called"); log(node);
				    		//return '//www.jstree.com/fiddle/?lazy';
				    		return (node.id==='#' ? '//www.webmonster.ca/jsp/menu_response/json_hvac/manuals_brands.jsp' : '//www.webmonster.ca/jsp/menu_response/json_hvac/manuals_brands_children.jsp');
				    	},
				    	'type': 'post',
				    	'dataType': 'json',
				    	'data': function(node)
				    	{	//The following return values are provided for parameters of a calling jsp file
				    		//log("data: node_id: "+node.id+" is called"); log(node);
				    		if(node.id==='#') return {'id' : node.id, 'parent': node.parent};
				    		
				    		log("data: node_id: "+node.id+", hint: "+node.data.hint+" is called"); log(node);
				    		return {'id' : node.id, 'parent': node.parent, 'hint': node.data.hint};
				    	}
				    	
				    }
			  }
		});

		//this is called whenever node in any level is clicked
		$('#manual_tree_div').on("changed.jstree", function (e, data) 
		{
			log("********** changed.jstree ************");
			log(data);
			if(data.node.data.hint!=null)
			{
				if(data.node.data.hint.indexOf("leaf level") != -1)
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


		$('#manual_tree_div').on("load_node.jstree", function (e, data) 
		{ 
			log("load_node.jstree");
			log(data);
			if(data.node.data.hint.indexOf(":go_next_level_to_open")!=-1)//means searching is implemented
			{
				$('#searchButton').trigger('click');
			}
		});
		$('#searchButton').click(function()
		{
			$('#searchInput').tooltipster('hide');
			var searchValue=$('#searchInput').val();
			
			log("lookup testing ...");
			log($("#searchInput").typeahead('getActive'));
			
			//1. if searchValue == Selected Item then go ahead for search tree
			//2. else find it on the json list and go ahead for search tree
			
			var selectedModelNumberItem=$("#searchInput").typeahead('getActive');
			if(selectedModelNumberItem===undefined)//not selected of model number
			{
				showTooltip("Model number is required.");
			}
			else if(selectedModelNumberItem.name!=searchValue)
			{	
				log("selectedModelNumberItem.name!=searchValue");
				var modelObj=getModelObj(g_modelList, searchValue);
				log(modelObj);
				if(modelObj.length==0) //not found
				{
					showTooltip("Model number typed in is not existing.");
				}
				else
				{
					searchTree(modelObj[0]);
				}
			}
			else if(selectedModelNumberItem.name==searchValue) //g_brandNode already assigned in results of $('#manual_tree_div').on("changed.jstree"
			{
				log("selectedModelNumberItem.name==searchValue");
				searchTree(selectedModelNumberItem);
			}
		});
		//see https://github.com/bassjobsen/Bootstrap-3-Typeahead	
		//see http://tosbourn.com/setting-a-minimum-length-for-your-search-in-typeahead-js/
		$.get('http://www.webmonster.ca/jsp/menu_response/json_hvac/hvac_manuals_model_number.jsp', function(data)
		{
			g_modelList=data;
			//log(data);
		    $("#searchInput").typeahead(
		    { 
		    	source: data,
		    	autoSelect: false,
		    	updater: function(item)
		    	{
		    		log("updater is called");
		    		searchTree(item);
		    		return item;
		    	}
		    });
		},'json');

		function openNode(nodeId)
		{
			$("#manual_tree_div").jstree("open_node", nodeId);//to call url
		}
		function searchTree(modelObj)//where modelObj is a selected item object
		{
			log("searchTree({id: "+modelObj.id+", name: "+modelObj.name+"}) is called");
			
			for(var ids=modelObj.id.split(":"), i=ids.length-1; i>=0; i-- )
			{
				var node=$('#manual_tree_div').jstree(true).get_node(ids[i]);
				log(i+" : node returned on click of search: "+node);
				if(i==2 && node)//model number node
				{
					$("#manual_tree_div").jstree("select_node", node.id);//to high light
					break; //the node in the tree already existing
				}
				else if(i==1 && node) //system type node
				{
					node.data.hint+=":go_next_level_to_open";//load->model number node above if-statement
					openNode(node.id);
					break;
				}
				else if(i==0 && node) //brand node
				{
					node.data.hint+=":go_next_level_to_open";//load->this function->system type node above if-statement
					openNode(node.id);
					break;
				}
			}
			
			//if found then search
			//else go and get it first
			/*
			
			if(g_brandNode==null)
			{
				//This compound statement is not expected to implemented but if any, then it is a sementic error
				log("ERROR: b_brandNode is null, which is not expected. Please check the logic.");
			}
			else if(g_brandNode.node.children.length==0)
			{
				openNode(g_brandNode.node.id, true);
			}
			else for(var i=0; i<g_brandNode.node.children.length;i++)//ac, furnace, hp, humidifier, etc
			{
				log("child["+i+"]: "+g_brandNode.node.children[i]);
				//var level2Node=$('#manual_tree_div').jstree(true).get_node(g_brandNode.node.children[i])
				//if(level2Node.children.length==0) openNode(level2Node.id, false);
			}
			*/
			
			
			//g_brandNode.instance.search(searchValue);
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
			
			 
		}
	});
				
	function getModelObj(data, name)
	{
		return data.filter(function(data){return data.name.toUpperCase()==name.toUpperCase()})
	}
	function showTooltip(str)
	{
		$('#searchInput').tooltipster('content', str);
		$('#searchInput').tooltipster('show');
	}
	
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