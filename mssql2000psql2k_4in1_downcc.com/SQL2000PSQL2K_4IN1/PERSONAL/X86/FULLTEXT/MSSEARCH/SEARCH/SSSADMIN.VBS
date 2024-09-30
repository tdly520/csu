'+----------------------------------------------------------------------------
'
'   Microsoft (R) Site Server Search
'   Copyright (C) Microsoft Corporation, 1996-1997.
'   File:   sssadmin.vbs
'
'   Contents:   
'
'+----------------------------------------------------------------------------

    Option Explicit

'----------------------------------------------------------------------------'
'                                   Defaults
'----------------------------------------------------------------------------'

    const ADD_PATH_DEFAULT_INCLUDE = TRUE
    const ADD_TIMING_DEFAULT       = 30
    const FILE_EXTENSION_EXPORT    = ".sbp"
    const FILE_EXTENSION_EXPORTCONFIG    = ".sbc"
    const DEFAULT_PROXY_PORT               = 80
    const DEFAULT_PROPLIMIT        = 10
    const SEARCH_TIMEOUT_THRESHOLD = 600
    const SEARCH_TIMEOUT_DEFAULT   = 60000
    const SEARCH_ROWLIMIT_DEFAULT  = 200
    const BUILDENV_TIMEOUT_DEFAULT       = 10
    const BUILDENV_DATA_TIMEOUT_DEFAULT  = 10

    const SEARCH_APPLICATION_NAME = "ExchangeServer"
'----------------------------------------------------------------------------'
'                                  Constants
'----------------------------------------------------------------------------'


'---------------------------------  Debug  ---------------------------------'

    ' DEBUGOUT = 2  - launches ScriptDebugger
    ' DEBUGOUT >= 1 - DBG statements enabled
    ' DEBUGOUT = 0  - DBG disabled    

    const DEBUGOUT = 1

'-------------------------------  Object Ids  -------------------------------'

    const OBJECT_SEARCH_ERROR   = "MSSearch.SearchHelp"
    const OBJECT_SEARCH_HELP    = "MSSearch.SearchHelp"
    const OBJECT_SEARCH_SYNTAX  = "MSSearch.SearchHelp"
    const OBJECT_SEARCH_ADMIN   = "MSSearch.Admin"
    const OBJECT_COMMAND_LINE   = "MSSearch.CmdLineParser"
    const OBJECT_DEBUG          = "MSSearch.SearchHelp"
    const OBJECT_CRS            = "CRSApi.ReplicationServer"
    const OBJECT_SEARCH_CRS     = "MSSearch.CRSGthr"

'--------------------------  Operations & Targets  --------------------------'

    ' operations

    const L_OpGet_Command                = "get"
    const L_OpAdd_Command                = "add"
    const L_OpSet_Command                = "set"
    const L_OpRemove_Command             = "remove"
    const L_OpBuild_Command              = "build"
    const L_OpSearch_Command             = "search"
    const L_OpImport_Command             = "import"
    const L_OpExport_Command             = "export"

    ' targets

    const L_ObjStatus_Text            = "status"
    const L_ObjCatalog_Text           = "catalog"
    const L_ObjSearchserver_Text      = "searchserver"
    const L_ObjStartpage_Text         = "startaddress"
    const L_ObjSite_Text              = "site"
    const L_ObjPath_Text              = "path"
    const L_ObjFiletype_Text          = "extension"
    const L_ObjMapping_Text           = "mapping"
    const L_ObjConfig_Text            = "config"
    const L_ObjTiming_Text            = "timing"
    const L_ObjBuildenv_Text          = "buildenv"
    const L_ObjSearchenv_Text         = "searchenv"
    const L_ObjProtocol_Text          = "protocol"
    const L_ObjLogs_Text              = "logs"
    const L_ObjProxy_Text             = "proxy"

'---------------------------------  Types  ---------------------------------'

    ' defininitons

    const vbAuthenType             = -10
    const vbProjectType            = -11
    const vbPerformanceType        = -12
    const vbDirectionType          = -13
    const vbBuildOpType            = -14
    const vbAddRemoveType          = -15
    const vbTimingType             = -16
    const vbProxyType              = -17
    const vbExtenRuleType	   = -18

    ' names

    const L_TypeString_Text               = "string"
    const L_TypeLong_Text                 = "number"
    const L_TypeBoolean_Text              = "TRUE|FALSE"
    const L_TypeAuthen_Text               = "Basic|NTLM|Anon"
    const L_TypeProject_Text              = "Crawl|Notify"
    const L_TypePerformance_Text          = "1 (background) --> 5 (dedicated)"
    const L_TypeDirection_Text            = "Up|Down"
    const L_TypeOperation_Text            = "start|startincremental|stop|pause|resume|prop|abortprop"
    const L_TypeAddremove_Text            = "Add|Remove"
    const L_TypeTiming_Text               = "seconds|minutes|documents|unlimited"
    const L_TypeProxy_Text                = "none|system|custom"
    const L_TypeExtension_Text            = "crawl|avoid"

    ' types

    const GATHER_TYPE_NOTIFY                    = 0
    const GATHER_TYPE_CRAWL                     = 1
    const L_TypeProjectNotify_Text               =  "notify"
    const L_TypeProjectCrawl_Text                =  "crawl"
    const L_TypeProjectUnknown_Text              =  "unknown"

    const GATHER_TYPE_AUTHENTICATION_ANONYMOUS  = 0
    const GATHER_TYPE_AUTHENTICATION_NTLM       = 1
    const GATHER_TYPE_AUTHENTICATION_BASIC      = 2
    const L_TypeAuthenAnonymous_Text             = "anonymous (default)"
    const L_TypeAuthenBasic_Text                 = "basic"
    const L_TypeAuthenNtlm_Text                  = "NTLM"
    const L_TypeAuthenNone_Text			 = "anon"
    const L_TypeAuthenUnknown_Text               = "unknown authentication type"

    const L_TypeDirectionUp_Text                 = "up"
    const L_TypeDirectionDown_Text               = "down"

    const L_TypeOpStart_Text                     = "start"
    const L_TypeOpStartincremental_Text          = "startincremental"
    const L_TypeOpStop_Text                      = "stop"
    const L_TypeOpPause_Text                     = "pause"
    const L_TypeOpResume_Text                    = "resume"
    const L_TypeOpProp_Text                      = "prop"
    const L_TypeOpAbortprop_Text                 = "abortprop"

    const L_TypeAdd_Text                          = "add"
    const L_TypeRemove_Text                       = "remove"

    const L_TypeSeconds_Text                      = "seconds"
    const L_TypeMinutes_Text                      = "minutes"
    const L_TypeDocuments_Text                    = "documents"
    const L_TypeUnlimited_Text                    = "unlimited"

    const L_TypeNone_Text                         = "none"
    const L_TypeSystem_Text                       = "system"
    const L_TypeCustom_Text                       = "custom"

    const L_TypeExtenCrawl_Text                   = "crawl"
    const L_TypeExtenAvoid_Text                   = "avoid"

    const PROXY_TYPE_NONE   = 1
    const PROXY_TYPE_SYSTEM = 0
    const PROXY_TYPE_CUSTOM = 2

    const CONST_PERFORMANCE_MAX     = 5
    const CONST_PERFORMANCE_MIN     = 1  

'----------------------------------  Help  ----------------------------------'

    ' operations

    const HELP_OP                   = 1001
    const HELP_OP_BUILD             = 1800
    const HELP_OP_SEARCH            = 2100

    const HELP_OP_IMPORT            = 1900
    const HELP_OP_IMPORT_CATALOG    = 1902
    const HELP_OP_IMPORT_CONFIG     = 1904
    const HELP_OP_EXPORT            = 2000
    const HELP_OP_EXPORT_CATALOG    = 2002
    const HELP_OP_EXPORT_CONFIG     = 2004

    ' get

    const HELP_OP_GET               = 1002
    const HELP_OP_GET_STATUS        = 1003
    const HELP_OP_GET_STARTPAGES    = 1005
    const HELP_OP_GET_SITES         = 1007
    const HELP_OP_GET_CONFIG        = 1009
    const HELP_OP_GET_MAPPINGS      = 1011
    const HELP_OP_GET_FILETYPEs     = 1013
    const HELP_OP_GET_PATHS         = 1015
    const HELP_OP_GET_TIMING        = 1017
    const HELP_OP_GET_SEARCHSERVERS = 1019
    const HELP_OP_GET_BUILDENV      = 1021
    const HELP_OP_GET_SEARCHENV     = 1023
    const HELP_OP_GET_PROTOCOLS     = 1025
    const HELP_OP_GET_LOGS          = 1027
    const HELP_OP_GET_PROXY         = 1029

    ' add

    const HELP_OP_ADD               = 1100
    const HELP_OP_ADD_CATALOG       = 1107
    const HELP_OP_ADD_MAPPING       = 1111
    const HELP_OP_ADD_FILETYPE      = 1113
    const HELP_OP_ADD_SEARCHSERVER  = 1115

    ' set

    const HELP_OP_SET               = 1200
    const HELP_OP_SET_STARTPAGE     = 1201
    const HELP_OP_SET_SITE          = 1203
    const HELP_OP_SET_PATH          = 1205
    const HELP_OP_SET_CONFIG        = 1207
    const HELP_OP_SET_TIMING        = 1209 
    const HELP_OP_SET_BUILDENV      = 1211
    const HELP_OP_SET_SEARCHENV     = 1213
    const HELP_OP_SET_PROTOCOL      = 1215
    const HELP_OP_SET_PROXY         = 1219

    ' remove

    const HELP_OP_REMOVE              = 1300
    const HELP_OP_REMOVE_STARTPAGE    = 1301
    const HELP_OP_REMOVE_SITE         = 1303
    const HELP_OP_REMOVE_PATH         = 1305
    const HELP_OP_REMOVE_CATALOG      = 1307
    const HELP_OP_REMOVE_TIMING       = 1309 
    const HELP_OP_REMOVE_MAPPING      = 1311
    const HELP_OP_REMOVE_FILETYPE     = 1313
    const HELP_OP_REMOVE_SEARCHSERVER = 1315


'---------------------------------  Syntax  ---------------------------------'

    ' operations

    const SYNTAX_OP_BUILD             = 1801
    const SYNTAX_OP_SEARCH            = 2101

    const SYNTAX_OP_IMPORT            = 1901
    const SYNTAX_OP_IMPORT_CATALOG    = 1903
    const SYNTAX_OP_IMPORT_CONFIG     = 1905
    const SYNTAX_OP_EXPORT            = 2001
    const SYNTAX_OP_EXPORT_CATALOG    = 2003
    const SYNTAX_OP_EXPORT_CONFIG     = 2005

    ' get

    const SYNTAX_OP_GET_STATUS        = 1004
    const SYNTAX_OP_GET_STARTPAGES    = 1006
    const SYNTAX_OP_GET_SITES         = 1008
    const SYNTAX_OP_GET_CONFIG        = 1010
    const SYNTAX_OP_GET_MAPPINGS      = 1012
    const SYNTAX_OP_GET_FILETYPEs     = 1014
    const SYNTAX_OP_GET_PATHS         = 1016
    const SYNTAX_OP_GET_TIMING        = 1018
    const SYNTAX_OP_GET_SEARCHSERVERS = 1020
    const SYNTAX_OP_GET_BUILDENV      = 1022
    const SYNTAX_OP_GET_SEARCHENV     = 1024
    const SYNTAX_OP_GET_PROTOCOLS     = 1026
    const SYNTAX_OP_GET_LOGS          = 1028
    const SYNTAX_OP_GET_PROXY         = 1030

    ' add

    const SYNTAX_OP_ADD_CATALOG       = 1108
    const SYNTAX_OP_ADD_MAPPING       = 1112
    const SYNTAX_OP_ADD_FILETYPE      = 1114
    const SYNTAX_OP_ADD_SEARCHSERVER  = 1116

    ' set

    const SYNTAX_OP_SET_STARTPAGE     = 1202
    const SYNTAX_OP_SET_SITE          = 1204
    const SYNTAX_OP_SET_PATH          = 1206
    const SYNTAX_OP_SET_CONFIG        = 1208
    const SYNTAX_OP_SET_TIMING        = 1210 
    const SYNTAX_OP_SET_BUILDENV      = 1212
    const SYNTAX_OP_SET_SEARCHENV     = 1214
    const SYNTAX_OP_SET_PROTOCOL      = 1216
    const SYNTAX_OP_SET_PROXY         = 1220

    ' remove

    const SYNTAX_OP_REMOVE_STARTPAGE    = 1302
    const SYNTAX_OP_REMOVE_SITE         = 1304
    const SYNTAX_OP_REMOVE_PATH         = 1306
    const SYNTAX_OP_REMOVE_CATALOG      = 1308
    const SYNTAX_OP_REMOVE_TIMING       = 1310
    const SYNTAX_OP_REMOVE_MAPPING      = 1312
    const SYNTAX_OP_REMOVE_FILETYPE     = 1314
    const SYNTAX_OP_REMOVE_SEARCHSERVER = 1316

    'status of build catalog
    const STATUS_BUILD_PAUSED           = 2

'---------------------------------  Error  ---------------------------------'
    
    const E_WSHINVALIDARG       = 9             ' runtime WSH invalid arg
    const E_EXCEPTION           = -2147352567   ' exception occured
    const E_INVALIDARG          = -2147024809   ' invalid argument
    const E_FILEEXISTS          = -2147024713   ' file already exists
    const E_OBJECTEXISTS        = -2147218174   ' object already exists
    const E_NOTEXIST            = 424           ' object doesn't exist
    const E_OBJNOTEXIST         = -2147218170   ' cannot find specified object
    const E_STARTPAGES          = -2147218133   ' no crawlseeds
    const E_FILENOTFOUND        = -2147024894   ' file not found
    const E_INVALIDPATH         = -2147024893   ' invalid path
    const E_INVALIDCONFIG       = -2147417851   ' invalid configuration file
    const E_ACCESSDENIED        = 70            ' tried to export/import a directory
    const E_CANNOTCONNECT       = 429           ' can't create object (aka. unknown server)
    const E_RPCSERVERUNAVAIL    = -2147023174   ' RPC server is unavailable (aka. unknwon server) 
    const E_WRITEREGISTRY       = -2147218172   ' error writing registry 
    const E_SEARCHSERVERNOTFOUND = -2147217143  ' search server was not found
    const E_CLASSNOTREG         = -2147221164   ' class not registered
    const E_CREATEOBJECT        = 429           ' can't create object (same as E_CANNOTCONNECT)
    const E_SEARCHNOTEXIST      = -2147220479   ' requested catalog name is not valid (search server)
    const E_CATALOGENABLED      = -2147220454   ' catalog already enabled
    const E_CATALOGDISABLED     = -2147220447   ' catalog already disabled
    const E_SEARCHCATALOGNAMEINVALID  = -2147220457   ' catalog name invalid
    const E_CATALOGNAMEINVALID  = -2147218142   ' catalog name invalid

'----------------------------------------------------------------------------'
'                               Global Variables
'----------------------------------------------------------------------------'

    '
    ' private - used only within utility functions - it is public since we
    '           need to preserver the value outside of the function
    '
    public objCmdLine
    public objDebug

    '
    ' public - used by all functions
    '

    public objHost
    public objBuildServer
    public objSearchServer
   
'----------------------------------------------------------------------------'
'                           Command Line Parameters
'----------------------------------------------------------------------------'

    ' global

    const L_Catalog_ArgumentName           = "catalog"
    const L_CatalogShort_ArgumentName     = "c"     'short form of: catalog
    const L_Host_ArgumentName              = "host"
    const L_HostShort_ArgumentName        = "h"     'short form of: host
    const L_Site_ArgumentName              = "site"
    const L_SiteShort_ArgumentName        = "s"     'short form of: site
    const L_Application_ArgumentName       = "application"
    const L_ApplicationShort_ArgumentName   = "x"

    ' shared

    const L_User_ArgumentName              = "user" 
    const L_UserShort_ArgumentName        = "u"     'short form of: user
    const L_Password_ArgumentName          = "password" 
    const L_PasswordShort_ArgumentName    = "p"    'short form of: password 
    const L_Performance_ArgumentName       = "performance"
    const L_PerformanceShort_ArgumentName = "f"     'short form of: performance
    const L_Location_ArgumentName          = "location"
    const L_LocationShort_ArgumentName    = "l"     'short form of: location
    const L_Include_ArgumentName           = "include" 
    const L_IncludeShort_ArgumentName     = "i"     'short form of:include
    const L_Timeout_ArgumentName           = "timeout"
    const L_TimeoutShort_ArgumentName     = "o"     'short form of: timeout

    ' catalog

    const L_Build_ArgumentName             = "build"
    const L_BuildShort_ArgumentName       = "b"     'short form of: build
    const L_Search_ArgumentName            = "search"
    const L_SearchShort_ArgumentName      = "e"     'short form of: search
        
    ' startpage

    const L_Url_ArgumentName               = "address"
    const L_UrlShort_ArgumentName         = "a"     'short form of: address
    const L_Sitehops_ArgumentName          = "sitehops"
    const L_SitehopsShort_ArgumentName    = "s"     'short form of: sitehops
    const L_Pagehops_ArgumentName          = "pagehops"
    const L_PagehopsShort_ArgumentName    = "p"     'short form of: pagehops
    const L_Directories_ArgumentName       = "directory"
    const L_DirectoriesShort_ArgumentName = "d"     'short form of: directory
    const L_Siterule_ArgumentName          = "siterule"
    const L_SiteruleShort_ArgumentName    = "t"     'short form of: siterule

    ' config

    const L_Crawlinterval_ArgumentName      = "crawlinterval"
    const L_ForceMerge_ArgumentName         = "forcemerge"
    const L_Projecttype_ArgumentName        = "projecttype"
    const L_ProjecttypeShort_ArgumentName   = "p"        'short form of: projecttype
    const L_Notification_ArgumentName       = "notification"
    const L_NotificationShort_ArgumentName  = "n"        'short form of: notification
    const L_Success_ArgumentName            = "success"
    const L_SuccessShort_ArgumentName       = "s"       'short form of: success
    const L_Disallow_ArgumentName           = "disallow"
    const L_DisallowShort_ArgumentName      = "d"        'short form of: disallow
    const L_Complex_ArgumentName            = "complex"
    const L_ComplexShort_ArgumentName       = "o"       'short form of: complex
    const L_Limit_ArgumentName       = "autoprop"
    const L_LimitShort_ArgumentName  = "a"       'short form of: autoprop
    const L_Logs_ArgumentName               = "logs"
    const L_LogsShort_ArgumentName          = "l"        'short form of: logs
    const L_ExtensionRule_ArgumentName        = "extensionrule"
    const L_ExtensionRuleShort_ArgumentName   = "e"
    
    ' path

    const L_Path_ArgumentName              = "path"
    const L_PathShort_ArgumentName        = "p"     'short form of: path
    const L_Allow_ArgumentName             = "allow"
    const L_AllowShort_ArgumentName       = "a"     'short form of: allow
    const L_Subdir_ArgumentName            = "subdir"
    const L_SubdirShort_ArgumentName      = "d"     'short form of: subdir

    ' import and export

    const L_Filename_ArgumentName          = "filename"
    const L_FilenameShort_ArgumentName    = "f"     'short form of: filename

    ' timing

    const L_TimingType_ArgumentName       = "type"
    const L_TimingTypeShort_ArgumentName = "t"      'short form of: type
    const L_TimingHits_ArgumentName       = "hits"
    const L_TimingHitsShort_ArgumentName = "i"      'short form of: hits

    ' mapping

    const L_To_ArgumentName                = "to"
    const L_ToShort_ArgumentName          = "t"     'short form of: to
    const L_From_ArgumentName              = "from"
    const L_FromShort_ArgumentName        = "f"     'short form of: from

    ' filetype

    const L_Filetype_ArgumentName          = "extension"
    const L_FiletypeShort_ArgumentName    = "e"         'short form of: extension

    ' search server

    const L_Searchserver_ArgumentName      = "searchserver"
    const L_SearchserverShort_ArgumentName = "s"        'short form of: searchserver

    ' site

    const L_Authentype_ArgumentName        = "authen"   ' means: authenticationtype
    const L_AuthentypeShort_ArgumentName  = "a"     'short form of: authen(authentication type)

    ' buildenv

    const L_Contact_ArgumentName           = "contact"
    const L_ContactShort_ArgumentName     = "c"     'short form of: contact
    const L_Useragent_ArgumentName         = "useragent"
    const L_UseragentShort_ArgumentName   = "a"     'short form of: useragent
    const L_Temppath_ArgumentName          = "temppath"
    const L_TemppathShort_ArgumentName    = "t"     'short form of: temppath
    const L_Datatimeout_ArgumentName       = "datatimeout"
    const L_DatatimeoutShort_ArgumentName = "d"     'short form of: datatimeout
    const L_Pluginuser_ArgumentName        = "propuser"
    const L_PluginuserShort_ArgumentName  = "r"        'short form of: propuser
    const L_PropPassword_ArgumentName        = "proppassword"
    const L_PropPasswordShort_ArgumentName  = "w"        'short form of: proppassword

    ' searchenv

    const L_Default_ArgumentName           = "default"
    const L_DefaultShort_ArgumentName     = "d"     'short form of: default

    ' protocols

    const L_Protocol_ArgumentName          = "protocol"
    const L_ProtocolShort_ArgumentName    = "p"     'short form of: protocol

    ' build

    const L_Operation_ArgumentName       = "operation"
    const L_OperationShort_ArgumentName = "o"       'short form of: operation

    ' proxy

    const L_Proxy_ArgumentName                 = "proxy"
    const L_ProxyShort_ArgumentName           = "p"     'short form of: proxy
    const L_Server_ArgumentName                = "server"
    const L_ServerShort_ArgumentName          = "e"     'short form of: server
    const L_Port_ArgumentName                  = "port"
    const L_PortShort_ArgumentName            = "o"     'short form of: port
    const L_Bypass_ArgumentName                = "bypass"
    const L_BypassShort_ArgumentName          = "b"     'short form of: bypass
    const L_Except_ArgumentName                = "except"
    const L_ExceptShort_ArgumentName          = "x"     'short form of: except

    ' search

    const L_Enabled_ArgumentName               = "enabled"
    const L_EnabledShort_ArgumentName         = "e"     'short form of: enabled
    const L_Searchtimeout_ArgumentName         = "timeout"
    const L_SearchtimeoutShort_ArgumentName   = "t"     'short form of: timeout
    const L_RowLimit_ArgumentName		= "rowlimit"
    const L_RowLimitShort_ArgumentName		= "r"

'----------------------------------------------------------------------------'
'                                   Strings
'----------------------------------------------------------------------------'

'-------------------------  Headers and Display  ----------------------------'

    const L_MainHeader_Message       = "Search Administration"
    const L_MainCopyright_Message    = "(c) 1997 Microsoft Corporation"
    const L_BuildHeader_Message      = "Catalog build server"
    const L_SearchHeader_Message     = "Search server"
    const L_Divider_Message           = "--------------------"
    const L_None_Message              = "<none>"
    const L_Unlimited_Message         = "<unlimited>"
    const L_InitialBuild_Message     = "-"
    const L_Comma_Message             = ", "
    const L_LabelIndent_Message      =   "           "
    const L_LabelPtr_Message         =   " --> "

