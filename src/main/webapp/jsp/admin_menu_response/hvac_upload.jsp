<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.common.*" %>
<%@ page import="com.enums.*" %>
<%@ page import="java.util.*" %>
<%@ page isELIgnored ="false" %>
<style>

	#hvac_upload_form label
	{
		font-weight: normal;
		width: 160px;
	}
	#hvac_upload_form select
	{
		color: black;
	}
	#hvac_upload_form input
	{
		color: black;
	}
	.tooltipster-default
	{
		border-radius: 1px;
		border: 1px solid #eee;

		background: #942724;
		color: #e4f1ff;
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
		$('#hvac_upload_form').validate
		({
			rules:
			{
				file_to_upload:
				{
					required: true,
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
				file_to_upload:
				{
					required: "You should choose a file to upload!"
				},
				select_animal:
				{
					required: "You should choose the right image for the elephant!"
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
	
	});//$(document).ready

	function submitForm()
	{
		run_waitMe("roundBounce");
		var formData=new FormData(document.getElementById("hvac_upload_form"));
		formData.set('submitter_note', CKEDITOR.instances.estimateNoteEditor.getData());
		formData.set('note_msg', 'estimates');//it will be /estimates/filename.pdf in dropbox

		$.ajax
	     ({
	         type: "post",
	         dataType: "", //see https://rochcass.wordpress.com/tag/freegeoip-net-post/
	         url: "/fileupload",
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
		$("#hvac_upload_form").waitMe
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
		
		$('#hvac_upload_form').waitMe('hide');
		
		if(strResponse==="<%= Message.CONTACT_SUCCESS %>")
		{
			$('#submit_success_alert').css('visibility','visible').fadeIn();
			$('#submit_error_alert').css('visibility','hidden');
			CKEDITOR.instances.estimateNoteEditor.setData("");
			$('#hvac_upload_form')[0].reset();
			
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
<div style="padding-left: 30px; padding-bottom: 10px; text-align: left; margin-top: -10px;">Upload -> <strong>HVAC</strong></div>
<div style="padding: 20px 20px 20px 20px; text-align: left; background-color: #555762; color: white;">
	<h3 style='color: #f9d540; margin-top: -10px;'>Upload files to google drive</h3>
	<form id='hvac_upload_form' action='./' style="padding-left: 20px;">
		<div>
	   		<label for="hvacBrands">Brand:</label>
	   		<select id="hvacBrands">
	   			<%
	   				for(HvacBrands brand : HvacBrands.values())
	   				{
	   					out.print("<option value='"+brand.toString()+"' >"+brand.toString()+"</option>");
	   				}
	   			%>
	   		</select>
	   	</div>
	   	<div>
	   		<label for="hvacAccommodationType">Space Type:</label>
	   		<select id="hvacAccommodationType">
	   			<%
	   				for(HvacAccommodationTypes space : HvacAccommodationTypes.values())
	   				{
	   					out.print("<option value='"+space.toString()+"' >"+space.toString()+"</option>");
	   				}
	   			%>
	   		</select>
	   	</div>
	   	<div>
	   		<label for="hvacSystemType">System Type:</label>
	   		<select id="hvacSystemType">
	   			<%
	   				for(HvacSystems sys : HvacSystems.values())
	   				{
	   					out.print("<option value='"+sys.toString()+"' >"+sys.toString()+"</option>");
	   				}
	   			%>
	   		</select>
	   	</div>
	   	<div>
	   		<label for="hvacSystemModel">Model Number:</label>
	   		<input type='text' id='hvacSystemModel' name='hvacSystemModel'  placeholder='Model Number' style='width: 250px; height: 22px'/>
	   	</div>
	   	<div>
	   		<label for="hvacManualType">Manual Type:</label>
	   		<select id="hvacManualType">
	   			<%
	   				for(HvacManualTypes manual : HvacManualTypes.values())
	   				{
	   					out.print("<option value='"+manual.toString()+"' >"+manual.toString()+"</option>");
	   				}
	   			%>
	   		</select>
	   		<input type='hiddden' style='width: 0px; height: 0px; border: none; background-color: #555762' name='submittingCompanyId' id='submittingCompanyId' value='1'/>
	   	</div>
	   	<div>
	   		<label for="hvacFuelType">Fuel Type:</label>
	   		<select id="hvacFuelType">
	   			<%
	   				for(HvacFuels fuel : HvacFuels.values())
	   				{
	   					out.print("<option value='"+fuel.toString()+"' >"+fuel.toString()+"</option>");
	   				}
	   			%>
	   		</select>
	   	</div>
	   	<div>
	   		<label for="file_to_upload">A file to upload :</label>
			<input type='file' id='file_to_upload' name='file_to_upload' style='color: #ffffff;'/>
	   	</div>
	   	<div>
	   		<label style="width: 100%">Please select the elephant before submitting:</label>
	   				<!-- To hide the input but only to display the error message -->
	   				<input type='text' style='width: 0; height: 0; border: none; -webkit-appearance: none; background-color: #555762' name='select_animal' id='select_animal' value='a'/>
	
	   				<fieldset>
	   				<input type='radio' style='width: 150px; outline: 0px' name='animalGroup' id='animal_1' value='1'/>
	   				<input type='radio' style='width: 80px; outline: 0px' name='animalGroup' id='animal_2' value='2'/>
	   				<input type='radio' style='width: 100px; outline: 0px' name='animalGroup' id='animal_3' value='3'/>
	   				</fieldset>
	   				<img src="images/three_animals.png" width="362" height="86" alt="Three Animals" border="0"/>
	   	</div>
	   	<div>
					<input type='submit' style='width: 80px;' value='Submit' id='submitButton' />
					<input type='hidden' id='client_place' name='client_place' value='toronto'/>
		</div>
		<div id="submit_success_alert" class="alert alert-success hide-bt-alert"><%=Message.CONTACT_SUCCESS %>
		</div>

		<div id="submit_error_alert" class="alert alert-danger  hide-bt-alert">
			<a href='#' id='submit_error_alert_anchor'>Error: please check your input data and try again!</a>
		</div>
				
	</form>
</div>
  
