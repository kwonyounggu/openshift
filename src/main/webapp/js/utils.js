function log(text) 
{
  if (window.console) 
  {
     window.console.log(text);
  }
}
function capitaliseFirstLetter(string)
{
	string=string.toLowerCase();
    return string.charAt(0).toUpperCase() + string.slice(1);
}
//Check if html5 available
function isCanvasSupported()
{
	  var elem = document.createElement('canvas');
	  return !!(elem.getContext && elem.getContext('2d'));
}