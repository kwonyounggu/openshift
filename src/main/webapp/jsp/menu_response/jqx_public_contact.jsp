<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>
<style>
	td.estimate_form_td
	{
		color: #ffffff;
		vertical-align: top;
	}
</style>
<script language="Javascript" type="text/javascript">
	var editorValid=false;
	$(document).ready(function () 
	{
        $("#jqx_estimateNoteEditor").jqxEditor
        (
            {
                height: '200px', width: '100%', 
                //theme: 'energyblue',
                tools: "outdent indent | ul ol | image | link"
                
        	}
        );
        $("#jqx_estimateNoteEditor").on('change', function (event) 
        {
        	var strText=$('#jqx_estimateNoteEditor').jqxEditor('val');
            if(strText!=undefined)
            {
            	log(strText +" --- 1");
            	log($(strText).text() +" --- 2");
            	strText=$.trim($(strText).text());//remove html tags using $(strText).text()
            	
            	log(strText +" --- 3"+strText.length);
            	if(strText.length>0) editorValid=true;
            }
        });
        $("#jqxSubmitButton").jqxButton({ width: '100', disabled: false});

        /*
        $("#jqxSubmitButton").on('click', function () 
        {
            if(editorChanged)
            {
                 //alert("submit now with\n"+$("#clinicalSummaryEditor").jqxEditor('val'));
                 saveClinicalSummary();
            }
            else alert("No content change detected yet!");
            
        });
        */
        
        //$("#jqxSubmitButton").on('click', function () 
        $("#jqxSubmitButton").click(function () 
        {
        	var onsuccess=$("#estimate_form").jqxValidator('validate');			
			log("$(\"#jqxSubmitButton\").click() is called in jqx_public_contact.jsp, validataion="+onsuccess+" !");	
			if(!onsuccess) return;
			
			run_waitMe("roundBounce");
			/*
			$.ajax
		     ({
		         type: "post",
		         dataType: "",
		         url: "/carm/admin?op=ajax_form_estimate",
		         data: 
		         {
		    	 		action: 		action_command,
		    	 		app_id:  		appId,
		    	 		app_purpose:		document.getElementById("app_purpose").value,
		    	 		app_symbol:		document.getElementById("app_symbol").value,
		    	 		number_of_groups:	document.getElementById("number_of_groups").value,
		    	 		reviewers_per_item:	document.getElementById("reviewers_per_item").value,
		    	 		assignment_type:	document.getElementById("assignment_type").value,
		    	 		confirmatory:		getRadioValue('confirmatoryRadio'),
		    	 		toMediator:		getRadioValue('toMediatorRadio')		    	 		
		     	 },
		         success: getAdminActionResponse,
		         error: function(response) //called for 404 error, etc
		         {
		        	 alert(response.responseText);	
		             
		         }
		      }); 
			  */  	
        });     
        
        $("#jqx_submitter_name").jqxInput({placeHolder: "홍길동", width: '200px', height: 22, minLength: 2, maxLength: 80});
        $("#jqx_submitter_phone").jqxMaskedInput({mask: '(###)###-####', width: '220px', height: 22,});
        
        $("#jqx_submitter_email").jqxInput({placeHolder: "<%=AuthData.mycompany_email_address%>", width: '240px', height: 22,});
        $("#jqx_submitter_name, #jqx_submitter_phone, #jqx_submitter_email").removeClass("jqx-rc-all");
        
		$("#estimate_form").jqxValidator
		(
			{
				onError: function()
				{
					log("You have not filled the estimate form correctly!");
				},
				rules:
				[	
					 { input: '#jqx_submitter_name', message: 'Name is required!', action: 'keyup, blur', rule: 'required' },
					 {
							 input: '#jqx_submitter_name',
							 message: 'Korean or English [A-Za-z ]!',
							 rule: function(input, commit)
							 {
								 document.getElementById('jqx_submitter_name').value=trim(document.getElementById('jqx_submitter_name').value);
								 return (isKoreanName(document.getElementById('jqx_submitter_name')) || checkNameUsingRegEx(document.getElementById('jqx_submitter_name').value));
							 }
					  },
					  {
						 input: '#jqx_submitter_phone',
						 message: 'Invalid phone number!',
						 action: 'valuechanged, blur', 
						 rule: 'phone'
					 },
					 { input: '#jqx_submitter_email', message: 'E-mail is required!', action: 'keyup, blur', rule: 'required' },
					 { input: '#jqx_submitter_email', message: 'Invalid e-mail!', action: 'keyup', rule: 'email' },
					 {
						 input: '#jqx_estimateNoteEditor',
						 message: 'Please put your requirements!',
	                     rule: function(input, commit) 
	                     {                    	 
	                        return editorValid;
	                     }
				  	 }
				]
			}
		);
		 
	});//$(document).ready

	function run_waitMe(effect)
	{ 	console.log("run_waitMe ...");
		$("#estimate_form").waitMe
		({
			effect: effect,
			text: 'Please wait...',
			bg: 'rgba(255,255,255,0.5)',
			color: '#000',
			maxSize: '',
			source: 'img.svg',
			onClose: function() {}
		});
	}
	function saveClinicalSummary()
	{
		var login_level=parseInt("${crb.login_level}");
		var seniority=parseInt("${crb.seniority}");
	
		if(!(login_level==1 || login_level==2 ))		
		{
			alert("You are not allowed to edit this summary!!!.");
			return;
		}
		
		var saveString=$("#clinicalSummaryEditor").jqxEditor('val');
		if(saveString.length<=1)
			alert("Not a right clinical summary to save!");
		else
		{
			var selected_row_index=$('#jqxgrid').jqxGrid('getselectedrowindex');			
			httpRequestPost("<%= MenuLink.PUBLIC_CONTEXT %>","op=ajax_carm_central_save_clinical_summary&new_clinical_summary="+escape(saveString)+"&selected_carm_id="+$("#jqxgrid").jqxGrid('getcellvalue', selected_row_index, 'carm_id'), "saveClinicalSummaryResponse");
		}
	}
	function saveClinicalSummaryResponse(strResponse)
	{
		if(strResponse.indexOf('session_timeout')==0) 
		{
			alert("Your session is expired. Please login again.");
			location.reload();
		}
		else if(strResponse.indexOf('false:')==-1)//not found, means true
		{
			//location.reload();
			//update checked, edited_date, editor_id in the selected row
			var selected_row_index=$('#jqxgrid').jqxGrid('getselectedrowindex');
			$('#jqxgrid').jqxGrid('setcellvalue',selected_row_index, 'new_clinical_summary', $("#clinicalSummaryEditor").jqxEditor('val'));//set new clincal summary
			$('#jqxgrid').jqxGrid('setcellvalue',selected_row_index, 'edited', true);
			$('#jqxgrid').jqxGrid('setcellvalue',selected_row_index, 'edit_date', new Date());
			$('#jqxgrid').jqxGrid('setcellvalue',selected_row_index, 'editor_id', '${carm_login_id}');

			alert("Successfully save!");
		}
		else 
		{
			alert(strResponse.substring(6));//false, then display
			//location.reload();
		}
	}
