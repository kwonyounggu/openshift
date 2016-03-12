function validateEmail(email)
{
   //var re = /^(([^%#&+<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
   // var re=/^([a-zA-Z0-9\._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/; //used before
   //return email.match(re);//used before
 
   var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
   return reg.test(email);
}
function validatePassword(pwd)
{	//var re = /^[A-Za-z]\w{3,}[A-Za-z0-9]$/;
	var re = /^[A-Za-z0-9]\w{3,}[A-Za-z0-9]$/;//alpha-numeric combinations without any order
	return pwd.match(re);
}
function verify2Passwords(pwd,cpwd)
{	var is_ok=true;

	if(pwd==null || cpwd==null || !validatePassword(pwd) || !validatePassword(cpwd) ||pwd!=cpwd)
	{	
		is_ok=false;
	}
//	else if(pwd.value.length<4) 
//	{
//		is_ok=false;
//	}
	return is_ok;		
}
function removeSpecialChars(str)
{ 
	return str.replace(/[^a-zA-Z 0-9 가-힣 ()=:.?_\/\[\]-]+/g,'');//original
}
function removeSpecialCharsEx(str)
{ 
	return str.replace(/[^a-zA-Z 0-9 가-힣 ()=:.,?_(\r\n|\n|\r)\t\/\[\]-]+/g,'');//original
}
function removeSpecialCharsV2(str)
{ 
	return str.replace(/[^a-zA-Z 0-9 가-힣 ()=._\/\[\]-]+/g,'');//original
}
function getAcceptableChars(str)
{ 
	return str.replace(/[^a-zA-Z 0-9 가-힣 ().?_\/\[\]-]+/g,'');//original
}
function replaceDoubleQuotatations(mystr)
{
	return mystr.replace(/\"/g,'\'');
}
function removeNonAscii(mystr)
{
	return mystr.replace(/[^\x00-\x7F]/g, '');
}
function isNull(obj, msg) 
{
	if(obj.value == "") 
	{
		if(msg) 
		{
			alert(msg);
		}
		obj.focus();
		return true;
	}
	return false;
}

function isNumber(obj) 
{
	var str = obj.value;
	if(str.length == 0) return false;

	for(var i=0; i < str.length; i++) 
		if(!('0' <= str.charAt(i) && str.charAt(i) <= '9')) return false;
	
	return true;
}
function isPhoneNumber(obj) 
{
	var str = obj.value.toLowerCase();
	if(str.length < 9) return false; //02-123-1234: minimum length

	if(!('0' <= str.charAt(0) && str.charAt(0) <= '9')) return false;
	for(var i=1; i < str.length; i++) 
		if(!(('0' <= str.charAt(i) && str.charAt(i) <= '9') || str.charAt(i)=='-'||str.charAt(i)==' '||str.charAt(i)=='e'||str.charAt(i)=='x'||str.charAt(i)=='t'||str.charAt(i)==':')) return false;
	
	return true;
}
function isCellPhoneNumber(obj) 
{
	var str = obj.value;
	if(str.length == 0) return true; //02-123-1234: minimum length
	else if(str.length<9) return false;
	
	if(!('0' <= str.charAt(0) && str.charAt(0) <= '9')) return false;
	for(var i=1; i < str.length; i++) 
		if(!(('0' <= str.charAt(i) && str.charAt(i) <= '9') || str.charAt(i)=='-')) return false;
	
	return true;
}
function isSame(obj1, obj2) 
{
	//alert("obj1="+obj1.value+" obj2="+obj2.value);
	var str1 = obj1.value;
	var str2 = obj2.value;
	if(str1.length == 0 || str2.length == 0) return false;

	if(str1 == str2) return true;
	return false;
}

function isShort(obj, len, msg) 
{
	var str = obj.value;
	if(str.length < len) 
	{
		if(msg) 
		{
			alert(msg);	
		}
		obj.focus();
		obj.select();
		return true;
	}
	return false;
}

function isAlphabet(obj) 
{
	var str = obj.value;
	if(str.length == 0)
		return false;

	str = str.toUpperCase();
	for(var i=0; i < str.length; i++) {
		if(!('A' <= str.charAt(i) && str.charAt(i) <= 'Z'))
			return false;
	}
	return true;
}

function isAlphaNumeric(obj) 
{
	var str = obj.value;
	if(str.length == 0) return false;

	str = str.toUpperCase();
	for(var i=0; i < str.length; i++) {
		if(!(('A' <= str.charAt(i) && str.charAt(i) <= 'Z') ||
			('0' <= str.charAt(i) && str.charAt(i) <= '9')))
			return false;
	}
	return true;
}
//check korean name without any space in the middle
function isKoreanName(name)
{
	 if(name.value.length==0 || name.value.length==1) return false;
	 for (var i=0; i<name.value.length; i++)
		 if ((name.value.charAt(i) >= "가") && (name.value.charAt(i) <= "힣")) continue; 
		 else return false;
	 return i<6 ? true: false;//up to 5 chars it's ok
}
//check english name including numbers unless the 1st char is a digit
function isEngName(obj) 
{
	var str = obj.value;
	if(str.length == 0) return false;

	str = str.toUpperCase();
	if(!('A' <= str.charAt(0) && str.charAt(0) <= 'Z')) return false;

	for(var i=1; i < str.length; i++) {
		if(!(('A' <= str.charAt(i) && str.charAt(i) <= 'Z') ||
			('0' <= str.charAt(i) && str.charAt(i) <= '9')))
			return false;
	}
	return true;
}
function isID(obj) 
{
	var str = obj.value;
	if(str.length == 0)
		return false;

	str = str.toUpperCase();
	if(!('A' <= str.charAt(0) && str.charAt(0) <= 'Z')) return false;

	for(var i=1; i < str.length; i++) {
		if(!(('A' <= str.charAt(i) && str.charAt(i) <= 'Z') ||
			('0' <= str.charAt(i) && str.charAt(i) <= '9') ||
			(str.charAt(i) == '_')||
			(str.charAt(i) == '.')))
			return false;
	}
	return true;
}
function isRightWordForDemographics(obj) 
{
	var str = obj.value;
	if(str.length == 0)
		return false;

	str = str.toUpperCase();
	if(!('A' <= str.charAt(0) && str.charAt(0) <= 'Z')) return false;

	for(var i=1; i < str.length; i++) {
		if(!(('A' <= str.charAt(i) && str.charAt(i) <= 'Z') ||
			('0' <= str.charAt(i) && str.charAt(i) <= '9') ||
			(str.charAt(i) == '_')||
			(str.charAt(i) == '-')||
			(str.charAt(i) == ' ')||
			(str.charAt(i) == '.')))
			return false;
	}
	return true;
}
//This will be only used for CSR's Epoch login

function isLoginID(obj) 
{
	var str = obj.value;
	if(str.length < 6) //first_name.last_name.01
		return false;

	str = str.toUpperCase();
	//The first char should be in alphabet.
	if(!('A' <= str.charAt(0) && str.charAt(0) <= 'Z')) return false;

	for(var i=1; i < str.length; i++) {
		if(!(('A' <= str.charAt(i) && str.charAt(i) <= 'Z') ||
			('0' <= str.charAt(i) && str.charAt(i) <= '9') ||
			(str.charAt(i) == '_')||
			(str.charAt(i) == '.')))
			return false;
	}
	return true;
}
function is_postal_code(entry1)
{ // CANADIAN CODES ONLY
	var strlen=entry1.length; if(strlen!=6) {return false;}
	var entry=entry1.toUpperCase();    // in case of lowercase characters
	// Check for legal characters in string - note index starts at zero
	if('ABCEGHJKLMNPRSTVXY'.indexOf(entry.charAt(0))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(1))<0) {return false;}
	if('ABCDEFGHJKLMNPQRSTUVWXYZ'.indexOf(entry.charAt(2))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(3))<0) {return false;}
	if('ABCDEFGHJKLMNPQRSTUVWXYZ'.indexOf(entry.charAt(4))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(5))<0) {return false;}
	return true;
}
function is_csr_reference_no(entry1)
{ // CANADIAN CODES ONLY
	var strlen=entry1.length; if(strlen!=13) {return false;}
	var entry=entry1.toUpperCase();    // in case of lowercase characters
	// Check for legal characters in string - note index starts at zero
	if('0123456789'.indexOf(entry.charAt(0))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(1))<0) {return false;}
	if('_'.indexOf(entry.charAt(2))<0) {return false;}
	if('ABCDEFGHIJKLMNOPQRSTUVWXYZ'.indexOf(entry.charAt(3))<0) {return false;}
	if('ABCDEFGHIJKLMNOPQRSTUVWXYZ'.indexOf(entry.charAt(4))<0) {return false;}
	if('_'.indexOf(entry.charAt(5))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(6))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(7))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(8))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(9))<0) {return false;}
	if('_'.indexOf(entry.charAt(10))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(11))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(12))<0) {return false;}
	return true;
}
function is_bpews_reference_no(entry1)
{ // CANADIAN CODES ONLY
	var strlen=entry1.length; if(strlen!=17) {return false;}
	var entry=entry1.toUpperCase();    // in case of lowercase characters
	// Check for legal characters in string - note index starts at zero
	if('0123456789'.indexOf(entry.charAt(0))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(1))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(2))<0) {return false;}
	if('_'.indexOf(entry.charAt(3))<0) {return false;}
	if('ABCDEFGHIJKLMNOPQRSTUVWXYZ'.indexOf(entry.charAt(4))<0) {return false;}
	if('ABCDEFGHIJKLMNOPQRSTUVWXYZ'.indexOf(entry.charAt(5))<0) {return false;}
	if('_'.indexOf(entry.charAt(6))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(7))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(8))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(9))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(10))<0) {return false;}
	if('_'.indexOf(entry.charAt(11))<0) {return false;}
	if('ABCDEFGHIJKLMNOPQRSTUVWXYZ'.indexOf(entry.charAt(12))<0) {return false;}
	if('_'.indexOf(entry.charAt(13))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(14))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(15))<0) {return false;}
	if('0123456789'.indexOf(entry.charAt(16))<0) {return false;}
	return true;
}
function check_alphanumeric(cid) 
{	if(cid=="") return false;
	var alpha_numeric = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'+'1234567890'; 
		var pass=true;
	for (var i=0; i < cid.length; i++) 
	{	if (alpha_numeric.indexOf(cid.charAt(i)) < 0) 
		{	pass=false;
			break; 
		}
	}	
	return pass;
}
function check_news_category(cid) 
{	if(cid=="") return false;
	var alpha_numeric = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'+'1234567890'+' '; 
		var pass=true;
	for (var i=0; i < cid.length; i++) 
	{	if (alpha_numeric.indexOf(cid.charAt(i)) < 0) 
		{	pass=false;
			break; 
		}
	}	
	return pass;
}
//Medication Safety: check drug name in create study
function check_drug_name(cid) 
{	if(cid=="") return false;
	var alpha_numeric = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'+'-1234567890'+' '+'\''+','+'-'+'\('+'\)'; 
	var pass=true;
	for (var i=0; i < cid.length; i++) 
	{	if (alpha_numeric.indexOf(cid.charAt(i)) < 0) 
		{	pass=false;
			break; 
		}
	}	
	return pass;
}
// Removes leading whitespaces
function LTrim( value ) {
	
	var re = /\s*((\S+\s*)*)/;
	return value.replace(re, "$1");
	
}