'--------------------------------  Labels  ----------------------------------'

    ' global

    const L_LabelCatalog_Message       =   "Catalog: "

    ' status

    const L_LabelBuildStatus_Message  =   "   Build status:    "
    const L_LabelBuildDate_Message    =   "   Build date:      "
    const L_LabelBuildStart_Message   =   "   Build started:   "
    const L_LabelBuildDatePrevious_Message = "   Previous build:  "      
    const L_LabelSearchStatus_Message =   "   Search status:   "   
    const L_LabelSearchTimeout_Message  = "   Search timeout:  "
    const L_LabelSearchRowLimit_Message = "   Query row limit: "
    const L_LabelBuiltBy_Message      =   "   Built by:        "        
    const L_LabelSize_Message          =   "   Size:            "
    const L_LabelSizeCurrent_Message  =   "   Documents found: "
    const L_LabelSizePrevious_Message =   "   Previous size:   "     
    const L_LabelCreated_Message       =   "   Created:         "
    const L_LabelIndexSize_Message    =   "   Index size:      "
    const L_LabelIndexSizeCurrent_Message = "   Current index size: "   
    const L_LabelIndexSizePrevious_Message = "   Previous index size: "
    const L_LabelCurrentRead_Message  =   "   Currently reading:  "

    ' startpages

    const L_LabelStartpages_Message    =   "   Start addresses:  "
    const L_LabelStartpage_Message     =   "Start address: "
    const L_LabelSiteRules_Message    =   "   Only site rules:  "
    const L_LabelPageHops_Message     =   "   Page hops:        "
    const L_LabelSiteHops_Message     =   "   Site hops:        "
    const L_LabelSiteList_Message     =   "   Directories:      "

    ' searchservers

    const L_LabelSearchservers_Message =   "   Search servers:  "

    ' sites

    const L_LabelSites_Message         =   "   Sites:            "
    const L_LabelSite_Message          =   "Site: "
    const L_LabelInclude_Message       =   "   Included:         "
    const L_LabelCrawlExtensions_Message       =   "   Crawl Extensions: "
    const L_LabelAccountName_Message  =   "   Account:          "
    const L_LabelAuthentication_Message =  "   Authentication:   "

    ' config

    const L_LabelLogStatus_Message    =   "   Log status:       "
    const L_LabelLogSuccess_Message   =   "   Log success:      "
    const L_LabelLogDisallowed_Message =  "   Log excluded:     "
    const L_LabelFollowComplex_Message =  "   Follow complex:   " 
    const L_LabelMaxLogs_Message      =   "   Maximum logs:     "
    const L_LabelCrawlInterval_Message  = "   Crawl interval:   "
    const L_LabelProjectType_Message  =   "   Project type:    "
    const L_LabelProtocols_Message     =   "   Protocols:       "
    const L_LabelNotificationProject_Message = "   Notification:    "
    const L_LabelProplenabled_Message  =   "   Autoprop enabled: "
    const L_LabelProplimitA_Message   =   " (every "
    const L_LabelProplimitB_Message   =   " documents)"

    ' mappings

    const L_LabelMappings_Message      =   "   Mappings:        "

    ' extensions

    const L_LabelFiletypes_Message     =   "   Extensions:       "

    ' logs

    const L_LabelLog_Message           =   "Log: "
    const L_LabelLogs_Message          =   "   Logs: "
    const L_LabelLogsHeader_Message   =   "Date                 Name					Size"
    const L_LabelLogNum_Message       =   "Number of logs: "

    ' timing

    const L_LabelTiming_Message        =   "   Hit frequency:    "

    ' path

    const L_LabelPath_Message          =   "Path: "
    const L_LabelPathFollow_Message   =   "   Allow:            "
    const L_LabelPathSubdirs_Message  =   "   Sub-directories:  "

    ' env

    const L_LabelSearchserver_Message  =   "Host: "
    const L_LabelBuildserver_Message   =   "Host: "
    const L_LabelCatalogCount_Message =   "   No. of catalogs:  "
    const L_LabelContact_Message       =   "   E-mail address:   "
    const L_LabelUseragent_Message     =   "   User agent:       "
    const L_LabelTempPath_Message     =   "   Temp. files:      "
    const L_LabelPerformance_Message   =   "   Performance:      "
    const L_LabelCatalogLocation_Message ="   Catalog location: "
    const L_LabelConnectTimeout_Message = "   Connect timeout:  "
    const L_LabelDataTimeout_Message  =   "   Data timeout:     "
    const L_LabelGatherAccount_Message =  "   Crawling account: "
    const L_LabelPluginAccount_Message =  "   Admin. account:   "
    const L_LabelDefaultCatalog_Message = "   Default catalog:  "

    ' protocol

    const L_LabelProtocol_Message          =   "Protocol: "
    const L_LabelProtocolInclude_Message  =   "   Include:   "
    const L_LabelProtocolHandler_Message  =   "   Handler:   "

    ' proxy

    const L_LabelProxyServer_Message      = "   Server:        "
    const L_LabelPort_Message              = "   Port:          "
    const L_LabelBypass_Message            = "   Bypass local:  "
    const L_LabelExceptions_Message        = "   Exceptions:    "

    ' metrics (post-labels)

    const L_MetricDocs_Message          =   " documents"
    const L_MetricTimingBet_Message    =   " seconds between requests"
    const L_MetricTimingSimul_Message  =   " documents simultaneously"
    const L_MetricTimingUnlim_Message  =   "Unlimited"
    const L_MetricTimingSingle_Message =   "1 document per request"
    const L_MetricBytes_Message         =   " bytes"
    const L_MetricSeconds_Message       =   " seconds"
    const L_MetricMilliseconds_Message  =   " milliseconds"
    const L_MetricPerformance_Message   =   " (dedicated server is 5)"

'---------------------------------  Status  ---------------------------------'

    ' global

    const L_StatusConnecting_Message           = "Connecting..."
    const L_StatusAddingSearchserver_Message = "Adding search server..."

    ' build

    const L_StatusBuilding_Message   = "Starting build..."
    const L_StatusBuildingIncremental_Message   = "Starting incremental build..."
    const L_StatusStopping_Message   = "Stopping build..."
    const L_StatusPausing_Message    = "Pausing build..."
    const L_StatusResuming_Message   = "Resuming build..."
    const L_StatusPropping_Message   = "Forcing propagation of catalog..."
    const L_StatusAbortingProp_Message = "Aborting propagation of catalog..."
    const L_StatusStatus_Message     = "Retrieving  status..."

    ' search

    const L_SuccessSearchA_Message          = "Successfully set configuration for catalog, %1, on host, %2" 

    ' log

    const L_LogStatusSuccess_Message   =  "Successful and failed accesses"
    const L_LogStatusFailed_Message    =  "Failed accesses only"
    const L_LogSuccessTrue_Message     =  "TRUE  - logs URLs that were crawled successfully"
    const L_LogSuccessFalse_Message    =  "FALSE - will not log URLs that were crawled successfully"
    const L_LogDisallowedTrue_Message  =  "TRUE  - logs URLs disallowed by site rules and Robots.txt"
    const L_LogDisallowedFalse_Message =  "FALSE - will not log URLs disallowed by site rules and Robots.txt"
    const L_FollowComplexTrue_Message  =  "TRUE  - follows URLs containing question marks"
    const L_FollowComplexFalse_Message =  "FALSE - will not follow URLs containing question marks"

    ' config

    const L_NotificationProjectNone_Message = "<none>"

    ' import/export

    const L_SuccessImport_Message      = "Successfully imported definition from file, %1, to catalog, %2" 
    const L_SuccessExport_Message      = "Successfully exported definition for catalog, %1, to file, %2" 
    const L_SuccessImportConfig_Message      = "Successfully imported definition from file, %1, to build server on host, %2" 
    const L_SuccessExportConfig_Message      = "Successfully exported definition for build server on host, %1, to file, %2" 

    ' startpage

    const L_SuccessRemoveStartpage_Message    = "Successfully removed start addresses, %1, from catalog, %2" 
    const L_SuccessSetStartpage_Message       = "Successfully set properties for start addresses, %1, in catalog, %2" 
    const L_SiteRulesTrue_Message               = "True - crawl sites in site rules only"
    const L_SiteRulesFalse_Message              = "False"

    ' catalog

    const L_SuccessAddBuildCatalogA_Message         = "Successfully added build catalog, %1, to host, %2" 
    const L_SuccessAddSearchCatalogA_Message         = "Successfully added search catalog, %1, to host, %2" 
    const L_SuccessRemoveBuildcatalogA_Message = "Successfully removed catalog definition, %1, from host, %2" 
    const L_SuccessRemoveSearchcatalogA_Message = "Successfully removed catalog, %1, from host, %2" 
    const L_SuccessSetCatalogA_Message         = "Successfully set properties for catalog, %1, on host, %2" 

    ' site
     
    const L_SuccessRemoveSiteA_Message         = "Successfully removed site rule, %1, from catalog, %2" 
    const L_SuccessSetSiteA_Message            = "Successfully set properties for site rule, %1, in catalog, %2" 

    ' path

    const L_SuccessRemovePathA_Message         = "Successfully removed path rule, %1, from site, %2" 
    const L_SuccessSetPathA_Message            = "Successfully set properties for path rule, %1, on site, %2" 

    ' timing

    const L_SuccessRemoveTimingA_Message       = "Successfully reverted to default site hit frequency for site, %1, on host, %2" 
    const L_SuccessSetTimingA_Message          = "Successfully set site hit frequency for site, %1, on host, %2" 

    ' mapping

    const L_SuccessAddMappingA_Message         = "Successfully added URL mapping, %1, to catalog definition, %2" 
    const L_SuccessRemoveMappingA_Message      = "Successfully removed mapping with the crawler access location %1, from catalog definition, %2" 

    ' filetype

    const L_SuccessAddFiletypeA_Message        = "Successfully added file type, %1, to catalog definition, %2" 
    const L_SuccessRemoveFiletypeA_Message     = "Successfully removed file type, %1, from catalog definition, %2" 

    ' searchserver

    const L_SuccessAddSearchserverA_Message    = "Successfully added Search server, %1, to catalog definition, %2" 
    const L_SuccessRemoveSearchserverA_Message = "Successfully removed Search server, %1, from catalog definition, %2" 

    ' protocol

    const L_SuccessSetProtocolA_Message        = "Successfully set properties for protocol, %1, in catalog definition, %2" 

    ' config

    const L_SuccessSetConfigA_Message          = "Successfully set configuration for catalog, %1, on host, %2" 

    ' environment

    const L_SuccessSetBuildenv_Message          = "Successfully set build environment for host: %1"
    const L_SuccessSetSearchenv_Message         = "Successfully set search environment for host: %1"

    ' proxy

    const L_StatusProxyNone_Message             = "A proxy server is not currently being used."
    const L_StatusProxySystem_Message           = "The system proxy server settings are being used."
    const L_StatusProxyCustom_Message           = "Custom proxy server settings are being used."
    const L_ProxyBypassTrue_Message             = "TRUE - bypass proxy server for local addresses"
    const L_ProxyBypassFalse_Message            = "FALSE - use proxy server for all addresses"
    const L_SuccessSetProxy_Message             = "Successfully configured proxy server for host: "
    
'---------------------------------  Error  ---------------------------------'

    ' global

    const L_Operation_ErrorMessage           = "The following command is unknown: "
    const L_InvalidObject_ErrorMessage     = "Invalid object: "
    const L_InvalidParam_ErrorMessage       = "The value for the specified parameter is not the correct type:"
    const L_LabelType_ErrorMessage          = "Type: "
    const L_LabelArgument_ErrorMessage      = "Parameter: "
    const L_LabelValue_ErrorMessage         = "Specified value: "
    const L_InvalidPathA_ErrorMessage      = "The specified path, "
    const L_InvalidPathB_ErrorMessage      = ", is invalid for parameter, "
    const L_RequiredArg_ErrorMessage        = "The following argument is missing: "
    const L_UnexpectedOrExternal_ErrorMessage = "%1 (Error: %2)"
    const L_CommandLine_ErrorMessage        = "An error has occurred parsing the command line."
    const L_InvalidCatalogName_ErrorMessage    = "Error: The specified catalog name is invalid: "

    ' connection

    const L_ConnectLocalhost_ErrorMessage    = "Unable to connect to the local host."
    const L_ConnectHost_ErrorMessage         = "Unable to connect to the host: "
    const L_NotInstalled_ErrorMessage        = "Error: Site Server Search is not installed on host:"
    const L_ConnectSearchserver_ErrorMessage = "Error: Unable to connect to the Search server: "
    const L_UnknownSearchserver_ErrorMessage = "Error: The following Search server does not exist: "

    ' build

    const L_BuildOperation_ErrorMessage         = "The following build operation is unknown: "
    const L_BuildFailed_ErrorMessage            = "Build failed."
    const L_BuildIncrementalFailed_ErrorMessage = "Incremental build failed."
    const L_PauseFailed_ErrorMessage            = "Unable to pause build."
    const L_ResumeFailed_ErrorMessage           = "Unable to resume build."
    const L_StopFailed_ErrorMessage             = "Unable to stop build."
    const L_PropFailed_ErrorMessage             = "Unable to propagate catalog."
    const L_AbortPropFailed_ErrorMessage       = "Unable to abort propagation of catalog."
    const L_BuildNotPausedA_ErrorMessage      = "This catalog build, %1, is not paused. You can only resume a paused build."
    const L_BuildNotCrawlingA_ErrorMessage    = "This catalog, %1 is not being built. You can only stop a build in progress."

    ' search

    const L_NullTimeoutAWarning_Message        = "Warning: A null or negative search timeout was specified. Will revert to the default (%1 milliseconds) timeout."
    const L_TimeoutAWarning_Message             = "Warning: You have specified a very short timeout (%1 milliseconds). Some queries might never be returned."
    const L_SearchtimeoutHelp_Message            = "Verify that this catalog has been propagated at least once before setting the catalog properties."
    const L_NullRowLimitWarning_Message		= "Warning: A null, zero, or negative value for query row limit was specified. Will revert to the default value (%1)"
    const L_CatalogEnabledAWarning_Message     = "The catalog, %1, is already enabled."
    const L_CatalogDisabledAWarning_Message    = "The catalog, %1, is already disabled."

    ' catalog

    const L_NoCatalogs_ErrorMessage             = "There are no catalogs on this host: "
    const L_ExistCatalogA_ErrorMessage          = "The catalog, %1, already exists on host, %2"
    const L_ExistBuildCatalogA_ErrorMessage     = "The build catalog, %1, already exists on host, %2"
    const L_ExistSearchCatalogA_ErrorMessage    = "The search catalog, %1, already exists on host, %2"
    const L_NotExistCatalogA_ErrorMessage       = "The build catalog rule, %1, does not exist on host, %2"
    const L_NotExistBuildcatalogA_ErrorMessage  = "The catalog definition, %1, does not exist on host, %2"
    const L_NotExistSearchcatalogA_ErrorMessage = "The search catalog, %1, does not exist on host, %2"
    const L_NotRemovedWarning_Message           = "Warning: No catalogs were removed. Type 'SSSADMIN.VBS REMOVE CATALOG /?' for help." ' Portion in quotes should match actual syntax of command
    const L_NoPropTargetWarning_Message	        = "Warning: There is no default propagation target for build catalogs created using the command line. Propagation will not succeed unless at least one propagation server is specified using ADD SEARCHSERVER."

    ' timing

    const L_NoTiming_ErrorMessage               = "The host, %1, does not contain any site hit frequency rules"
    const L_NotExistTimingA_ErrorMessage      = "Site hit frequency rules for site, %1, are not defined on host %2"
    const L_InvalidHits_ErrorMessage            = "A positive value must be specified for hits."

    ' path

    const L_NoPathsA_ErrorMessage              = "There are no path rules for site, %1, for catalog definition, %2"
    const L_NotExistPathA_ErrorMessage        = "The path rule, %1, is not defined on site, %2"
    const L_NotFoundPathA_ErrorMessage        = "The path rule, %1, was not found. Please verify that the path rule is valid."

    ' site

    const L_NoSites_ErrorMessage                = "There are no site rules in catalog definition, %1"
    const L_NotExistSiteA_ErrorMessage        = "The site, %1, is not defined in catalog definition, %2"
    const L_NoUser_ErrorMessage        = "No user account specified for authentication type %1. Authentication type will revert to %2."
    const L_ExtraUser_ErrorMessage        = "Account specified for anonymous authentication type. Account will not be used."

    ' startpage

    const L_NoStartpagesA_ErrorMessage         = "Error: This catalog definition, %1, does not contain a start address."
    const L_NotExistStartpageA_ErrorMessage   = "The start address, %1, is not defined in catalog definition, %2"
    const L_NotFoundStartpageA_ErrorMessage   = "The start address, %1, was not found. Please verify that the start address is valid."
    const L_SiteRuleWarning_Message             = "The crawl sites in the Site Rules list option was selected. The settings for page hops and site hops will be ignored. "

    ' mapping

    const L_ExistMappingA_ErrorMessage         = "Either the crawler access location or the display location of the URL mapping, %1 to %2, is already defined in catalog definition, %3"
    const L_NotExistMappingA_ErrorMessage     = "The URL mapping from, %1, is not defined in catalog definition, %2"

    ' filetype

    const L_ExistFiletypeA_ErrorMessage        = "The file type, %1, is already defined in catalog definition, %2"
    const L_NotExistFiletypeA_ErrorMessage    = "The file type, %1, is not defined in catalog definition, %2"

    ' searchserver

    const L_ExistSearchserverA_ErrorMessage    = "The Search server, %1, is already defined in catalog definition, %2"
    const L_NotExistSearchserverA_ErrorMessage = "The Search server, %1, is not defined in catalog definition, %2"
    
    ' import/export

    const L_InvalidFilename_ErrorMessage        = "Cannot open file: %1. "
    const L_InvalidConfiguration_ErrorMessage   = "Error: Invalid configuration file specified: "

    ' buildenv

    const L_NullConnectTimeoutAWarning_Message     = "Warning: A null or negative timeout was specified. Will revert to the default (%1 second) timeout."
    const L_NullDataTimeoutAWarning_Message        = "Warning: A null or negative data timeout was specified. Will revert to the default (%1 second) timeout."

    ' protocol

    const L_NotExistProtocolA_ErrorMessage    = "The protocol, %1, does not exist in catalog definition, %2"

    ' config

    const L_InvalidProplimitA_ErrorMessage     = "An invalid propagation limit (%1) was specified. This value must be 0 or greater than %2"
    const L_NolimitSpecifiedAWarning_Message   = "Warning. You have not specified a propagation limit."
    const L_NolimitSpecifiedBWarning_Message   = "The following default value will be used: "

    ' proxy

    const L_ProxyUnknown_ErrorMessage           = "Unknown configuration for proxy server."

'----------------------------------  Misc  ----------------------------------'

    const L_AddStartpageHelp_Message = "For help on adding start addresses, type 'SSSADMIN.VBS SET STARTADDRESS /?'"                       ' portion in quotes should match actual syntax of command
    const L_NotifyProjectHelp_Message = "To set a notification source for a catalog, type 'SSSADMIN.VBS SET CONFIG /?'"                 ' portion in quotes should match actual syntax of command
    const L_GetPathHelp_Message = "To list the paths on this site, type 'SSSADMIN.VBS GET PATH /SITE:sitename /CATALOG:catalogname'"    ' portion in quotes should match actual syntax of command
    const L_GetStartpageHelp_Message = "To view the list of start addresses for this catalog, type 'SSSADMIN.VBS GET STARTADDRESS'"     ' portion in quotes should match actual syntax of command 

'----------------------------------------------------------------------------'
'                              Utility Functions
'----------------------------------------------------------------------------'

'+----------------------------------------------------------------------------
'
'   Function:   DBG
'
'   Synopsis:   macro for debugout
'
'   Arguments:  string to output to debug out 
'
'   Note:       the DEBUGOUT constant controls whether strings are sent to
'               debug out
'
'
'
'+----------------------------------------------------------------------------

function DBG( szDebug )

    if (DEBUGOUT >= 1) then

        objDebug.DebugOut "SSEARCH.VBS: " + szDebug

    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   utilCreateObjects
'
'   Synopsis:   Creates the primary object - connects to host, creates the
'               catalog builder and search server objects
'
'   Returns:    TRUE    - succesfullly created objects
'               FALSE   - failed
'
'   Arguments:  none
'
'
'
'+----------------------------------------------------------------------------

function utilCreateObjects()

    On Error Resume Next

    Dim szHost
    Dim szApplication

    DBG("utilCreateObjects")

    wscript.Echo L_StatusConnecting_Message

    ' initialize

    utilCreateObjects = FALSE

    '  create host object

    Set objHost = CreateObject( OBJECT_SEARCH_ADMIN )
    if (Err.Number <> 0) then exit function

    ' parse the host out of the command line
    
    szHost = utilGetArg( L_Host_ArgumentName, -1, vbString )
    if IsEmpty(szHost) then exit function

    ' parse the application name out of the command line
    
    szApplication = utilGetArg( L_Application_ArgumentName, -1, vbString )
    if IsEmpty(szApplication) then exit function

    ' connect to host (or localhost if not specified)

    if IsNull(szHost) then 
        objHost.HostName = ""
    else
        objHost.HostName = szHost
    end if

    ' check for errors 

    if (Err.Number <> 0) then
        if IsNull(szHost) then
            wscript.Echo
            wscript.Echo L_ConnectLocalhost_ErrorMessage
            szHost = "<localhost>"
        else
            wscript.Echo
            wscript.Echo L_ConnectHost_ErrorMessage + szHost
        end if
        select case Err.Number
            case E_RPCSERVERUNAVAIL    
                wscript.Echo L_UnknownSearchserver_ErrorMessage + szHost
            case E_CLASSNOTREG
                wscript.Echo L_NotInstalled_ErrorMessage + szHost 
            case else
                call dispError
        end select
        exit function
    end if

    ' use the default application name, if the user did not specify
    if (IsNull(szApplication)) then
        szApplication = SEARCH_APPLICATION_NAME
    end if

    Dim objApplication
    Set objApplication = objHost.Applications.Item(szApplication)  
    if (Err.Number <> 0) then 
        call dispError
        exit function
    end if

    ' get the catalog builder

    Set objBuildServer = objApplication.BuildServer
    if (Err.Number <> 0) then 
        call dispError
        exit function
    end if

    ' get the search server

    Set objSearchServer = objApplication.SearchServer
    if (Err.Number <> 0) then
        call dispError
        exit function
    end if
    
   utilCreateObjects = TRUE

   wscript.Echo

end function

'+----------------------------------------------------------------------------
'
'   Function:   utilParseCommandLine
'
'   Synopsis:   Parses the command line.
'
'   Returns:    TRUE    - successfully parsed the command line
'               FALSE   - failed parsing command line
'
'   Arguments:  none
'
'
'
'   Note:
'
'       We have to initialy parse out the operation and target since the
' cmdline object can only have single character abbreviations that are used
' once. Therefore, we need to add only those areguments that are relevant for
' this target.
'
'+----------------------------------------------------------------------------

function utilParseCommandLine( ByRef szOperation, ByRef szTarget )

    Dim objArguments

    On Error Resume Next

    DBG("utilParseCommandLine")

    ' initialize

    utilParseCommandLine = FALSE

    ' create command line object

    set objCmdLine = CreateObject( OBJECT_COMMAND_LINE )
    if (Err.Number <> 0) then exit function

    ' get the operation and target from command line

    set objArguments = wscript.Arguments
    szOperation = objArguments.Item(0)
    if (Err.Number <> 0) then
        if ((Err.Number = E_WSHINVALIDARG) Or (Err.Number = E_EXCEPTION)) then 
            szOperation = ""
        else 
            exit function
        end if
        Err.Number = 0
    end if


    szTarget = objArguments.Item(1)
    if (Err.Number <> 0) then
        if ((Err.Number = E_WSHINVALIDARG) Or (Err.Number = E_EXCEPTION)) then 
            szTarget = ""
        else 
            exit function
        end if
        Err.Number = 0
    end if

    call objCmdLine.Init( szOperation, szTarget )
    if (Err.Number <> 0) then exit function

    Dim arg
    for each arg in objArguments
        call objCmdLine.AddArgument(arg)
        if (Err.Number <> 0) then exit function
    next

    ' add global arguments for parsing

    call objCmdLine.AddShortcut( L_Catalog_ArgumentName, L_CatalogShort_ArgumentName )
    call objCmdLine.AddShortcut( L_Host_ArgumentName, L_HostShort_ArgumentName )
    call objCmdLine.AddShortcut( L_Application_ArgumentName, L_ApplicationShort_ArgumentName )
    call objCmdLine.AddShortcut( L_Site_ArgumentName, L_SiteShort_ArgumentName )
        

    ' add arguments depending on operation

    select case LCase(szOperation)

        case L_OpBuild_Command

            call objCmdLine.AddShortcut( L_Operation_ArgumentName, L_OperationShort_ArgumentName )

        case L_OpImport_Command

            call objCmdLine.AddShortcut( L_Filename_ArgumentName, L_FilenameShort_ArgumentName )

        case L_OpExport_Command

            call objCmdLine.AddShortcut( L_Filename_ArgumentName, L_FilenameShort_ArgumentName )

        case L_OpRemove_Command

            call objCmdLine.AddShortcut( L_Build_ArgumentName, L_BuildShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Search_ArgumentName, L_SearchShort_ArgumentName )

        case L_OpAdd_Command

            call objCmdLine.AddShortcut( L_Build_ArgumentName, L_BuildShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Search_ArgumentName, L_SearchShort_ArgumentName )

       case L_OpSearch_Command
            
            call objCmdLine.AddShortcut( L_Enabled_ArgumentName, L_EnabledShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Searchtimeout_ArgumentName, L_SearchtimeoutShort_ArgumentName )
            call objCmdLine.AddShortcut( L_RowLimit_ArgumentName, L_RowLimitShort_ArgumentName )
	
        case else

    end select

    if (Err.Number <> 0) then exit function

    ' add arguments depending on target

    select case LCase(szTarget)

        case L_ObjSite_Text

            call objCmdLine.AddShortcut( L_Include_ArgumentName, L_IncludeShort_ArgumentName )
            call objCmdLine.AddShortcut( L_User_ArgumentName, L_UserShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Password_ArgumentName, L_PasswordShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Authentype_ArgumentName, L_AuthentypeShort_ArgumentName )
            
        case L_ObjStartpage_Text

            call objCmdLine.AddShortcut( L_Url_ArgumentName, L_UrlShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Pagehops_ArgumentName, L_PagehopsShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Sitehops_ArgumentName, L_SitehopsShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Directories_ArgumentName, L_DirectoriesShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Siterule_ArgumentName, L_SiteruleShort_ArgumentName )

        case L_ObjTiming_Text
        
            call objCmdLine.AddShortcut( L_TimingType_ArgumentName, L_TimingTypeShort_ArgumentName )
            call objCmdLine.AddShortcut( L_TimingHits_ArgumentName, L_TimingHitsShort_ArgumentName )
        
        case L_ObjPath_Text

            call objCmdLine.AddShortcut( L_Path_ArgumentName, L_PathShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Allow_ArgumentName, L_AllowShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Subdir_ArgumentName, L_SubdirShort_ArgumentName )

        case L_ObjMapping_Text

            call objCmdLine.AddShortcut( L_To_ArgumentName, L_ToShort_ArgumentName )
            call objCmdLine.AddShortcut( L_From_ArgumentName, L_FromShort_ArgumentName )

        case L_ObjFiletype_Text

            call objCmdLine.AddShortcut( L_Filetype_ArgumentName, L_FiletypeShort_ArgumentName )

        case L_ObjSearchserver_Text

            call objCmdLine.AddShortcut( L_Searchserver_ArgumentName, L_SearchserverShort_ArgumentName )

        case L_ObjConfig_Text

            call objCmdLine.AddShortcut( L_Projecttype_ArgumentName, L_ProjecttypeShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Notification_ArgumentName, L_NotificationShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Success_ArgumentName    , L_SuccessShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Disallow_ArgumentName   , L_DisallowShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Complex_ArgumentName    , L_ComplexShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Limit_ArgumentName    , L_LimitShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Logs_ArgumentName    , L_LogsShort_ArgumentName )
            call objCmdLine.AddShortcut( L_ExtensionRule_ArgumentName, L_ExtensionRuleShort_ArgumentName )

        case L_ObjBuildenv_Text

            call objCmdLine.AddShortcut( L_Contact_ArgumentName, L_ContactShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Useragent_ArgumentName, L_UseragentShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Temppath_ArgumentName, L_TemppathShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Performance_ArgumentName, L_PerformanceShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Location_ArgumentName, L_LocationShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Timeout_ArgumentName, L_TimeoutShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Datatimeout_ArgumentName, L_DatatimeoutShort_ArgumentName )
            call objCmdLine.AddShortcut( L_User_ArgumentName, L_UserShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Password_ArgumentName, L_PasswordShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Pluginuser_ArgumentName, L_PluginuserShort_ArgumentName )
            call objCmdLine.AddShortcut( L_PropPassword_ArgumentName, L_PropPasswordShort_ArgumentName )

        case L_ObjSearchenv_Text

            call objCmdLine.AddShortcut( L_Performance_ArgumentName, L_PerformanceShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Location_ArgumentName, L_LocationShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Default_ArgumentName, L_DefaultShort_ArgumentName )

        case L_ObjProtocol_Text

            call objCmdLine.AddShortcut( L_Protocol_ArgumentName, L_ProtocolShort_ArgumentName )        
            call objCmdLine.AddShortcut( L_Include_ArgumentName, L_IncludeShort_ArgumentName )

        case L_ObjProxy_Text

            call objCmdLine.AddShortcut( L_Proxy_ArgumentName, L_ProxyShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Server_ArgumentName, L_ServerShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Port_ArgumentName, L_PortShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Bypass_ArgumentName, L_BypassShort_ArgumentName )
            call objCmdLine.AddShortcut( L_Except_ArgumentName, L_ExceptShort_ArgumentName )

        case else
    
    end select

    if (Err.Number <> 0) then exit function

    utilParseCommandLine = TRUE

