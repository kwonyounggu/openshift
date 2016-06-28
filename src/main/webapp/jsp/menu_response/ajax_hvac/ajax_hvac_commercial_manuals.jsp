<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
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
<div class="tree well">
    <ul>
        <li> <span><i class="glyphicon glyphicon-folder-open"></i> Parent</span>  <a href="">Goes somewhere</a>

            <ul>
                <li>	<span><i class="glyphicon glyphicon-minus-sign"></i> Child</span>  <a href="">Goes somewhere</a>

                    <ul>
                        <li> <span><i class="glyphicon glyphicon-leaf"></i> Grand Child</span>  <a href="">Goes somewhere</a>

                        </li>
                    </ul>
                </li>
                <li>	<span><i class="glyphicon glyphicon-minus-sign"></i> Child</span>  <a href="">Goes somewhere</a>

                    <ul>
                        <li> <span><i class="glyphicon glyphicon-leaf"></i> Grand Child</span>  <a href="">Goes somewhere</a>

                        </li>
                        <li>	<span><i class="glyphicon glyphicon-minus-sign"></i> Grand Child</span>  <a href="">Goes somewhere</a>

                            <ul>
                                <li> <span><i class="glyphicon glyphicon-minus-sign"></i> Great Grand Child</span>  <a href="">Goes somewhere</a>

                                    <ul>
                                        <li> <span><i class="glyphicon glyphicon-leaf"></i> Great great Grand Child</span>  <a href="">Goes somewhere</a>

                                        </li>
                                        <li> <span><i class="glyphicon glyphicon-leaf"></i> Great great Grand Child</span>  <a href="">Goes somewhere</a>

                                        </li>
                                    </ul>
                                </li>
                                <li> <span><i class="glyphicon glyphicon-leaf"></i> Great Grand Child</span>  <a href="">Goes somewhere</a>

                                </li>
                                <li> <span><i class="glyphicon glyphicon-leaf"></i> Great Grand Child</span>  <a href="">Goes somewhere</a>

                                </li>
                            </ul>
                        </li>
                        <li> <span><i class="glyphicon glyphicon-leaf"></i> Grand Child</span>  <a href="">Goes somewhere</a>

                        </li>
                    </ul>
                </li>
            </ul>
        </li>
        <li> <span><i class="glyphicon glyphicon-folder-open"></i> Parent2</span>  <a href="">Goes somewhere</a>

            <ul>
                <li>	<span><i class="glyphicon glyphicon-leaf"></i> Child</span>  <a href="">Goes somewhere</a>

                </li>
            </ul>
        </li>
    </ul>
</div>
<div class="tree">
    <ul>
        <li> <span><i class="glyphicon glyphicon-calendar"></i> 2013, Week 2</span>

            <ul>
                <li>	<span class="btn-xs btn-successs"><i class="glyphicon glyphicon-minus-sign"></i> Monday, January 7: 8.00 hours</span>

                    <ul>
                        <li> <span><i class="glyphicon glyphicon-time"></i> 8.00</span> &ndash; <a href="">Changed CSS to accomodate...</a>

                        </li>
                    </ul>
                </li>
                <li>	<span class="btn-xs btn-success"><i class="glyphicon glyphicon-minus-sign"></i> Tuesday, January 8: 8.00 hours</span>

                    <ul>
                        <li> <span><i class="glyphicon glyphicon-time"></i> 6.00</span> &ndash; <a href="">Altered code...</a>

                        </li>
                        <li> <span><i class="glyphicon glyphicon-time"></i> 2.00</span> &ndash; <a href="">Simplified our approach to...</a>

                        </li>
                    </ul>
                </li>
                <li>	<span class="btn-xs btn-warning"><i class="glyphicon glyphicon-minus-sign"></i> Wednesday, January 9: 6.00 hours</span>

                    <ul>
                        <li> <span><i class="glyphicon glyphicon-time"></i> 3.00</span> &ndash; <a href="">Fixed bug caused by...</a>

                        </li>
                        <li> <span><i class="glyphicon glyphicon-time"></i> 3.00</span> &ndash; <a href="">Comitting latest code to Git...</a>

                        </li>
                    </ul>
                </li>
                <li>	<span class="btn-xs btn-danger"><i class="glyphicon glyphicon-minus-sign"></i> Wednesday, January 9: 4.00 hours</span>

                    <ul>
                        <li> <span><i class="glyphicon glyphicon-time"></i> 2.00</span> &ndash; <a href="">Create component that...</a>

                        </li>
                    </ul>
                </li>
            </ul>
        </li>
        <li> <span><i class="glyphicon glyphicon-calendar"></i> 2013, Week 3</span>

            <ul>
                <li>	<span class="btn-xs btn-success"><i class="glyphicon glyphicon-minus-sign"></i> Monday, January 14: 8.00 hours</span>

                    <ul>
                        <li> <span><i class="glyphicon glyphicon-time"></i> 7.75</span> &ndash; <a href="">Writing documentation...</a>

                        </li>
                        <li> <span><i class="glyphicon glyphicon-time"></i> 0.25</span> &ndash; <a href="">Reverting code back to...</a>

                        </li>
                    </ul>
                </li>
            </ul>
        </li>
    </ul>
</div>