// Removes ending whitespaces
function RTrim( value ) {
	
	var re = /((\s*\S+)*)\s*/;
	return value.replace(re, "$1");
	
}

// Removes leading and ending whitespaces
function trim( value ) {
	
	return LTrim(RTrim(value));
	
}

function checkAddress(cid) 
{	cid=trim(cid);
	if(cid==""||cid.length<1) return false;
	var alpha_numeric = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'+'#-1234567890.'+' '; 
		var pass=true;
	for (var i=0; i < cid.length; i++) 
	{	if (alpha_numeric.indexOf(cid.charAt(i)) < 0) 
		{	pass=false;
			break; 
		}
	}	
	return pass;
}

function checkAlphanumericSpace(cid) 
{	
	if(cid=="") return false;
	var alpha_numeric = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'+'1234567890'+' '; 
		var pass=true;
	for (var i=0; i < cid.length; i++) 
	{	if (alpha_numeric.indexOf(cid.charAt(i)) < 0) 
		{	pass=false;
			break; 
		}
	}	
	return pass;
}
/*****************************************
find a special character:
return false if it contains a special char
return true if it is ok for name.
******************************************/
function checkName(name) 
{	
	if(name=="") return false;
	
	var non_name = "~!@#$%^&*()+=-[]\\\';,./{}|\":<>?"+"1234567890"; 
	var is_ok=true;
	for (var i=0; i < name.length; i++) 
	{	if (non_name.indexOf(name.charAt(i))!=-1) 
		{	is_ok=false;
			break; 
		}
	}	
	return is_ok;
}

function isEmail(obj) 
{
	var str = obj.value;
	if(str == "")
		return false;

	var i = str.indexOf("@");
	if(i < 0)
		return false;

	i = str.indexOf(".");
	if(i < 0)
		return false;
	
	return true;
}

function isCardNumber(obj)
{
	var str = obj.value;
	if(str.length != 16)
		return false;

	for(var i=0; i < 16; i++) 
	{
		if(!('0' <= str.charAt(i) && str.charAt(i) <= '9')) 
			return false;
	}
	return true;
}
function isUrl(s) 
{
	var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
	return regexp.test(s);
}
//For checking if a string is blank, null or undefined I use:
function isBlank(str)
{
	return (!str || /^\s*$/.test(str));
}
