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
	
	#estimate_table td
	{
		font-size: 40px;
	}
	#estimate_table span
	{
		font-size: 40px;
	}
	#estimate_table span
	{
		font-size: 40px;
	}
	#estimate_table input
	{
		font-size: 38px;
		width: 80%;
	}
	input[type=radio] 
	{
	    border: 0px;
	    width: 100%;
	    height: 1em;
	}
	.tooltipster-default
	{
		border-radius: 1px;
		border: 1px solid #eee;

		background: #942724;
		color: #e4f1ff;
	}	
	/* http://iamceege.github.io/tooltipster */
	.tooltipster-content
	{
		/*Not working*/
	}
	.hide-bt-alert
	{
		display: none;
	}
	.alert-success
	{
		border-radius:0;
		padding: 2px 5px;
	}
	.alert-danger
	{
			border-radius:0;
			padding: 2px 5px;
	}
	.alert-danger a:link 
	{
	    color: red;
	}
	.alert-danger a
	{
	    text-decoration: none;
	}
	.alert-danger a:visited 
	{
	    color: red;
	}
	.alert-danger a:hover 
	{
	    color: red;
	}
	.alert-danger a:active 
	{
	    color: red;
	}
</style>
<script src="js/ckeditor/ckeditor.js"></script>
<script type="text/javascript">

	$(document).ready(function ()
	{
		//change the following on top of the contact, just below the menu
		if(typeof FormData == 'undefined')
			jAlert("<p>Your browser does not support HTML5. Please upgrade your browser with the latest version. Otherwise it won't work properly!</p>", "Warning Message");
	
		//The following does not work from Google Chrome
		/*$.getJSON("http://freegeoip.net/json/", function(data) 
		{
			var location_info=data.city+" "+data.region_name+" "+data.country_name;
		});
		*/
		//see https://rochcass.wordpress.com/tag/freegeoip-net-post/
		$.ajax
		({
			url: 'http://freegeoip.net/json/',
			type: 'POST',
			dataType: 'jsonp',
			success: function (data) 
			{
				//put the client location in a hidden input field
				$('#client_place').val(data.city+" "+data.region_name+" "+data.country_name);
			}
		});
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
			height: 300
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
				select_animal:
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
			//var tName=$.trim(value);
		    return (isKoreanName(element) || checkNameUsingRegEx(value.trim()));
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
		//For tablet
		$("#submitButton").click(function()
		{
	        $("#estimate_form").valid();
	    });
		$('#estimate_form').on('submit',function(e)
		{
	        e.preventDefault();
	    });
	});//$(document).ready

	function submitForm()
	{
		run_waitMe("roundBounce");
		
		var formData=new FormData(document.getElementById("estimate_form"));
		/**** Android original google chrome does not support formData.set ****/
		//formData.set('submitter_note', CKEDITOR.instances.estimateNoteEditor.getData());
		//formData.set('note_msg', 'estimates');
		log("submitter_note: "+CKEDITOR.instances.estimateNoteEditor.getData());
		$.ajax
	     ({
	         type: "post",
	         dataType: "", //see https://rochcass.wordpress.com/tag/freegeoip-net-post/
	         url: "/fileupload?note_msg=estimates&submitter_note="+CKEDITOR.instances.estimateNoteEditor.getData(),
	         data: formData,
	     	 processData: false, // Don't process the files
	         contentType: false, // Set content type to false as jQuery will tell the server its a query string request
	         success: fileUploadResponse,
	         error: function(jqXHR, exception) //called for 404 error, etc
	         {
	        	 var msg = '';
	             if (jqXHR.status === 0) 
	             {
	                 msg = 'Not connect.\n Verify Network.';
	             } 
	             else if (jqXHR.status == 404) 
	             {
	                 msg = 'Requested page not found. [404]';
	             } 
	             else if (jqXHR.status == 500) 
	             {
	                 msg = 'Internal Server Error [500].';
	             } 
	             else if (exception === 'parsererror') 
	             {
	                 msg = 'Requested JSON parse failed.';
	             } 
	             else if (exception === 'timeout') 
	             {
	                 msg = 'Time out error.';
	             } 
	             else if (exception === 'abort') 
	             {
	                 msg = 'Ajax request aborted.';
	             } 
	             else 
	             {
	                 msg = 'Uncaught Error.\n' + jqXHR.responseText;
	             }
	        	 log("HTTP Error: "+msg);
	             fileUploadResponse(msg+" from ajax calling!");
	         }
	      }); 
		  
	}
        
	function run_waitMe(effect)
	{ 	console.log("run_waitMe: "+effect);
		$("#estimate_form").waitMe
		({
			effect: effect,
			text: 'Please wait...',
			bg: 'rgba(255,255,255,0.1)',
			color: '#000',
			maxSize: '',
			source: 'img.svg',
			onClose: function() {}
		});
	}

	function fileUploadResponse(strResponse)
	{
		log(strResponse+" from fileUploadResponse");
		
		$('#estimate_form').waitMe('hide');
		
		if(strResponse==="<%= Message.CONTACT_SUCCESS %>")
		{
			$('#submit_success_alert').css('visibility','visible').fadeIn();
			$('#submit_error_alert').css('visibility','hidden');
			CKEDITOR.instances.estimateNoteEditor.setData("");
			$('#estimate_form')[0].reset();
			
			//in 5 sec, remove the success sign and reload
			window.setTimeout(function() 
			{
				$('#submit_success_alert').fadeTo(500, 0).slideUp(500, function()
			    {
			        $(this).remove(); 
			        location.reload();
			    });
			}, 5000);
		}
		else
		{
			$('#submit_success_alert').css('visibility','hidden');
			
			$('#submit_error_alert').prop('title', "'"+strResponse.replace(/error|:/gi, "")+"'");
			$('#submit_error_alert').css('visibility','visible').fadeIn();
		}		
	}
	
	//see, http://abandon.ie/notebook/simple-file-uploads-using-jquery-ajax
