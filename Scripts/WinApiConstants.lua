-- WINAPI Constants For The WinApi Action Plugin 
-- Instructions: Copy The Contents Of This File And Paste It Into Your Project's "Global Actions" Pane

-- !! DO NOT MODIFY ANY OF THE LINES BELOW
	

WS_OVERLAPPED                           = "0x00000000";
WS_POPUP                                = "0x80000000";
WS_CHILD                                = "0x40000000";
WS_MINIMIZE                             = "0x20000000";
WS_VISIBLE                              = "0x10000000";
WS_DISABLED                             = "0x08000000";
WS_CLIPSIBLINGS                         = "0x04000000";
WS_CLIPCHILDREN                         = "0x02000000";
WS_MAXIMIZE                             = "0x01000000";
WS_CAPTION                              = "0x00C00000";
WS_BORDER                               = "0x00800000";
WS_DLGFRAME                             = "0x00400000";
WS_VSCROLL                              = "0x00200000";
WS_HSCROLL                              = "0x00100000";
WS_SYSMENU                              = "0x00080000";
WS_THICKFRAME                           = "0x00040000";
WS_GROUP                                = "0x00020000";
WS_TABSTOP                              = "0x00010000";
WS_MINIMIZEBOX                          = "0x00020000";
WS_MAXIMIZEBOX                          = "0x00010000";
WS_TILED                                = "0x00000000";
WS_ICONIC                               = "0x20000000";
WS_SIZEBOX                              = "0x00040000";
WS_TILEDWINDOW                          = WS_OVERLAPPEDWINDOW;
WS_OVERLAPPEDWINDOW                     = "0x00000000|0x00C00000|0x00080000|0x00040000|0x00020000|0x00010000";
WS_POPUPWINDOW                          = "0x80000000|0x00800000|0x00080000";
WS_CHILDWINDOW                          = "0x40000000";



WS_EX_DLGMODALFRAME                     = "0x00000001";
WS_EX_NOPARENTNOTIFY                    = "0x00000004";
WS_EX_TOPMOST                           = "0x00000008";
WS_EX_ACCEPTFILES                       = "0x00000010";
WS_EX_TRANSPARENT                       = "0x00000020";
WS_EX_MDICHILD                          = "0x00000040";
WS_EX_TOOLWINDOW                        = "0x00000080";
WS_EX_WINDOWEDGE                        = "0x00000100";
WS_EX_CLIENTEDGE                        = "0x00000200";
WS_EX_CONTEXTHELP                       = "0x00000400";
WS_EX_RIGHT                             = "0x00001000";
WS_EX_LEFT                              = "0x00000000";
WS_EX_RTLREADING                        = "0x00002000";
WS_EX_LTRREADING                        = "0x00000000";
WS_EX_LEFTSCROLLBAR                     = "0x00004000";
WS_EX_RIGHTSCROLLBAR                    = "0x00000000";
WS_EX_CONTROLPARENT                     = "0x00010000";
WS_EX_STATICEDGE                        = "0x00020000";
WS_EX_APPWINDOW                         = "0x00040000";
WS_EX_OVERLAPPEDWINDOW                  = "0x00000100|0x00000200";
WS_EX_PALETTEWINDOW                     = "0x00000100|0x00000080|0x00000008";
WS_EX_LAYERED                           = "0x00080000";
WS_EX_NOINHERITLAYOUT                   = "0x00100000"; -- Disable inheritence of mirroring by children
WS_EX_LAYOUTRTL                         = "0x00400000"; -- Right to left mirroring
WS_EX_COMPOSITED                        = "0x02000000";
WS_EX_NOACTIVATE                        = "0x08000000";



GWL_WNDPROC                             = "-4";
GWL_HINSTANCE                           = "-6";
GWL_HWNDPARENT                          = "-8";
GWL_STYLE                               = "-16";
GWL_EXSTYLE                             = "-20";
GWL_USERDATA                            = "-21";
GWL_ID                                  = "-12";



CWP_ALL                                 = "0x0000";
CWP_SKIPINVISIBLE                       = "0x0001";
CWP_SKIPDISABLED                        = "0x0002";
CWP_SKIPTRANSPARENT                     = "0x0004";