end function


'+----------------------------------------------------------------------------
'
'   Function:   utilGetBuildCatalog
'
'   Synopsis:   Fetches the build catalog object
'
'   Returns:    build catalog object
'
'   Arguments:  name of catalog to get
'
'
'
'+----------------------------------------------------------------------------

function utilGetBuildCatalog ( szCatalog )

    On Error Resume Next

    Dim objBuildCatalogs, objBuildCatalog

    DBG("utilGetBuildCatalog")

    ' get the collection of build catalogs

    Set objBuildCatalogs = objBuildServer.BuildCatalogs
    if (Err.Number <> 0) then
        dispError()
        set utilGetBuildCatalog = Empty
        exit function
    end if

    ' get the catalog

    set objBuildCatalog = objBuildCatalogs.Item( szCatalog )
    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then
            Dim msgstr
            msgstr = L_NotExistCatalogA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szCatalog )
            msgstr = replace(msgstr, "%2",  objHost.HostName)
            wscript.Echo  msgstr
            wscript.Echo
        else
            dispError()
        end if
        set utilGetBuildCatalog = Empty
        exit function
    end if

    set utilGetBuildCatalog = objBuildCatalog

end function

'+----------------------------------------------------------------------------
'
'   Function:   utilGetSearchCatalog
'
'   Synopsis:   Fetches the Search catalog object
'
'   Returns:    Search catalog object
'
'   Arguments:  name of catalog to get
'
'
'
'+----------------------------------------------------------------------------

function utilGetSearchCatalog ( szCatalog )

    On Error Resume Next

    Dim objSearchCatalogs, objSearchCatalog

    DBG("utilGetSearchCatalog")

    ' get the collection of Search catalogs

    Set objSearchCatalogs = objSearchServer.SearchCatalogs
    if (Err.Number <> 0) then
        dispError()
        set utilGetSearchCatalog = Empty
        exit function
    end if

    ' get the catalog

    set objSearchCatalog = objSearchCatalogs.Item( szCatalog )
    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then
            Dim msgstr
            msgstr = L_NotExistSearchcatalogA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szCatalog )
            msgstr = replace(msgstr, "%2",  objHost.HostName)
            wscript.Echo  msgstr
            wscript.Echo
        else
            dispError()
        end if
        set utilGetSearchCatalog = Empty
        exit function
    end if

    set utilGetSearchCatalog = objSearchCatalog

end function

'+----------------------------------------------------------------------------
'
'   Function:   utilGetArg
'
'   Synopsis:   Gets the specified argument off of the command line
'
'   Returns:    Null    - if not found
'               Empty   - if unexpected error
'               Arg     - if found 
'
'   Arguments:
'               szArgName   name of argument to fetch
'               idSyntax    id of syntax help for this command
'               nVarType    type of parameter
'
'   Note:
'           This function will display the appropriate error message
'   if argument is of the wrong type and will return Empty
'
'
'
'+----------------------------------------------------------------------------

function utilGetArg( szArgName, idSyntax, nVarType )

    On Error Resume Next
    
    Dim szArg

    DBG( "utilGetArg" )

    ' initialize return value to failuer

    utilGetArg = Empty

    ' get the argument

    szArg = objCmdLine.GetValue( szArgName )
    if (Err.Number <> 0) then
        call dispError
        exit function
    end if

    ' if not found, return as Null

    if (IsEmpty(szArg)) then
        utilGetArg = Null
        exit function
    end if

    ' convert the argument depending on type

    select case nVarType
        case vbLong
            utilGetArg = CLng(szArg)
        case vbString
            utilGetArg = szArg
        case vbExtenRuleType
            select case LCase(szArg)
                case LCase( L_TypeExtenAvoid_Text )
                    utilGetArg = CBool("True")
                case LCase( L_TypeExtenCrawl_Text )
                    utilGetArg = CBool("False")
                case else
                    Err.Number = -1
            end select
        case vbBoolean
            utilGetArg = CBool(szArg)
        case vbAuthenType
            select case LCase(szArg)
                case LCase( L_TypeAuthenNtlm_Text )
                    utilGetArg = GATHER_TYPE_AUTHENTICATION_NTLM
                case LCase( L_TypeAuthenBasic_Text )
                    utilGetArg = GATHER_TYPE_AUTHENTICATION_BASIC
		case LCase( L_TypeAuthenNone_Text )
		    utilGetArg = GATHER_TYPE_AUTHENTICATION_ANONYMOUS
                case else
                    Err.Number = -1
            end select
        case vbProjectType
            select case LCase(szArg)
                case LCase( L_TypeProjectCrawl_Text )
                    utilGetArg = GATHER_TYPE_CRAWL
                case LCase( L_TypeProjectNotify_Text )
                    utilGetArg = GATHER_TYPE_NOTIFY
                case else
                    Err.Number = -1
            end select
        case vbPerformanceType
            Dim nTemp
            nTemp = CLng(szArg)
            if ((nTemp < CONST_PERFORMANCE_MIN) Or (nTemp > CONST_PERFORMANCE_MAX)) then 
                Err.Number = -1
            else 
                utilGetArg = nTemp
            end if
        case vbDirectionType
            ' note: assuming return type is bUp: TRUE = Up  FALSE = Down
            select case LCase(szArg)
                case LCase( L_TypeDirectionUp_Text)
                    utilGetArg = True
                case LCase( L_TypeDirectionDown_Text )
                    utilGetArg = False
                case else
                    Err.Number = -1
            end select
        case vbBuildOpType
            select case LCase(szArg)
                case LCase( L_TypeOpStart_Text )
                    utilGetArg = L_TypeOpStart_Text
                case LCase( L_TypeOpStartincremental_Text )
                    utilGetArg = L_TypeOpStartincremental_Text 
                case LCase( L_TypeOpStop_Text )
                    utilGetArg = L_TypeOpStop_Text
                case LCase( L_TypeOpPause_Text )
                    utilGetArg = L_TypeOpPause_Text
                case LCase( L_TypeOpResume_Text )
                    utilGetArg = L_TypeOpResume_Text
                case LCase( L_TypeOpProp_Text )
                    utilGetArg = L_TypeOpProp_Text
                case LCase( L_TypeOpAbortprop_Text )
                    utilGetArg = L_TypeOpAbortprop_Text 
                case else
                    Err.Number = -1
            end select
        case vbAddRemoveType
            ' note: assuming return type is bUp: TRUE = Up  FALSE = Down
            select case LCase(szArg)
                case LCase( L_TypeAdd_Text )
                    utilGetArg = True
                case LCase( L_TypeRemove_Text )
                    utilGetArg = False
                case else
                    Err.Number = -1
            end select
        case vbTimingType
            select case LCase(szArg)
                case LCase( L_TypeSeconds_Text )
                    utilGetArg = L_TypeSeconds_Text
                case LCase( L_TypeMinutes_Text )
                    utilGetArg = L_TypeMinutes_Text
                case LCase( L_TypeDocuments_Text )
                    utilGetArg = L_TypeDocuments_Text
                case LCase( L_TypeUnlimited_Text )
                    utilGetArg = L_TypeUnlimited_Text
                case else
                    Err.Number = -1
            end select
        case vbProxyType
            select case LCase(szArg)
                case LCase( L_TypeNone_Text )
                    utilGetArg = L_TypeNone_Text
                case LCase( L_TypeSystem_Text )
                    utilGetArg = L_TypeSystem_Text
                case LCase( L_TypeCustom_Text )
                    utilGetArg = L_TypeCustom_Text
                case else
                    Err.Number = -1
            end select
        case else
            wscript.Echo L_UnknownType_Message + CStr(nVarType)
            exit function
    end select

    ' check for errors during conversion

    if (Err.Number <> 0) then
        call dispInvalidParam( szArgName, szArg, nVarType )
        wscript.Echo
        call dispSyntax( idSyntax )
        utilGetArg = Empty
        exit function
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   utilGetRequiredArg
'
'   Synopsis:   Gets the specified required argument off of the command line
'               Note: really a simple wrapper around utilGetArg - see utilGetArg
'               for detailed description
'
'   Returns:    Empty - if argument not found or any errors occured
'               Note: simplifies number of conditions - if argument not found
'               or there was an error converting the argument is irrelevant
'               to the caller of this function - they would exit in either case
'
'
'
'+----------------------------------------------------------------------------

function utilGetRequiredArg( szArgName, idSyntax, nVarType )

    On Error Resume Next

    Dim szArg

    DBG( "utilGetRequiredArg" )

    ' get the argument

    utilGetRequiredArg = utilGetArg( szArgName, idSyntax, nVarType )

    ' check if error

    if IsEmpty(utilGetRequiredArg) then exit function

    ' check if parameter not found

    if IsNull(utilGetRequiredArg) then
        wscript.Echo L_RequiredArg_ErrorMessage + szArgName
        wscript.Echo
        call dispSyntax( idSyntax )
        utilGetRequiredArg = Empty
        exit function
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   utilIsHelp
'
'   Synopsis:   Checks if help is requested. If requested, display help and
'               syntax
'
'   Returns:    BOOL - indicates whether help was requested
'
'   Arguments:  idHelp      - help id (for call to external dll)
'               idSyntax    - syntax id (for call to external dll)
'
'
'
'+----------------------------------------------------------------------------

function utilIsHelp( idHelp, idSyntax )

    DBG( "utilIsHelp" )

    if (objCmdLine.IsHelp) then
        call dispHelp( idHelp )
        if (idSyntax <> -1) then call dispSyntax( idSyntax)
        utilIsHelp = TRUE
    else
        utilIsHelp = FALSE
    end if

end function


'+----------------------------------------------------------------------------
'
'   Function:   utilInvalidArgs
'
'   Synopsis:   Checks if the args are all valid for this command. If not, display help and
'               syntax
'
'   Returns:    BOOL - indicates whether the args passed
'
'   Arguments:  idHelp      - help id (for call to external dll)
'               idSyntax    - syntax id (for call to external dll)
'
'
'
'+----------------------------------------------------------------------------

function utilInvalidArgs( idHelp, idSyntax )

    DBG( "utilInvalidArgs" )

    if (Not objCmdLine.VerifyArguments) then
        call dispHelp( idHelp )
        if (idSyntax <> -1) then call dispSyntax( idSyntax)
        utilInvalidArgs = TRUE
    else
        utilInvalidArgs = FALSE
    end if

end function

'----------------------------------------------------------------------------'
'                               Display Functions
'----------------------------------------------------------------------------'

'+----------------------------------------------------------------------------
'
'   Function:   dispHelp
'
'   Synopsis:   Displays help associated with specified id
'
'   Arguments:  Help id.
'
'
'
'+----------------------------------------------------------------------------

function dispHelp( idHelp )

    Dim objHelp
    Dim szHelp

    ' create the help object

    set objHelp = CreateObject( OBJECT_SEARCH_HELP )
    if (Err.Number <> 0) then
        call dispError
    end if
    
    ' get the help text

    szHelp = objHelp.GetHelp( idHelp )

    ' display the help text

    wscript.Echo szHelp

end function


'+----------------------------------------------------------------------------
'
'   Function:   dispSyntax
'
'   Synopsis:   Displays the syntax for an operation on an object
'
'   Arguments:  [szOp]  - [in] operation
'               [szObj] - [in] target of operation
'
'
'
'+----------------------------------------------------------------------------

Sub dispSyntax( idSyntax )

    DBG("dispSyntax")

    On Error Resume Next

    Dim objSyntax
    Dim szSyntax

    ' create the help object

    set objSyntax = CreateObject( OBJECT_SEARCH_SYNTAX )
    if (Err.Number <> 0) then
        call dispError
    end if
    
    ' get the syntax text

    szSyntax = objSyntax.GetHelp( idSyntax)

    ' display the syntax text

    wscript.Echo szSyntax

End Sub

'+----------------------------------------------------------------------------
'
'   Function:   dispError
'
'   Synopsis:   Display error information
'
'
'
'+----------------------------------------------------------------------------

function dispError() 
 
    Dim objHelp

    DBG( "dispError" )

    ' create error object

    set objHelp = CreateObject( OBJECT_SEARCH_ERROR )

    ' display the error
        
    Dim msgstr
    msgstr = L_UnexpectedOrExternal_ErrorMessage
    msgstr = replace(msgstr, "%1",  Err.Description )
    msgstr = replace(msgstr, "%2",  CStr(Err.Number) )
    wscript.Echo  msgstr

end function    

'+----------------------------------------------------------------------------
'
'   Function:   dispCmdLineError
'
'   Synopsis:   Display command line erro
'
'
'
'+----------------------------------------------------------------------------

function dispCmdLineError() 
 
    Dim objHelp

    DBG( "dispError" )

    ' create error object

    set objHelp = CreateObject( OBJECT_SEARCH_ERROR )

    ' display the error
        
    wscript.Echo L_CommandLine_ErrorMessage
    wscript.Echo "Error: " + objHelp.GetErrorMessage( Err.Number )

end function    

'+----------------------------------------------------------------------------
'
'   Function:   dispInvalidParam
'
'   Synopsis:   Display invalid paramter.
'
'
'
'+----------------------------------------------------------------------------

function dispInvalidParam( szArg, szValue, nType ) 
 
    Dim objHelp
    Dim szType

    DBG( "dispInvalidParam" )

    ' get the display type

    select case nType
        case vbString
            szType = L_TypeString_Text
        case vbLong
            szType = L_TypeLong_Text
        case vbExtenRuleType
             szType = L_TypeExtension_Text
        case vbBoolean
            szType = L_TypeBoolean_Text
        case vbAuthenType
            szType = L_TypeAuthen_Text
        case vbProjectType
            szType = L_TypeProject_Text
        case vbPerformanceType
            szType = L_TypePerformance_Text
        case vbDirectionType
            szType = L_TypeDirection_Text
        case vbBuildOpType
            szType = L_TypeOperation_Text
        case vbAddRemoveType
            szType = L_TypeAddremove_Text
        case vbTimingType
            szType = L_TypeTiming_Text
        case vbProxyType
            szType = L_TypeProxy_Text
        case else
            szType = L_TypeUnknown_Text
    end select

    ' display the invalid param error

    wscript.Echo    L_InvalidParam_ErrorMessage
    wscript.Echo    L_LabelType_ErrorMessage     + vbTab + vbTab + vbTab + szType
    wscript.Echo    L_LabelArgument_ErrorMessage + vbTab + vbTab + szArg
    wscript.Echo    L_LabelValue_ErrorMessage    + vbTab + szValue

end function    

'+----------------------------------------------------------------------------
'
'   Function:   dispCatalogName
'
'   Synopsis:   Displays the catalog name for specifed catalog.
'
'
'
'+----------------------------------------------------------------------------

function dispCatalogName( objCatalog )

    On Error Resume Next

    DBG( "dispCatalogName" )

    wscript.Echo  L_LabelCatalog_Message + objCatalog.Name

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogStatus
'
'   Synopsis:   Displays basic status information for specified catalog:
'               a. number of documents (in catalog)
'               b. date of last build
'               c. search servers for this catalog
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogStatus( objBuildCatalog )

    On Error Resume Next

    DBG( "dispBuildCatalogStatus" )

    Dim objPreviousProperties, objCurrentProperties
    Dim l_objSearchServers, l_objSearchServer
    Dim szSearchServerList
    Dim cSearchServers

    ' display catalog status info

    wscript.Echo  L_LabelBuildStatus_Message + objBuildCatalog.Status

    if (objBuildCatalog.IsBuilding) then

        ' display current build properties

        set objCurrentProperties = objBuildCatalog.CurrentBuildProperties
        wscript.Echo    L_LabelSizeCurrent_Message + CStr(objCurrentProperties.NumberOfDocuments) + L_MetricDocs_Message
'        wscript.Echo    L_LabelBuildStart_Message  + CStr(objCurrentProperties.BuildDate)
        wscript.Echo    L_LabelIndexSizeCurrent_Message + CStr(objCurrentProperies.IndexSize) + L_MetricBytes_Message

        ' display previous build properites

        set objPreviousProperties = objBuildCatalog.PreviousBuildProperties
        if (objPreviousProperties.BuildDate <> 0) then            
            wscript.Echo    L_LabelSizePrevious_Message       + CStr(objPreviousProperties.NumberOfDocuments) + L_MetricDocs_Message
            wscript.Echo    L_LabelBuildDatePrevious_Message + CStr(objPreviousProperties.BuildDate)
'            wscript.Echo    L_LabelIndexSizePrevious_Message + CStr(objPreviousProperies.IndexSize) + L_MetricBytes_Message
        else
            wscript.Echo    L_LabelSizePrevious_Message       + L_InitialBuild_Message
            wscript.Echo    L_LabelBuildDatePrevious_Message + L_InitialBuild_Message
'            wscript.Echo    L_LabelIndexSizePrevious_Message + L_InitialBuild_Message            
        end if

    else

        ' display build properties

        set objCurrentProperties = objBuildCatalog.CurrentBuildProperties
        if (objCurrentProperties.BuildDate <> 0) then            
            wscript.Echo    L_LabelSize_Message       + CStr(objCurrentProperties.NumberOfDocuments) + L_MetricDocs_Message
            wscript.Echo    L_LabelBuildDate_Message + CStr(objCurrentProperties.BuildDate)
'            wscript.Echo    L_LabelIndexSize_Message + CStr(objCurrentProperies.IndexSize) + L_MetricBytes_Message
        else
            wscript.Echo    L_LabelSize_Message        + L_InitialBuild_Message
            wscript.Echo    L_LabelBuildDate_Message  + L_InitialBuild_Message
'            wscript.Echo    L_LabelIndexSize_Message  + L_InitialBuild_Message            
        end if

    end if

    ' iterate through search servers for this catalog

    set l_objSearchServers = objBuildCatalog.SearchServers
    if (l_objSearchServers.Count = 0) then

        ' no search servers

        wscript.Echo L_LabelSearchservers_Message + L_None_Message
    else

        wscript.Echo L_LabelSearchservers_Message + CStr(l_objSearchServers.Count)

        ' enumerate the searchservers

        For Each l_objSearchServer In  l_objSearchServers
            wscript.Echo L_LabelIndent_Message + l_objSearchServer.Name
        Next

    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogStatusExtended
'
'   Synopsis:   Display additional detailed status information:
'               a. log status
'               b. URLs currently being read
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogStatusExtended( objBuildCatalog )

    On Error Resume Next

    DBG( "dispBuildCatalogStatusExtended" )

    Dim szLogStatus
    Dim rgCurrentRead
    Dim szPage

    if (objBuildCatalog.LogSuccess) then
        szLogStatus = L_LogStatusSuccess_Message
    else
        szLogStatus = L_LogStatusFailed_Message
    end if

    wscript.Echo L_LabelLogStatus_Message + szLogStatus

    ' iterate through the pages that are currently being read

    rgCurrentRead = objBuildCatalog.CurrentPages
    if (UBound(rgCurrentRead) > 0) then
        wscript.Echo L_LabelCurrentRead_Message + CStr(UBound(rgCurrentRead))
        for each szPage in rgCurrentRead
            wscript.Echo L_LabelIndent_Message + szPage
        next
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispSearchCatalogStatus
'
'   Synopsis:   Display status for the search searver catalog:
'               a. built by (host)
'               b. search status (enabled\disabled)
'
'
'
'+----------------------------------------------------------------------------