</script>
<div style="width: 95%; background-color: #555762; color: #ffffff; padding: 10px 20px 10px 30px; text-align:left;">
    	<ul>
    		<h3 style='color: #f9d540'>Contact</h3>
    		<h4 style='font-size: 32px; color: #bad5fe;'>
    		If you are interested in growing your business and building a positive brand experience for your customers/patients, then we should talk:
    		</h4>
    		<li>By Email: <a href="mailto:<%=AuthData.mycompany_email_address%>?Subject=Hello WebMonster.CA" style="color:inherit;text-decoration: none" target="_top"><%=AuthData.mycompany_email_address%></a></li>
    		
    		<li>By Skype: <%=AuthData.skype_id %>
    			<br />
    			- appointment required
    		</li>
    		
    		<li>By Phone: <%=AuthData.company_phone %>
    			<br/>
    			- from 9:00am to 5:00pm (EST)
    		</li>
    		
    		<li>By Visiting primary place: 
    			<br/>
    			- <%=AuthData.company_address.substring(0, AuthData.company_address.length()-15) %>			
    			<br/>
    			- appointment required
    		</li>
    		<li>By Visiting secondary place: 		
    			<br/>
    			- TBD
    			<br/>
    			- appointment required
    		</li>
    		
    		<li>What did you have in mind? <h4 style='font-size: 32px; color: #bad5fe;'>Suggestions to include: competitor's websites, designs that you like, some initial ideas for your brand, what kind of niches you'd like to explore, and anything to get the conversation going!</h4></li>
    		<li style='list-style-type: none; height: 30%' />
    	</ul>
