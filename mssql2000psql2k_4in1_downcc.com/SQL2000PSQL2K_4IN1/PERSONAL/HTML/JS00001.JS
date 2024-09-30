function DoNothing()
{
	// Stub
}

//***************
//COLOR FUNCTIONS
//***************

function LoadMenuColors()
{
	// Stub
	// gszBgColorTabDisabled = 'CC9933';
}


function SynchColorsToSystem( iType )
{
	// TODO NOTE: Why are you doing this? Can't most of these be set directly
	// from CSS style sheets? Investigate!
	
	// Use CSS system constants for other colors
	divTitle.style.color = 'threeddarkshadow';
	divTitle.style.borderColor = 'threeddarkshadow';

	anchorAbout.style.color = 'threedshadow';
	divDescription.style.color = 'threeddarkshadow';
			
	tblTooltip.style.backgroundColor = 'infobackground';
	tblTooltip.style.color = 'infotext';
	divTooltipPointer.style.color = 'windowframe';
	
	// Show a one-pixel border around the divTooltip
	divTooltip.style.borderWidth = 1;
	
	// Special case the taskpad type
	switch( iType ) {
		case CON_LISTVIEW:
			divLVContainerTop.style.backgroundColor = 'window';
			break;
			
		case CON_NOLISTVIEW:
			// Stub
			break;

		case CON_STATUS:
			for( var i = 0; i <= giTotalFeedbackElements; i++ ) {
				document.all('divFeedbackCaptionContainer_' + i).style.borderColor = 'threeddarkshadow';
				document.all('divFeedbackCaptionLeft_' + i).style.color = 'threeddarkshadow';
				document.all('divFeedbackCaptionRight_' + i).style.color = 'threeddarkshadow';
				document.all('divFeedbackText_' + i).style.color = 'threeddarkshadow';
			}
			break;
	}
}

function SetBaseColors( iPageType )
{
	switch( iPageType ) {
		case CON_MENUPAGE:		
		case CON_LINKPAGE:		
			break;

		case CON_HOMEPAGE:
			tdWatermark.style.color = gszBaseColorLight;
			tdBranding.style.color = gszBaseColorBranding;
			break;
			
		case CON_TODOPAGE:
		case CON_ABOUTPAGE:
			tdTitle.style.color = gszBaseColorLight;
			tdWatermark.style.color = gszBaseColorLight;
			tdBranding.style.color = gszBaseColorBranding;
			break;			
	}
}

//*****************
//TOOLTIP FUNCTIONS
//*****************

function SynchTooltipColorsToSystem()
{
	tblTooltip.style.backgroundColor = 'infobackground';
	tblTooltip.style.color = 'infotext';
	divTooltipPointer.style.color = 'buttonshadow';
	
	// Show a one-pixel border around the divTooltip
	divTooltip.style.borderWidth = 1;
}

function LoadTooltipPointer()
{
	divTooltipPointer.innerText = L_gszTooltipPointer_StaticText;
}

//*******************************
//CONTAINMENT + MENUBAR FUNCTIONS
//*******************************

function DeterminePageContext( iMenuTab, iMenuTabState, iPageType )
{
	var iContainment = ResolveContainment();
	switch( iContainment )
	{
		case CON_FRAMESET_1:
			SynchronizeMenubar( iMenuTab, iMenuTabState );
			break;
			
		case CON_STANDALONE:
			// Ignore if page does not contain 'About' elements
			switch( iPageType )
			{
				case CON_HOMEPAGE:
				case CON_TODOPAGE:
				case CON_LINKPAGE:
					break;
					
				case CON_TASKPAGE:
				// Hide the About anchor, since it's not used when the page is shown
				// in stanalone mode
				divAbout.style.visibility = 'hidden';
				break;
			}
	}	
}

function ResolveContainment()
{
	// Determine if running in a frameset
	if( self != top ) {
		// Determine if parent is top
		if( self.parent == top ) {
			return CON_FRAMESET_1;
		}
		else {
			// Stub: page is more than 1 level away from Top
			// TODO: For SBS/BO 5.0 design, this level will be used...
		}
	}
	else {
		// Page is running in stand-alone mode
		return CON_STANDALONE;
	}
}

function SynchronizeMenubar( iMenuTab, iMenuTabState )
{
	// Brute-force resetting of all tabs to default state
	for( var i = 0; i <= giTotalTabs; i++ ) {
		window.parent.frames[0].document.all('mnu_' + i).parentElement.style.backgroundColor = gszBgColorTabDefault;
		window.parent.frames[0].document.all('mnu_' + i).parentElement.style.color = gszColorTabDefault;
		window.parent.frames[0].document.all('mnu_' + i).style.color = gszColorAnchorMenuDefault;
		window.parent.frames[0].document.all('mnu_' + i).className = 'anchorMenuDefault';
	}

	// Switch current tab to default or disabled state
	// depending on the passed iMenuTabState state
	switch( iMenuTabState )
	{
		case CON_TAB_ENABLED:
			window.parent.frames[0].document.all('mnu_' + iMenuTab).parentElement.style.backgroundColor = gszBgColorTabSelected;
			window.parent.frames[0].document.all('mnu_' + iMenuTab).parentElement.style.color = gszColorTabSelected;
			window.parent.frames[0].document.all('mnu_' + iMenuTab).style.color = gszColorAnchorMenuSelected;
			window.parent.frames[0].document.all('mnu_' + iMenuTab).className = 'anchorMenuSelected';	
			break;

		case CON_TAB_DISABLED:
			window.parent.frames[0].document.all('mnu_' + iMenuTab).parentElement.style.backgroundColor = gszBgColorTabDisabled;
			window.parent.frames[0].document.all('mnu_' + iMenuTab).style.color = gszColorTabDisabled;
			window.parent.frames[0].document.all('mnu_' + iMenuTab).className = 'anchorMenuSelected';
			break;						
	}
}

//*****************
//UTILITY FUNCTIONS
//*****************

function GetSmallerDimension()
{
	//Purpose: Returns the smaller of clientHeight or clientWidth
	var cw = document.body.clientWidth;
	var ch = document.body.clientHeight;
	
	//Get smaller of clientWidth or clientHeight
	if( cw <= ch ) {
		return cw;
	}
	else {
		return ch;
	}
}

function GetElementIndex(ElementID)
{
	// Purpose: Given an Element ID formatted as follows:
	//         "divCaption_12"
	// returns the numeric portion after the underscore character;
	// returns -1 if delimiter not found.
	
	var iDelimitLoc = ElementID.indexOf( '_' );

	if( iDelimitLoc == -1 ) {
		// Return -1 if delimiter not found (which shouldn't happen)
		return iDelimitLoc;
	}
	else {
		var theIndex = ElementID.substring( iDelimitLoc + 1, ElementID.length );
		// TODO: Confirm that theIndex is numeric and does not contain illegal characters
		return theIndex;
	}
}

function GetPixelSize(szTheSize)
{
	// Purpose: Given an Element.style.fontSize formatted as follows:
	//          "72px"
	// returns the parsed numeric portion, discarding the "px" string at the end;
	// Assumes that szTheSize is properly formatted, and that the Object Model identifier
	// for pixel size always appears at the end of the string.
	
	// TODO: Absolutely no error checking here (or in calling function)
	return parseInt(szTheSize);
}

function Quoted(szTheString)
{
	// Adds quotation marks ("") around the passed string;
	// (e.g. if szTheString = Hello, quoted returns "Hello")
	return '\"' + szTheString + '\"';
}