function dispSearchCatalogStatus( objSearchCatalog )

    On Error Resume Next

    DBG( "dispSearchCatalogStatus" )

    ' display the status 

    wscript.Echo L_LabelSearchStatus_Message + objSearchCatalog.Status

    ' display catalog source

    if (objSearchCatalog.BuildServerName = "") then
        wscript.Echo L_LabelBuiltBy_Message     + L_InitialBuild_Message
    else
        wscript.Echo L_LabelBuiltBy_Message     + objSearchCatalog.BuildServerName
    end if

   ' display the timeout

    wscript.Echo L_LabelSearchTimeout_Message + CStr(objSearchCatalog.QueryTimeout) + L_MetricMilliseconds_Message

    wscript.Echo L_LabelSearchRowLimit_Message + CStr(objSearchCatalog.MaxResultRows)

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogSearchServers
'
'   Synopsis:   Displays search servers for specified catalog.
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogSearchServers( objBuildCatalog )

    Dim lobjSearchServers, lobjSearchServer
    
    ' get the search server collection

    set lobjSearchServers = objBuildCatalog.SearchServers
    wscript.Echo L_LabelSearchservers_Message + CStr(lobjSearchServers.Count)

    ' enumerate the search servers

    for each lobjSearchServer in lobjSearchServers
        wscript.Echo L_LabelIndent_Message + lobjSearchServer.Name
    next

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogStartPages
'
'   Synopsis:   Displays start pages (urls) for specified catalog.
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogStartPages( objBuildCatalog )

    Dim objStartPages, objStartPage
    
    ' get the start page collection

    set objStartPages = objBuildCatalog.StartPages
    wscript.Echo L_LabelStartpages_Message + CStr(objStartPages.Count)

    ' enumerate the start pages

    for each objStartPage in objStartPages
        wscript.Echo L_LabelIndent_Message + objStartPage.URL
    next

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogSites
'
'   Synopsis:   Display site restriction information for specified catalog.
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogSites( objBuildCatalog )

    Dim objSites, objSite
    
    ' get the start page collection

    set objSites = objBuildCatalog.Sites
    wscript.Echo L_LabelSites_Message + CStr(objSites.Count)

    ' enumerate the start pages

    for each objSite in objSites
        wscript.Echo L_LabelIndent_Message + objSite.Name
    next

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogConfig
'
'   Synopsis:   Display configuration for specified catalog
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogConfig( objBuildCatalog )

    On Error Resume Next

    Dim lProjectType
    Dim lCrawlInterval
    Dim szLogSuccess
    Dim szLogDisallow
    Dim szFollowComplex
    Dim szNotificationProject
    Dim objLogs

    ' get the crawl interval
 
    lCrawlInterval = objBuildCatalog.CrawlInterval
    wscript.Echo L_LabelCrawlInterval_Message + CStr(lCrawlInterval)

    ' get the project type

    lProjectType = objBuildCatalog.ProjectType
    select case lProjectType
        case GATHER_TYPE_NOTIFY
            wscript.Echo L_LabelProjectType_Message + L_TypeProjectNotify_Text
        case GATHER_TYPE_CRAWL
            wscript.Echo L_LabelProjectType_Message + L_TypeProjectCrawl_Text
        case else
            wscript.Echo L_LabelProjectType_Message + L_TypeProjectUnknown_Text
    end select 

    ' get notifcation project name

    szNotificationProject = objBuildCatalog.NotificationSource
    if (szNotificationProject = "") then

        szNotificationProject = L_NotificationProjectNone_Message

    end if
    wscript.Echo L_LabelNotificationProject_Message + szNotificationProject

    ' display the crawl interval

    wscript.Echo L_LabelCrawlInterval_Message + CStr( lCrawlInterval )

    ' display log success value 

    if (objBuildCatalog.LogSuccess) then
        szLogSuccess = L_LogSuccessTrue_Message
    else
        szLogSuccess = L_LogSuccessFalse_Message
    end if
    wscript.Echo L_LabelLogSuccess_Message + szLogSuccess

    ' display log excluded value

    if (objBuildCatalog.LogExcluded) then
        szLogDisallow = L_LogDisallowedTrue_Message
    else
        szLogDisallow = L_LogDisallowedFalse_Message
    end if
    wscript.Echo L_LabelLogDisallowed_Message + szLogDisallow

    ' display follow complext urls value

    if (objBuildCatalog.FollowComplexUrls) then
        szFollowComplex = L_FollowComplexTrue_Message
    else
        szFollowComplex = L_FollowComplexFalse_Message
    end if
    wscript.Echo L_LabelFollowComplex_Message + szFollowComplex

   ' display whether extensions are included or excluded
    Dim objFileTypes
    set objFileTypes = objBuildCatalog.Extensions
    wscript.Echo L_LabelCrawlExtensions_Message + CStr(objFileTypes.IncludedExtensions)

    ' display prop limit information

    if (objBuildCatalog.AutoPropLimitEnabled) then
        wscript.Echo L_LabelProplenabled_Message + CStr(objBuildCatalog.AutoPropLimitEnabled) + L_LabelProplimitA_Message + CStr(objBuildCatalog.AutoPropLimit) + L_LabelProplimitB_Message
    else
        wscript.Echo L_LabelProplenabled_Message + CStr(objBuildCatalog.AutoPropLimitEnabled)
    end if

    ' display maximum number of logs

    set objLogs = objBuildCatalog.Logs
    wscript.Echo L_LabelMaxLogs_Message + CStr(objLogs.MaxLogs)
        
end function

'+----------------------------------------------------------------------------
'
'   Function:   dispSearchCatalogConfig
'
'   Synopsis:   Display configuration for specified search catalog
'
'
'
'+----------------------------------------------------------------------------

function dispSearchCatalogConfig( objSearchCatalog )

    On Error Resume Next

    Dim nTimeout

    ' display the timeout

    nTimeout = objSearchCatalog.QueryTimeout
    wscript.Echo L_LabelSearchTimeout_Message + CStr(nTimeout)
    wscript.Echo L_LabelSearchRowLimit_Message + CStr(objSearchCatalog.MaxResultRows)
        
end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogProtocols
'
'   Synopsis:   Display protocols for specified catalog
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogProtocols( objBuildCatalog )

    Dim objProtocols, objProtocol
    
    ' get the start page collection

    set objProtocols = objBuildCatalog.Protocols
    wscript.Echo L_LabelProtocols_Message + CStr(objProtocols.Count)

    ' enumerate the start pages

    for each objProtocol in objProtocols
        wscript.Echo L_LabelIndent_Message + objProtocol.UrlName
    next

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogMappings
'
'   Synopsis:   Display URL mappings for specified catalog
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogMappings( objBuildCatalog )

    Dim objMappings, objMapping
    
    ' get the mappings collection

    set objMappings = objBuildCatalog.Mappings
    wscript.Echo L_LabelMappings_Message + CStr(objMappings.Count)

    ' enumerate the mapping

    for each objMapping in objMappings
        wscript.Echo L_LabelIndent_Message + objMapping.From + L_LabelPtr_Message + objMapping.To
    next

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogFileTypes
'
'   Synopsis:   Display filetypes (extensions) used by specified catalog.
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogFileTypes( objBuildCatalog )

    Dim objFileTypes, objFileType
    
    ' get the start page collection

    set objFileTypes = objBuildCatalog.Extensions

   ' specify whether these extensions are included or excluded

    wscript.Echo L_LabelCrawlExtensions_Message + CStr(objFileTypes.IncludedExtensions)

    ' enumerate the start pages

    wscript.Echo L_LabelFiletypes_Message + CStr(objFileTypes.Count)
    for each objFileType in objFileTypes
        wscript.Echo L_LabelIndent_Message + objFileType.Extension
    next

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildCatalogLogs
'
'   Synopsis:   Display logs for a specified catalog.
'
'
'
'+----------------------------------------------------------------------------

function dispBuildCatalogLogs( objBuildCatalog )

    Dim objLog, objLogs
    
    ' get the start page collection

    set objLogs = objBuildCatalog.Logs
    wscript.Echo L_LabelLogs_Message + CStr(objLogs.Count)
    wscript.Echo L_LabelIndent_Message + L_LabelLogsHeader_Message

    ' enumerate the start pages

    for each objLog in objLogs
        wscript.Echo L_LabelIndent_Message + CStr(objLog.Created) + vbTab + objLog.Name + vbTab + CStr(objLog.Size)
    next

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispSiteName
'
'   Synopsis:   Display name of specified site.
'
'
'
'+----------------------------------------------------------------------------

function dispSiteName( objSite )

    On Error Resume Next

    DBG( "dispSiteName" )

    wscript.Echo  L_LabelSite_Message + objSite.Name

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispSiteTiming
'
'   Synopsis:   Display host hit timing for specified site.
'
'
'
'+----------------------------------------------------------------------------

function dispSiteTiming( objSite )

    On Error Resume Next

    DBG( "dispSiteTiming" )

    ' if the site timing is positive, indicates seconds between request

    if (objSite.HitInterval > 0) then
        wscript.Echo  L_LabelTiming_Message + CStr(objSite.HitInterval) + L_MetricTimingBet_Message
    elseif (objSite.HitInterval < -1) then
        wscript.Echo  L_LabelTiming_Message + CStr(Abs(objSite.HitInterval)) + L_MetricTimingSimul_Message
    elseif (objSite.HitInterval = -1) then
        wscript.Echo  L_LabelTiming_Message + L_MetricTimingUnlim_Message
    elseif (objSite.HitInterval = 0) then
        wscript.Echo  L_LabelTiming_Message + L_MetricTimingSingle_Message
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispSiteConfig
'
'   Synopsis:   Display site configuration.
'
'
'
'+----------------------------------------------------------------------------

function dispSiteConfig( objSite )

    Dim szAccountName
    Dim nAuthenType

    On Error Resume Next

    DBG( "dispSiteConfig" )

    wscript.Echo L_LabelInclude_Message          + CStr( objSite.Included )

    szAccountName = objSite.AccountName
    if (szAccountName = "") then
        wscript.Echo L_LabelAccountName_Message     + L_None_Message
    else
        wscript.Echo L_LabelAccountName_Message     + szAccountName
    end if

    wscript.echo  L_LabelAuthentication_Message + dispAuthen(objSite.AuthenticationType)

end function

function dispAuthen( nAuthenType ) 

    select case nAuthenType
        
        case GATHER_TYPE_AUTHENTICATION_ANONYMOUS

            dispAuthen = L_TypeAuthenAnonymous_Text
        
        case GATHER_TYPE_AUTHENTICATION_NTLM

            dispAuthen = L_TypeAuthenNtlm_Text

        case GATHER_TYPE_AUTHENTICATION_BASIC 

            dispAuthen = L_TypeAuthenBasic_Text

        case else

            dispAuthen = L_ProjectTypeUnknown_Message

    end select 

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispStartPageName
'
'   Synopsis:   Display name of specified startpage
'
'
'
'+----------------------------------------------------------------------------

function dispStartPageName( objStartPage )

    On Error Resume Next

    DBG( "dispStartPageName" )

    wscript.Echo  L_LabelStartpage_Message + objStartPage.URL

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispStartPageConfig
'
'   Synopsis:   Display start page configuration.
'
'
'
'+----------------------------------------------------------------------------

function dispStartPageConfig( objStartPage )

    On Error Resume Next

    DBG( "dispStartPageConfig" )

    if (objStartPage.EnumerationDepth = -1) And (objStartPage.HostDepth = -1) then
        wscript.Echo L_LabelSiteRules_Message + L_SiteRulesTrue_Message
    else
        wscript.Echo L_LabelSiteRules_Message + L_SiteRulesFalse_Message
    end if


    if (objStartPage.EnumerationDepth = -1) then
        wscript.Echo  L_LabelPageHops_Message + L_Unlimited_Message
    else
        wscript.Echo  L_LabelPageHops_Message + CStr(objStartPage.EnumerationDepth)
    end if

    if( objStartPage.HostDepth = -1 ) then
        wscript.Echo  L_LabelSiteHops_Message + L_Unlimited_Message
    else
        wscript.Echo  L_LabelSiteHops_Message + CStr(objStartPage.HostDepth)
    end if

    wscript.Echo  L_LabelSiteList_Message + CStr(objStartPage.FollowDirectories)

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispPathName
'
'   Synopsis:   Display name of specified path
'
'
'
'+----------------------------------------------------------------------------

function dispPathName( objPath )

    On Error Resume Next

    DBG( "dispPathName" )

    wscript.Echo  L_LabelPath_Message + objPath.Path

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispPathConfig
'
'   Synopsis:   Display path configuration.
'
'
'
'+----------------------------------------------------------------------------

function dispPathConfig( objPath )

    On Error Resume Next

    DBG( "dispPathConfig" )

    wscript.Echo L_LabelPathFollow_Message + CStr( objPath.Included )
    wscript.Echo L_LabelPathSubdirs_Message + CStr( objPath.IncludeSubdirs )

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildServerName
'
'   Synopsis:   Display host name
'
'
'
'   Note:       No arguments are required since the information is stored in
'               global arguments.

'+----------------------------------------------------------------------------

function dispBuildServerName()

    On Error Resume Next

    DBG( "dispHostName" )

    wscript.Echo  L_LabelBuildserver_Message + objHost.HostName

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildServerConfig
'
'   Synopsis:   Display configuration for the build server.
'
'
'
'   Note:       No arguments are required since the information is stored in
'               global arguments.
'
'+----------------------------------------------------------------------------

function dispBuildServerConfig()

    On Error Resume Next

    DBG( "dispBuildServerConfig" )

    wscript.Echo L_LabelCatalogCount_Message + CStr(objBuildServer.BuildCatalogs.Count)
    wscript.Echo L_LabelContact_Message + objBuildServer.EmailAddress
    wscript.Echo L_LabelUseragent_Message + objBuildServer.UserAgent
    if (objBuildServer.TempPath <> "") then 
        wscript.Echo L_LabelTempPath_Message +    objBuildServer.TempPath
    else                                    
        wscript.Echo L_LabelTempPath_Message +    L_None_Message
    end if
    wscript.Echo L_LabelPerformance_Message      + CStr(objBuildServer.PerformanceLevel) + L_MetricPerformance_Message
    wscript.Echo L_LabelCatalogLocation_Message + objBuildServer.DefaultCatalogsLocation
    wscript.Echo L_LabelConnectTimeout_Message  + CStr(objBuildServer.ConnectTimeout) + L_MetricSeconds_Message
    wscript.Echo L_LabelDataTimeout_Message     + CStr(objBuildServer.DataTimeout) + L_MetricSeconds_Message
    if (objBuildServer.DefaultAccountName <> "") then 
        wscript.Echo L_LabelGatherAccount_Message + objBuildServer.DefaultAccountName
    else                                              
        wscript.Echo L_LabelGatherAccount_Message + L_None_Message
    end if
    if (objBuildServer.DefaultPluginAccountName <> "") then 
        wscript.Echo L_LabelPluginAccount_Message + objBuildServer.DefaultPluginAccountName
    else                                              
        wscript.Echo L_LabelPluginAccount_Message + L_None_Message
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispBuildServerProxy
'
'   Synopsis:   Display proxy setting for the build server.
'
'
'
'+----------------------------------------------------------------------------

function dispBuildServerProxy()

    On Error Resume Next

    DBG( "dispBuildServerProxy" )

    ' check the build server proxy settings

    select case objBuildServer.ProxyUsageSetting

        case PROXY_TYPE_NONE:

            wscript.Echo L_StatusProxyNone_Message

        case PROXY_TYPE_SYSTEM:

            wscript.Echo L_StatusProxySystem_Message

        case PROXY_TYPE_CUSTOM:
            
            wscript.Echo L_StatusProxyCustom_Message
            wscript.Echo L_LabelProxyServer_Message + objBuildServer.ProxyAddress
            wscript.Echo L_LabelPort_Message         + CStr(objBuildServer.ProxyPortNumber)

            if (objBuildServer.ProxyBypassForLocalAddresses = 0) then
                wscript.Echo L_LabelBypass_Message + L_ProxyBypassFalse_Message
            else
                wscript.Echo L_LabelBypass_Message + L_ProxyBypassTrue_Message
            end if

            if ( objBuildServer.ProxyBypassAddressesList = "" ) then
                wscript.Echo L_LabelExceptions_Message    +  L_None_Message
            else
                wscript.Echo L_LabelExceptions_Message    +  objBuildServer.ProxyBypassAddressesList
            end if

        case else

            wscript.Echo L_ProxyUnknown_ErrorMessage

    end select

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispSearchServerName
'
'   Synopsis:   Display host name
'
'
'
'   Note:       No arguments are required since the information is stored in
'               global arguments.

'+----------------------------------------------------------------------------

function dispSearchServerName()

    On Error Resume Next

    DBG( "dispHostName" )

    wscript.Echo  L_LabelBuildserver_Message + objHost.HostName

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispSearchServerConfig
'
'   Synopsis:   Display configuration for the build server.
'
'
'
'   Note:       No arguments are required since the information is stored in
'               global arguments.
'
'+----------------------------------------------------------------------------

function dispSearchServerConfig()

    On Error Resume Next

    DBG( "dispSearchServerConfig" )

    wscript.Echo L_LabelCatalogCount_Message    + CStr(objSearchServer.SearchCatalogs.Count)
    wscript.Echo L_LabelPerformance_Message      + CStr(objSearchServer.PerformanceLevel) + L_MetricPerformance_Message
    wscript.Echo L_LabelCatalogLocation_Message + objSearchServer.CatalogsLocation
    if (objSearchServer.DefaultCatalog = "") then
        wscript.Echo L_LabelDefaultCatalog_Message + L_None_Message
    else
        wscript.Echo L_LabelDefaultCatalog_Message + objSearchServer.DefaultCatalog
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispProtocolName
'
'   Synopsis:   Display name of specified protocol
'
'
'
'+----------------------------------------------------------------------------

function dispProtocolName( objProtocol )

    On Error Resume Next

    DBG( "dispProtocolName" )

    wscript.Echo  L_LabelProtocol_Message + objProtocol.UrlName

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispProtocolConfig
'
'   Synopsis:   Display protocol configuration.
'
'
'
'+----------------------------------------------------------------------------

function dispProtocolConfig( objProtocol )

    On Error Resume Next

    DBG( "dispProtocolConfig" )

    wscript.Echo L_LabelProtocolInclude_Message + CStr( objProtocol.Included )
    wscript.Echo L_LabelProtocolHandler_Message + CStr( objProtocol.ProgIdHandler)

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispLogName
'
'   Synopsis:   Display name of specified log
'
'
'
'+----------------------------------------------------------------------------

function dispLogName( objLog )

    On Error Resume Next

    DBG( "dispLogName" )

    wscript.Echo  L_LabelLog_Message + objLog.Name

end function

'+----------------------------------------------------------------------------
'
'   Function:   dispLogConfig
'
'   Synopsis:   Display log configuration.
'
'
'
'+----------------------------------------------------------------------------

function dispLogConfig( objLog )

    On Error Resume Next

    DBG( "dispLogConfig" )

    wscript.Echo L_LabelCreated_Message + CStr( objLog.Created )
    wscript.Echo L_LabelSize_Message + CStr( objLog.Size )

end function

'----------------------------------------------------------------------------'
'                           Administration Functions
'----------------------------------------------------------------------------'


'----------------------------  Get Functions  -------------------------------'


'+----------------------------------------------------------------------------
'
'   Function:   GetStatus
'
'   Synopsis:   Prints out the status of all (or specified) catalogs
'
'   Parameters:
'        [catalog]   optional    get status for this catalog
'
'
'
'+----------------------------------------------------------------------------

function GetStatus()

    DBG( "GetStatus" )

    Dim bIsHelp, bInvalidArgs
    
    Dim szCatalog
    Dim objBuildCatalogs, objSearchCatalogs
    Dim objBuildCatalog , objSearchCatalog
    Dim objSearchServers, objSearchServerItem
    Dim strSearchServers
    
    On Error Resume Next

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_GET_STATUS, SYNTAX_OP_GET_STATUS)
    if ( bIsHelp ) then
        exit function
    end if

    ' check to see if catalog specified on command line

    szCatalog = utilGetArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_STATUS, vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_STATUS, SYNTAX_OP_GET_STATUS)
    if ( bInvalidArgs ) then
        exit function
    end if

    if IsNull(szCatalog) then

        ' display summary info for all catalogs

        wscript.Echo
        wscript.Echo L_BuildHeader_Message
        wscript.Echo L_Divider_Message

        ' get the collection of build catalogs

        Set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' iterate through the build catalogs

        if (objBuildCatalogs.Count = 0) then
            wscript.Echo L_None_Message
        else
            For Each objBuildCatalog In objBuildCatalogs
                call dispCatalogName( objBuildCatalog )
                call dispBuildCatalogStatus( objBuildCatalog )
                wscript.Echo 
            Next
        end if

        ' iterate through the search catalogs

        wscript.Echo
        wscript.Echo L_SearchHeader_Message
        wscript.Echo L_Divider_Message
        set objSearchCatalogs = objSearchServer.SearchCatalogs
        if (objSearchCatalogs.Count = 0) then
            wscript.Echo L_None_Message
        end if
        For Each objSearchCatalog In objSearchCatalogs
            call dispCatalogName( objSearchCatalog )
            call dispSearchCatalogStatus( objSearchCatalog )
        Next

    else

        ' get the build and search catalog

        set objBuildCatalog = utilGetBuildCatalog( szCatalog )
        set objSearchCatalog = utilGetSearchCatalog( szCatalog )
    
        ' check if the catalog exists at all

        if IsEmpty(objBuildCatalog) And IsEmpty(objSearchCatalog) then exit function

        ' display catalog name

        call dispCatalogName( objBuildCatalog )

        ' display search catalog status

        if (IsEmpty(objSearchCatalog) = FALSE) then
            call dispSearchCatalogStatus( objSearchCatalog )
        end if

        ' display build catalog status

        if (IsEmpty(objBuildCatalog) = FALSE) then
            call dispBuildCatalogStatus( objBuildCatalog )
            call dispBuildCatalogStatusExtended( objBuildCatalog )
        end if
        
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetStartPages
'
'   Synopsis:   Enumerates the startpages for a specified catalog. 
'
'   Parameters: if a startpage url is specified as a parameter, show all attribs
'               if no catalog specified, show all startpages for all catalogs 

'
'
'
'+----------------------------------------------------------------------------

function GetStartPages()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim objBuildCatalogs, objBuildCatalog
    Dim objStartPages, objStartPage

    On Error Resume Next

    DBG( "GetStartPage" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_STARTPAGES, SYNTAX_OP_GET_STARTPAGES )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_STARTPAGES, vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_STARTPAGES, SYNTAX_OP_GET_STARTPAGES)
    if ( bInvalidArgs ) then
        exit function
    end if

    if IsNull(szCatalog) then
        
        ' get the colleciton of catalogs

        set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' check if any catalogs exist in collection

        if (objBuildCatalogs.Count = 0) then
            wscript.Echo L_NoCatalogs_ErrorMessage + objHost.HostName
            exit function
        end if

        ' enumerate the startpages on all catalogs

        for each objBuildCatalog in objBuildCatalogs
            call dispCatalogName( objBuildCatalog )
            call dispBuildCatalogStartPages( objBuildCatalog )
            wscript.Echo
        next

    else

        ' get the build catalog

        set objBuildCatalog = utilGetBuildCatalog( szCatalog )
        if IsEmpty(objBuildCatalog) then exit function

        ' get the start page collection

        set objStartPages = objBuildCatalog.StartPages

        ' check if any startpages in collection

        if (objStartPages.Count = 0) then
            Dim msgstr
            msgstr = L_NoStartpagesA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szCatalog )
            wscript.Echo  msgstr
            exit function
        end if

        ' enumerate the start pages

        for each objStartPage in objStartPages
            call dispStartPageName( objStartPage )
            call dispStartPageConfig( objStartPage )
            wscript.Echo
        next
                
    end if


end function

'+----------------------------------------------------------------------------
'
'   Function:   GetSites
'
'   Synopsis:   Enumerates the sites for a specified catalog. 
'
'   Parameters: [site] - show details for site, if missing show all sites
'               [catalog] - show sites for catalog, if missing show all catalogs
'
'
'
'+----------------------------------------------------------------------------

function GetSites()
 
    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim objBuildCatalogs, objBuildCatalog
    Dim objSites, objSite

    On Error Resume Next

    DBG( "GetSites" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_SITES, SYNTAX_OP_GET_SITES )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_SITES , vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_SITES, SYNTAX_OP_GET_SITES)
    if ( bInvalidArgs ) then
        exit function
    end if

    if IsNull(szCatalog) then

       ' get the collection of catalogs

       set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' check if any catalogs exist in collection

        if (objBuildCatalogs.Count = 0) then
            wscript.Echo L_NoCatalogs_ErrorMessage + objHost.HostName
            exit function
        end if

       ' enumerate the catalogs

        for each objBuildCatalog in objBuildCatalogs

            call dispCatalogName( objBuildCatalog )
            call dispBuildCatalogSites( objBuildCatalog )
            wscript.Echo

        next

    else

        ' get the build catalog

        set objBuildCatalog = utilGetBuildCatalog( szCatalog )
        if IsEmpty(objBuildCatalog) then exit function

        ' get the collection of sites

        set objSites = objBuildCatalog.Sites
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if
                
       ' check if any sites exist in collection

        if (objSites.Count = 0) then
            Dim msgstr
            msgstr = L_NoSites_ErrorMessage
            msgstr = replace(msgstr, "%1",  szCatalog)
            wscript.Echo  msgstr
            exit function
        end if

        ' enumerate all the sites on this catalog

        for each objSite in objSites
            call dispSiteName( objSite )
            call dispSiteConfig( objSite )
            wscript.Echo
        next

    end if


end function

'+----------------------------------------------------------------------------
'
'   Function:   GetTiming
'
'   Synopsis:   Enumerates the timing for sites on a server. 
'
'   Parameters:  [site] - show details for site, if missing show all sites
'
'
'
'+----------------------------------------------------------------------------

function GetTiming()
 
    Dim bIsHelp, bInvalidArgs
    Dim szSite
    Dim objBuildCatalogs, objBuildCatalog
    Dim objSites, objSite
    Dim msgstr

    On Error Resume Next

    DBG( "GetTiming" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_TIMING, SYNTAX_OP_GET_TIMING )
    if (bIsHelp) then
        exit function
    end if

    ' get the site name from the command line

    szSite = utilGetArg( L_Site_ArgumentName, SYNTAX_OP_GET_TIMING, vbString )
    if IsEmpty(szSite) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_TIMING, SYNTAX_OP_GET_TIMING)
    if ( bInvalidArgs ) then
        exit function
    end if

   ' get the collection of sites

    set objSites = objBuildServer.Sites
    if (Err.Number <> 0) then
        dispError()
       exit function
    end if

    ' check if any sites exist in collection

    if (objSites.Count = 0) then
        msgstr = L_NoTiming_ErrorMessage
        msgstr = replace(msgstr, "%1",  objHost.HostName)
        wscript.Echo  msgstr
        exit function
    end if

    if IsNull(szSite) then

        ' enumerate all the sites on this catalog

        for each objSite in objSites
            call dispSiteName( objSite )
            call dispSiteTiming( objSite )
            wscript.Echo
        next

    else

        ' list specific site information

        set objSite  = objSites.Item( szSite )
        if (Err.Number <> 0) then
            if (Err.Number = E_NOTEXIST) then
                msgstr = L_NotExistTimingA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szSite )
                msgstr = replace(msgstr, "%2",  objHost.HostName)
                wscript.Echo  msgstr
            else
                dispError()
            end if
            exit function
        end if

        ' display site timing info

        call dispSiteName( objSite )
        call dispSiteTiming( objSite )
    
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetConfig
'
'   Synopsis:   Get the configuration for a specified catalog. 
'
'   Parameters:  [catalog] - show configuration for catalog, if missing show all catalogs
'
'
'
'+----------------------------------------------------------------------------