</div>
<div style="height: 20px;"></div>
<div style="width: 95%; background-color: #555762; color: #ffffff; padding: 10px 20px 30px 30px; text-align:left;">
  			<form id='estimate_form' action='./'>
			   	<table  id='estimate_table' style='width: 100%; border-spacing: 4px; padding: 0px 0px 30px 0px;'>
			   		<tr>
			   			<td colspan='2' style='text-align: left;'>
			   				<h3 style='color: #f9d548;'>Estimate<span style='color: #8fc161;'>(*: required)</span></h3>		   				
			   			</td>
			   		</tr>
			   		<tr>
			   			<td class='estimate_form_td'  style='width: 25%; '>Name: <span style='color: #8fc161;'>*</span>
			   			</td>
			   			<td>
			 				<input type='text' id='submitter_name' name='submitter_name'  placeholder='Bob Smith' />
						</td>
			   		</tr>
			   		<tr>
			   			<td class='estimate_form_td'   style='width: 25%; '>Phone: <span style='color: #8fc161;'>*</span>
			   			</td>
			   			<td>
			 				<input type='text' name='submitter_phone' placeholder='(123)-123-1234' />
						</td>
			   		</tr>
			   		<tr>
			   			<td class='estimate_form_td'   style='width: 25%'>E-Mail: <span style='color: #8fc161;'>*</span>
			   			</td>
			   			<td>
			 				<input type='text' name='submitter_email' placeholder='webmosnter.ca@gmail.com' />
						</td>
			   		</tr>
					<tr>
			   			<td class='estimate_form_td' colspan='2'>Note about your requirements:
			   				<span style='color: #8fc161;' id='note_span'>*
			   					<!-- To hide the input but only to display the error message -->
			   					<input type='text' style='width: 0px; height: 0px; border: none; background-color: #555762' name='note_msg' id='note_msg' value='estimates'/>
			   				</span>
			   				<br/>
			 				<textarea id='estimateNoteEditor' name='submitter_note' id='submitter_note' ></textarea>
						</td>
			   		</tr>


					<tr>
			   			<td class='estimate_form_td' colspan='2'>A file to upload about your app :&nbsp;</td>
			   		</tr>
			   		<tr>
			   			<td class='estimate_form_td' colspan='2'>
			 				<input type='file' id='file_to_upload' name='file_to_upload' style='color: #ffffff; width: 600px; -webkit-appearance: none'/>
						</td>
			   		</tr>

			   		<tr>
			   			<td class='estimate_form_td' colspan='2'>Select the elephant before submitting <span style='color: #8fc161;' id='check_robot_span'>*</span>
			   				<!-- To hide the input but only to display the error message -->
			   				<input type='text' style='width: 0%; height: 0%; border: none; -webkit-appearance: none' name='select_animal' id='select_animal' value='1'/>
			   				<br />
			   				<input type='radio' style='width: 150px; outline: 0px' name='animalGroup' id='animal_1' value='1'/>
			   				<input type='radio' style='width: 150px; outline: 0px' name='animalGroup' id='animal_2' value='2'/>
			   				<input type='radio' style='width: 150px; outline: 0px' name='animalGroup' id='animal_3' value='3'/>
			   				<br />
			   				<img src="images/three_animals.png" width="462" height="86" alt="Three Animals" border="0"/>
						</td>
			   		</tr>
					<tr>
					    <td colspan='2' style='padding-top: 30px; text-align: left;'>
							<input type='submit' style='width: 220px;' value='Submit' id='submitButton' onfocus="this.blur()"/>
							<input type='hidden' id='client_place' name='client_place' value='toronto'/>
						</td>
					</tr>
					
					<tr>
						<td colspan='2'>
							<div id="submit_success_alert" class="alert alert-success hide-bt-alert"><%=Message.CONTACT_SUCCESS %>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan='2'>
							<div id="submit_error_alert" class="alert alert-danger  hide-bt-alert">
								<a href='#' id='submit_error_alert_anchor'>Error: please check your input data and try again!</a>
							</div>
						</td>
					</tr>
			 </table>
		 </form>
</div>