</script>
<table style='width: 90%; padding-top: 20px; padding-bottom: 20px; table-layout: fixed'>
   <tr>
    <td style='background-color: #555762; color: #ffffff; width: 50%; vertical-align: top;'>
    	<ul style='font-size: 12px'>
    		<h3 style='color: #f9d548;'>Contact</h3>
    		<br/>
    		If you are interested in growing your business and building a positive brand expirience for your customers/patients, then we should talk:
    		<br/><br/>
    		<li>By Phone: <%=AuthData.company_phone %>
    			<br/>
    			- from 9:00am to 5:00pm (EST)
    		</li>
    		<li>By Skype: <%=AuthData.skype_id %>
    			<br />
    			- appointment required
    		</li>
    		<li>By Visiting primary place: 
    			<br/>
    			- <%=AuthData.company_address %>			
    			<br/>
    			- appointment required
    		</li>
    		<li>By Visiting secondary place: 		
    			<br/>
    			- TBD
    			<br/>
    			- appointment required
    		</li>
    		<li>By Email: <a href="mailto:<%=AuthData.mycompany_email_address%>?Subject=Hello WebMonster.CA" style="color:inherit;text-decoration: none" target="_top"><%=AuthData.mycompany_email_address%></a></li>
    		<li>What did you have in mind? Suggestions to include: competitor's websites, designs that you like, some initial ideas for your brand, what kind of niches you'd like to explore, and anything to get the conversation going!</li>
    		<li style='list-style-type: none; height: 30%' />
    	</ul>
    </td>	
    <td style='width: 20px'></td>
    <td style='background-color: #555762; color: #ffffff; width: 50%; padding: 5px 20px 5px 20px;'>
    	
  			<form id='estimate_form' action='./'>
			   	<table  id='estimate_table' style='width: 100%; border-spacing: 4px; padding: 0px 0px 10px 0px;'> 	
			   		<tr>
			   			<td colspan='2' style='text-align: left;'>
			   				<h3 style='color: #f9d548;'>Estimate(Under construction now)</h3>
			   				<span style='font-size: .95em; color: #8fc161;'>(*: must)</span>
			   				<span style='font-size: 11px; color: #bad5fe;'>Your payment is not required unless you are satisfied.</span>
			   			</td>
			   		</tr>
			   		<tr>
			   			<td class='estimate_form_td'  colspan='2'>Name <span style='font-size: .95em; color: #8fc161;'>*</span>&nbsp; :&nbsp;
			 				<input type='text' id='jqx_submitter_name' value='' maxlength='80' class='text-input'/>			
						</td> 
			   		</tr> 
			   		<tr>
			   			<td class='estimate_form_td'  colspan='2'>Phone <span style='font-size: .95em; color: #8fc161;'>*</span>&nbsp;:&nbsp;
			 				<input type='text' id='jqx_submitter_phone' class='text-input'/>				
						</td> 
			   		</tr> 
			   		<tr>
			   			<td class='estimate_form_td'  colspan='2'>E-Mail <span style='font-size: .95em; color: #8fc161;'>*</span>&nbsp;:&nbsp;
			 				<input type='text' id='jqx_submitter_email' class='text-input'/>					
						</td> 
			   		</tr>		
					<tr>
			   			<td class='estimate_form_td' colspan='2'>Note about your requirements <span style='font-size: .95em; color: #8fc161;'>*</span>&nbsp;:&nbsp;
			   				<br/> 
			 				<textarea id='jqx_estimateNoteEditor'></textarea>						
						</td> 
			   		</tr> 
			   		
			   		
					<tr>
			   			<td class='estimate_form_td' colspan='2'>A file about your application design to upload :&nbsp;</td>
			   		</tr>
			   		<tr>
			   			<td colspan='2'> 
			 				<input type='text' id='jqx_submitter_mmm' value='' class='text-input'/>					
						</td> 
			   		</tr> 	
			   		
			   		<tr>
			   			<td class='estimate_form_td' colspan='2'>Please select the elephant before submitting <span style='font-size: .95em; color: #8fc161;'>*</span>&nbsp;:&nbsp;
			   				<br />
			   				<input type='radio' style='margin-right: 100px; margin-left: 50px;'/>
			   				<input type='radio' style='margin-right: 100px;'/>
			   				<input type='radio'/>
			   				<img src="images/three_animals.png" width="362" height="86" alt="Three Animals" border="0"/>
						</td>
			   		</tr> 
			   		<!--  
			   		<tr><td colspan='2' align='center'><img id='spinner_img' src='images/common/spinner.gif' width=32 height=32  class="spinner_unhidden"/></td></tr>
			   		-->
					<tr>
					    <td colspan='2' >	
							<input type='button' value=Submit id='jqxSubmitButton' />		
						</td>
					</tr>
			 </table>
		 </form>			
    </td>
  </tr>
  <tr>
	<td colspan='3' style='border: 0px solid gray'>
		
		
	</td>
  <tr>
</table>