SW_HIDE                                 = 0;
SW_SHOWNORMAL                           = 1;
SW_NORMAL                               = 1;
SW_SHOWMINIMIZED                        = 2;
SW_SHOWMAXIMIZED                        = 3;
SW_MAXIMIZE                             = 3;
SW_SHOWNOACTIVATE                       = 4;
SW_SHOW                                 = 5;
SW_MINIMIZE                             = 6;
SW_SHOWMINNOACTIVE                      = 7;
SW_SHOWNA                               = 8;
SW_RESTORE                              = 9;
SW_SHOWDEFAULT                          = 10;



GW_HWNDFIRST                            = 0;
GW_HWNDLAST                             = 1;
GW_HWNDNEXT                             = 2;
GW_HWNDPREV                             = 3;
GW_OWNER                                = 4;
GW_CHILD                                = 5;



BS_PUSHBUTTON                           = "0x00000000";
BS_DEFPUSHBUTTON                        = "0x00000001";
BS_CHECKBOX                             = "0x00000002";
BS_AUTOCHECKBOX                         = "0x00000003";
BS_RADIOBUTTON                          = "0x00000004";
BS_3STATE                               = "0x00000005";
BS_AUTO3STATE                           = "0x00000006";
BS_GROUPBOX                             = "0x00000007";
BS_USERBUTTON                           = "0x00000008";
BS_AUTORADIOBUTTON                      = "0x00000009";
BS_PUSHBOX                              = "0x0000000A";
BS_OWNERDRAW                            = "0x0000000B";
BS_TYPEMASK                             = "0x0000000F";
BS_LEFTTEXT                             = "0x00000020";
BS_TEXT                                 = "0x00000000";
BS_ICON                                 = "0x00000040";
BS_BITMAP                               = "0x00000080";
BS_LEFT                                 = "0x00000100";
BS_RIGHT                                = "0x00000200";
BS_CENTER                               = "0x00000300";
BS_TOP                                  = "0x00000400";
BS_BOTTOM                               = "0x00000800";
BS_VCENTER                              = "0x00000C00";
BS_PUSHLIKE                             = "0x00001000";
BS_MULTILINE                            = "0x00002000";
BS_NOTIFY                               = "0x00004000";
BS_FLAT                                 = "0x00008000";
BS_RIGHTBUTTON                          = "0x00000020";



CBS_SIMPLE                              = "0x0001";
CBS_DROPDOWN                            = "0x0002";
CBS_DROPDOWNLIST                        = "0x0003";
CBS_OWNERDRAWFIXED                      = "0x0010";
CBS_OWNERDRAWVARIABLE                   = "0x0020";
CBS_AUTOHSCROLL                         = "0x0040";
CBS_OEMCONVERT                          = "0x0080";
CBS_SORT                                = "0x0100";
CBS_HASSTRINGS                          = "0x0200";
CBS_NOINTEGRALHEIGHT                    = "0x0400";
CBS_DISABLENOSCROLL                     = "0x0800";
CBS_UPPERCASE                           = "0x2000";
CBS_LOWERCASE                           = "0x4000";



ES_LEFT                                 = "0x0000";
ES_CENTER                               = "0x0001";
ES_RIGHT                                = "0x0002";
ES_MULTILINE                            = "0x0004";
ES_UPPERCASE                            = "0x0008";
ES_LOWERCASE                            = "0x0010";
ES_PASSWORD                             = "0x0020";
ES_AUTOVSCROLL                          = "0x0040";
ES_AUTOHSCROLL                          = "0x0080";
ES_NOHIDESEL                            = "0x0100";
ES_OEMCONVERT                           = "0x0400";
ES_READONLY                             = "0x0800";
ES_WANTRETURN                           = "0x1000";
ES_NUMBER                               = "0x2000";



