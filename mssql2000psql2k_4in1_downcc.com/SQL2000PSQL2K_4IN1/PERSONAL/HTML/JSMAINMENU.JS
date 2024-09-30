
// namespace object

var  lastSel=-1;


function ClickMenu()
{
    var     el;
    var     iPos;
    var     aux;
		
    // changing menu classes
    
    el		= window.event.srcElement;        
    aux		= GetIndex(el.id);
    if(lastSel == aux)
    {
//		alert("here");
		return 0;
    }
/*	
    if(lastSel!=-1)
    {
	    document.all('mnu_' + lastSel).className="GrayRow"; 
	    document.all('fnt_' + lastSel).className="LabelFontWhite"   		    		
    }
    else
    {
    	document.all('mnu_' + FIRST_MENU_SEL).className="GrayRow";
	    document.all('fnt_' + FIRST_MENU_SEL).className="LabelFontWhite"   		    		    	
    }

*/
    lastSel = aux;	
    
  //  document.all('mnu_' + lastSel).className="WhiteRow";    		    		
   // document.all('fnt_' + lastSel).className="LabelFont";    		    		

    // loading data for selected tab	
    
    return lastSel;

}

function GetIndex(elID)
{
	var i;
	var iPos = elID.indexOf( '_' );

	if( iPos != -1 )
    {
		var iPos = elID.substring( iPos + 1, elID.length );
	}
	
	i = parseInt(iPos, 10);
	return i;
}