function GetConfig()
 
    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim objBuildCatalogs, objBuildCatalog

    On Error Resume Next

    DBG( "GetConfig" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_CONFIG, SYNTAX_OP_GET_CONFIG )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_CONFIG, vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_CONFIG, SYNTAX_OP_GET_CONFIG)
    if ( bInvalidArgs ) then
        exit function
    end if

    if IsNull(szCatalog) then
        
        ' get the colleciton of catalogs

        set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' check if any catalogs exist in collection

        if (objBuildCatalogs.Count = 0) then
            wscript.Echo L_NoCatalogs_ErrorMessage + objHost.HostName
            exit function
        end if

        ' enumerate the configuration for all catalogs

        for each objBuildCatalog in objBuildCatalogs
            call dispCatalogName( objBuildCatalog )
            call dispBuildCatalogConfig( objBuildCatalog )
            call dispBuildCatalogProtocols( objBuildCatalog )
            wscript.Echo
        next

    else

        ' get the build catalog

        set objBuildCatalog = utilGetBuildCatalog( szCatalog )
        if IsEmpty(objBuildCatalog) then exit function

        ' display header info
        call dispCatalogName( objBuildCatalog )
        call dispBuildCatalogConfig( objBuildCatalog )
        call dispBuildCatalogProtocols( objBuildCatalog )
                
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetMappings
'
'   Synopsis:   Get the mappings for a specified catalog. 
'
'   Parameters:  [catalog] - show mappings for catalog, if missing show all mapping
'
'
'
'+----------------------------------------------------------------------------

function GetMappings()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim objBuildCatalogs, objBuildCatalog

    On Error Resume Next

    DBG( "GetMappings" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_MAPPINGS, SYNTAX_OP_GET_MAPPINGS )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_MAPPINGS , vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_MAPPINGS, SYNTAX_OP_GET_MAPPINGS)
    if ( bInvalidArgs ) then
        exit function
    end if

    if IsNull(szCatalog) then
        
        ' get the colleciton of catalogs

        set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' check if any catalogs exist in collection

        if (objBuildCatalogs.Count = 0) then
            wscript.Echo L_NoCatalogs_ErrorMessage + objHost.HostName
            exit function
        end if

        ' enumerate the configuration for all catalogs

        for each objBuildCatalog in objBuildCatalogs
            call dispCatalogName( objBuildCatalog )
            call dispBuildCatalogMappings( objBuildCatalog )
            wscript.Echo
        next

    else

        ' get the build catalog

        set objBuildCatalog = utilGetBuildCatalog( szCatalog )
        if IsEmpty(objBuildCatalog) then exit function

        ' display mapping info

        call dispCatalogName( objBuildCatalog )
        call dispBuildCatalogMappings( objBuildCatalog )
                
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetFileTypes
'
'   Synopsis:   Get the filetypes for a specified catalog. 
'
'   Parameters:  [catalog] - show filetypes for a catalog, if missing show all filetypes
'
'
'
'+----------------------------------------------------------------------------

function GetFileTypes()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim objBuildCatalogs, objBuildCatalog

    On Error Resume Next

    DBG( "GetFileTypes" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_FILETYPES, SYNTAX_OP_GET_FILETYPES )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_FILETYPES , vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_FILETYPES, SYNTAX_OP_GET_FILETYPES)
    if ( bInvalidArgs ) then
        exit function
    end if

    if IsNull(szCatalog) then
        
        ' get the collection of catalogs

        set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' check if any catalogs exist in collection

        if (objBuildCatalogs.Count = 0) then
            wscript.Echo L_NoCatalogs_ErrorMessage + objHost.HostName
            exit function
        end if

        ' enumerate the filetyps for all catalogs

        for each objBuildCatalog in objBuildCatalogs
            call dispCatalogName( objBuildCatalog )
            call dispBuildCatalogFileTypes( objBuildCatalog )
            wscript.Echo
        next

    else

        ' get the build catalog

        set objBuildCatalog = utilGetBuildCatalog( szCatalog )
        if IsEmpty(objBuildCatalog) then exit function

        ' display info

        call dispCatalogName( objBuildCatalog )
        call dispBuildCatalogFileTypes( objBuildCatalog )
                
    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetPaths
'
'   Synopsis:   Gets the paths for a specified site. 
'
'   Syntax:
'       sssadmin get paths <site name> </catalog:catalog name>
'
'   Parameters:  
'
'       <site>          required    site to fetch paths for
'       <catalog>       required    paths for the site on this catalog
'
'   Notes:
'
'       If a catalog isn't specified, the configuration for this site is 
'       gathered from the host.
'
'
'
'+----------------------------------------------------------------------------

function GetPaths()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog, szSite

    Dim objBuildCatalogs, objBuildCatalog
    Dim objSites, objSite
    Dim objPaths, objPath
    Dim msgstr

    On Error Resume Next

    DBG( "GetPaths" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_GET_PATHS, SYNTAX_OP_GET_PATHS)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the site from the command line

    szSite = utilGetRequiredArg( L_Site_ArgumentName, SYNTAX_OP_GET_PATHS, vbString )
    if IsEmpty(szSite) then exit function

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_PATHS, vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_PATHS, SYNTAX_OP_GET_PATHS)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the sites collection (for this catalog)

    set objSites = objBuildCatalog.Sites
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' get the specified site

    set objSite = objSites.Item( szSite )
    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then
            msgstr = L_NotExistSiteA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szSite )
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
        else
            dispError()
        end if
        exit function
    end if

    ' get the collection of paths

    set objPaths = objSite.Paths
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' check if any paths in the collection

    if (objPaths.Count = 0) then
        msgstr = L_NoPathsA_ErrorMessage
        msgstr = replace(msgstr, "%1",  szSite )
        msgstr = replace(msgstr, "%2",  szCatalog)
        wscript.Echo  msgstr
        exit function
    end if

    ' enumerate the paths

    for each objPath in objPaths
        
        call dispPathName( objPath )
        call dispPathConfig( objPath )
        wscript.Echo

    next

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetSearchServers
'
'   Synopsis:   Enumerates the SearchServers for a specified catalog. 
'
'   Parameters:  if no catalog specified, show search servers for all catalogs 
'
'
'
'+----------------------------------------------------------------------------

function GetSearchServers()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim objBuildCatalogs, objBuildCatalog
    Dim lobjSearchServers, lobjSearchServer

    On Error Resume Next

    DBG( "GetSearchServer" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_SEARCHSERVERS, SYNTAX_OP_GET_SEARCHSERVERS )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_SEARCHSERVERS, vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_SEARCHSERVERS, SYNTAX_OP_GET_SEARCHSERVERS)
    if ( bInvalidArgs ) then
        exit function
    end if

    if IsNull(szCatalog) then
        
        ' get the colleciton of catalogs

        set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' check if any catalogs exist in collection

        if (objBuildCatalogs.Count = 0) then
            wscript.Echo L_NoCatalogs_ErrorMessage + objHost.HostName
            exit function
        end if

        ' enumerate the search servers on all catalogs

        for each objBuildCatalog in objBuildCatalogs
            call dispCatalogName( objBuildCatalog )
            call dispBuildCatalogSearchServers( objBuildCatalog )
            wscript.Echo
        next

    else

        ' get the build catalog

        set objBuildCatalog = utilGetBuildCatalog( szCatalog )
        if IsEmpty(objBuildCatalog) then exit function

        ' display search servers for only this catalog

        call dispCatalogName( objBuildCatalog )
        call dispBuildCatalogSearchServers( objBuildCatalog )
        wscript.Echo
                
    end if


end function

'+----------------------------------------------------------------------------
'
'   Function:   GetBuildEnv
'
'   Synopsis:   Get the build environment. 
'
'   Parameters:  <none>
'
'
'
'+----------------------------------------------------------------------------

function GetBuildEnv()
 
    Dim bIsHelp, bInvalidArgs

    On Error Resume Next

    DBG( "GetBuildEnv" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_BUILDENV, SYNTAX_OP_GET_BUILDENV )
    if (bIsHelp) then
        exit function
    end if

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_BUILDENV, SYNTAX_OP_GET_BUILDENV)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' display information

    call dispBuildServerName()
    call dispBuildServerConfig()       

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetSearchEnv
'
'   Synopsis:   Get the build environment. 
'
'   Parameters:  <none>
'
'
'
'+----------------------------------------------------------------------------

function GetSearchEnv()
 
    Dim bIsHelp, bInvalidArgs

    On Error Resume Next

    DBG( "GetSearchEnv" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_SEARCHENV, SYNTAX_OP_GET_SEARCHENV )
    if (bIsHelp) then
        exit function
    end if

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_SEARCHENV, SYNTAX_OP_GET_SEARCHENV)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' display information

    call dispSearchServerName()
    call dispSearchServerConfig()       

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetProtocols
'
'   Synopsis:   Gets the paths for a specified site. 
'
'   Parameters:  
'
'       [catalog]       optional    paths for the site on this catalog
'
'   Syntax:
'
'       sssadmin get protocols </catalog:catalog name>
'
'
'
'+----------------------------------------------------------------------------

function GetProtocols()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog

    Dim objBuildCatalogs, objBuildCatalog
    Dim objProtocols, objProtocol

    On Error Resume Next

    DBG( "GetProtocols" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_GET_PROTOCOLS, SYNTAX_OP_GET_PROTOCOLS)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_PROTOCOLS, vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_PROTOCOLS, SYNTAX_OP_GET_PROTOCOLS)
    if ( bInvalidArgs ) then
        exit function
    end if

    if IsNull(szCatalog) then

        ' get the collection of catalogs

        set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' check if any catalogs exist in collection

        if (objBuildCatalogs.Count = 0) then
            wscript.Echo L_NoCatalogs_ErrorMessage + objHost.HostName
            exit function
        end if

        ' enumerate the protocols on all catalogs

        for each objBuildCatalog in objBuildCatalogs
            call dispCatalogName( objBuildCatalog )
            call dispBuildCatalogProtocols( objBuildCatalog )
            wscript.Echo
        next

    else

        ' get the build catalog

        set objBuildCatalog = utilGetBuildCatalog( szCatalog )
        if IsEmpty(objBuildCatalog) then exit function

        ' get the protocols collection (for this catalog)

        set objProtocols = objBuildCatalog.Protocols
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' check if any protocols in the collection

        if (objProtocols.Count = 0) then
            wscript.Echo L_NoProtocolsA_ErrorMessage + szCatalog + L_NoProtocolsB_ErrorMessage + objHost.HostName
            exit function
        end if

        ' enumerate the protocols

        for each objProtocol in objProtocols
        
            call dispProtocolName( objProtocol )
            call dispProtocolConfig( objProtocol )
            wscript.Echo

        next

    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetLogs
'
'   Synopsis:   Gets the logs for a specified site. 
'
'   Parameters:  
'
'       [catalog]       optional    logs for this catalog
'
'   Syntax:
'
'       sssadmin get logs </catalog:catalog name>
'
'
'
'+----------------------------------------------------------------------------

function GetLogs()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog

    Dim objBuildCatalogs, objBuildCatalog
    Dim objLogs, objLog

    On Error Resume Next

    DBG( "GetLogs" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_GET_LOGS, SYNTAX_OP_GET_LOGS)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetArg( L_Catalog_ArgumentName, SYNTAX_OP_GET_LOGS, vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_LOGS, SYNTAX_OP_GET_LOGS)
    if ( bInvalidArgs ) then
        exit function
    end if

    if IsNull(szCatalog) then

        ' get the collection of catalogs

        set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' check if any catalogs exist in collection

        if (objBuildCatalogs.Count = 0) then
            wscript.Echo L_NoCatalogs_ErrorMessage + objHost.HostName
            exit function
        end if

        ' enumerate the search servers on all catalogs

        for each objBuildCatalog in objBuildCatalogs
            call dispCatalogName( objBuildCatalog )
            call dispBuildCatalogLogs( objBuildCatalog )
            wscript.Echo
        next

    else

        ' get the build catalog

        set objBuildCatalog = utilGetBuildCatalog( szCatalog )
        if IsEmpty(objBuildCatalog) then exit function

        ' get the logs collection (for this catalog)

        set objLogs = objBuildCatalog.Logs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' display number of logs

        wscript.Echo L_LabelLogNum_Message + CStr(objLogs.Count)
        wscript.Echo

        ' enumerate the logs

        for each objLog in objLogs
            call dispLogName( objLog )
            call dispLogConfig( objLog )
            wscript.Echo
        next

    end if

end function

'+----------------------------------------------------------------------------
'
'   Function:   GetProxy
'
'   Synopsis:   Get the proxy settings. 
'
'   Parameters:  <none>
'
'
'
'+----------------------------------------------------------------------------

function GetProxy()
 
    Dim bIsHelp, bInvalidArgs

    On Error Resume Next

    DBG( "GetProxy" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_GET_PROXY, SYNTAX_OP_GET_PROXY )
    if (bIsHelp) then
        exit function
    end if

    bInvalidArgs = utilInvalidArgs(HELP_OP_GET_PROXY, SYNTAX_OP_GET_PROXY)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' display information

    call dispBuildServerProxy()       

end function


'----------------------------  Set Functions  -------------------------------'

'+----------------------------------------------------------------------------
'
'   Function:   SetStartPage
'
'   Synopsis:   Sets the properties on a start page for the specified catalog. 
'
'   Parameters:  
'
'       <catalog>       required    catalog to add startpage for
'       <startpage>     required    startpage to add
'       [pagehops]      optional    number of page hops [default: unlimited]
'       [sitehops]      optional    number of site hops [default: 0]
'       [directory]     optional    follow directory tree [default: False]
'
'
'
'
'+----------------------------------------------------------------------------

function SetStartPage()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog, szURL
    Dim objBuildCatalogs, objBuildCatalog
    Dim objStartPages, objStartPage
    Dim nPageHops, nSiteHops
    Dim bDirectories, bSiteRule
    Dim dummy

    On Error Resume Next

    DBG( "SetStartPage" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_SET_STARTPAGE, SYNTAX_OP_SET_STARTPAGE)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_SET_STARTPAGE, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the URL from the command line
    
    szURL = utilGetRequiredArg( L_Url_ArgumentName, SYNTAX_OP_SET_STARTPAGE, vbString )
    if IsEmpty(szURL) then exit function

    ' get the items to set off of the command line

    bDirectories = utilGetArg( L_Directories_ArgumentName, SYNTAX_OP_SET_STARTPAGE, vbBoolean )
    if IsEmpty(bDirectories) then exit function

    bSiteRule = utilGetArg( L_Siterule_ArgumentName, SYNTAX_OP_SET_STARTPAGE, vbBoolean )
    if IsEmpty(bSiteRule) then exit function

    nPageHops = utilGetArg( L_Pagehops_ArgumentName, SYNTAX_OP_SET_STARTPAGE, vbLong )
    if IsEmpty(nPageHops) then exit function

    nSiteHops = utilGetArg( L_Sitehops_ArgumentName, SYNTAX_OP_SET_STARTPAGE, vbLong )
    if IsEmpty(nSiteHops) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_SET_STARTPAGE, SYNTAX_OP_SET_STARTPAGE)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the start page collection

    set objStartPages = objBuildCatalog.StartPages
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' get the specified url or add it if it doesn't exist

    set objStartPage = objStartPages.Item( szURL )

    ' If the start page doesn't exist Err.Number isn't set but the object is invalid.
    ' Grab the URL and see if that fails.

    dummy = objStartPage.url

    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then

            ' add the specified url

            Err.Number = 0
            set objStartPage = objStartPages.Add( szURL )
            if (Err.Number <> 0) then
                if (Err.Number = E_OBJECTEXISTS) then
                    Dim msgstr
                    msgstr = L_NotFoundStartpageA_ErrorMessage
                    msgstr = replace(msgstr, "%1",  szUrl )
                    wscript.Echo  msgstr
                    wscript.Echo L_GetStartpageHelp_Message
                    exit function
                end if
                dispError()
                exit function
            end if
        else
            ' report an error

            dispError()
            exit function

        end if
    end if

    ' set the properties on the url

    if (IsNull(nPageHops) <> TRUE) then
        objStartPage.EnumerationDepth = nPageHops
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if
    end if

    if (IsNull(nSiteHops) <> TRUE) then
        objStartPage.HostDepth = nSiteHops
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if
    end if

    if (IsNull(bSiteRule) <> TRUE) then
        if (bSiteRule) then
            objStartPage.EnumerationDepth = -1
            objStartPage.HostDepth = -1
            if (IsNull(nSiteHops) <> TRUE) Or (IsNull(nPageHops) <> TRUE) then
                wscript.Echo L_SiteRuleWarning_Message
                wscript.Echo
            end if
		else
            if ((IsNull(nSiteHops) = TRUE) And (IsNull(nPageHops) = TRUE)) And ((objStartPage.EnumerationDepth = -1) And (objStartPage.HostDepth = -1)) then
				objStartPage.HostDepth = 0	
			end if					
        end if
    end if
    if (IsNull(bDirectories) <> TRUE) then
        objStartPage.FollowDirectories = bDirectories
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if
    end if

    ' display the results

    for each objStartPage in objStartPages
        call dispStartPageName( objStartPage )
        call dispStartPageConfig( objStartPage )
        wscript.Echo
    next

end function

'+----------------------------------------------------------------------------
'
'   Function:   SetSite
'
'   Synopsis:   Sets a site to the specified catalog. 
'
'   Parameters:  
'
'       <site>          required    site to set
'       <catalog>       required    catalog site exists on
'       [username]      optional    user name to access acount (default: system account)
'       [password]      optional    password for specified user name
'       [authen]        optional    authentication type (default: none)
'
'
'
'+----------------------------------------------------------------------------

function SetSite()
 
    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim szSite
    Dim objBuildCatalogs, objBuildCatalog
    Dim objSites, objSite
    Dim msgstr

    ' properties

    Dim bInclude
    Dim szUser, szPassword
    Dim nAuthenType

    On Error Resume Next

    DBG( "SetSite" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_SET_SITE, SYNTAX_OP_SET_SITE)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the site name from the command line
    
    szSite = utilGetRequiredArg( L_Site_ArgumentName, SYNTAX_OP_SET_SITE, vbString )
    if IsEmpty(szSite) then exit function

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_SET_SITE, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the properties

    bInclude = utilGetArg( L_Include_ArgumentName, SYNTAX_OP_SET_SITE, vbBoolean )
    if IsEmpty(bInclude) then exit function

    szUser = utilGetArg( L_User_ArgumentName, SYNTAX_OP_SET_SITE, vbString )
    if IsEmpty(szUser) then exit function

    szPassword = utilGetArg( L_Password_ArgumentName, SYNTAX_OP_SET_SITE, vbString )
    if IsEmpty(szPassword) then exit function

    nAuthenType = utilGetArg( L_Authentype_ArgumentName, SYNTAX_OP_SET_SITE, vbAuthenType )
    if IsEmpty(nAuthenType) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_SET_SITE, SYNTAX_OP_SET_SITE)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the collection of sites

    set objSites = objBuildCatalog.Sites
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if
                
    ' get the site from the collection

    set objSite = objSites.Item( szSite )
    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then

            ' add the site to the collection

            Err.Number = 0
            set objSite = objSites.Add( szSite, TRUE )
            if (Err.Number <> 0) then
                dispError()
                exit function
            end if

        else

            ' report an error

            dispError()
            exit function

        end if
    end if

    ' set the properties

    if (IsNull(bInclude) = FALSE) then objSite.Included = bInclude

    ' verify that the authentication/user combination is valid - that is,
    ' we are not trying to set ntlm/basic authentication with no user

    if (IsNull(nAuthenType)) then 
	nAuthenType = objSite.AuthenticationType
    else
	if ((nAuthenType <> GATHER_TYPE_AUTHENTICATION_ANONYMOUS) And (IsNull(szUser))) then
	    msgstr = L_NoUser_ErrorMessage
	    msgstr = replace(msgstr, "%1",  dispAuthen(nAuthenType) )
	    msgstr = replace(msgstr, "%2",  dispAuthen(objSite.AuthenticationType))
	    wscript.Echo msgstr
	    wscript.Echo
	end if 
    end if                 

    'If the type is anonymous, and they are trying to set a user, fail to
    ' set the user and output an error message
    if ((nAuthenType = GATHER_TYPE_AUTHENTICATION_ANONYMOUS) And (Not (IsNull(szUser)))) then
	msgstr = L_ExtraUser_ErrorMessage
	wscript.Echo msgstr
	wscript.Echo
	szUser = ""
	szPassword = ""
    end if 

    ' set the authentication type. (Checked for missing authen type or authen 
    ' type with missing user above. If the user is missing here, either we had 
    ' anonymous authen, or no authen was set.)

    if Not ((nAuthenType <> GATHER_TYPE_AUTHENTICATION_ANONYMOUS) And (IsNull(szUser))) then
        if IsNull(szPassword) then szPassword = ""
        if IsNull(szUser) then szUser = ""
        call objSite.SetAccount( szUser, szPassword, nAuthenType )
        if (Err.Number <> 0) then
		DBG "Error while setting account"
            dispError
            exit function
	end if
    end if

    
    ' display results

    msgstr = L_SuccessSetSiteA_Message
    msgstr = replace(msgstr, "%1",  szSite )
    msgstr = replace(msgstr, "%2",  szCatalog)
    wscript.Echo  msgstr
    wscript.Echo

    ' display site configuration

    call dispSiteName( objSite )
    call dispSiteConfig( objSite )
    wscript.Echo

end function

'+----------------------------------------------------------------------------
'
'   Function:   SetTiming
'
'   Synopsis:   Sets timing for a site on a server. 
'
'   Parameters:  
'
'       <site>          required    site to set
'       <timing>        required    timing interval for site
'
'
'
'+----------------------------------------------------------------------------

function SetTiming()
 
    Dim bIsHelp, bInvalidArgs
    Dim szSite
    Dim objSites, objSite
    Dim szType
    Dim nHits

    On Error Resume Next

    DBG( "SetTiming" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_SET_TIMING, SYNTAX_OP_SET_TIMING )
    if (bIsHelp) then
        exit function
    end if

   ' get the site from the command line
    
    szSite = utilGetRequiredArg( L_Site_ArgumentName, SYNTAX_OP_SET_TIMING, vbString )
    if IsEmpty(szSite) then exit function

    ' get the type from the command line

    szType = utilGetRequiredArg( L_TimingType_ArgumentName, SYNTAX_OP_SET_TIMING, vbTimingType )
    if IsEmpty(szType) then exit function

    ' get the hits from the command line

    nHits = utilGetArg( L_TimingHits_ArgumentName, SYNTAX_OP_SET_TIMING, vbLong )
    if IsEmpty(nHits) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_SET_TIMING, SYNTAX_OP_SET_TIMING)
    if ( bInvalidArgs ) then
        exit function
    end if

   ' get the collection of sites

    set objSites = objBuildServer.Sites
    if (Err.Number <> 0) then
       dispError()
       exit function
    end if

    ' get the site from the collection

    set objSite = objSites.Item( szSite )
    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then
            Err.Number = 0
            set objSite = objSites.Add( szSite )
            if (Err.Number <> 0) then
                dispError()
                exit function
            end if
        else
            dispError()
            exit function
        end if
    end if

    ' check the type of interval

    if szType = L_TypeUnlimited_Text then

        ' set nHits to special value

        nHits = -1

    else

        ' make sure hits was specified, if not set to default

        if IsNull(nHits) then
            wscript.Echo L_RequiredArg_ErrorMessage + L_TimingHits_ArgumentName
            wscript.Echo
            call dispSyntax( SYNTAX_OP_SET_TIMING )
            exit function
        end if

        ' make sure value for hits is correct

        if nHits <= 0 then
            wscript.Echo L_InvalidHits_ErrorMessage
            exit function
        end if

        ' check the type of interval

        select case szType

            case L_TypeSeconds_Text

                ' we do nothing
        
            case L_TypeMinutes_Text

                ' multiply by 60

                nHits = nHits * 60

            case L_TypeDocuments_Text

                ' check if 1 document per second

                if (nHits = 1) then
                    nHits = 0
                end if

                ' set document count to negative

                nHits = 0 - nHits


        end select

    end if

    ' set the hit interval 
        
    objSite.HitInterval = nHits
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' display success

    Dim msgstr
    msgstr = L_SuccessSetTimingA_Message
    msgstr = replace(msgstr, "%1",  szSite )
    msgstr = replace(msgstr, "%2",  objHost.HostName)
    wscript.Echo  msgstr
    wscript.Echo

    ' display site timing info

    call dispSiteName( objSite )
    call dispSiteTiming( objSite )

end function