LBS_NOTIFY                              = "0x0001";
LBS_SORT                                = "0x0002";
LBS_NOREDRAW                            = "0x0004";
LBS_MULTIPLESEL                         = "0x0008";
LBS_OWNERDRAWFIXED                      = "0x0010";
LBS_OWNERDRAWVARIABLE                   = "0x0020";
LBS_HASSTRINGS                          = "0x0040";
LBS_USETABSTOPS                         = "0x0080";
LBS_NOINTEGRALHEIGHT                    = "0x0100";
LBS_MULTICOLUMN                         = "0x0200";
LBS_WANTKEYBOARDINPUT                   = "0x0400";
LBS_EXTENDEDSEL                         = "0x0800";
LBS_DISABLENOSCROLL                     = "0x1000";
LBS_NODATA                              = "0x2000";
LBS_NOSEL                               = "0x4000";
LBS_COMBOBOX                            = "0x8000";
LBS_STANDARD                            = "0x0001|0x0002|0x00200000|0x00800000";



SS_LEFT                                 = "0x00000000";
SS_CENTER                               = "0x00000001";
SS_RIGHT                                = "0x00000002";
SS_ICON                                 = "0x00000003";
SS_BLACKRECT                            = "0x00000004";
SS_GRAYRECT                             = "0x00000005";
SS_WHITERECT                            = "0x00000006";
SS_BLACKFRAME                           = "0x00000007";
SS_GRAYFRAME                            = "0x00000008";
SS_WHITEFRAME                           = "0x00000009";
SS_USERITEM                             = "0x0000000A";
SS_SIMPLE                               = "0x0000000B";
SS_LEFTNOWORDWRAP                       = "0x0000000C";
SS_OWNERDRAW                            = "0x0000000D";
SS_BITMAP                               = "0x0000000E";
SS_ENHMETAFILE                          = "0x0000000F";
SS_ETCHEDHORZ                           = "0x00000010";
SS_ETCHEDVERT                           = "0x00000011";
SS_ETCHEDFRAME                          = "0x00000012";
SS_TYPEMASK                             = "0x0000001F";



DS_ABSALIGN                             = "0x01";
DS_SYSMODAL                             = "0x02";
DS_LOCALEDIT                            = "0x20";   -- Edit items get local storage. 
DS_SETFONT                              = "0x40";   -- User specified font for Dlg controls 
DS_MODALFRAME                           = "0x80";   -- Can be combined with WS_CAPTION  
DS_NOIDLEMSG                            = "0x100";  -- WM_ENTERIDLE message will not be sent 
DS_SETFOREGROUND                        = "0x200";  -- not in win3.1 
DS_3DLOOK                               = "0x0004";
DS_FIXEDSYS                             = "0x0008";
DS_NOFAILCREATE                         = "0x0010";
DS_CONTROL                              = "0x0400";
DS_CENTER                               = "0x0800";
DS_CENTERMOUSE                          = "0x1000";
DS_CONTEXTHELP                          = "0x2000";
DS_SHELLFONT                            = "0x40|0x0008";



AW_FADEIN                               = "0x00080000"; -- fade-in
AW_FADEOUT                              = "0x00090000"; -- fade-out
AW_SLIDEIN_LEFT                         = "0x00040001"; -- slide in from left
AW_SLIDEOUT_LEFT                        = "0x00050002"; -- slide out to left
AW_SLIDEIN_RIGHT                        = "0x00040002"; -- slide in from right
AW_SLIDEOUT_RIGHT                       = "0x00050001"; -- slide out to right
AW_SLIDEIN_TOP                          = "0x00040004"; -- slide-in from top
AW_SLIDEOUT_TOP                         = "0x00050008"; -- slide-out to top
AW_SLIDEIN_BOTTOM                       = "0x00040008"; -- slide-in from bottom
AW_SLIDEOUT_BOTTOM                      = "0x00050004"; -- slide-out to bottom
AW_SLIDEIN_TOPLEFT                      = "0x00040005"; -- diagonal slide-in from Top-left
AW_SLIDEOUT_TOPLEFT                     = "0x0005000a"; -- diagonal slide-out to Top-left
AW_SLIDEIN_TOPRIGHT                     = "0x00040006"; -- diagonal slide-in from Top-Right
AW_SLIDEOUT_TOPRIGHT                    = "0x00050009"; -- diagonal slide-out to Top-Right
AW_SLIDEIN_BOTTOMLEFT                   = "0x00040009"; -- diagonal slide-in from Bottom-left
AW_SLIDEOUT_BOTTOMLEFT                  = "0x00050006"; -- diagonal slide-out to Bottom-left
AW_SLIDEIN_BOTTOMRIGHT                  = "0x0004000a"; -- diagonal slide-in from Bottom-right
AW_SLIDEOUT_BOTTOMRIGHT                 = "0x00050005"; -- diagonal slide-out to Bottom-right
AW_EXPLODE                              = "0x00040010"; -- explode
AW_IMPLODE                              = "0x00050010"; -- implode


