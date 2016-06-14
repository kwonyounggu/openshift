<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>
<style>
	#hvac_container ul
	{
		/*list-style: initial;*/
	}
</style>
<script type="text/javascript">
<!--
$(document).ready(function ()
{
	$('[data-toggle="tabajax"]').click(function(e) 
	{
	    e.preventDefault()
	    var loadurl = $(this).attr('href')
	    var targ = $(this).attr('data-target')
	    $.get(loadurl, function(data) 
	    {
	        $(targ).html(data)

	    });
	    $(this).tab('show')
	});
});//$(document).ready
//-->
</script>
<h4>HVAC in North America</h4>
<div style="width: 90%">
  <ul class="nav nav-tabs">
    <li class="active dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">Manuals<span class="caret"></span></a>
      <ul class="dropdown-menu">
        <li><a data-toggle="tabajax" data-target="#residential_manuals" href="jsp/menu_response/ajax_hvac/ajax_hvac_residential_manuals.jsp">Residential</a></li>
        <li><a data-toggle="tabajax" data-target="#commercial_manuals" href="/controller?op=menu_public_hvac_ajax_commercial_manuals">Commercial</a></li>
        <li><a data-toggle="tabajax" data-target="#industrial_manuals" href="/controller?op=menu_public_hvac_ajax_industrial_manuals">Industrial</a></li>
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
     <h3>Under construction</h3>
      <p>Under construction</p>
    </div>
    <div id="industrial_manuals" class="tab-pane fade">
      <h3>Under construction</h3>
      <p>Under construction</p>
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