'+----------------------------------------------------------------------------
'
'   Function:   SetConfig
'
'   Synopsis:   Set the configuration for a specified catalog. 
'
' Parameters:
'
'    <(c)atalog>       required    set configuration for this catalog
'    [(p)rojecttype]   optional    type of project
'    [(n)otification]  optional    source of notification (valid for notify projects)
'    [s(u)ccess]       optional    log successfully found addresses (default:FALSE)
'    [(d)isallow]      optional    log addresses not fetched due to restrictions (default:FALSE)
'    [comple(x)]       optional    allow complex addresses (urls with wildcards) (default:?)
'    [(e)xtensionrule]       optional     should extensions be crawled or avoided?(default:CRAWL)
'
'
'
'+----------------------------------------------------------------------------

function SetConfig()
 
    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim objBuildCatalog, objLogs

    Dim bForceMerge
    Dim lCrawlInterval
    Dim nProjectType
    Dim szNotification
    Dim bSuccess, bDisallow, bComplex, bPropLimit, bExtensionsAvoided
    Dim nPropLimit, nLogs
    Dim msgstr

    On Error Resume Next

    DBG( "SetConfig" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_SET_CONFIG, SYNTAX_OP_SET_CONFIG )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_SET_CONFIG, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the properties from the command line

    lCrawlInterval = utilGetArg( L_CrawlInterval_ArgumentName, SYNTAX_OP_SET_CONFIG, vbLong )
    if IsEmpty(lCrawlInterval) then exit function    

    bForceMerge = utilGetArg( L_ForceMerge_ArgumentName, SYNTAX_OP_SET_CONFIG, vbBoolean )
    if IsEmpty(bForceMerge) then exit function    

    nProjectType = utilGetArg( L_Projecttype_ArgumentName, SYNTAX_OP_SET_CONFIG, vbProjectType )
    if IsEmpty(nProjectType) then exit function

    szNotification = utilGetArg( L_Notification_ArgumentName, SYNTAX_OP_SET_CONFIG, vbString)
    if IsEmpty(szNotification) then exit function

    bSuccess = utilGetArg( L_Success_ArgumentName, SYNTAX_OP_SET_CONFIG, vbBoolean )
    if IsEmpty(bSuccess) then exit function

    bDisallow = utilGetArg( L_Disallow_ArgumentName, SYNTAX_OP_SET_CONFIG, vbBoolean )
    if IsEmpty(bDisallow) then exit function

    bComplex = utilGetArg( L_Complex_ArgumentName, SYNTAX_OP_SET_CONFIG, vbBoolean )
    if IsEmpty(bComplex) then exit function

    nPropLimit = utilGetArg( L_Limit_ArgumentName, SYNTAX_OP_SET_CONFIG, vbLong )
    if IsEmpty(nPropLimit) then exit function

    nLogs = utilGetArg( L_Logs_ArgumentName, SYNTAX_OP_SET_CONFIG, vbLong )
    if IsEmpty(nLogs) then exit function

    bExtensionsAvoided = utilGetArg( L_ExtensionRule_ArgumentName, SYNTAX_OP_SET_CONFIG, vbExtenRuleType )
    if IsEmpty(bExtensionsAvoided) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_SET_CONFIG, SYNTAX_OP_SET_CONFIG)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' set the properties

    if (IsNull(nPropLimit) = FALSE) then
        if (nPropLimit = 0) then
            objBuildCatalog.AutoPropLimitEnabled = FALSE
        else
            if (nPropLimit < DEFAULT_PROPLIMIT) then
                msgstr = L_InvalidProplimitA_ErrorMessage
                msgstr = replace(msgstr, "%1",  CStr(nPropLimit) )
                msgstr = replace(msgstr, "%2",  CStr(DEFAULT_PROPLIMIT))
                wscript.Echo  msgstr
                exit function
            end if
            objBuildCatalog.AutoPropLimitEnabled = TRUE
            objBuildCatalog.AutoPropLimit = nPropLimit
        end if
    end if
    

    if (IsNull(nLogs) = FALSE) then 
        set objLogs = objBuildCatalog.Logs
        objLogs.MaxLogs = nLogs
    end if

    if (IsNull(lCrawlInterval) = FALSE) then objBuildCatalog.CrawlInterval = lCrawlInterval
    if (IsNull(bForceMerge) = FALSE) then objBuildCatalog.ForceMerge(1)
    if (IsNull(nProjectType) = FALSE) then objBuildCatalog.ProjectType = nProjectType
    if (IsNull(szNotification) = FALSE) then objBuildCatalog.NotificationSource = szNotification
    if (IsNull(bSuccess) = FALSE) then objBuildCatalog.LogSuccess = bSuccess
    if (IsNull(bDisallow) = FALSE) then objBuildCatalog.LogExcluded = bDisallow
    if (IsNull(bComplex) = FALSE) then objBuildCatalog.FollowComplexUrls = bComplex
    if (IsNull(bExtensionsAvoided) = FALSE) then 
        Dim objFiletypes
        set objFiletypes = objBuildCatalog.Extensions
        objFileTypes.IncludedExtensions = Not bExtensionsAvoided
    end if
    if (Err.Number <> 0) then
        call dispError()
    end if


   ' display success

    msgstr = L_SuccessSetConfigA_Message
    msgstr = replace(msgstr, "%1",  szCatalog )
    msgstr = replace(msgstr, "%2",  objHost.HostName)
    wscript.Echo  msgstr
    wscript.Echo

    ' display results 

    call dispCatalogName( objBuildCatalog )
    call dispBuildCatalogConfig( objBuildCatalog )
    call dispBuildCatalogProtocols( objBuildCatalog )

end function

'+----------------------------------------------------------------------------
'
'   Function:   SetPath
'
'   Synopsis:   Set a path to the specified site. 
'
'   Parameters:  
'
'        <path>          required    path the add to site
'        <site>          required    the site to add
'        <catalog>       required    catalog site (with path) exists on
'        [allow]         optional    allow this path
'        [subdir]        optional    follow subdirectories
'
'   Syntax:
'
'       sssadmin set path   </site:site name> </catalog:catalog name> </path:path> 
'                           </allow:TRUE|FALSE> </subdir:TRUE|FALSE> 
'
'
'
'+----------------------------------------------------------------------------

function SetPath()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog, szSite, szPath
    Dim objBuildCatalogs, objBuildCatalog
    Dim objSites, objSite
    Dim objPaths, objPath
    Dim bAllow, bSubdir
    Dim msgstr

    On Error Resume Next

    DBG( "SetPath" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_SET_PATH, SYNTAX_OP_SET_PATH )
    if ( bIsHelp ) then exit function
 
    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_SET_PATH, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the site name from the command line
    
    szSite = utilGetRequiredArg( L_Site_ArgumentName, SYNTAX_OP_SET_PATH, vbString )
    if IsEmpty(szSite) then exit function

    ' get the path from the command line
    
    szPath = utilGetRequiredArg( L_Path_ArgumentName, SYNTAX_OP_SET_PATH, vbString )
    if IsEmpty(szPath) then exit function

    ' get the parameters

    bAllow = utilGetArg( L_Allow_ArgumentName, SYNTAX_OP_SET_PATH, vbBoolean )
    if IsEmpty(bAllow) then exit function

    bSubdir = utilGetArg( L_Subdir_ArgumentName, SYNTAX_OP_SET_PATH, vbBoolean )
    if IsEmpty(bSubdir) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_SET_PATH, SYNTAX_OP_SET_PATH)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the sites collection (for this catalog)

    set objSites = objBuildCatalog.Sites
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' get the specified site

    set objSite = objSites.Item( szSite )
    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then
            msgstr = L_NotExistSiteA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szSite )
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
        else
            dispError()
        end if
        exit function
    end if

    ' get the collection of paths

    set objPaths = objSite.Paths
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' get the specified path

    set objPath = objPaths.Item( szPath )
    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then

            ' add new path if not found
    
            Err.Number = 0
            DBG "Adding the path"
            set objPath = objPaths.Add( szPath, ADD_PATH_DEFAULT_INCLUDE )
            if (Err.Number <> 0) then
                if (Err.Number = E_OBJECTEXISTS) then
		    Err.Number = 0

		    ' attempt to match whatever transformation the gatherer
		    ' does when it adds a path and find the path again

		    if (InStr(szPath, "\\") =1) Or (InStr (szPath, "file:") = 1) then

			' this is a file path, add file: and fix any slashes 
			' which are going the wrong way
		        szNewPath = replace( szPath, "/", "\")
			if (InStr (szPath, "file:") <> 1) then
			    szNewPath = "file:" + szNewPath
                        end if

			' special case for localhost: add /// after file:
			' and remove one \, if there is one
			if (szSite = "localhost") then
                            szNewPath = replace (szNewPath, "file:\", "file:") 
                            szNewPath = replace (szNewPath, "file:", "file:///") 
			end if

		    else 

		        ' try to fix the address, assuming it is an http 
			' address
		        Dim szNewPath, nPos, szPrefix, szSitePrefix

			' make all slashes forward slashes
		        szNewPath = replace( szPath, "\", "/")

			' get the portion of the path which does not include
			' http: or //<site_name>

    		        szNewPath = replace(szNewPath, "http:", "")

			szSitePrefix = "//" + szSite
    		        nPos = InStr(szNewPath, szSitePrefix)
		        if ( (nPos = 1) ) then
                            szNewPath = replace(szNewPath, szSitePrefix, "", 1,1)
			end if			

			' the remaining path should start with a slash

    		        nPos = InStr(szNewPath, "/")
		        if ( (nPos <> 1) ) then
			    szNewPath = "/" + szNewPath 
		        end if

			' the gatherer leaves out the site if it is localhost

			if Not (szSite = "localhost") then
			    szNewPath = szSite + szNewPath
			end if

			' add in http://

		        szNewPath = "http://" + szNewPath
			
		    end if

		    DBG "Full http path is: " + szNewPath

		    set objPath = objPaths.Item( szNewPath )
		    if (Err.Number <> 0) then
                        msgstr = L_NotFoundPathA_ErrorMessage
                        msgstr = replace(msgstr, "%1",  szPath )
                        wscript.Echo  msgstr
                        wscript.Echo L_GetPathHelp_Message
                        exit function
		    end if
		else
                    dispError()
                    exit function
                end if
            end if

        else

            ' report an error

            dispError()
            exit function

        end if
    end if

    ' set the properties

    if (IsNull(bAllow) = FALSE)  then objPath.Included       = bAllow
    if (IsNull(bSubdir) = FALSE) then objPath.IncludeSubdirs = bSubdir

    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' display the results

    msgstr = L_SuccessSetPathA_Message
    msgstr = replace(msgstr, "%1",  szPath )
    msgstr = replace(msgstr, "%2",  szSite)
    wscript.Echo  msgstr
    wscript.Echo
        
    call dispPathName( objPath )
    call dispPathConfig( objPath )

end function

'+----------------------------------------------------------------------------
'
'   Function:   SetBuildEnv
'
'   Synopsis:   Set the build environment. 
'
'   Parameters: 
'
'       [c(o)ntact]     optional    email address used when gathering content
'       [usera(g)ent]   optional    user agent used when gathering content
'       [(t)emppath]    optional    temporary path
'       [p(e)rformance] optional    performance level: 1 (background) -> 5 (dedicated)
'       [t(i)meout]     optional    timeout for gathering a particular address
'       [(d)atatimeout] optional    timeout for data for a partciular address
'       [(u)ser]        optional    account name for the build service
'       [proppass(w)ord]optional    password for prop account name
'       [(p)assword]    optional    password for build account name
'       [plugi(n)user]  optional    account name for the plugin
'
'
'
'+----------------------------------------------------------------------------

function SetBuildEnv()
 
    Dim bIsHelp, bInvalidArgs
    Dim szUser, szPassword, szPropPassword, szPluginUser
    Dim szContact, szUserAgent, szTempPath, szLocation
    Dim nPerformance, nTimeout, nDataTimeout
    Dim msgstr

    On Error Resume Next

    DBG( "SetBuildEnv" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_SET_BUILDENV, SYNTAX_OP_SET_BUILDENV )
    if (bIsHelp) then
        exit function
    end if

    ' get the parameters

    szContact = utilGetArg( L_Contact_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbString)
    if IsEmpty(szContact) then exit function

    szUserAgent = utilGetArg( L_Useragent_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbString)
    if IsEmpty(szUserAgent) then exit function

    szTempPath = utilGetArg( L_Temppath_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbString)
    if IsEmpty(szTempPath) then exit function

    nPerformance = utilGetArg( L_Performance_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbPerformanceType )
    if IsEmpty(nPerformance) then exit function

    szLocation = utilGetArg( L_Location_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbString)
    if IsEmpty(szLocation) then exit function

    nTimeout = utilGetArg( L_Timeout_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbLong)
    if IsEmpty(nTimeout) then exit function

    nDataTimeout = utilGetArg( L_Datatimeout_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbLong)
    if IsEmpty(nDataTimeout) then exit function

    szUser = utilGetArg( L_User_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbString )
    if IsEmpty(szUser) then exit function

    szPluginUser = utilGetArg( L_Pluginuser_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbString )
    if IsEmpty(szPluginUser) then exit function

    szPropPassword = utilGetArg( L_PropPassword_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbString )
    if IsEmpty(szPropPassword) then exit function

    szPassword = utilGetArg( L_Password_ArgumentName, SYNTAX_OP_SET_BUILDENV, vbString )
    if IsEmpty(szPassword) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_SET_BUILDENV, SYNTAX_OP_SET_BUILDENV)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' set the parameters

    if (IsNull(szTempPath) <> TRUE) then 
        objBuildServer.TempPath = szTempPath
        if (Err.Number = E_INVALIDPATH) then
            wscript.Echo L_InvalidPathA_ErrorMessage + szTempPath + L_InvalidPathB_ErrorMessage + L_Temppath_ArgumentName
            exit function
        end if
    end if

    if (IsNull(szLocation) <> TRUE) then 
        objBuildServer.DefaultCatalogsLocation = szLocation
        if (Err.Number = E_INVALIDPATH) then
            wscript.Echo L_InvalidPathA_ErrorMessage + szLocation + L_InvalidPathB_ErrorMessage + L_Location_ArgumentName
            exit function
        end if
    end if

    if (IsNull(szContact) <> TRUE) then objBuildServer.EmailAddress = szContact
    if (IsNull(szUserAgent) <> TRUE) then objBuildServer.UserAgent = szUserAgent
    if (IsNull(nPerformance) <> TRUE) then objBuildServer.PerformanceLevel = nPerformance

    if (IsNull(nTimeout) <> TRUE) then 
        if (nTimeout <= 0) then
            msgstr = L_NullConnectTimeoutAWarning_Message
            msgstr = replace(msgstr, "%1",  CStr(BUILDENV_TIMEOUT_DEFAULT) )
            wscript.Echo  msgstr
            wscript.Echo
            nTimeout = BUILDENV_TIMEOUT_DEFAULT
        end if
        objBuildServer.ConnectTimeout = nTimeout
    end if

    if (IsNull(nDataTimeout) <> TRUE) then 
        if (nDataTimeout <= 0) then
            msgstr = L_NullDataTimeoutAWarning_Message
            msgstr = replace(msgstr, "%1",  CStr(BUILDENV_DATA_TIMEOUT_DEFAULT) )
            wscript.Echo  msgstr
            wscript.Echo
            nDataTimeout = BUILDENV_DATA_TIMEOUT_DEFAULT
        end if
        objBuildServer.DataTimeout = nDataTimeout
    end if

    if (IsNull(szUser) <> TRUE) then
        if IsNull(szPassword) then szPassword = ""
        call objBuildServer.SetDefaultAccount( szUser, szPassword )
    end if
    if (IsNull(szPluginUser) <> TRUE) then
        if IsNull(szPropPassword) then szPropPassword = ""
        call objBuildServer.SetDefaultPluginAccount( szPluginUser, szPropPassword )
    end if

    if (Err.Number <> 0) then
        call dispError()
        exit function
    end if

    ' display the results

    msgstr = L_SuccessSetBuildenv_Message
    msgstr = replace(msgstr, "%1",  objHost.HostName)
    wscript.Echo  msgstr
    wscript.Echo

    call dispBuildServerName()
    call dispBuildServerConfig()       

end function

'+----------------------------------------------------------------------------
'
'   Function:   SetSearchEnv
'
'   Synopsis:   Set the search environment. 
'
'   Parameters:  
'
'       [p(e)rformance] optional    performance level: 1 (background) -> 5 (dedicated)
'       [(l)ocation]    optional    default location for catalogs
'       [(d)efault]     optional    specifies the default catalog
'
'   Syntax:
'           sssadmin set searchenv [performance:number] [location:path]
'
'
'
'+----------------------------------------------------------------------------

function SetSearchEnv()
 
    Dim bIsHelp, bInvalidArgs
    Dim szLocation, szCatalog
    Dim nPerformance

    On Error Resume Next

    DBG( "SetSearchEnv" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_SET_SEARCHENV, SYNTAX_OP_SET_SEARCHENV )
    if (bIsHelp) then
        exit function
    end if

    ' get the parameters

    nPerformance = utilGetArg( L_Performance_ArgumentName, SYNTAX_OP_SET_SEARCHENV, vbPerformanceType )
    if IsEmpty(nPerformance) then exit function

    szLocation = utilGetArg( L_Location_ArgumentName, SYNTAX_OP_SET_SEARCHENV, vbString)
    if IsEmpty(szLocation) then exit function

    szCatalog = utilGetArg( L_Default_ArgumentName, SYNTAX_OP_SET_SEARCHENV, vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_SET_SEARCHENV, SYNTAX_OP_SET_SEARCHENV)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' set the parameters

    if (IsNull(szLocation) <> TRUE) then 
        objSearchServer.CatalogsLocation = szLocation
        if (Err.Number = E_INVALIDPATH) then
            wscript.Echo L_InvalidPathA_ErrorMessage + szLocation + L_InvalidPathB_ErrorMessage + L_Location_ArgumentName
            exit function
        end if
    end if

    if (IsNull(nPerformance) <> TRUE) then objSearchServer.PerformanceLevel = nPerformance

    if (IsNull(szCatalog) <> TRUE) then objSearchServer.DefaultCatalog = szCatalog

    if (Err.Number <> 0) then
        call dispError()
        exit function
    end if

    ' display the results

    Dim msgstr
    msgstr = L_SuccessSetSearchenv_Message
    msgstr = replace(msgstr, "%1",  objHost.HostName)
    wscript.Echo  msgstr
    wscript.Echo

    call dispSearchServerName()
    call dispSearchServerConfig()       

end function

'+----------------------------------------------------------------------------
'
'   Function:   SetProtocol
'
'   Synopsis:   Sets the protocols for a specified site. 
'
'   Parameters:  
'
'       <catalog>       required    catalog containing protocols to set
'       <protocol>      required    protocol whose properties to set
'       <include>       required    this protocol should be included
'
'   Syntax:
'
'       sssadmin set protocol </catalog:catalog name> </protocol:protocol>
'                             </include:TRUE|FALSE>
'
'
'
'+----------------------------------------------------------------------------

function SetProtocol()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog, szProtocol
    Dim objBuildCatalogs, objBuildCatalog
    Dim objProtocols, objProtocol
    Dim bInclude
    Dim szHandler
    Dim msgstr

    On Error Resume Next

    DBG( "SetProtocol" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_SET_PROTOCOL, SYNTAX_OP_SET_PROTOCOL)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_SET_PROTOCOL, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the protocol from the command line

    szProtocol = utilGetRequiredArg( L_Protocol_ArgumentName, SYNTAX_OP_SET_PROTOCOL, vbString )
    if IsEmpty(szProtocol) then exit function

    ' get the property to set

    bInclude = utilGetRequiredArg( L_Include_ArgumentName, SYNTAX_OP_SET_PROTOCOL, vbBoolean )
    if IsEmpty(bInclude) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_SET_PROTOCOL, SYNTAX_OP_SET_PROTOCOL)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the protocols collection (for this catalog)

    set objProtocols = objBuildCatalog.Protocols
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' get the specified protocol

    set objProtocol = objProtocols.Item( szProtocol )
    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then
            msgstr = L_NotExistProtocolA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szProtocol )
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
        else
            dispError()
        end if
        exit function
    end if

    ' set the property

    if (IsNull(bInclude) <> TRUE) then objProtocol.Included = bInclude
    if (Err.Number <> 0) then
        call dispError()
        exit function
    end if

    ' display the results

    msgstr = L_SuccessSetProtocolA_Message
    msgstr = replace(msgstr, "%1",  szProtocol )
    msgstr = replace(msgstr, "%2",  szCatalog)
    wscript.Echo  msgstr
    wscript.Echo

    call dispProtocolName( objProtocol )
    call dispProtocolConfig( objProtocol )

end function


'+----------------------------------------------------------------------------
'
'   Function:   SetProxy
'
'   Synopsis:   Set the proxy settings. 
'
'
'
'+----------------------------------------------------------------------------

function SetProxy()
 
    Dim bIsHelp, bInvalidArgs
    Dim szProxyType, szServer, szExceptions
    Dim nProxyType, nPort
    Dim bBypass, nBypass

    On Error Resume Next

    DBG( "SetProxy" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_SET_PROXY, SYNTAX_OP_SET_PROXY )
    if (bIsHelp) then
        exit function
    end if

    ' get the parameters

    szProxyType = utilGetRequiredArg( L_Proxy_ArgumentName, SYNTAX_OP_SET_PROXY, vbProxyType )
    if IsEmpty(szProxyType) then exit function

    ' get remaing parameters based on proxy type

    select case szProxyType

        case L_TypeNone_Text

            nProxyType = PROXY_TYPE_NONE

        case L_TypeSystem_Text

            nProxyType = PROXY_TYPE_SYSTEM

        case L_TypeCustom_Text

            nProxyType = PROXY_TYPE_CUSTOM

            ' get required arguments

            szServer = utilGetRequiredArg( L_Server_ArgumentName, SYNTAX_OP_SET_PROXY, vbString )
            if IsEmpty(szServer) then exit function

            ' get optional arguments

            nPort = utilGetArg( L_Port_ArgumentName, SYNTAX_OP_SET_PROXY, vbLong )
            if IsEmpty(nPort) then exit function

            bBypass = utilGetArg( L_Bypass_ArgumentName, SYNTAX_OP_SET_PROXY, vbBoolean)
            if IsEmpty(bBypass) then exit function

            szExceptions = utilGetArg( L_Except_ArgumentName, SYNTAX_OP_SET_PROXY, vbString )
            if IsEmpty(szExceptions) then exit function

    end select
         
    bInvalidArgs = utilInvalidArgs(HELP_OP_SET_PROXY, SYNTAX_OP_SET_PROXY)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' set the parameters

    if IsNull(szServer) then szServer = ""
    if IsNull(nPort) then 
        nPort = objBuildServer.ProxyPortNumber
        if (nPort = 0) then nPort = DEFAULT_PROXY_PORT
    end if
    if IsNull(szExceptions) then szExceptions = objBuildServer.ProxyBypassAddressesList
    if IsNull(bBypass) then  
        nBypass = objBuildServer.ProxyBypassForLocalAddresses
    else
        if (bBypass) then
            nBypass = 1
        else
            nBypass = 0
        end if
    end if

    call objBuildServer.SetProxySettings( nProxyType, szServer, nPort, nBypass, szExceptions )

    ' check if any errors

    if (Err.Number <> 0) then
        call dispError()
        exit function
    end if

    ' display the results

    wscript.Echo L_SuccessSetProxy_Message + objHost.HostName
    wscript.Echo

    call dispBuildServerProxy()       

end function

'----------------------------  Add Functions  -------------------------------'

'+----------------------------------------------------------------------------
'
'   Function:   AddCatalog
'
'   Synopsis:   Add (create) a catalog. 
'
'   Parameters:  
'
'       <catalog name>  required    name for catalog
'
'
'
'+----------------------------------------------------------------------------