CS_VREDRAW                              = "0x0001";
CS_HREDRAW                              = "0x0002";
CS_DBLCLKS                              = "0x0008";
CS_OWNDC                                = "0x0020";
CS_CLASSDC                              = "0x0040";
CS_PARENTDC                             = "0x0080";
CS_NOCLOSE                              = "0x0200";
CS_SAVEBITS                             = "0x0800";
CS_BYTEALIGNCLIENT                      = "0x1000";
CS_BYTEALIGNWINDOW                      = "0x2000";
CS_GLOBALCLASS                          = "0x4000";
CS_IME                                  = "0x00010000";
CS_DROPSHADOW                           = "0x00020000";



COLOR_SCROLLBAR                         = 0;
COLOR_BACKGROUND                        = 1;
COLOR_ACTIVECAPTION                     = 2;
COLOR_INACTIVECAPTION                   = 3;
COLOR_MENU                              = 4;
COLOR_WINDOW                            = 5;
COLOR_WINDOWFRAME                       = 6;
COLOR_MENUTEXT                          = 7;
COLOR_WINDOWTEXT                        = 8;
COLOR_CAPTIONTEXT                       = 9;
COLOR_ACTIVEBORDER                      = 10;
COLOR_INACTIVEBORDER                    = 11;
COLOR_APPWORKSPACE                      = 12;
COLOR_HIGHLIGHT                         = 13;
COLOR_HIGHLIGHTTEXT                     = 14;
COLOR_BTNFACE                           = 15;
COLOR_BTNSHADOW                         = 16;
COLOR_GRAYTEXT                          = 17;
COLOR_BTNTEXT                           = 18;
COLOR_INACTIVECAPTIONTEXT               = 19;
COLOR_BTNHIGHLIGHT                      = 20;

COLOR_3DDKSHADOW                        = 21;
COLOR_3DLIGHT                           = 22;
COLOR_INFOTEXT                          = 23;
COLOR_INFOBK                            = 24;


-- GDI Constants

PS_SOLID                                = "0";
PS_DASH                                 = "1";    
PS_DOT                                  = "2";      
PS_DASHDOT                              = "3";     
PS_DASHDOTDOT                           = "4";     
PS_NULL                                 = "5";
PS_INSIDEFRAME                          = "6";
PS_USERSTYLE                            = "7";
PS_ALTERNATE                            = "8";
PS_STYLE_MASK                           = "0x0000000F";
PS_ENDCAP_ROUND                         = "0x00000000";
PS_ENDCAP_SQUARE                        = "0x00000100";
PS_ENDCAP_FLAT                          = "0x00000200";
PS_ENDCAP_MASK                          = "0x00000F00";
PS_JOIN_ROUND                           = "0x00000000";
PS_JOIN_BEVEL                           = "0x00001000";
PS_JOIN_MITER                           = "0x00002000";
PS_JOIN_MASK                            = "0x0000F000";
PS_COSMETIC                             = "0x00000000";
PS_GEOMETRIC                            = "0x00010000";
PS_TYPE_MASK                            = "0x000F0000";

TRANSPARENT                             = 1;
OPAQUE	                                = 2;

NULLREGION                              = 1;
SIMPLEREGION                            = 2;
COMPLEXREGION                           = 3;

