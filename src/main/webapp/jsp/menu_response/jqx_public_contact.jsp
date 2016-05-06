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
	input
	{
		color: #000000;
	}
	table
	{
		border-collapse: separate;
		border-spacing: 5px;
	}
	.tooltipster-default
	{
		border-radius: 1px;
		border: 1px solid #eee;

		background: #942724;
		color: #e4f1ff;
	}
</style>
<script src="js/ckeditor/ckeditor.js"></script>
<script type="text/javascript">

	$(document).ready(function ()
	{
		//change the following on top of the contact, just below the menu
		if(typeof FormData == 'undefined')
			jAlert("<p>Your browser does not support HTML5. Please upgrade your browser with the latest version. Otherwise it won't work properly!</p>", "Warning Message");
	
		CKEDITOR.replace( 'estimateNoteEditor',
		{
			// Define the toolbar groups as it is a more accessible solution.
			toolbarGroups:
			[
				{"name":"basicstyles","groups":["basicstyles"]},
				{"name":"links","groups":["links"]},
				{"name":"paragraph","groups":["list","blocks"]},
				{"name":"insert","groups":["insert"]}
			],
			// Remove the redundant buttons from toolbar groups defined above.
			removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',
			resize_enabled: false,
			height: 150
		});
	
		//Initialize the tooltips
		 $('form input').tooltipster
		 ({
				     trigger: 'custom',
				     onlyOne: false,
				     position: 'right',
				     multiple:false,
				     autoClose:false
		   });
	
		//$(".phone").mask("(999) 999-9999");
		$('#estimate_form').validate
		({
			//ignore: ".ignore :hidden",
			//ignore: [],
			rules:
			{
				submitter_name:
				{	required: true,
					minlength: 2,
					maxlength: 80,
					isNameValid: true
				},
				submitter_phone:
				{
					required: true,
					isPhoneValid: true
				},
				submitter_email:
				{
					required: true,
					email: true
				},
				note_msg:
				{
					required: true,
					isTextValid: true
				},
				file_to_upload:
				{
					required: false,
					isFileValid: true
				},
				animalGroup:
				{
					required: true,
					isAnimalValid: true
				}
			},
			messages:
			{
				submitter_name:
				{
					required: "Your name is required!"
				},
				submitter_phone:
				{
					required: "Phone number is required!"
				},
				submitter_email:
				{
					required: "E-Mail is required!"
				}
			},
			submitHandler: function (form)
			{ 
				submitForm();
	            return false;
	        },
	        errorPlacement: function (error, element)
	        {
				var lastError = $(element).data('lastError'),
					newError = $(error).text();
	
				$(element).data('lastError', newError);
	
				if (newError !== '' && newError !== lastError)
				{
					$(element).tooltipster('content', newError);
					$(element).tooltipster('show');
				}
			},
			success: function (label, element)
			{
				$(element).tooltipster('hide');
			}
		});
		$.validator.addMethod("isNameValid", function(value, element)
		{
		    return (isKoreanName(element) || checkNameUsingRegEx(value));
		}, "Your name is not valid!");
		$.validator.addMethod("isPhoneValid", function(value, element)
		{
			var regPhone=/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/;
			return regPhone.test(value);
		}, "Phone number is not valid!");
		$.validator.addMethod("isTextValid", function(value, element)
		{
			var estimateEditorText=$.trim($(CKEDITOR.instances.estimateNoteEditor.getData()).text());
			return estimateEditorText.length>3;
		}, "Please put a note!");
		$.validator.addMethod("isFileValid", function(value, element)
		{
			if( document.getElementById("file_to_upload").files.length == 0 )
			{
				log("No files selected");
				return true;
			}
			else
			{
				log("file size: "+document.getElementById("file_to_upload").files[0].size);
				return (document.getElementById("file_to_upload").files[0].size <= <%=Utils.MAX_FILE_SIZE%>);
	
			}
		}, "Please limit the file size upto 5MB!");
		$.validator.addMethod("isAnimalValid", function(value, element)
		{
			return $("#animal_3").is(":checked");
		}, "Please answer correctly");
	
	});//$(document).ready

	function submitForm()
	{
		run_waitMe("roundBounce");
		var formData=new FormData(document.getElementById("estimate_form"));
		$.ajax
	     ({
	         type: "post",
	         dataType: "",
	         url: "/file_upload",
	         data: formData,
	         /*data: 
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
	     	 },*/
	     	 processData: false, // Don't process the files
	         contentType: false, // Set content type to false as jQuery will tell the server its a query string request
	         success: fileUploadResponse,
	         error: function(response) //called for 404 error, etc
	         {
	        	 alert(response.responseText);	
	             
	         }
	      }); 
		  
	}
        
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
	function fileUploadResponse(strResponse)
	{
		log(strResponse+" from fileUploadResponse")
		/*if(strResponse.indexOf('session_timeout')==0) 
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
		*/
	}