function AddCatalog()
 
    Dim bIsHelp, bInvalidArgs, bBuild, bSearch
    Dim szCatalog
    Dim objBuildCatalog, objBuildCatalogs, objSearchCatalog, objSearchCatalogs
    Dim msgstr

    On Error Resume Next

    DBG( "AddCatalog" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_ADD_CATALOG, SYNTAX_OP_ADD_CATALOG)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the catalog from the command line
    
    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_ADD_CATALOG, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the parameters

    bBuild = utilGetArg( L_Build_ArgumentName, SYNTAX_OP_ADD_CATALOG, vbBoolean )
    if IsEmpty(bBuild) then exit function
    if IsNull(bBuild) then bBuild = TRUE

    bSearch = utilGetArg( L_Search_ArgumentName, SYNTAX_OP_ADD_CATALOG, vbBoolean )
    if IsEmpty(bSearch) then exit function
    if IsNull(bSearch) then bSearch = FALSE

    bInvalidArgs = utilInvalidArgs(HELP_OP_ADD_CATALOG, SYNTAX_OP_ADD_CATALOG)
    if ( bInvalidArgs ) then
        exit function
    end if

	if ( bBuild ) then
		' get the collection of build catalogs

		Set objBuildCatalogs = objBuildServer.BuildCatalogs
		if (Err.Number <> 0) then
		    dispError()
			exit function
		end if

        ' add the catalog to the collection

        set objBuildCatalog = objBuildCatalogs.Add( szCatalog, "" )
        if (Err.Number <> 0) then
            if (Err.Number = E_OBJECTEXISTS) then
                msgstr = L_ExistBuildCatalogA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szCatalog )
                msgstr = replace(msgstr, "%2",  objHost.HostName)
                wscript.Echo  msgstr
            elseif (Err.Number = E_CATALOGNAMEINVALID) then
                wscript.Echo L_InvalidCatalogName_ErrorMessage + szCatalog
            else
                dispError()
            end if
            exit function
        end if

        ' display the results

        msgstr = L_SuccessAddBuildCatalogA_Message
        msgstr = replace(msgstr, "%1",  szCatalog )
        msgstr = replace(msgstr, "%2",  objHost.HostName)
        wscript.Echo  msgstr
        wscript.Echo

        dispCatalogName( objBuildCatalog )
        dispBuildCatalogConfig( objBuildCatalog )

	end if
                
	if ( bSearch ) then
		' get the collection of build catalogs

		Set objSearchCatalogs = objSearchServer.SearchCatalogs
		if (Err.Number <> 0) then
		    dispError()
			exit function
		end if

        ' add the catalog to the collection

        set objSearchCatalog = objSearchCatalogs.Add( szCatalog )
        if (Err.Number <> 0) then
            if (Err.Number = E_FILEEXISTS) then
                msgstr = L_ExistSearchCatalogA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szCatalog )
                msgstr = replace(msgstr, "%2",  objHost.HostName)
                wscript.Echo  msgstr
            elseif (Err.Number = E_SEARCHCATALOGNAMEINVALID) then
                wscript.Echo L_InvalidCatalogName_ErrorMessage + szCatalog
            else
                dispError()
            end if
            exit function
        end if

        ' display the results

        msgstr = L_SuccessAddSearchCatalogA_Message
        msgstr = replace(msgstr, "%1",  szCatalog )
        msgstr = replace(msgstr, "%2",  objHost.HostName)
        wscript.Echo  msgstr
        wscript.Echo

        dispCatalogName( objSearchCatalog )
        dispSearchCatalogConfig( objSearchCatalog )

	end if

    wscript.echo
    wscript.echo L_NoPropTargetWarning_Message

end function


'+----------------------------------------------------------------------------
'
'   Function:   AddMapping
'
'   Synopsis:   Add the mapping for a specified catalog. 
'
'   Parameters:  
'
'        <catalog>       required    catalog to add mapping to
'        <from>          required    from part of mapping
'        <to>            required    to part of mapping 
'
'
'
'+----------------------------------------------------------------------------

function AddMapping()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim szFrom, szTo
    Dim objBuildCatalogs, objBuildCatalog
    Dim objMappings, objMapping
    Dim msgstr

    On Error Resume Next

    DBG( "AddMapping" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_ADD_MAPPING, SYNTAX_OP_ADD_MAPPING )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog from the command line
    
    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_ADD_MAPPING, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the 'from' argument

    szFrom = utilGetRequiredArg( L_From_ArgumentName, SYNTAX_OP_ADD_MAPPING, vbString )
    if IsEmpty(szFrom) then exit function

    ' get the 'to' argument

    szTo = utilGetRequiredArg( L_To_ArgumentName, SYNTAX_OP_ADD_MAPPING, vbString )
    if IsEmpty(szTo) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_ADD_MAPPING, SYNTAX_OP_ADD_MAPPING)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the mappings collection

    set objMappings = objBuildCatalog.Mappings
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' add this mapping to the collection

    set objMapping = objMappings.Add( szFrom, szTo )
    if (Err.Number <> 0) then
        if (Err.Number = E_OBJECTEXISTS) then
            msgstr = L_ExistMappingA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szFrom )
            msgstr = replace(msgstr, "%2",  szTo )
            msgstr = replace(msgstr, "%3",  szCatalog )
            wscript.Echo  msgstr
        else
            dispError()
        end if
        exit function
    end if

    ' display the results

    msgstr = L_SuccessAddMappingA_Message
    msgstr = replace(msgstr, "%1",  szFrom )
    msgstr = replace(msgstr, "%2",  szTo )
    wscript.Echo  msgstr
    wscript.Echo

    call dispCatalogName( objBuildCatalog )
    call dispBuildCatalogMappings( objBuildCatalog )

end function

'+----------------------------------------------------------------------------
'
'   Function:   AddFileType
'
'   Synopsis:   Add the filetype for a specified catalog. 
'
'   Parameters:  
'
'        <catalog>       required    catalog to add mapping to
'        <filetype>      required    filetype to add to catalog
'
'
'
'+----------------------------------------------------------------------------

function AddFileType()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim szFiletype
    Dim objBuildCatalogs, objBuildCatalog
    Dim objFiletypes, objFiletype
    Dim msgstr

    On Error Resume Next

    DBG( "AddFileType" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_ADD_FILETYPE, SYNTAX_OP_ADD_FILETYPE )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog from the command line
    
    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_ADD_FILETYPE, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the filetype from the command line

    szFiletype = utilGetRequiredArg( L_Filetype_ArgumentName, SYNTAX_OP_ADD_FILETYPE, vbString )
    if IsEmpty(szFiletype) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_ADD_FILETYPE, SYNTAX_OP_ADD_FILETYPE)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the collection of search servers

    set objFiletypes = objBuildCatalog.Extensions
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' add this mapping to the collection

    set objFiletype = objFiletypes.Add( szFiletype )
    if (Err.Number <> 0) then
        if (Err.Number = E_OBJECTEXISTS) then
            msgstr = L_ExistFiletypeA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szFiletype )
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
        else
            dispError()
        end if
        exit function
    end if

    ' display the results

    msgstr = L_SuccessAddFiletypeA_Message
    msgstr = replace(msgstr, "%1",  szFiletype )
    msgstr = replace(msgstr, "%2",  szCatalog)
    wscript.Echo  msgstr
    wscript.Echo

    ' display info

    call dispCatalogName( objBuildCatalog )
    call dispBuildCatalogFileTypes( objBuildCatalog )

end function

'+----------------------------------------------------------------------------
'
'   Function:   AddSearchServer
'
'   Synopsis:   Adds the specifed search server to the specified catalog. 
'
'   Parameters:  
'
'        <catalog>       required    catalog to add searchserver to
'        <search server> required    search server to add to catalog
'
'
'
'+----------------------------------------------------------------------------

function AddSearchServer()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim szSearchServer
    Dim objBuildCatalogs, objBuildCatalog
    Dim lobjSearchServers, lobjSearchServer
    Dim msgstr

    On Error Resume Next

    DBG( "AddSearchServer" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_ADD_SEARCHSERVER, SYNTAX_OP_ADD_SEARCHSERVER )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_ADD_SEARCHSERVER, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the search server from the command line
    
    szSearchServer = utilGetRequiredArg( L_Searchserver_ArgumentName, SYNTAX_OP_ADD_SEARCHSERVER, vbString )
    if IsEmpty(szSearchServer) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_ADD_SEARCHSERVER, SYNTAX_OP_ADD_SeARCHSERVER)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the search server collection (for this catalog)

    set lobjSearchServers = objBuildCatalog.SearchServers
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' add the search server

    wscript.Echo L_StatusAddingSearchserver_Message
    set lobjSearchServer = lobjSearchServers.Add( szSearchServer )
    wscript.Echo
    if (Err.Number <> 0) then
        select case Err.Number
            case E_NOTEXIST       
                msgstr = L_ExistSearchserverA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szSearchServer )
                msgstr = replace(msgstr, "%2",  szCatalog)
                wscript.Echo  msgstr
            case E_OBJECTEXISTS
                msgstr = L_ExistSearchserverA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szSearchServer )
                msgstr = replace(msgstr, "%2",  szCatalog)
                wscript.Echo  msgstr
            case E_CANNOTCONNECT
                wscript.Echo L_ConnectSearchserver_ErrorMessage + szSearchServer
            case E_RPCSERVERUNAVAIL
                wscript.Echo L_UnknownSearchserver_ErrorMessage + szSearchServer
            case else
                dispError()
        end select
        exit function
    end if

    ' display the results

    msgstr = L_SuccessAddSearchserverA_Message
    msgstr = replace(msgstr, "%1",  szSearchServer )
    msgstr = replace(msgstr, "%2",  szCatalog)
    wscript.Echo  msgstr
    wscript.Echo

    ' display search servers for only this catalog

    call dispCatalogName( objBuildCatalog )
    call dispBuildCatalogSearchServers( objBuildCatalog )
    wscript.Echo

end function

'----------------------------  Remove Functions  -------------------------------'

'+----------------------------------------------------------------------------
'
'   Function:   RemoveStartPage
'
'   Synopsis:   Remove a start page from the specified catalog. 
'
'   Parameters:  
'
'       <catalog>       required    catalog to add startpage for
'       <startpage>     required    startpage to add
'
'
'
'+----------------------------------------------------------------------------

function RemoveStartPage()
 
    Dim bIsHelp, bInvalidArgs
    Dim szCatalog, szURL
    Dim objBuildCatalogs, objBuildCatalog
    Dim objStartPages, objStartPage
    Dim msgstr

    On Error Resume Next

    DBG( "RemoveStartPage" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_REMOVE_STARTPAGE, SYNTAX_OP_REMOVE_STARTPAGE)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_REMOVE_STARTPAGE, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the URL from the command line
    
    szURL = utilGetRequiredArg( L_Url_ArgumentName, SYNTAX_OP_REMOVE_STARTPAGE, vbString )
    if IsEmpty(szURL) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_REMOVE_STARTPAGE, SYNTAX_OP_REMOVE_STARTPAGE)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the start page collection

    set objStartPages = objBuildCatalog.StartPages
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' remove the specified url

    objStartPages.Remove szURL
    if (Err.Number <> 0) then
        if (Err.Number = E_OBJNOTEXIST) then
            msgstr = L_NotExistStartpageA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szURL )
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
            wscript.Echo
        else
            dispError()
        end if
        exit function
    end if

    ' display the results

    msgstr = L_SuccessRemoveStartpage_Message
    msgstr = replace(msgstr, "%1",  szURL )
    msgstr = replace(msgstr, "%2",  szCatalog)
    wscript.Echo  msgstr
    wscript.Echo

    call dispCatalogName( objBuildCatalog )
    call dispBuildCatalogStartPages( objBuildCatalog )
                        
end function

'+----------------------------------------------------------------------------
'
'   Function:   RemoveSite
'
'   Synopsis:   Removes a site to the specified catalog. 
'
'   Parameters:  
'       <site>          required    site to add
'       <catalog>       required    catalog to add site to
'
'
'
'+----------------------------------------------------------------------------

function RemoveSite()
 
    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim szSite
    Dim objBuildCatalogs, objBuildCatalog
    Dim objSites, objSite
    Dim msgstr

    On Error Resume Next

    DBG( "RemoveSite" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_REMOVE_SITE, SYNTAX_OP_REMOVE_SITE)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the site name from the command line
    
    szSite = utilGetRequiredArg( L_Site_ArgumentName, SYNTAX_OP_REMOVE_SITE, vbString )
    if IsEmpty(szSite) then exit function

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_REMOVE_SITE, vbString )
    if IsEmpty(szCatalog) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_REMOVE_SITE, SYNTAX_OP_REMOVE_SITE)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the collection of sites

    set objSites = objBuildCatalog.Sites
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if
                
    ' remove the site from the collection

    call objSites.Remove( szSite )
    if (Err.Number <> 0) then
        if (Err.Number = E_OBJNOTEXIST) then
            msgstr = L_NotExistSiteA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szSite )
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
            wscript.Echo
        else
            dispError()
        end if
        exit function
    end if

    ' display the results

    msgstr = L_SuccessRemoveSiteA_Message
    msgstr = replace(msgstr, "%1",  szSite )
    msgstr = replace(msgstr, "%2",  szCatalog)
    wscript.Echo  msgstr
    wscript.Echo

    call dispCatalogName( objBuildCatalog )
    call dispBuildCatalogSites( objBuildCatalog )

end function


'+----------------------------------------------------------------------------
'
'   Function:   RemoveCatalog
'
'   Synopsis:   Remove (delete) a catalog. 
'
'   Parameters:  
'
'       <catalog name>  required    name of catalog
'	<build>	        optional    true(remove build catalog) or false
'	<search>	optional    true(remove search catalog) or false
'
'
'+----------------------------------------------------------------------------

function RemoveCatalog()
 
    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim bBuild, bSearch
    Dim objBuildCatalog, objBuildCatalogs
    Dim objSearchCatalog, objSearchCatalogs
    Dim msgstr

    On Error Resume Next

    DBG( "RemoveCatalog" )

    ' check if help requested

    bIsHelp = utilIsHelp(HELP_OP_REMOVE_CATALOG, SYNTAX_OP_REMOVE_CATALOG)
    if ( bIsHelp ) then
        exit function
    end if

    ' get the catalog from the command line
    
    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_REMOVE_CATALOG, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the parameters

    bBuild = utilGetArg( L_Build_ArgumentName, SYNTAX_OP_REMOVE_CATALOG, vbBoolean )
    if IsEmpty(bBuild) then exit function
    if IsNull(bBuild) then bBuild = TRUE

    bSearch = utilGetArg( L_Search_ArgumentName, SYNTAX_OP_REMOVE_CATALOG, vbBoolean )
    if IsEmpty(bSearch) then exit function
    if IsNull(bSearch) then bSearch = TRUE

    bInvalidArgs = utilInvalidArgs(HELP_OP_REMOVE_CATALOG, SYNTAX_OP_REMOVE_CATALOG)
    if ( bInvalidArgs ) then
        exit function
    end if

    if (bSearch = FALSE) And (bBuild = FALSE) then
        wscript.Echo L_NotRemovedWarning_Message          
    end if

    if bBuild then

        ' get the collection of build catalogs
    
        Set objBuildCatalogs = objBuildServer.BuildCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' remvoe the catalog from the collection

        call objBuildCatalogs.Remove( szCatalog )
        if (Err.Number <> 0) then
            if (Err.Number = E_OBJNOTEXIST) then
                msgstr = L_NotExistBuildcatalogA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szCatalog )
                msgstr = replace(msgstr, "%2",  objHost.HostName)
                wscript.Echo  msgstr
            else
                dispError()
            end if
        else

            ' display the results

            msgstr = L_SuccessRemoveBuildcatalogA_Message
            msgstr = replace(msgstr, "%1",  szCatalog )
            msgstr = replace(msgstr, "%2",  objHost.HostName)
            wscript.Echo  msgstr

        end if

    end if
    
    ' reset error

    Err.Number = 0

    if bSearch then

        ' get the collection of Search catalogs
    
        Set objSearchCatalogs = objSearchServer.SearchCatalogs
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

        ' remvoe the catalog from the collection

        call objSearchCatalogs.Remove( szCatalog )
        if (Err.Number <> 0) then
            if (Err.Number = E_SEARCHNOTEXIST) then
                msgstr = L_NotExistSearchcatalogA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szCatalog )
                msgstr = replace(msgstr, "%2",  objHost.HostName)
                wscript.Echo  msgstr
            else
                dispError()
            end if
        else

            ' display the results

            msgstr = L_SuccessRemoveSearchcatalogA_Message
            msgstr = replace(msgstr, "%1",  szCatalog )
            msgstr = replace(msgstr, "%2",  objHost.HostName)
            wscript.Echo  msgstr

        end if

    end if
                
end function

'+----------------------------------------------------------------------------
'
'   Function:   RemovePath
'
'   Synopsis:   Remove a path to the specified site. 
'
'   Parameters:  
'
'        <path>          required    path the add to site
'        <site>          required    the site to add
'        <catalog>       required    catalog to add site to
'
'
'
'+----------------------------------------------------------------------------

function RemovePath()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog, szSite, szPath
    Dim objBuildCatalogs, objBuildCatalog
    Dim objSites, objSite
    Dim objPaths, objPath
    Dim msgstr

    On Error Resume Next

    DBG( "RemovePath" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_REMOVE_PATH, SYNTAX_OP_REMOVE_PATH )
    if ( bIsHelp ) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_REMOVE_PATH, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the site name from the command line
    
    szSite = utilGetRequiredArg( L_Site_ArgumentName, SYNTAX_OP_REMOVE_PATH, vbString )
    if IsEmpty(szSite) then exit function

    ' get the path from the command line
    
    szPath = utilGetRequiredArg( L_Path_ArgumentName, SYNTAX_OP_REMOVE_PATH, vbString )
    if IsEmpty(szPath) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_REMOVE_PATH, SYNTAX_OP_REMOVE_PATH)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the sites collection (for this catalog)

    set objSites = objBuildCatalog.Sites
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' get the specified site

    set objSite = objSites.Item( szSite )
    if (Err.Number <> 0) then
        if (Err.Number = E_NOTEXIST) then
            msgstr = L_NotExistSiteA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szSite )
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
        else
            dispError()
        end if
        exit function
    end if

    ' get the collection of paths

    set objPaths = objSite.Paths
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' remove the path

    objPaths.Remove szPath
    if (Err.Number <> 0) then
        if (Err.Number = E_OBJNOTEXIST) then
            msgstr = L_NotExistPathA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szPAth )
            msgstr = replace(msgstr, "%2",  szSite)
            wscript.Echo  msgstr
            wscript.Echo
        else
            dispError()
        end if
        exit function
    end if

    ' display the results

    msgstr = L_SuccessRemovePathA_Message
    msgstr = replace(msgstr, "%1",  szPath)
    msgstr = replace(msgstr, "%2",  szSite)
    wscript.Echo  msgstr
    wscript.Echo

end function

'+----------------------------------------------------------------------------
'
'   Function:   RemoveTiming
'
'   Synopsis:   Reverst the timing for a site back to the default. 
'
'   Parameters:  
'
'        <site>       required    site to removing timing for
'
'
'
'+----------------------------------------------------------------------------

function RemoveTiming()
 
    Dim bIsHelp, bInvalidArgs
    Dim szSite, szTiming
    Dim objSites, objSite
    Dim nTiming
    Dim msgstr

    On Error Resume Next

    DBG( "RemoveTiming" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_REMOVE_TIMING, SYNTAX_OP_REMOVE_TIMING )
    if (bIsHelp) then
        exit function
    end if

   ' get the site from the command line
    
    szSite = utilGetRequiredArg( L_Site_ArgumentName, SYNTAX_OP_REMOVE_TIMING, vbString )
    if IsEmpty(szSite) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_REMOVE_TIMING, SYNTAX_OP_REMOVE_TIMING)
    if ( bInvalidArgs ) then
        exit function
    end if

   ' get the collection of sites

    set objSites = objBuildServer.Sites
    if (Err.Number <> 0) then
        dispError()
       exit function
    end if

    ' remove the timing for this site

    objSites.Remove szSite 
    if (Err.Number <> 0) then
        if (Err.Number = E_WRITEREGISTRY) then
            msgstr = L_NotExistTimingA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szSite )
            msgstr = replace(msgstr, "%2",  objHost.HostName)
            wscript.Echo  msgstr
            wscript.Echo
        else
            dispError()
        end if
        exit function
    end if


    ' display success

    msgstr = L_SuccessRemoveTimingA_Message
    msgstr = replace(msgstr, "%1",  szSite )
    msgstr = replace(msgstr, "%2",  objHost.HostName)
    wscript.Echo  msgstr
    wscript.Echo

end function

'+----------------------------------------------------------------------------
'
'   Function:   RemoveMapping
'
'   Synopsis:   Remove the mapping for a specified catalog. 
'
'   Parameters:  
'
'        <catalog>       required    catalog to add mapping to
'        <from>          required    from part of mapping
'        <to>            required    to part of mapping 
'
'
'
'+----------------------------------------------------------------------------

function RemoveMapping()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim szFrom, szTo
    Dim objBuildCatalogs, objBuildCatalog
    Dim objMappings, objMapping
    Dim msgstr

    On Error Resume Next

    DBG( "RemoveMapping" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_REMOVE_MAPPING, SYNTAX_OP_REMOVE_MAPPING )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog from the command line
    
    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_REMOVE_MAPPING, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the 'from' argument

    szFrom = utilGetRequiredArg( L_From_ArgumentName, SYNTAX_OP_REMOVE_MAPPING, vbString )
    if IsEmpty(szFrom) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_REMOVE_MAPPING, SYNTAX_OP_REMOVE_MAPPING)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the mappings collection

    set objMappings = objBuildCatalog.Mappings
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' remove this mapping from the collection

    objMappings.Remove( szFrom )
    if (Err.Number <> 0) then
        if (Err.Number = E_OBJNOTEXIST) then
            msgstr = L_NotExistMappingA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szFrom  )
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
        else
            dispError()
        end if
        exit function
    end if

    ' display the results

    msgstr = L_SuccessRemoveMappingA_Message
    msgstr = replace(msgstr, "%1",  szFrom )
    msgstr = replace(msgstr, "%2",  szCatalog)
    wscript.Echo  msgstr
    wscript.Echo

end function

'+----------------------------------------------------------------------------
'
'   Function:   RemoveFileType
'
'   Synopsis:   Remove the filetype for a specified catalog. 
'
'   Parameters:  
'
'        <catalog>       required    catalog to add mapping to
'        <filetype>      required    filetype to add to catalog
'
'
'
'+----------------------------------------------------------------------------

function RemoveFileType()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim szFiletype
    Dim objBuildCatalogs, objBuildCatalog
    Dim objFiletypes
    Dim msgstr

    On Error Resume Next

    DBG( "RemoveFileType" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_REMOVE_FILETYPE, SYNTAX_OP_REMOVE_FILETYPE )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog from the command line
    
    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_REMOVE_FILETYPE, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the filetype from the command line

    szFiletype = utilGetRequiredArg( L_Filetype_ArgumentName, SYNTAX_OP_REMOVE_FILETYPE, vbString )
    if IsEmpty(szFiletype) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_REMOVE_FILETYPE, SYNTAX_OP_REMOVE_FILETYPE)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the collection of search servers

    set objFiletypes = objBuildCatalog.Extensions
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' remove this mapping from the collection

    objFiletypes.Remove( szFiletype )
    if (Err.Number <> 0) then
        if (Err.Number = E_OBJNOTEXIST) then
            msgstr = L_NotExistFiletypeA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szFiletype )
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
        else
            dispError()
        end if
        exit function
    end if

    ' display the results

    msgstr = L_SuccessRemoveFiletypeA_Message
    msgstr = replace(msgstr, "%1",  szFiletype )
    msgstr = replace(msgstr, "%2",  szCatalog)
    wscript.Echo  msgstr
    wscript.Echo

end function

'+----------------------------------------------------------------------------
'
'   Function:   RemoveSearchServer
'
'   Synopsis:   Removes the specifed search server to the specified catalog. 
'
'   Parameters:  
'
'        <catalog>       required    catalog to add searchserver to
'        <search server> required    search server to add to catalog
'
'
'
'+----------------------------------------------------------------------------

function RemoveSearchServer()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim szSearchServer
    Dim objBuildCatalogs, objBuildCatalog
    Dim lobjSearchServers 
    Dim msgstr

    On Error Resume Next

    DBG( "RemoveSearchServer" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_REMOVE_SEARCHSERVER, SYNTAX_OP_REMOVE_SEARCHSERVER )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_REMOVE_SEARCHSERVER, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the search server from the command line
    
    szSearchServer = utilGetRequiredArg( L_Searchserver_ArgumentName, SYNTAX_OP_REMOVE_SEARCHSERVER, vbString )
    if IsEmpty(szSearchServer) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_REMOVE_SEARCHSERVER, SYNTAX_OP_REMOVE_SEARCHSERVER)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' get the search server collection (for this catalog)

    set lobjSearchServers = objBuildCatalog.SearchServers
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' add the search server
    lobjSearchServers.Remove( szSearchServer )
    if (Err.Number <> 0) then
        if (Err.Number = E_SEARCHSERVERNOTFOUND) then
            msgstr = L_NotExistSearchserverA_ErrorMessage
            msgstr = replace(msgstr, "%1",  szSearchServer)
            msgstr = replace(msgstr, "%2",  szCatalog)
            wscript.Echo  msgstr
        else
            dispError()
        end if
        exit function
    end if

    ' display the results

    msgstr = L_SuccessRemoveSearchserverA_Message
    msgstr = replace(msgstr, "%1",  szSearchServer )
    msgstr = replace(msgstr, "%2",  szCatalog)
    wscript.Echo  msgstr
    wscript.Echo

end function

'----------------------------------------------------------------------------'
'                                  Operations
'----------------------------------------------------------------------------'

'+----------------------------------------------------------------------------
'
'   Function:   opGet
'
'   Synopsis:   Performs the get operation
'
'
'
'+----------------------------------------------------------------------------

