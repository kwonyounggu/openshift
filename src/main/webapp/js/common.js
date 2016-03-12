	function getRadioValue(radioGroupName) 
	{
	    var radios = document.getElementsByName(radioGroupName);
		var returnValue="";
	    for (var i = 0; i < radios.length; i++) 
		{
	        if (radios[i].checked) 
		    {
	        	returnValue=radios[i].value;
	        	break;
		    }
	    }
	    //console.log("getRadioValue("+radioGroupName+") return value="+returnValue);
	    return returnValue;
	}
	function setRadioValue(radioGroupName, matchValue) 
	{	
	    var radios = document.getElementsByName(radioGroupName);
		try
		{
		    for (var i = 0; i < radios.length; i++) 
			{	//console.log(matchValue+"<=>"+radios[i].value);
				//if(matchValue.indexOf(radios[i].value)!=-1)
				if(matchValue===radios[i].value)
				{	//console.log("matched.................");
					radios[i].checked=true;
					break;
				}
		    }
		}
		catch(e)
		{
			jAlert("<p>"+e+"</p>", "Error Message");
		}
	}
	//The following function is for the last week's questionID=18 about by whom
	function getCheckValues(groupName) 
	{
	    var boxes = document.getElementsByName(groupName);
		var returnValue="a:"+(boxes[0].checked? "1": "0")+"|"+
						"b:"+(boxes[1].checked? "1": "0")+"|"+
						"c:"+(boxes[2].checked? "1": "0")+"|"+
						"d:"+(boxes[3].checked? "1": "0");
	    return returnValue;
	}
	function setCheckValues(groupName, previousValues) 
	{
		//console.log(previousValues);
	    var boxes = document.getElementsByName(groupName);
	    var temp = previousValues.split('|');
	    boxes[0].checked=(temp[0].split(':')[1]==="1") ? true: false;
	    boxes[1].checked=(temp[1].split(':')[1]==="1") ? true: false;
	    boxes[2].checked=(temp[2].split(':')[1]==="1") ? true: false;
	    boxes[3].checked=(temp[3].split(':')[1]==="1") ? true: false;

	    return boxes[0].checked || boxes[1].checked || boxes[2].checked || boxes[3].checked;
	}
	function getCheckValuesForThree(groupName) 
	{
	    var boxes = document.getElementsByName(groupName);
		var returnValue="a:"+(boxes[0].checked? "1": "0")+"|"+
						"b:"+(boxes[1].checked? "1": "0")+"|"+
						"c:"+(boxes[2].checked? "1": "0");
	    return returnValue;
	}
	//The following three functions are used for duty period section
	function setCheckValuesForThree(groupName, previousValues) 
	{
		//console.log(previousValues);
	    var boxes = document.getElementsByName(groupName);
	    var temp = previousValues.split('|');
	    boxes[0].checked=(temp[0].split(':')[1]==="1") ? true: false;
	    boxes[1].checked=(temp[1].split(':')[1]==="1") ? true: false;
	    boxes[2].checked=(temp[2].split(':')[1]==="1") ? true: false;

	    return boxes[0].checked || boxes[1].checked || boxes[2].checked;
	}
	function getCheckValuesForTen(groupName) 
	{
	    var boxes = document.getElementsByName(groupName);
		var returnValue="a:"+(boxes[0].checked? "1": "0")+"|"+
						"b:"+(boxes[1].checked? "1": "0")+"|"+
						"c:"+(boxes[2].checked? "1": "0")+"|"+
						"d:"+(boxes[3].checked? "1": "0")+"|"+
						"e:"+(boxes[4].checked? "1": "0")+"|"+
						"f:"+(boxes[5].checked? "1": "0")+"|"+
						"g:"+(boxes[6].checked? "1": "0")+"|"+
						"h:"+(boxes[7].checked? "1": "0")+"|"+
						"i:"+(boxes[8].checked? "1": "0")+"|"+
						"j:"+(boxes[9].checked? "1": "0");
	    return returnValue;
	}
	function setCheckValuesForTen(groupName, previousValues) 
	{
		//console.log(previousValues);
	    var boxes = document.getElementsByName(groupName);
	    var temp = previousValues.split('|');
	    boxes[0].checked=(temp[0].split(':')[1]==="1") ? true: false;
	    boxes[1].checked=(temp[1].split(':')[1]==="1") ? true: false;
	    boxes[2].checked=(temp[2].split(':')[1]==="1") ? true: false;
	    boxes[3].checked=(temp[3].split(':')[1]==="1") ? true: false;
	    boxes[4].checked=(temp[4].split(':')[1]==="1") ? true: false;
	    boxes[5].checked=(temp[5].split(':')[1]==="1") ? true: false;
	    boxes[6].checked=(temp[6].split(':')[1]==="1") ? true: false;
	    boxes[7].checked=(temp[7].split(':')[1]==="1") ? true: false;
	    boxes[8].checked=(temp[8].split(':')[1]==="1") ? true: false;
	    boxes[9].checked=(temp[9].split(':')[1]==="1") ? true: false;

	    return boxes[0].checked || boxes[1].checked || boxes[2].checked || boxes[3].checked || boxes[4].checked || boxes[5].checked || boxes[6].checked || boxes[7].checked || boxes[8].checked || boxes[9].checked;
	}