</script>
<table style='width: 90%; padding-top: 20px; padding-bottom: 20px; table-layout: fixed'>
   <tr>
    <td style='background-color: #555762; color: #ffffff; width: 50%; vertical-align: top;'>
    	<ul style='font-size: 12px'>
    		<h3 style='color: #f9d540'>Contact[Under construction]</h3>
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
			   				<span style='font-size: .95em; color: #8fc161;'>(*: required)</span>
			   				<span style='font-size: 11px; color: #bad5fe;'>Payment is not required unless you are satisfied.</span>
			   			</td>
			   		</tr>
			   		<tr>
			   			<td class='estimate_form_td'  style='width: 20%'>Name: <span style='font-size: .95em; color: #8fc161;'>*</span>
			   			</td>
			   			<td>
			 				<input type='text' name='submitter_name'  placeholder='Bob Smith' style='width: 250px; height: 22px'/>
						</td>
			   		</tr>
			   		<tr>
			   			<td class='estimate_form_td'   style='width: 20%'>Phone: <span style='font-size: .95em; color: #8fc161;'>*</span>
			   			</td>
			   			<td>
			 				<input type='text' name='submitter_phone' placeholder='(123)-123-1234' style='width: 250px; height: 22px'/>
						</td>
			   		</tr>
			   		<tr>
			   			<td class='estimate_form_td'   style='width: 20%'>E-Mail: <span style='font-size: .95em; color: #8fc161;'>*</span>
			   			</td>
			   			<td>
			 				<input type='text' name='submitter_email' placeholder='webmosnter.ca@gmail.com' style='width: 250px; height: 22px'/>
						</td>
			   		</tr>
					<tr>
			   			<td class='estimate_form_td' colspan='2'>Note about your requirements:
			   				<span style='font-size: .95em; color: #8fc161;' id='note_span'>*
			   					<!-- To hide the input but only to display the error message -->
			   					<input type='text' style='width: 0px; height: 0px; border: none; background-color: #555762' name='note_msg' id='note_msg' value='1'/>
			   				</span>
			   				<br/>
			 				<textarea id='estimateNoteEditor' name='submitter_note' cols='80' rows='10'></textarea>
						</td>
			   		</tr>


					<tr>
			   			<td class='estimate_form_td' colspan='2'>A file about your application design to upload :&nbsp;</td>
			   		</tr>
			   		<tr>
			   			<td class='estimate_form_td' colspan='2'>
			 				<input type='file' id='file_to_upload' name='file_to_upload' style='color: #ffffff; width: 300px'/>
						</td>
			   		</tr>

			   		<tr>
			   			<td class='estimate_form_td' colspan='2'>Please select the elephant before submitting <span style='font-size: .95em; color: #8fc161;' id='check_robot_span'>*</span>&nbsp;:&nbsp;
			   				<br />
			   				<input type='radio' style='margin-right: 100px; margin-left: 50px;' name='animalGroup' id='animal_1' value='1'/>
			   				<input type='radio' style='margin-right: 100px;' name='animalGroup' id='animal_2' value='2'/>
			   				<input type='radio' name='animalGroup' id='animal_3' value='3'/>
			   				<img src="images/three_animals.png" width="362" height="86" alt="Three Animals" border="0"/>
						</td>
			   		</tr>
			   		<!--
			   		<tr><td colspan='2' align='center'><img id='spinner_img' src='images/common/spinner.gif' width=32 height=32  class="spinner_unhidden"/></td></tr>
			   		-->
					<tr>
					    <td colspan='2' >
							<input type='submit' value='Submit' id='submitButton' />
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