WHITE_BRUSH                             = 0;
LTGRAY_BRUSH                            = 1;
GRAY_BRUSH                              = 2;
DKGRAY_BRUSH                            = 3;
BLACK_BRUSH	                        = 4;
NULL_BRUSH                              = 5;
HOLLOW_BRUSH                            = 5;
WHITE_PEN                               = 6;
BLACK_PEN                               = 7;
NULL_PEN                                = 8;
OEM_FIXED_FONT                          = 10;
ANSI_FIXED_FONT                         = 11;
ANSI_VAR_FONT                           = 12;
SYSTEM_FONT                             = 13;
DEVICE_DEFAULT_FONT                     = 14;
DEFAULT_PALETTE                         = 15;
SYSTEM_FIXED_FONT                       = 16;
DEFAULT_GUI_FONT                        = 17;

ANSI_CHARSET                            = 0;
BALTIC_CHARSET                          = 186;
CHINESEBIG5_CHARSET                     = 136;
DEFAULT_CHARSET                         = 1;
EASTEUROPE_CHARSET                      = 238;
GB2312_CHARSET                          = 134;
GREEK_CHARSET                           = 161;
HANGUL_CHARSET                          = 129;
MAC_CHARSET                             = 77;
OEM_CHARSET                             = 255;
RUSSIAN_CHARSET                         = 204;
SHIFTJIS_CHARSET                        = 128;
SYMBOL_CHARSET                          = 2;
TURKISH_CHARSET                         = 162
VIETNAMESE_CHARSET                      = 163;
JOHAB_CHARSET                           = 130;
ARABIC_CHARSET                          = 178;
HEBREW_CHARSET                          = 177;
THAI_CHARSET                            = 222;

FW_DONTCARE                             = 0; 
FW_THIN                                 = 100; 
FW_EXTRALIGHT                           = 200; 
FW_ULTRALIGHT                           = 200; 
FW_LIGHT                                = 300; 
FW_NORMAL                               = 400; 
FW_REGULAR                              = 400; 
FW_MEDIUM                               = 500; 
FW_SEMIBOLD                             = 600; 
FW_DEMIBOLD                             = 600; 
FW_BOLD                                 = 700; 
FW_EXTRABOLD                            = 800; 
FW_ULTRABOLD                            = 800; 
FW_HEAVY                                = 900; 
FW_BLACK                                = 900; 


-- Locale Info Constants

LOCALE_SYSTEM_DEFAULT	                = "1";            -- Default system locale.
LOCALE_USER_DEFAULT	                = "2";            -- Default user locale.

