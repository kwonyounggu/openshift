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

<!-- It may be used for hvac home later. Aug-5-2016 -->
  <ul class="nav nav-tabs">
  	<li class="active"><a id="residential_anchor" data-toggle="tab_ajax" data-target="#residential_manuals" onfocus="this.blur()" href="jsp/menu_response_smartphone/hvac/hvac_system_manuals.jsp">System Manuals</a></li>
  </ul>

  <div class="tab-content">
    <div id="residential_manuals" class="tab-pane fade in active" style="vertical-align: top;"></div>
  </div>