function opGet( szTarget )

    On Error Resume Next

    DBG( "Get" )

    select case LCase(szTarget)

        case L_ObjStatus_Text
                
                call GetStatus ()

        case L_ObjStartpage_Text

                call GetStartPages ()

        case L_ObjSite_Text

                call GetSites ()

        case L_ObjConfig_Text

                call GetConfig ()

        case L_ObjMapping_Text

                call GetMappings ()

        case L_ObjFiletype_Text

                call GetFileTypes ()

        case L_ObjPath_Text

                call GetPaths ()

        case L_ObjTiming_Text

                call GetTiming ()

        case L_ObjSearchserver_Text

                call GetSearchServers ()

        case L_ObjBuildenv_Text

                call GetBuildEnv ()
    
        case L_ObjSearchenv_Text

                call GetSearchEnv ()

        case L_ObjProtocol_Text

                call GetProtocols ()

        case L_ObjLogs_Text

                call GetLogs ()

        case L_ObjProxy_Text

                call GetProxy()

        case else

            if utilIsHelp(HELP_OP_GET,-1) then exit function

            if (szTarget <> "") then 
                wscript.Echo L_InvalidObject_ErrorMessage + szTarget
                wscript.Echo
            end if

            call dispHelp( HELP_OP_GET )

    end select

end function

'+----------------------------------------------------------------------------
'
'   Function:   opSet
'
'   Synopsis:   Performs the set operation
'
'
'
'+----------------------------------------------------------------------------

function opSet( szTarget )

    On Error Resume Next

    DBG( "Set" )

    select case LCase(szTarget)

        case L_ObjStartpage_Text

            call SetStartPage()

        case L_ObjSite_Text

                call SetSite ()

        case L_ObjTiming_Text

                call SetTiming ()

        case L_ObjConfig_Text

                call SetConfig ()

        case L_ObjPath_Text

                call SetPath ()

        case L_ObjBuildenv_Text

                call SetBuildEnv ()
    
        case L_ObjSearchenv_Text

                call SetSearchEnv ()
    
        case L_ObjProtocol_Text

                call SetProtocol ()

        case L_ObjProxy_Text

            call SetProxy ()

        case else

            if utilIsHelp(HELP_OP_SET,-1) then exit function

            if (szTarget <> "") then 
                wscript.Echo L_InvalidObject_ErrorMessage + szTarget
                wscript.Echo
            end if

            call dispHelp( HELP_OP_SET )

    end select

end function

'+----------------------------------------------------------------------------
'
'   Function:   opAdd
'
'   Synopsis:   Performs the add operation
'
'
'
'   Notes:      You can 'add' the following objects:
'               
'+----------------------------------------------------------------------------

function opAdd( szTarget )

    On Error Resume Next

    DBG( "Add" )

    select case LCase(szTarget)

        case L_ObjCatalog_Text
            
            call AddCatalog()

        case L_ObjMapping_Text

            call AddMapping()

        case L_ObjFiletype_Text

            call AddFileType()

        case L_ObjSearchserver_Text

            call AddSearchServer()
    
        case else

            if utilIsHelp(HELP_OP_ADD,-1) then exit function
    
            if (szTarget <> "") then 
                wscript.Echo L_InvalidObject_ErrorMessage + szTarget
                wscript.Echo
            end if

            call dispHelp( HELP_OP_ADD )

    end select

end function

'+----------------------------------------------------------------------------
'
'   Function:   opRemove
'
'   Synopsis:   Performs the remove operation
'
'
'
'+----------------------------------------------------------------------------

function opRemove( szTarget )

    On Error Resume Next

    DBG( "Remove" )

    select case LCase(szTarget)

        case L_ObjCatalog_Text
            
            call RemoveCatalog()

        case L_ObjStartpage_Text
 
            call RemoveStartPage()

        case L_ObjSite_Text
            
            call RemoveSite()

        case L_ObjPath_Text

            call RemovePath()
    
        case L_ObjTiming_Text

            call RemoveTiming()

        case L_ObjMapping_Text

            call RemoveMapping()

        case L_ObjFiletype_Text

            call RemoveFileType()

        case L_ObjSearchserver_Text

            call RemoveSearchServer()

        case else

            if utilIsHelp(HELP_OP_REMOVE,-1) then exit function

            if (szTarget <> "") then 
                wscript.Echo L_InvalidObject_ErrorMessage + szTarget
                wscript.Echo
            end if

            call dispHelp( HELP_OP_REMOVE )

    end select

end function

'+----------------------------------------------------------------------------
'
'   Function:   opImport
'
'   Synopsis:   Performs the import operation
'
'
'
'+----------------------------------------------------------------------------

function opImport( szTarget )

    On Error Resume Next

    DBG( "Import" )

    select case LCase(szTarget)

        case L_ObjCatalog_Text

            call ImportCatalog ()

        case L_ObjConfig_Text

                call ImportConfig ()

        case else

            if utilIsHelp(HELP_OP_IMPORT,-1) then exit function

            if (szTarget <> "") then 
                wscript.Echo L_InvalidObject_ErrorMessage + szTarget
                wscript.Echo
            end if

            call dispHelp( HELP_OP_IMPORT )

    end select

end function

'+----------------------------------------------------------------------------
'
'   Function:   opExport
'
'   Synopsis:   Performs the export operation
'
'
'
'+----------------------------------------------------------------------------

function opExport( szTarget )

    On Error Resume Next

    DBG( "Export" )

    select case LCase(szTarget)

        case L_ObjCatalog_Text

            call ExportCatalog ()

        case L_ObjConfig_Text

                call ExportConfig ()

        case else

            if utilIsHelp(HELP_OP_EXPORT,-1) then exit function

            if (szTarget <> "") then 
                wscript.Echo L_InvalidObject_ErrorMessage + szTarget
                wscript.Echo
            end if

            call dispHelp( HELP_OP_EXPORT )

    end select

end function


'+----------------------------------------------------------------------------
'
'   Function:   opBuild

'   Synopsis:   Performs the build operation
'
'
'
'   Parameters:  
'
'        <(c)atalog name>       required    catalog to build
'        <(o)peration>          required    specifies what to do with build
'
'+----------------------------------------------------------------------------

function opBuild()

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim objBuildCatalog
    Dim szOperation
    Dim msgstr

    On Error Resume Next

    DBG( "Build" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_BUILD, SYNTAX_OP_BUILD )
    if ( bIsHelp ) then
        exit function
    end if

   ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_BUILD, vbString )
    if IsEmpty(szCatalog) then exit function

    ' get the operation specified

    szOperation = utilGetRequiredArg( L_Operation_ArgumentName, SYNTAX_OP_BUILD, vbBuildOpType )
    if IsEmpty(szOperation) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_BUILD, SYNTAX_OP_BUILD)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the build catalog

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    select case LCase(szOperation)

        case L_TypeOpStart_Text

            ' build the catalog
    
            wscript.Echo L_StatusBuilding_Message
            wscript.Echo
            call objBuildCatalog.StartBuild()
            if (Err.Number <> 0) then
                wscript.Echo L_BuildFailed_ErrorMessage
                if (Err.Number = E_STARTPAGES) then
                    wscript.Echo
                    msgstr = L_NoStartpagesA_ErrorMessage
                    msgstr = replace(msgstr, "%1",  szCatalog )
                    wscript.Echo  msgstr
                    wscript.Echo L_AddStartpageHelp_Message
                else
                    dispError()
                end if
                exit function
            end if

        case L_TypeOpStartincremental_Text

            ' build the catalog
    
            wscript.Echo L_StatusBuildingIncremental_Message
            wscript.Echo
            call objBuildCatalog.StartIncrementalBuild()
            if (Err.Number <> 0) then
                wscript.Echo L_BuildIncrementalFailed_ErrorMessage
                if (Err.Number = E_STARTPAGES) then
                    wscript.Echo
                    msgstr = L_NoStartpagesA_ErrorMessage
                    msgstr = replace(msgstr, "%1",  szCatalog )
                    wscript.Echo  msgstr
                    wscript.Echo L_AddStartpageHelp_Message
                else
                    dispError()
                end if
                exit function
            end if

        case L_TypeOpStop_Text

            ' stop the catalog
         
            wscript.Echo L_StatusStopping_Message
            wscript.Echo
            call objBuildCatalog.StopBuild()
            if (Err.Number <> 0) then
                wscript.Echo L_StopFailed_ErrorMessage
                dispError()
                exit function
            end if

        case L_TypeOpPause_Text

            ' stop the catalog
         
            wscript.Echo L_StatusPausing_Message
            wscript.Echo
            call objBuildCatalog.PauseBuild()
            if (Err.Number <> 0) then
                wscript.Echo L_PauseFailed_ErrorMessage
                dispError()
                exit function
            end if

        case L_TypeOpResume_Text

            ' check if the catalog has been paused

            if (objBuildCatalog.StatusCode <> STATUS_BUILD_PAUSED) then
                msgstr = L_BuildNotPausedA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szCatalog )
                wscript.Echo  msgstr
                exit function
            end if

            ' resume the catalog
         
            wscript.Echo L_StatusResuming_Message
            wscript.Echo
            call objBuildCatalog.ResumeBuild()
            if (Err.Number <> 0) then
                wscript.Echo L_ResumeFailed_ErrorMessage
                dispError()
                exit function
            end if

        case L_TypeOpProp_Text

            ' force the catalog to prop

            wscript.Echo L_StatusPropping_Message
            wscript.Echo
            call objBuildCatalog.ForceProp()
            if (Err.Number <> 0) then
                wscript.Echo L_PropFailed_ErrorMessage
                dispError()
                exit function
            end if

        case L_TypeOpAbortprop_Text

            ' abort the catalog propagation

            wscript.Echo L_StatusAbortingProp_Message
            wscript.Echo
            call objBuildCatalog.AbortProp()
            if (Err.Number <> 0) then
                wscript.Echo L_AbortPropFailed_ErrorMessage
                dispError()
                exit function
            end if

        case else

            wscript.Echo L_BuildOperation_ErrorMessage + szOperation

    end select

    ' display the catalog status
    wscript.Echo L_StatusStatus_Message
    wscript.Echo
    call dispCatalogName( objBuildCatalog )
    call dispBuildCatalogStatus( objBuildCatalog )

end function

'+----------------------------------------------------------------------------
'
'   Function:   opSearch

'   Synopsis:   Performs the search operation
'
'
'
'+----------------------------------------------------------------------------

function opSearch

    Dim bIsHelp, bInvalidArgs
    Dim szCatalog
    Dim objSearchCatalog, objSearchCatalogs
    Dim nTimeout
    Dim nRowlimit
    Dim bEnabled
    Dim msgstr

    On Error Resume Next

    DBG( "opSearch" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_SEARCH, SYNTAX_OP_SEARCH )
    if (bIsHelp) then
        exit function
    end if

    ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_SEARCH, vbString )
    if IsEmpty(szCatalog) then exit function

    nTimeout = utilGetArg( L_Searchtimeout_ArgumentName, SYNTAX_OP_SEARCH, vbLong )
    if IsEmpty(nTimeout) then exit function

    nRowlimit = utilGetArg( L_RowLimit_ArgumentName, SYNTAX_OP_SEARCH, vbLong )
    if IsEmpty(nRowlimit) then exit function

    bEnabled = utilGetArg( L_Enabled_ArgumentName, SYNTAX_OP_SEARCH, vbBoolean )
    if IsEmpty(bEnabled) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_SEARCH, SYNTAX_OP_SEARCH)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' get the search catalogs collection

    set objSearchCatalogs = objSearchServer.SearchCatalogs
    if (Err.Number <> 0) then
        dispError()
        exit function
    end if

    ' get the search catalog

    set objSearchCatalog = objSearchCatalogs.Item(szCatalog)
    if (Err.Number <> 0) then
        if (Err.Number <> E_NOTEXIST) then
            dispError()
        else
            wscript.Echo L_NotOnSearchserverAWarning_Message + szCatalog + L_NotOnSearchserverBWarning_Message
            wscript.Echo L_SearchtimeoutHelp_Message            
        end if
        exit function
    end if

    ' set the properties

    if (IsNull(nTimeout) = FALSE) then

        ' check the parameter

        if (nTimeout < 0) then
            msgstr = L_NullTimeoutAWarning_Message
            msgstr = replace(msgstr, "%1",  CStr(SEARCH_TIMEOUT_DEFAULT) )
            wscript.Echo  msgstr
            wscript.Echo
         end if

        if (nTimeout < SEARCH_TIMEOUT_THRESHOLD) then
            msgstr = L_TimeoutAWarning_Message
            msgstr = replace(msgstr, "%1",  CStr(nTimeout) )
            wscript.Echo  msgstr
            wscript.Echo
        end if

        ' set the timeout

        objSearchCatalog.QueryTimeout = nTimeout
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

    end if        

    if (IsNull(nRowlimit) = FALSE) then

        ' check the parameter

        if (nRowlimit <= 0) then
            msgstr = L_NullRowLimitWarning_Message
            msgstr = replace(msgstr, "%1",  CStr(SEARCH_ROWLIMIT_DEFAULT) )
            wscript.Echo  msgstr
            wscript.Echo
            nRowlimit = SEARCH_ROWLIMIT_DEFAULT
        end if

        ' set the max results

        objSearchCatalog.MaxResultRows = nRowlimit
        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

    end if        



    if (IsNull(bEnabled) = FALSE) then

        ' set the search catalog status

        if (bEnabled) then
            objSearchCatalog.Enable
            if (Err.Number = E_CATALOGENABLED) then
                msgstr = L_CatalogEnabledAWarning_Message
                msgstr = replace(msgstr, "%1",  szCatalog )
                wscript.Echo  msgstr
                wscript.Echo
                Err.Number = 0
            end if
        else
            objSearchCatalog.Disable
            if (Err.Number = E_CATALOGDISABLED) then
                msgstr = L_CatalogDisabledAWarning_Message
                msgstr = replace(msgstr, "%1",  szCatalog )
                wscript.Echo  msgstr
                wscript.Echo
                Err.Number = 0
            end if
        end if

        if (Err.Number <> 0) then
            dispError()
            exit function
        end if

    end if

    ' display results

    msgstr = L_SuccessSearchA_Message
    msgstr = replace(msgstr, "%1",  szCatalog )
    msgstr = replace(msgstr, "%2",  objHost.HostName )
    wscript.Echo  msgstr
    wscript.Echo

    call dispCatalogName( objSearchCatalog )
    call dispSearchCatalogStatus( objSearchCatalog )

end function





'+----------------------------------------------------------------------------
'
'   Function:   ImportCatalog

'   Synopsis:   Imports a configuration file for a catalog
'
'
'
'   Syntax:
'       sssadmin import </catalog:catalog name> </filename:file name>
'
'   Parameters:  
'
'        <filename>       required    path to file to import
'        <catalog name>   required    catalog to import configuration for   
'
'+----------------------------------------------------------------------------

function ImportCatalog()

    Dim bIsHelp, bInvalidArgs
    Dim szFilename, szCatalog
    Dim objBuildCatalog
    Dim msgstr

    On Error Resume Next

    DBG( "Build" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_IMPORT_CATALOG, SYNTAX_OP_IMPORT_CATALOG )
    if ( bIsHelp ) then
        exit function
    end if

   ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_IMPORT_CATALOG, vbString )
    if IsEmpty(szCatalog) then exit function

   ' get the file name from the command line

    szFilename = utilGetRequiredArg( L_Filename_ArgumentName, SYNTAX_OP_IMPORT_CATALOG, vbString )
    if IsEmpty(szFilename) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_IMPORT_CATALOG, SYNTAX_OP_IMPORT_CATALOG)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' import the configuration file

    call objBuildServer.ImportCatalog( szCatalog, szFilename )
    if (Err.Number <> 0) then
        select case Err.Number        

            case E_CATALOGNAMEINVALID

                wscript.Echo L_InvalidCatalogName_ErrorMessage + szCatalog

            case E_FILENOTFOUND

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case E_ACCESSDENIED

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case E_INVALIDPATH

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case E_INVALIDCONFIG

                wscript.Echo L_InvalidConfiguration_ErrorMessage + szFilename

            case E_OBJECTEXISTS
    
                msgstr = L_ExistCatalogA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szCatalog )
                msgstr = replace(msgstr, "%2",  objHost.HostName)
                wscript.Echo  msgstr

            case else

                dispError

        end select

        exit function
    end if

    msgstr = L_SuccessImport_Message
    msgstr = replace(msgstr, "%2",  szCatalog )
    msgstr = replace(msgstr, "%1",  szFileName)
    wscript.Echo  msgstr
    wscript.Echo

    ' get the catalog object

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' display the catalog configuration

    call dispCatalogName( objBuildCatalog )
    call dispBuildCatalogConfig( objBuildCatalog )

end function

'+----------------------------------------------------------------------------
'
'   Function:   ImportConfig

'   Synopsis:   Imports a configuration file for an entire build server
'
'
'
'   Syntax:
'       sssadmin import </filename:file name>
'
'   Parameters:  
'
'        <filename>       required    path to file to import
'
'+----------------------------------------------------------------------------

function ImportConfig()

    Dim bIsHelp, bInvalidArgs
    Dim szFilename
    Dim objBuildCatalogs, objBuildCatalog
    Dim msgstr

    On Error Resume Next

    DBG( "ImportConfig" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_IMPORT_CONFIG, SYNTAX_OP_IMPORT_CONFIG )
    if ( bIsHelp ) then
        exit function
    end if

   ' get the file name from the command line

    szFilename = utilGetRequiredArg( L_Filename_ArgumentName, SYNTAX_OP_IMPORT_CONFIG, vbString )
    if IsEmpty(szFilename) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_IMPORT_CONFIG, SYNTAX_OP_IMPORT_CONFIG)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' import the configuration file

    call objBuildServer.LoadConfiguration( szFilename )
    if (Err.Number <> 0) then
        select case Err.Number        

            case E_FILENOTFOUND

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case E_ACCESSDENIED

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case E_INVALIDPATH

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case else

                dispError

        end select

        exit function
    end if

    msgstr = L_SuccessImportConfig_Message
    msgstr = replace(msgstr, "%2",  objHost.HostName )
    msgstr = replace(msgstr, "%1",  szFileName)
    wscript.Echo  msgstr
    wscript.Echo

    ' display the configuration

    dispBuildServerConfig()        

end function





'+----------------------------------------------------------------------------
'
'   Function:   ExportCatalog

'   Synopsis:   Exports a configuration file for an individual catalog
'
'
'
'   Syntax:
'       sssadmin export </catalog:catalog name> </filename:file name>
'
'   Parameters:  
'
'        <filename>       required    path to file for exported conifguration
'        <catalog name>   required    catalog to export configuration for   
'
'+----------------------------------------------------------------------------

function ExportCatalog()

    Dim bIsHelp, bInvalidArgs
    Dim szFilename, szCatalog
    Dim szExt
    Dim objBuildCatalog
    Dim msgstr

    On Error Resume Next

    DBG( "Build" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_EXPORT_CATALOG, SYNTAX_OP_EXPORT_CATALOG )
    if ( bIsHelp ) then
        exit function
    end if

   ' get the catalog name from the command line

    szCatalog = utilGetRequiredArg( L_Catalog_ArgumentName, SYNTAX_OP_EXPORT_CATALOG, vbString )
    if IsEmpty(szCatalog) then exit function

   ' get the file name from the command line

    szFilename = utilGetRequiredArg( L_Filename_ArgumentName, SYNTAX_OP_EXPORT_CATALOG, vbString )
    if IsEmpty(szFilename) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_EXPORT_CATALOG, SYNTAX_OP_EXPORT_CATALOG)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' check the file name to see if it has an .sbp extension

    szExt = Right( szFilename, 4 )
    if (szExt <> FILE_EXTENSION_EXPORT) then
        
        ' check if another extension specified
        
        if (Left(szExt,1) <> ".") then
        
            ' append extension to filename

            szFilename = szFilename + FILE_EXTENSION_EXPORT
            
        end if

    end if
        

    ' get the catalog object (verify it is a valid catalog)

    set objBuildCatalog = utilGetBuildCatalog( szCatalog )
    if IsEmpty(objBuildCatalog) then exit function

    ' export the configuration file

    call objBuildServer.ExportCatalog( szCatalog, szFilename )
    if (Err.Number <> 0) then
        select case Err.Number        

            case E_FILENOTFOUND

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case E_ACCESSDENIED

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description  

            case E_INVALIDPATH

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case E_INVALIDCONFIG

                wscript.Echo L_InvalidConfiguration_ErrorMessage + szFilename

            case E_OBJECTEXISTS
    
                msgstr = L_ExistCatalogA_ErrorMessage
                msgstr = replace(msgstr, "%1",  szCatalog )
                msgstr = replace(msgstr, "%2",  objHost.HostName)
                wscript.Echo  msgstr

            case else

                dispError

        end select
        exit function
    end if

    ' display the result

    msgstr = L_SuccessExport_Message
    msgstr = replace(msgstr, "%1",  szCatalog )
    msgstr = replace(msgstr, "%2",  szFileName)
    wscript.Echo  msgstr
    wscript.Echo

end function


'+----------------------------------------------------------------------------
'
'   Function:   ExportConfig

'   Synopsis:   Exports a configuration file for the entire build server
'
'
'
'   Syntax:
'       sssadmin export config </filename:file name>
'
'   Parameters:  
'
'        <filename>       required    path to file for exported conifguration
'
'+----------------------------------------------------------------------------

function ExportConfig()

    Dim bIsHelp, bInvalidArgs
    Dim szFilename, szCatalog
    Dim szExt
    Dim objBuildCatalog
    Dim msgstr

    On Error Resume Next

    DBG( "ExportConfig" )

    ' check if help requested

    bIsHelp = utilIsHelp( HELP_OP_EXPORT_CONFIG, SYNTAX_OP_EXPORT_CONFIG )
    if ( bIsHelp ) then
        exit function
    end if

   ' get the file name from the command line

    szFilename = utilGetRequiredArg( L_Filename_ArgumentName, SYNTAX_OP_EXPORT_CONFIG, vbString )
    if IsEmpty(szFilename) then exit function

    bInvalidArgs = utilInvalidArgs(HELP_OP_EXPORT_CONFIG, SYNTAX_OP_EXPORT_CONFIG)
    if ( bInvalidArgs ) then
        exit function
    end if

    ' check the file name to see if it has an .sbc extension

    szExt = Right( szFilename, 4 )
    if (szExt <> FILE_EXTENSION_EXPORTCONFIG) then
        
        ' check if another extension specified
        
        if (Left(szExt,1) <> ".") then
        
            ' append extension to filename

            szFilename = szFilename + FILE_EXTENSION_EXPORTCONFIG
            
        end if

    end if
        

    ' export the configuration file

    call objBuildServer.SaveConfiguration ( szFilename )
    if (Err.Number <> 0) then
        select case Err.Number        

            case E_FILENOTFOUND

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case E_ACCESSDENIED

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description  

            case E_INVALIDPATH

                msgstr = L_InvalidFilename_ErrorMessage
                msgstr = replace(msgstr, "%1",  szFilename )
                wscript.Echo  msgstr
                wscript.Echo    Err.Description

            case E_INVALIDCONFIG

                wscript.Echo L_InvalidConfiguration_ErrorMessage + szFilename

            case else

                dispError

        end select
        exit function
    end if

    ' display the result

    msgstr = L_SuccessExportConfig_Message
    msgstr = replace(msgstr, "%1", objHost.HostName )
    msgstr = replace(msgstr, "%2", szFilename )
    wscript.Echo  msgstr
    wscript.Echo

end function

'----------------------------------------------------------------------------'
'                                 Declarations
'----------------------------------------------------------------------------'

    Dim szOperation, szTarget
    Dim bResult

'----------------------------------------------------------------------------'
'                                     Main
'----------------------------------------------------------------------------'

    on error resume next

    wscript.Echo L_MainHeader_Message
    wscript.Echo L_MainCopyright_Message
    wscript.Echo

    '
    ' setup debug stuff
    '

    if (DEBUGOUT = 2) then Stop
    if (DEBUGOUT >= 1) then set objDebug = CreateObject( OBJECT_DEBUG )

    DBG "-- MAIN --"

    '
    ' initialize and parse the command line
    '

    bResult = utilParseCommandLine( szOperation, szTarget )
    if (bResult = FALSE) then
        call dispCmdLineError()
        wscript.Quit(-1)
    end if

    '
    ' create the objects (check if help is requested)
    '
    if (objCmdLine.IsHelp = FALSE) then
        bResult = utilCreateObjects ()
        if (bResult = FALSE) then wscript.Quit(-1)
    end if

    '
    ' call the appropriate operation
    '

    select case LCase(szOperation)

        case L_OpGet_Command

            call opGet( szTarget )

        case L_OpBuild_Command
        
            call opBuild ()

        case L_OpSearch_Command

            call opSearch ()

        case L_OpAdd_Command

            call opAdd( szTarget )

        case L_OpSet_Command

            call opSet( szTarget )

        case L_OpRemove_Command

            call opRemove( szTarget )

        case L_OpImport_Command

            call opImport ( szTarget )

        case L_OpExport_Command

            call opExport ( szTarget )

        case else
            if ((szOperation <> "") And (szOperation <> "/?") And (szOperation <> "-?")) then 
                wscript.Echo L_Operation_ErrorMessage + szOperation
                wscript.Echo
            end if
            call dispHelp( HELP_OP )

    end select

    wscript.Echo