LOCALE_ILANGUAGE                        = "0x00000001";   -- language id
LOCALE_SLANGUAGE                        = "0x00000002";   -- localized name of language
LOCALE_SENGLANGUAGE                     = "0x00001001";   -- English name of language
LOCALE_SABBREVLANGNAME                  = "0x00000003";   -- abbreviated language name
LOCALE_SNATIVELANGNAME                  = "0x00000004";   -- native name of language
LOCALE_ICOUNTRY                         = "0x00000005";   -- country code
LOCALE_SCOUNTRY                         = "0x00000006";   -- localized name of country
LOCALE_SENGCOUNTRY                      = "0x00001002";   -- English name of country
LOCALE_SABBREVCTRYNAME                  = "0x00000007";   -- abbreviated country name
LOCALE_SNATIVECTRYNAME                  = "0x00000008";   -- native name of country
LOCALE_IDEFAULTLANGUAGE                 = "0x00000009";   -- default language id
LOCALE_IDEFAULTCOUNTRY                  = "0x0000000A";   -- default country code
LOCALE_IDEFAULTCODEPAGE                 = "0x0000000B";   -- default oem code page
LOCALE_IDEFAULTANSICODEPAGE             = "0x00001004";   -- default ansi code page
LOCALE_IDEFAULTMACCODEPAGE              = "0x00001011";   -- default mac code page
LOCALE_SLIST                            = "0x0000000C";   -- list item separator
LOCALE_IMEASURE                         = "0x0000000D";   -- 0 = metric, 1 = US
LOCALE_SDECIMAL                         = "0x0000000E";   -- decimal separator
LOCALE_STHOUSAND                        = "0x0000000F";   -- thousand separator
LOCALE_SGROUPING                        = "0x00000010";   -- digit grouping
LOCALE_IDIGITS                          = "0x00000011";   -- number of fractional digits
LOCALE_ILZERO                           = "0x00000012";   -- leading zeros for decimal
LOCALE_INEGNUMBER                       = "0x00001010";   -- negative number mode
LOCALE_SNATIVEDIGITS                    = "0x00000013";   -- native ascii 0-9
LOCALE_SCURRENCY                        = "0x00000014";   -- local monetary symbol
LOCALE_SINTLSYMBOL                      = "0x00000015";   -- intl monetary symbol
LOCALE_SMONDECIMALSEP                   = "0x00000016";   -- monetary decimal separator
LOCALE_SMONTHOUSANDSEP                  = "0x00000017";   -- monetary thousand separator
LOCALE_SMONGROUPING                     = "0x00000018";   -- monetary grouping
LOCALE_ICURRDIGITS                      = "0x00000019";   -- # local monetary digits
LOCALE_IINTLCURRDIGITS                  = "0x0000001A";   -- # intl monetary digits
LOCALE_ICURRENCY                        = "0x0000001B";   -- positive currency mode
LOCALE_INEGCURR                         = "0x0000001C";   -- negative currency mode
LOCALE_SDATE                            = "0x0000001D";   -- date separator
LOCALE_STIME                            = "0x0000001E";   -- time separator
LOCALE_SSHORTDATE                       = "0x0000001F";   -- short date format string
LOCALE_SLONGDATE                        = "0x00000020";   -- long date format string
LOCALE_STIMEFORMAT                      = "0x00001003";   -- time format string
LOCALE_IDATE                            = "0x00000021";   -- short date format ordering
LOCALE_ILDATE                           = "0x00000022";   -- long date format ordering
LOCALE_ITIME                            = "0x00000023";   -- time format specifier
LOCALE_ITIMEMARKPOSN                    = "0x00001005";   -- time marker position
LOCALE_ICENTURY                         = "0x00000024";   -- century format specifier (short date)
LOCALE_ITLZERO                          = "0x00000025";   -- leading zeros in time field
LOCALE_IDAYLZERO                        = "0x00000026";   -- leading zeros in day field (short date)
LOCALE_IMONLZERO                        = "0x00000027";   -- leading zeros in month field (short date)
LOCALE_S1159                            = "0x00000028";   -- AM designator
LOCALE_S2359                            = "0x00000029";   -- PM designator
LOCALE_ICALENDARTYPE                    = "0x00001009";   -- type of calendar specifier
LOCALE_IOPTIONALCALENDAR                = "0x0000100B";   -- additional calendar types specifier
LOCALE_IFIRSTDAYOFWEEK                  = "0x0000100C";   -- first day of week specifier
LOCALE_IFIRSTWEEKOFYEAR                 = "0x0000100D";   -- first week of year specifier
LOCALE_SDAYNAME1                        = "0x0000002A";   -- long name for Monday
LOCALE_SDAYNAME2                        = "0x0000002B";   -- long name for Tuesday
LOCALE_SDAYNAME3                        = "0x0000002C";   -- long name for Wednesday
LOCALE_SDAYNAME4                        = "0x0000002D";   -- long name for Thursday
LOCALE_SDAYNAME5                        = "0x0000002E";   -- long name for Friday
LOCALE_SDAYNAME6                        = "0x0000002F";   -- long name for Saturday
LOCALE_SDAYNAME7                        = "0x00000030";   -- long name for Sunday
LOCALE_SABBREVDAYNAME1                  = "0x00000031";   -- abbreviated name for Monday
LOCALE_SABBREVDAYNAME2                  = "0x00000032";   -- abbreviated name for Tuesday
LOCALE_SABBREVDAYNAME3                  = "0x00000033";   -- abbreviated name for Wednesday
LOCALE_SABBREVDAYNAME4                  = "0x00000034";   -- abbreviated name for Thursday
LOCALE_SABBREVDAYNAME5                  = "0x00000035";   -- abbreviated name for Friday
LOCALE_SABBREVDAYNAME6                  = "0x00000036";   -- abbreviated name for Saturday
LOCALE_SABBREVDAYNAME7                  = "0x00000037";   -- abbreviated name for Sunday
LOCALE_SMONTHNAME1                      = "0x00000038";   -- long name for January
LOCALE_SMONTHNAME2                      = "0x00000039";   -- long name for February
LOCALE_SMONTHNAME3                      = "0x0000003A";   -- long name for March
LOCALE_SMONTHNAME4                      = "0x0000003B";   -- long name for April
LOCALE_SMONTHNAME5                      = "0x0000003C";   -- long name for May
LOCALE_SMONTHNAME6                      = "0x0000003D";   -- long name for June
LOCALE_SMONTHNAME7                      = "0x0000003E";   -- long name for July
LOCALE_SMONTHNAME8                      = "0x0000003F";   -- long name for August
LOCALE_SMONTHNAME9                      = "0x00000040";   -- long name for September
LOCALE_SMONTHNAME10                     = "0x00000041";   -- long name for October
LOCALE_SMONTHNAME11                     = "0x00000042";   -- long name for November
LOCALE_SMONTHNAME12                     = "0x00000043";   -- long name for December
LOCALE_SMONTHNAME13                     = "0x0000100E";   -- long name for 13th month (if exists)
LOCALE_SABBREVMONTHNAME1                = "0x00000044";   -- abbreviated name for January
LOCALE_SABBREVMONTHNAME2                = "0x00000045";   -- abbreviated name for February
LOCALE_SABBREVMONTHNAME3                = "0x00000046";   -- abbreviated name for March
LOCALE_SABBREVMONTHNAME4                = "0x00000047";   -- abbreviated name for April
LOCALE_SABBREVMONTHNAME5                = "0x00000048";   -- abbreviated name for May
LOCALE_SABBREVMONTHNAME6                = "0x00000049";   -- abbreviated name for June
LOCALE_SABBREVMONTHNAME7                = "0x0000004A";   -- abbreviated name for July
LOCALE_SABBREVMONTHNAME8                = "0x0000004B";   -- abbreviated name for August
LOCALE_SABBREVMONTHNAME9                = "0x0000004C";   -- abbreviated name for September
LOCALE_SABBREVMONTHNAME10               = "0x0000004D";   -- abbreviated name for October
LOCALE_SABBREVMONTHNAME11               = "0x0000004E";   -- abbreviated name for November
LOCALE_SABBREVMONTHNAME12               = "0x0000004F";   -- abbreviated name for December
LOCALE_SABBREVMONTHNAME13               = "0x0000100F";   -- abbreviated name for 13th month (if exists)
LOCALE_SPOSITIVESIGN                    = "0x00000050";   -- positive sign
LOCALE_SNEGATIVESIGN                    = "0x00000051";   -- negative sign
LOCALE_IPOSSIGNPOSN                     = "0x00000052";   -- positive sign position
LOCALE_INEGSIGNPOSN                     = "0x00000053";   -- negative sign position
LOCALE_IPOSSYMPRECEDES                  = "0x00000054";   -- mon sym precedes pos amt
LOCALE_IPOSSEPBYSPACE                   = "0x00000055";   -- mon sym sep by space from pos amt
LOCALE_INEGSYMPRECEDES                  = "0x00000056";   -- mon sym precedes neg amt
LOCALE_INEGSEPBYSPACE                   = "0x00000057";   -- mon sym sep by space from neg amt
LOCALE_FONTSIGNATURE                    = "0x00000058";   -- font signature
LOCALE_SISO639LANGNAME                  = "0x00000059";   -- ISO abbreviated language name
LOCALE_SISO3166CTRYNAME                 = "0x0000005A";   -- ISO abbreviated country name
LOCALE_IDEFAULTEBCDICCODEPAGE           = "0x00001012";   -- default ebcdic code page
LOCALE_IPAPERSIZE                       = "0x0000100A";   -- 1 = letter, 5 = legal, 8 = a3, 9 = a4
LOCALE_SENGCURRNAME                     = "0x00001007";   -- english name of currency
LOCALE_SNATIVECURRNAME                  = "0x00001008";   -- native name of currency
LOCALE_SYEARMONTH                       = "0x00001006";   -- year month format string
LOCALE_SSORTNAME                        = "0x00001013";   -- sort name
LOCALE_IDIGITSUBSTITUTION               = "0x00001014";   -- 0 = context, 1 = none, 2 = national

SND_SYNC                                = "0x0000";
SND_ASYNC                               = "0x0001";