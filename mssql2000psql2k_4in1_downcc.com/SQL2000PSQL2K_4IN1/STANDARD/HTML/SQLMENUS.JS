	// -------------------------------------------------------------
	// Client-side global variables
	// -------------------------------------------------------------

	var sOpenMenuID = "";

	var iChunk = 0;
	var iChunkStep = 10;
	var iChunkDelay = 20;
	var lastid = -1;

	var sMenuPos = "right";   // values: "right", "below"
	var sMenuStyle = "diagonal";	// values: "down", "across", "diagonal"

/* ----------------------------------------------------------------
   main function, doMenu, that hides any open pop-up menus, determines 
   which menu DIV to access, and starts its display 
	---------------------------------------------------------------- */

    function MouseOver()
    {
        var el;
        
        el = window.event.srcElement
        
        el.className = "clsMenuSpanSel";
    }

    function MouseOut()
    {
        var el;
        
        el = window.event.srcElement
        
        el.className = "clsMenuSpanNonSel";
    }

	function DoMenu(counter) 
	{
		var			eSrc = window.event.srcElement;
		var         i, j;

		//window.event.cancelBubble = true;
						
		if(lastid==eSrc.id)
		{
			return;
		}
		else
		{		
			lastid = eSrc.id
		}			
		

		// ----------------------------------------------------------
		// If we have a menu open, close it
		// ----------------------------------------------------------
				
		//if ("object" == typeof(document.all[divMenu1]) || "object" == typeof(document.all[divMenu2])) 
		//{
		    if(eSrc.className != "clsMenuSpanSel"    && 
		       eSrc.className != "clsMenuSpanNonSel" &&
		       eSrc.id        != "td_Menu"           &&
		       eSrc.className != "DataFont"          &&
		       eSrc.className != "clsMenuTitle"          &&
		       eSrc.className != "ColorRow1" )    
		    {   
			   var      bStatus = true;
			   
			   if(window.event.toElement != null)
			   {
					if(window.event.toElement.tagName == "TABLE")
					{
						//alert(window.event.toElement.className)
					}
			   }
			   
		       for(i=1; i <= counter; i++)
		       {
				   var      szDiv;
				   
				   szDiv      = "divMenu" + i;
				   if(szDiv == eSrc.id)
				   {
					  bStatus = false;
				   }			 
				}
				
				if(bStatus)	
				{
				    for(j=1; j<=counter; j++)	
				    {
				        document.all('divMenu' + j).style.visibility = "hidden";
				    }   
				}   				   					
       	    }    
			// ----------------------------------------------------------
			// If the menu open is the one whose title we click then bail
			// ----------------------------------------------------------

			if (sOpenMenuID == eSrc.id.replace("imgMenuTitle","divMenu"))
			{
				sOpenMenuID = "";
				return false;
			}
			else 
			{
				sOpenMenuID = "";
			}
			
		//}

		// ----------------------------------------------------------
		// If a menu title (other than that of an open menu) was clicked
		// ----------------------------------------------------------

		if ("clsMenuTitle" == eSrc.className) 
		{

		// ----------------------------------------------------------
		// Cancel default link behavior
		// ----------------------------------------------------------

			window.event.returnValue = false;

		// ----------------------------------------------------------
		// Get Menu associated with the Menu Title and make sure it exists
		// If it does, show the Menu
		// ----------------------------------------------------------

			sOpenMenuID = eSrc.id.replace("imgMenuTitle","divMenu")
			if ("object" == typeof(document.all[sOpenMenuID])) 
			{
				var eMenu = document.all[sOpenMenuID];
				var max;
				var length;
				
				iChunk = iChunkStep;

				// ----------------------------------------------------------
				// Get the offset of the parent TR and TABLE for positioning the Menu
				// ----------------------------------------------------------

				var eTR;
				var eTABLE = eSrc.parentElement.parentElement.parentElement.parentElement;//imgMenuTitle2;
				eTR = eTABLE.children(0);

								

				// ----------------------------------------------------------
				// Set the right and top offsets based on sMenuPos
				// ----------------------------------------------------------

				if ("right" == sMenuPos) 
				{
					eMenu.style.left = eTABLE.offsetLeft + eSrc.width - 2;
					eMenu.style.top = eTABLE.offsetTop  + eTR.offsetTop;
				}
				else 
				{
					eMenu.style.left = eTABLE.offsetLeft + 26;
					eMenu.style.top = eTABLE.offsetTop + eTR.offsetTop + eSrc.height;
				}

				// ----------------------------------------------------------
				// Zero out the Menu size and start the ShowMenu process
				// ----------------------------------------------------------
								
				eMenu.style.clip = "rect(0 0 0 0)";
				eMenu.style.visibility = "visible";
				
		
                // compute the maximum length of the menu strings		
				return window.setTimeout("ShowMenu(" + eMenu.id + ")", iChunkDelay);
			}
		}
	}

	// ----------------------------------------------------------
	// Function which returns the appropriate menu diplay animation
	// ----------------------------------------------------------

	function GetShowStyle() {
		if ("down" == sMenuStyle) return "rect(0 100% " + iChunk + "% 0)";
		if ("across" == sMenuStyle) return "rect(0 " + iChunk + "% 100% 0)";
		if ("diagonal" == sMenuStyle) return "rect(0 " + iChunk + "% " + iChunk + "% 0)";
		else return "rect(0 100% " + iChunk + "% 0)";
	}

	// ----------------------------------------------------------
	// Function which incrementally displays Menu in appropriate style
	// ----------------------------------------------------------

	function ShowMenu(eMenu) {
		eMenu.style.clip = GetShowStyle();
		if (100 >= iChunk) {
			window.setTimeout("ShowMenu(" + eMenu.id + ")", iChunkDelay);
		}
		iChunk += iChunkStep;
	}
