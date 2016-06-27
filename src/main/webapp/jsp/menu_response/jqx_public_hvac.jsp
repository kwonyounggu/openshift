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
	        $(targ).html(data);
	    });
	    $(this).tab('show');
	});
	
	$("#residential_anchor").click();//for the 1st initiation page by firing an event
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
    <li><a data-toggle="tab" href="#buy_sell">Supplies</a></li>
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
    <div id="buy_sell" class="tab-pane fade">
      <h3>Under construction</h3>
      <p>Under construction</p>
    </div>
  </div>
</div>