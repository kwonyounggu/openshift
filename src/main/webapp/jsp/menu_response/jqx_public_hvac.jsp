<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>
<style>
	/*see http://stackoverflow.com/questions/15316559/how-to-give-a-border-to-bootstrap-tab-contents*/
	.tab-content 
	{
	    border-left: 1px solid #ddd;
	    border-right: 1px solid #ddd;
	    border-bottom: 1px solid #dddddd;
	    
	    border-radius: 0 0 0px 0px;
	    
	    padding: 10px;
	    
	    text-align: left;
	}
	.nav-tabs 
	{
	    margin-bottom: -1px;
	}
	/*see http://jsfiddle.net/jhfrench/GpdgF/*/
	.tree 
	{
	    min-height:20px;
	    padding:19px;
	    margin-bottom:20px;
	    background-color:#fbfbfb;
	    border:1px solid #999;
	    -webkit-border-radius:4px;
	    -moz-border-radius:4px;
	    border-radius:4px;
	    -webkit-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
	    -moz-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
	    box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05)
	}
	.tree li 
	{
	    list-style-type:none;
	    margin:0;
	    padding:10px 5px 0 5px;
	    position:relative
	}
	.tree li::before, .tree li::after 
	{
	    content:'';
	    left:-20px;
	    position:absolute;
	    right:auto
	}
	.tree li::before 
	{
	    border-left:1px solid #999;
	    bottom:50px;
	    height:100%;
	    top:0;
	    width:1px
	}
	.tree li::after 
	{
	    border-top:1px solid #999;
	    height:20px;
	    top:25px;
	    width:25px
	}
	.tree li span 
	{
	    -moz-border-radius:5px;
	    -webkit-border-radius:5px;
	    border:1px solid #999;
	    border-radius:5px;
	    display:inline-block;
	    padding:3px 8px;
	    text-decoration:none
	}
	.tree li.parent_li>span 
	{
	    cursor:pointer
	}
	.tree>ul>li::before, .tree>ul>li::after 
	{
	    border:0
	}
	.tree li:last-child::before 
	{
	    height:30px
	}
	.tree li.parent_li>span:hover, .tree li.parent_li>span:hover+ul li span 
	{
	    background:#eee;
	    border:1px solid #94a0b4;
	    color:#000
	}
</style>
<script type="text/javascript">

$(document).ready(function ()
{
	//see http://stackoverflow.com/questions/8456974/how-to-use-ajax-loading-with-bootstrap-tabs
	$('[data-toggle="tab_ajax"]').click(function(e) 
	{
		log("INFO: tab is clicked ...");
	    e.preventDefault()
	    var loadurl = $(this).attr('href')
	    var targ = $(this).attr('data-target')
	    $.get(loadurl, function(data) 
	    {
	        $(targ).html(data)

	    });
	    $(this).tab('show');
	});
	
	$("#residential_anchor").click();//for the 1st initiation page by firing an event
	
	$(function () 
	{
	    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
	    $('.tree li.parent_li > span').on('click', function (e) {
	        var children = $(this).parent('li.parent_li').find(' > ul > li');
	        if (children.is(":visible")) {
	            children.hide('fast');
	            $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
	        } else {
	            children.show('fast');
	            $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
	        }
	        e.stopPropagation();
	    });
	});
});//$(document).ready

</script>
<h4>HVAC in North America</h4>
<div style="width: 95%">
  <ul class="nav nav-tabs">
    <li class="active dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">System Manuals<span class="caret"></span></a>
      <ul class="dropdown-menu">
        <li><a id="residential_anchor" data-toggle="tab_ajax" data-target="#residential_manuals" href="jsp/menu_response/ajax_hvac/ajax_hvac_residential_manuals.jsp">Residential</a></li>
        <li><a data-toggle="tab_ajax" data-target="#commercial_manuals" href="jsp/menu_response/ajax_hvac/ajax_hvac_commercial_manuals.jsp">Commercial</a></li>
        <li><a data-toggle="tab_ajax" data-target="#industrial_manuals" href="jsp/menu_response/ajax_hvac/ajax_hvac_industrial_manuals.jsp">Industrial</a></li>
      </ul>
    </li>
    <li><a data-toggle="tab" href="#troubleshootings">Trouble Shootings</a></li>
    <li><a data-toggle="tab" href="#questions_answers">Q & A</a></li>
    <li><a data-toggle="tab" href="#estimates">Estimates</a></li>
    <li><a data-toggle="tab" href="#search_contractors">Contractors</a></li>
    <li><a data-toggle="tab" href="#parts_supplies">Supplies</a></li>
  </ul>

  <div class="tab-content">
    <div id="residential_manuals" class="tab-pane fade in active">
      <!-- Ajax content will be loaded here-->
    </div>
    <div id="commercial_manuals" class="tab-pane fade">
     <!-- Ajax content will be loaded here-->
    </div>
    <div id="industrial_manuals" class="tab-pane fade">
      <!-- Ajax content will be loaded here-->
    </div>
    <div id="troubleshootings" class="tab-pane fade">
      <h3>Under construction</h3>
      <p>Under construction</p>
    </div>
    <div id="questions_answers" class="tab-pane fade">
      <h3>Under construction</h3>
      <p>Under construction</p>
    </div>
    <div id="estimates" class="tab-pane fade">
      <h3>Under construction</h3>
      <p>Under construction</p>
    </div>
    <div id="search_contractors" class="tab-pane fade">
      <h3>Under construction</h3>
      <p>Under construction</p>
    </div>
    <div id="parts_supplies" class="tab-pane fade">
      <h3>Under construction</h3>
      <p>Under construction</p>
    </div>
  </div>
</div>