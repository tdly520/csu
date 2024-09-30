function DoNothing()
{
	// Stub
}

//**********************************
// FIXED CONSTANTS (Not localizable)
//**********************************

// Taskpad Style Constants
var CON_LISTVIEW = 1;
var CON_NOLISTVIEW = 2;
var CON_STATUS = 3;

// Task Page Type Constants
var CON_MENUPAGE = 1;
var CON_HOMEPAGE = 2;
var CON_TASKPAGE = 3;
var CON_LINKPAGE = 4;
var CON_TODOPAGE = 5;
var CON_ABOUTPAGE = 6;
var CON_GUIDEPAGE = 7;		// Online Guide


// Taskpad Layout Style Constants
var CON_TASKPAD_STYLE_VERTICAL1 = 1;
var CON_TASKPAD_STYLE_VERTICAL2 = 2;
var CON_TASKPAD_STYLE_HORIZONTAL1 = 3;
var CON_TASKPAD_STYLE_NOLISTVIEW = 4;

// Containment Constants and variables
var CON_STANDALONE = 0;			// Page is running in stand-alone mode
var CON_FRAMESET_1 = 1;			// Page is running in a 1st-level frameset
var CON_TAB_DISABLED = 0;		// Menubar tab is disabled
var CON_TAB_ENABLED = 1;		// Menubar tab is enabled

var giTotalTabs = 3;				// zero-based array

//*******************************************
// LOCALIZABLE CONSTANTS FOR DYNAMIC RESIZING
//*******************************************

// Menu bar items:
var L_ConstMenuText_Number = .375;
var L_ConstNavSymbol_Number = .6;
var L_ConstMenuSpacer_Number = .1;

// Watermark & Branding
var ConstWatermarkHomeText = .75;
var ConstWatermarkVerticalText = .65;
var ConstWatermarkHorizontalText = .425;
var ConstWatermarkNoListviewText = .7;
var L_ConstBrandingText_Number = .115;

// Taskpad Standard Elements
var L_ConstTitleText_Number = .055;
var L_ConstAboutText_Number = .025;
var L_ConstDescriptionText_Number = .025;

// Taskpad Buttons
var L_ConstCaptionText_Number = .05;
var L_ConstAnchorLinkText_Number = .025;
var L_ConstSpanSymbolText_Number = .095;
var L_ConstSpanAnchorText_Number = .0255;

// Home Page Elements
var L_ConstAnchorUpdateTimeText_Number = .025;
var L_ConstStatusLabelLeftText_Number = .02;
var L_ConstStatusLabelCenterText_Number = .02;
var L_ConstStatusLabelRightText_Number = .02;
var L_ConstFailedServiceText_Number = .02;
var L_ConstFailedServiceSymbol_Number = .035;

// Summary Page (e.g. To Do List, About) Elements
var L_ConstSummaryTitleText_Number = .14
var L_ConstSummaryCaptionText_Number = .0575;
var L_ConstSummaryStaticInfoText_Number = .0225;
var L_ConstSummaryToDoPointerSize_Number = .035;
var L_ConstSummaryExitText_Number = .025;

// Feedback Elements
var L_ConstFeedbackCaptionText_Number = .0375;
var L_ConstFeedbackText_Number = .0225;

// Tooltip Elements

// TODO: The tooltip pointer uses Marlett to display a diamond-shaped pointer;
// confirm that this TrueType font will be available in all languages targeted for localization
var L_gszTooltipPointer_StaticText = 'u';

var L_ConstTooltipText_Number = .025;
var L_ConstTooltipOffsetTop_Number = .3;
var L_ConstTooltipOffsetBottom_Number = .3;

var L_ConstTooltipPointerText_Number = .05;
var L_ConstTooltipPointerOffsetBottom_Number = 1.8;
var L_ConstTooltipPointerOffsetTop_Number = 2.125;

var L_ConstLinkTooltipOffsetTop_Number = .0325;
var L_ConstLinkTooltipPointerOffsetTop_Number = 2.25;

//****************************************************
// window.setTimeout() or window.setInterval() Globals
// (expressed in milliseconds)
//****************************************************

// Set latency for showing tooltips
var giTooltipLatency = 750;

// Set interval for home page refresh
var giHomePageRefreshInterval = 3600000;  // (60 minutes * 60 seconds * 1000 ms)

// Set interval for e-mail info status polling
var giEmailPollingInterval = 900000;  // (15 minutes * 60 seconds * 1000 ms)

//***********************
// GLOBAL COLOR VARIABLES
//***********************

//var gszBaseColor = "3300CC";
//var gszBaseColorBody = "3399FF";

//var gszBaseColorLight = "99CCFF";
//var gszBaseColorBranding = "FFFFFF";

var gszBgColorMenu = 'buttonface';
var gszBgColorBand = 'highlight';

var gszColorTabDefault = 'buttontext';
var gszBgColorTabDefault = 'buttonface';

var gszColorTabSelected = 'highlighttext';
var gszBgColorTabSelected = 'highlight';

var gszColorTabDisabled = 'inactivecaptiontext';
var gszBgColorTabDisabled = 'inactivecaption';

var gszColorAnchorMenuDefault = 'buttontext';
var gszColorAnchorMenuSelected = 'highlighttext';
