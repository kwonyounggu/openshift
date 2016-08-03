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
	/*To show checkes only in the 1st level of the jstree by non-displaying its level children*/
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

		var g_modelList=[];
		var g_nodePdfDisplayed=null;
		 $('[data-toggle="tooltip"]').tooltip(); //bootstrap tooltip, http://v4-alpha.getbootstrap.com/components/tooltips/#examples
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
				  'show_only_matches' : true,
				  'show_only_matches_children': true,
				  search_callback:function(str, node)
				  {
					  if((node.data.hint.indexOf("model number level")!=-1 || node.data.hint.indexOf("manuals for")!=-1) && node.id.split(":")[2].search(new RegExp(str, "i"))!=-1)   
					  {
						  //log("search_callback (bingog): "+node.id+", "+node.text+", "+node.data.hint+", "+node.parent.split(":")[0]+", "+node.text.indexOf(str)!=-1);
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
				    		
				    		//log("data: node_id: "+node.id+", hint: "+node.data.hint+" is called"); log(node);
				    		return {'id' : node.id, 'parent': node.parent, 'hint': node.data.hint};
				    	}
				    	
				    }
			  }
		});

		//this is called whenever node in any level is clicked
		$('#manual_tree_div').on("changed.jstree", function (e, data) 
		{
			//log("********** changed.jstree ************");
			//log(data);
			if(data.node.data.hint!=null)
			{
				if(data.node.data.hint.indexOf("leaf level") != -1)
				{
					//note: do not implement if the currently selected/displayed pdf is the same one as in the right hand side
					if(g_nodePdfDisplayed==null || g_nodePdfDisplayed.id!=data.node.id)
					{
						log("It's a leaf with a parent ID="+data.node.parent+", node.id="+data.node.id);
						var pdfPath=data.node.id.replace("dl=0", "raw=1");
						document.getElementById('pdfIfram').setAttribute('src', "http://docs.google.com/gview?url="+pdfPath+"&embedded=true");
						
						$("#tree_path_div").html(data.node.parent);
						
						g_nodePdfDisplayed=data.node;
					}
				}
			}
		});

		//the following two event functions are triggering a tree search function
		$('#searchInput').keydown(function (e) 
		{
			if(e.which==13) $('#searchButton').trigger('click');
		 });

		$('#searchInput').mouseenter(function () 
		{
			//log("mouseenter");
			var that = $(this);
			that.tooltip('show');
		    setTimeout(function()
		    {
		        that.tooltip('hide');
		    }, 2000);
		 });
		$('#searchInput').mouseleave(function ()
		{
			//log("mouseleave");
			$(this).tooltip('hide');
		});
		
		$('#manual_tree_div').on("load_node.jstree", function (e, data) 
		{ 
			log("load_node.jstree");
			//log(data);
			if(data.node.data && data.node.data.hint.indexOf(":go_next_level_to_open")!=-1)//means searching is implemented
			{
				$('#searchButton').trigger('click');
			}
		});
		//see http://stackoverflow.com/questions/4486032/open-branch-when-clicking-on-a-node
		$('#manual_tree_div').on("select_node.jstree", function (e, data) 
		{ 
			log("select_node.jstree");
			data.instance.toggle_node(data.node);
		});
		//it is called after search is returned with a true.
		/*
		$('#manual_tree_div').on("search.jstree", function (e, data) 
		{ 
			log("search.jstree");
			log(data);
		});
		*/
		$('#searchButton').click(function()
		{
			
			var searchValue=$('#searchInput').val();
		
			var selectedModelNumberItem=$("#searchInput").typeahead('getActive');
			if(searchValue==="")//not selected of model number
			{
				$("#manual_tree_div").jstree(true).clear_search();
			}
			else if(selectedModelNumberItem===undefined || selectedModelNumberItem.name!=searchValue)
			{	
				//log("selectedModelNumberItem.name!=searchValue");
				var modelObj=getModelObj(g_modelList, searchValue);
				//log(modelObj);
				if(modelObj.length==0) //not found
				{
					showTooltip("Model number is not in the list.");
				}
				else
				{
					searchTree(modelObj[0]);
				}
			}
			else if(selectedModelNumberItem.name==searchValue)
			{
				//log("selectedModelNumberItem.name==searchValue");
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
		    		//log("updater is called");
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
			var node;
			for(var ids=modelObj.id.split(":"), i=ids.length-1; i>=0; i-- )
			{

				switch(i)
				{
					case 2: node=$('#manual_tree_div').jstree(true).get_node(modelObj.id);
							if(node) 
							{
								//$("#manual_tree_div").jstree("select_node", node.id);//just highlight if expanded already
								$("#manual_tree_div").jstree(true).search(modelObj.name);//show model number's parents in expanded way
								return;
							}
							break;
					case 1: node=$('#manual_tree_div').jstree(true).get_node(ids[0]+":"+ids[1]);
							if(node)
							{
								node.data.hint+=":go_next_level_to_open_"+ids[2];//load_model_numbers->load_event->final_search(name)
								openNode(node.id);
								return;
							}
							break;
					case 0: node=$('#manual_tree_div').jstree(true).get_node(ids[0]);
							if(node)
							{
								node.data.hint+=":go_next_level_to_open_"+ids[1];//load_system_type->load_event->load->model numbers
								openNode(node.id);
								return;
							}
							break;
					default: break;//not expected
				}
			} 
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
		
		setTimeout(function()
		{
			$('#searchInput').tooltipster('hide');
	    }, 2000);
	}
	
</script>  
<% 
//to do, button->submit button->see contact for the button activation
%>

<h4>More data will come soon.</h4>
<table style='table-layout: fixed'>
	<tr>
		<td style='width: 270px; vertical-align: top'>
			  <div class="input-group" >
			       <input id="searchInput" type="Search" placeholder="Model Number" class="form-control" data-provide="typeahead" data-toggle="tooltip" data-placement="auto" title="Search with a blank to reset." data-trigger="manual"/>
			       <div class="input-group-btn">
			           <button id="searchButton" class="btn btn-info">
			           <span class="glyphicon glyphicon-search"></span>
			           </button>
			       </div>
			  </div>
			  <div style="width: 270px; height: 100%; overflow: auto">
				<div id="manual_tree_div" style="border-radius:0px 0px 0px 0px; border:0px solid #000000;">
				</div>
			  </div>
		</td>
		<td width='10'></td>
		<td style='width: 73%; border-radius:0px 0px 0px 0px; border:1px solid #dddddd; border-style: hidden hidden hidden solid; vertical-align: top;'>
			<div class="hvac_rectangle">
				<div class="row">
					<div id="tree_path_div" class="col-md-10">
						GOODMAN:AIR_HANDLER:MBR:BROCHURE
					</div>
					<!-- http://stackoverflow.com/questions/19758313/align-div-right-in-bootstrap-3 -->
					<div class="col-md-2" style="padding-right: 5px;">
						<a href="#disqus_thread" onfocus="this.blur()" style="text-decoration: none;"><span class="label label-info">Leave a comment</span></a>
					</div>
				</div>
			</div>
			<!-- see http://embedresponsively.com/ and select Generic iFrame and google to display pdf with hint from http://stackoverflow.com/questions/8262278/supplying-an-embedable-pdf  -->
			<div class='embed-container'>
				<iframe id='pdfIfram' src='http://docs.google.com/gview?url=https://www.dropbox.com/s/x2bux8g239pm0f9/Admin_goodman_airhandler_acnf_brochure_2016_07_23.pdf?raw=1&embedded=true' style='border:0'></iframe>
			</div>	
			<!-- http://www.rantic.com/articles/facebook-comments-worth-seo-trade-off/ -->
			<!-- https://www.quora.com/Which-comment-system-is-better-Komentbox-or-Disqus/answer/Saurabh-Goel-23 -->
			<!-- https://www.quora.com/Are-Facebook-comments-crawlable/answer/Saurabh-Goel-23 -->
			<div><br/><p style="padding-left: 10px;">You are welcome to <span class="label label-info">leave a comment/request</span> for more manuals, any change, etc, according to this page.</p></div>
<!-- 			<div id="fbComments" data-width="100%" class="fb-comments" data-href="http://www.webmonster.ca/controller?op=menu_public_hvac#system_manual" data-numposts="5" data-order-by="reverse_time"></div> -->
			<div style="margin-left: 10px;">
				<div id="disqus_thread"></div>	
				<script>
				
				/**
				 *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
				 *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables 
				 *  see https://help.disqus.com/customer/portal/articles/472098-javascript-configuration-variables
				 */
				
				var disqus_config = function () 
				{
				    this.page.url = 'http://www.webmonster.ca/controller?op=menu_public_hvac';  // Replace PAGE_URL with your page's canonical URL variable
				    this.page.identifier = '0001'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
				};
				
				(function() 
				{ // DON'T EDIT BELOW THIS LINE
				    var d = document, s = d.createElement('script');
				    s.src = '//webmonster-ca.disqus.com/embed.js';
				    s.setAttribute('data-timestamp', +new Date());
				    (d.head || d.body).appendChild(s);
				})();
				</script>
				<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
             </div>                       
		</td>
	</tr>
</table>