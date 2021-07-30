MimeType = {};
local tMimeTypes = {
	Classes = {},
	Ext = ".ico",
	FolderIcon = {
		IconID = -1,
		IconPath = "",		
	},
	MimeTypes = {
		[".3dm"] = {Class="x-world",Des="x-3dmf",IconID=-1,IconPath=""},
		[".3dmf"] = {Class="x-world",Des="x-3dmf",IconID=-1,IconPath=""},
		[".a"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".aab"] = {Class="application",Des="x-authorware-bin",IconID=-1,IconPath=""},
		[".aam"] = {Class="application",Des="x-authorware-map",IconID=-1,IconPath=""},
		[".aas"] = {Class="application",Des="x-authorware-seg",IconID=-1,IconPath=""},
		[".abc"] = {Class="text",Des="vnd.abc",IconID=-1,IconPath=""},
		[".acgi"] = {Class="text",Des="html",IconID=-1,IconPath=""},
		[".afl"] = {Class="video",Des="animaflex",IconID=-1,IconPath=""},
		[".ai"] = {Class="application",Des="postscript",IconID=-1,IconPath=""},
		[".aif"] = {Class="audio",Des="aiff",IconID=-1,IconPath=""},
		[".aif"] = {Class="audio",Des="x-aiff",IconID=-1,IconPath=""},
		[".aifc"] = {Class="audio",Des="aiff",IconID=-1,IconPath=""},
		[".aifc"] = {Class="audio",Des="x-aiff",IconID=-1,IconPath=""},
		[".aiff"] = {Class="audio",Des="aiff",IconID=-1,IconPath=""},
		[".aiff"] = {Class="audio",Des="x-aiff",IconID=-1,IconPath=""},
		[".aim"] = {Class="application",Des="x-aim",IconID=-1,IconPath=""},
		[".aip"] = {Class="text",Des="x-audiosoft-intra",IconID=-1,IconPath=""},
		[".ani"] = {Class="application",Des="x-navi-animation",IconID=-1,IconPath=""},
		[".aos"] = {Class="application",Des="x-nokia-9000-communicator-add-on-software",IconID=-1,IconPath=""},
		[".aps"] = {Class="application",Des="mime",IconID=-1,IconPath=""},
		[".arc"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".arj"] = {Class="application",Des="arj",IconID=-1,IconPath=""},
		[".arj"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".art"] = {Class="image",Des="x-jg",IconID=-1,IconPath=""},
		[".asf"] = {Class="video",Des="x-ms-asf",IconID=-1,IconPath=""},
		[".asm"] = {Class="text",Des="x-asm",IconID=-1,IconPath=""},
		[".asp"] = {Class="text",Des="asp",IconID=-1,IconPath=""},
		[".asx"] = {Class="application",Des="x-mplayer2",IconID=-1,IconPath=""},
		[".asx"] = {Class="video",Des="x-ms-asf",IconID=-1,IconPath=""},
		[".asx"] = {Class="video",Des="x-ms-asf-plugin",IconID=-1,IconPath=""},
		[".au"] = {Class="audio",Des="basic",IconID=-1,IconPath=""},
		[".au"] = {Class="audio",Des="x-au",IconID=-1,IconPath=""},
		[".avi"] = {Class="application",Des="x-troff-msvideo",IconID=-1,IconPath=""},
		[".avi"] = {Class="video",Des="avi",IconID=-1,IconPath=""},
		[".avi"] = {Class="video",Des="msvideo",IconID=-1,IconPath=""},
		[".avi"] = {Class="video",Des="x-msvideo",IconID=-1,IconPath=""},
		[".avs"] = {Class="video",Des="avs-video",IconID=-1,IconPath=""},
		[".bcpio"] = {Class="application",Des="x-bcpio",IconID=-1,IconPath=""},
		[".bin"] = {Class="application",Des="mac-binary",IconID=-1,IconPath=""},
		[".bin"] = {Class="application",Des="macbinary",IconID=-1,IconPath=""},
		[".bin"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".bin"] = {Class="application",Des="x-binary",IconID=-1,IconPath=""},
		[".bin"] = {Class="application",Des="x-macbinary",IconID=-1,IconPath=""},
		[".bm"] = {Class="image",Des="bmp",IconID=-1,IconPath=""},
		[".bmp"] = {Class="image",Des="bmp",IconID=-1,IconPath=""},
		[".bmp"] = {Class="image",Des="x-windows-bmp",IconID=-1,IconPath=""},
		[".boo"] = {Class="application",Des="book",IconID=-1,IconPath=""},
		[".book"] = {Class="application",Des="book",IconID=-1,IconPath=""},
		[".boz"] = {Class="application",Des="x-bzip2",IconID=-1,IconPath=""},
		[".bsh"] = {Class="application",Des="x-bsh",IconID=-1,IconPath=""},
		[".bz"] = {Class="application",Des="x-bzip",IconID=-1,IconPath=""},
		[".bz2"] = {Class="application",Des="x-bzip2",IconID=-1,IconPath=""},
		[".c"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".c"] = {Class="text",Des="x-c",IconID=-1,IconPath=""},
		[".c"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".cat"] = {Class="application",Des="vnd.ms-pki.seccat",IconID=-1,IconPath=""},
		[".cc"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".cc"] = {Class="text",Des="x-c",IconID=-1,IconPath=""},
		[".ccad"] = {Class="application",Des="clariscad",IconID=-1,IconPath=""},
		[".cco"] = {Class="application",Des="x-cocoa",IconID=-1,IconPath=""},
		[".cdf"] = {Class="application",Des="cdf",IconID=-1,IconPath=""},
		[".cdf"] = {Class="application",Des="x-cdf",IconID=-1,IconPath=""},
		[".cdf"] = {Class="application",Des="x-netcdf",IconID=-1,IconPath=""},
		[".cer"] = {Class="application",Des="pkix-cert",IconID=-1,IconPath=""},
		[".cer"] = {Class="application",Des="x-x509-ca-cert",IconID=-1,IconPath=""},
		[".cha"] = {Class="application",Des="x-chat",IconID=-1,IconPath=""},
		[".chat"] = {Class="application",Des="x-chat",IconID=-1,IconPath=""},
		[".class"] = {Class="application",Des="java",IconID=-1,IconPath=""},
		[".class"] = {Class="application",Des="java-byte-code",IconID=-1,IconPath=""},
		[".class"] = {Class="application",Des="x-java-class",IconID=-1,IconPath=""},
		[".com"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".com"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".conf"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".cpio"] = {Class="application",Des="x-cpio",IconID=-1,IconPath=""},
		[".cpp"] = {Class="text",Des="x-c",IconID=-1,IconPath=""},
		[".cpt"] = {Class="application",Des="mac-compactpro",IconID=-1,IconPath=""},
		[".cpt"] = {Class="application",Des="x-compactpro",IconID=-1,IconPath=""},
		[".cpt"] = {Class="application",Des="x-cpt",IconID=-1,IconPath=""},
		[".crl"] = {Class="application",Des="pkcs-crl",IconID=-1,IconPath=""},
		[".crl"] = {Class="application",Des="pkix-crl",IconID=-1,IconPath=""},
		[".crt"] = {Class="application",Des="pkix-cert",IconID=-1,IconPath=""},
		[".crt"] = {Class="application",Des="x-x509-ca-cert",IconID=-1,IconPath=""},
		[".crt"] = {Class="application",Des="x-x509-user-cert",IconID=-1,IconPath=""},
		[".csh"] = {Class="application",Des="x-csh",IconID=-1,IconPath=""},
		[".csh"] = {Class="text",Des="x-script.csh",IconID=-1,IconPath=""},
		[".css"] = {Class="application",Des="x-pointplus",IconID=-1,IconPath=""},
		[".css"] = {Class="text",Des="css",IconID=-1,IconPath=""},
		[".cxx"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".dcr"] = {Class="application",Des="x-director",IconID=-1,IconPath=""},
		[".deepv"] = {Class="application",Des="x-deepv",IconID=-1,IconPath=""},
		[".def"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".der"] = {Class="application",Des="x-x509-ca-cert",IconID=-1,IconPath=""},
		[".dif"] = {Class="video",Des="x-dv",IconID=-1,IconPath=""},
		[".dir"] = {Class="application",Des="x-director",IconID=-1,IconPath=""},
		[".dl"] = {Class="video",Des="dl",IconID=-1,IconPath=""},
		[".dl"] = {Class="video",Des="x-dl",IconID=-1,IconPath=""},
		[".doc"] = {Class="application",Des="msword",IconID=-1,IconPath=""},
		[".dot"] = {Class="application",Des="msword",IconID=-1,IconPath=""},
		[".dp"] = {Class="application",Des="commonground",IconID=-1,IconPath=""},
		[".drw"] = {Class="application",Des="drafting",IconID=-1,IconPath=""},
		[".dump"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".dv"] = {Class="video",Des="x-dv",IconID=-1,IconPath=""},
		[".dvi"] = {Class="application",Des="x-dvi",IconID=-1,IconPath=""},
		[".dwf"] = {Class="drawing",Des="x-dwf|(old)",IconID=-1,IconPath=""},
		[".dwf"] = {Class="model",Des="vnd.dwf",IconID=-1,IconPath=""},
		[".dwg"] = {Class="application",Des="acad",IconID=-1,IconPath=""},
		[".dwg"] = {Class="image",Des="vnd.dwg",IconID=-1,IconPath=""},
		[".dwg"] = {Class="image",Des="x-dwg",IconID=-1,IconPath=""},
		[".dxf"] = {Class="application",Des="dxf",IconID=-1,IconPath=""},
		[".dxf"] = {Class="image",Des="vnd.dwg",IconID=-1,IconPath=""},
		[".dxf"] = {Class="image",Des="x-dwg",IconID=-1,IconPath=""},
		[".dxr"] = {Class="application",Des="x-director",IconID=-1,IconPath=""},
		[".el"] = {Class="text",Des="x-script.elisp",IconID=-1,IconPath=""},
		[".elc"] = {Class="application",Des="x-bytecode.elisp|(compiled|elisp)",IconID=-1,IconPath=""},
		[".elc"] = {Class="application",Des="x-elc",IconID=-1,IconPath=""},
		[".env"] = {Class="application",Des="x-envoy",IconID=-1,IconPath=""},
		[".eps"] = {Class="application",Des="postscript",IconID=-1,IconPath=""},
		[".es"] = {Class="application",Des="x-esrehber",IconID=-1,IconPath=""},
		[".etx"] = {Class="text",Des="x-setext",IconID=-1,IconPath=""},
		[".evy"] = {Class="application",Des="envoy",IconID=-1,IconPath=""},
		[".evy"] = {Class="application",Des="x-envoy",IconID=-1,IconPath=""},
		[".exe"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".f"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".f"] = {Class="text",Des="x-fortran",IconID=-1,IconPath=""},
		[".f77"] = {Class="text",Des="x-fortran",IconID=-1,IconPath=""},
		[".f90"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".f90"] = {Class="text",Des="x-fortran",IconID=-1,IconPath=""},
		[".fdf"] = {Class="application",Des="vnd.fdf",IconID=-1,IconPath=""},
		[".fif"] = {Class="application",Des="fractals",IconID=-1,IconPath=""},
		[".fif"] = {Class="image",Des="fif",IconID=-1,IconPath=""},
		[".fli"] = {Class="video",Des="fli",IconID=-1,IconPath=""},
		[".fli"] = {Class="video",Des="x-fli",IconID=-1,IconPath=""},
		[".flo"] = {Class="image",Des="florian",IconID=-1,IconPath=""},
		[".flx"] = {Class="text",Des="vnd.fmi.flexstor",IconID=-1,IconPath=""},
		[".fmf"] = {Class="video",Des="x-atomic3d-feature",IconID=-1,IconPath=""},
		[".for"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".for"] = {Class="text",Des="x-fortran",IconID=-1,IconPath=""},
		[".fpx"] = {Class="image",Des="vnd.fpx",IconID=-1,IconPath=""},
		[".fpx"] = {Class="image",Des="vnd.net-fpx",IconID=-1,IconPath=""},
		[".frl"] = {Class="application",Des="freeloader",IconID=-1,IconPath=""},
		[".funk"] = {Class="audio",Des="make",IconID=-1,IconPath=""},
		[".g"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".g3"] = {Class="image",Des="g3fax",IconID=-1,IconPath=""},
		[".gif"] = {Class="image",Des="gif",IconID=-1,IconPath=""},
		[".gl"] = {Class="video",Des="gl",IconID=-1,IconPath=""},
		[".gl"] = {Class="video",Des="x-gl",IconID=-1,IconPath=""},
		[".gsd"] = {Class="audio",Des="x-gsm",IconID=-1,IconPath=""},
		[".gsm"] = {Class="audio",Des="x-gsm",IconID=-1,IconPath=""},
		[".gsp"] = {Class="application",Des="x-gsp",IconID=-1,IconPath=""},
		[".gss"] = {Class="application",Des="x-gss",IconID=-1,IconPath=""},
		[".gtar"] = {Class="application",Des="x-gtar",IconID=-1,IconPath=""},
		[".gz"] = {Class="application",Des="x-compressed",IconID=-1,IconPath=""},
		[".gz"] = {Class="application",Des="x-gzip",IconID=-1,IconPath=""},
		[".gzip"] = {Class="application",Des="x-gzip",IconID=-1,IconPath=""},
		[".gzip"] = {Class="multipart",Des="x-gzip",IconID=-1,IconPath=""},
		[".h"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".h"] = {Class="text",Des="x-h",IconID=-1,IconPath=""},
		[".hdf"] = {Class="application",Des="x-hdf",IconID=-1,IconPath=""},
		[".help"] = {Class="application",Des="x-helpfile",IconID=-1,IconPath=""},
		[".hgl"] = {Class="application",Des="vnd.hp-hpgl",IconID=-1,IconPath=""},
		[".hh"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".hh"] = {Class="text",Des="x-h",IconID=-1,IconPath=""},
		[".hlb"] = {Class="text",Des="x-script",IconID=-1,IconPath=""},
		[".hlp"] = {Class="application",Des="hlp",IconID=-1,IconPath=""},
		[".hlp"] = {Class="application",Des="x-helpfile",IconID=-1,IconPath=""},
		[".hlp"] = {Class="application",Des="x-winhelp",IconID=-1,IconPath=""},
		[".hpg"] = {Class="application",Des="vnd.hp-hpgl",IconID=-1,IconPath=""},
		[".hpgl"] = {Class="application",Des="vnd.hp-hpgl",IconID=-1,IconPath=""},
		[".hqx"] = {Class="application",Des="binhex",IconID=-1,IconPath=""},
		[".hqx"] = {Class="application",Des="binhex4",IconID=-1,IconPath=""},
		[".hqx"] = {Class="application",Des="mac-binhex",IconID=-1,IconPath=""},
		[".hqx"] = {Class="application",Des="mac-binhex40",IconID=-1,IconPath=""},
		[".hqx"] = {Class="application",Des="x-binhex40",IconID=-1,IconPath=""},
		[".hqx"] = {Class="application",Des="x-mac-binhex40",IconID=-1,IconPath=""},
		[".hta"] = {Class="application",Des="hta",IconID=-1,IconPath=""},
		[".htc"] = {Class="text",Des="x-component",IconID=-1,IconPath=""},
		[".htm"] = {Class="text",Des="html",IconID=-1,IconPath=""},
		[".html"] = {Class="text",Des="html",IconID=-1,IconPath=""},
		[".htmls"] = {Class="text",Des="html",IconID=-1,IconPath=""},
		[".htt"] = {Class="text",Des="webviewhtml",IconID=-1,IconPath=""},
		[".htx"] = {Class="text",Des="html",IconID=-1,IconPath=""},
		[".ice"] = {Class="x-conference",Des="x-cooltalk",IconID=-1,IconPath=""},
		[".ico"] = {Class="image",Des="x-icon",IconID=-1,IconPath=""},
		[".idc"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".ief"] = {Class="image",Des="ief",IconID=-1,IconPath=""},
		[".iefs"] = {Class="image",Des="ief",IconID=-1,IconPath=""},
		[".iges"] = {Class="application",Des="iges",IconID=-1,IconPath=""},
		[".iges"] = {Class="model",Des="iges",IconID=-1,IconPath=""},
		[".igs"] = {Class="application",Des="iges",IconID=-1,IconPath=""},
		[".igs"] = {Class="model",Des="iges",IconID=-1,IconPath=""},
		[".ima"] = {Class="application",Des="x-ima",IconID=-1,IconPath=""},
		[".imap"] = {Class="application",Des="x-httpd-imap",IconID=-1,IconPath=""},
		[".inf"] = {Class="application",Des="inf",IconID=-1,IconPath=""},
		[".ini"] = {Class="text",Des="windows-settings-file",IconID=-1,IconPath=""},
		[".ins"] = {Class="application",Des="x-internett-signup",IconID=-1,IconPath=""},
		[".ip"] = {Class="application",Des="x-ip2",IconID=-1,IconPath=""},
		[".isu"] = {Class="video",Des="x-isvideo",IconID=-1,IconPath=""},
		[".it"] = {Class="audio",Des="it",IconID=-1,IconPath=""},
		[".iv"] = {Class="application",Des="x-inventor",IconID=-1,IconPath=""},
		[".ivr"] = {Class="i-world",Des="i-vrml",IconID=-1,IconPath=""},
		[".ivy"] = {Class="application",Des="x-livescreen",IconID=-1,IconPath=""},
		[".jam"] = {Class="audio",Des="x-jam",IconID=-1,IconPath=""},
		[".jav"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".jav"] = {Class="text",Des="x-java-source",IconID=-1,IconPath=""},
		[".java"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".java"] = {Class="text",Des="x-java-source",IconID=-1,IconPath=""},
		[".jcm"] = {Class="application",Des="x-java-commerce",IconID=-1,IconPath=""},
		[".jfif"] = {Class="image",Des="jpeg",IconID=-1,IconPath=""},
		[".jfif"] = {Class="image",Des="pjpeg",IconID=-1,IconPath=""},
		[".jfif"] = {Class="image",Des="jpeg",IconID=-1,IconPath=""},
		[".jpe"] = {Class="image",Des="jpeg",IconID=-1,IconPath=""},
		[".jpe"] = {Class="image",Des="pjpeg",IconID=-1,IconPath=""},
		[".jpeg"] = {Class="image",Des="jpeg",IconID=-1,IconPath=""},
		[".jpeg"] = {Class="image",Des="pjpeg",IconID=-1,IconPath=""},
		[".jpg"] = {Class="image",Des="jpeg",IconID=-1,IconPath=""},
		[".jpg"] = {Class="image",Des="pjpeg",IconID=-1,IconPath=""},
		[".jps"] = {Class="image",Des="x-jps",IconID=-1,IconPath=""},
		[".js"] = {Class="application",Des="x-javascript",IconID=-1,IconPath=""},
		[".js"] = {Class="application",Des="javascript",IconID=-1,IconPath=""},
		[".js"] = {Class="application",Des="ecmascript",IconID=-1,IconPath=""},
		[".js"] = {Class="text",Des="javascript",IconID=-1,IconPath=""},
		[".js"] = {Class="text",Des="ecmascript",IconID=-1,IconPath=""},
		[".jut"] = {Class="image",Des="jutvision",IconID=-1,IconPath=""},
		[".kar"] = {Class="audio",Des="midi",IconID=-1,IconPath=""},
		[".kar"] = {Class="music",Des="x-karaoke",IconID=-1,IconPath=""},
		[".ksh"] = {Class="application",Des="x-ksh",IconID=-1,IconPath=""},
		[".ksh"] = {Class="text",Des="x-script.ksh",IconID=-1,IconPath=""},
		[".la"] = {Class="audio",Des="nspaudio",IconID=-1,IconPath=""},
		[".la"] = {Class="audio",Des="x-nspaudio",IconID=-1,IconPath=""},
		[".lam"] = {Class="audio",Des="x-liveaudio",IconID=-1,IconPath=""},
		[".latex"] = {Class="application",Des="x-latex",IconID=-1,IconPath=""},
		[".lha"] = {Class="application",Des="lha",IconID=-1,IconPath=""},
		[".lha"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".lha"] = {Class="application",Des="x-lha",IconID=-1,IconPath=""},
		[".lhx"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".list"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".lma"] = {Class="audio",Des="nspaudio",IconID=-1,IconPath=""},
		[".lma"] = {Class="audio",Des="x-nspaudio",IconID=-1,IconPath=""},
		[".log"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".lsp"] = {Class="application",Des="x-lisp",IconID=-1,IconPath=""},
		[".lsp"] = {Class="text",Des="x-script.lisp",IconID=-1,IconPath=""},
		[".lst"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".lsx"] = {Class="text",Des="x-la-asf",IconID=-1,IconPath=""},
		[".ltx"] = {Class="application",Des="x-latex",IconID=-1,IconPath=""},
		[".lua"] = {Class="text",Des="lua-code-document",IconID=-1,IconPath=""},
		[".lzh"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".lzh"] = {Class="application",Des="x-lzh",IconID=-1,IconPath=""},
		[".lzx"] = {Class="application",Des="lzx",IconID=-1,IconPath=""},
		[".lzx"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".lzx"] = {Class="application",Des="x-lzx",IconID=-1,IconPath=""},
		[".m"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".m"] = {Class="text",Des="x-m",IconID=-1,IconPath=""},
		[".m1v"] = {Class="video",Des="mpeg",IconID=-1,IconPath=""},
		[".m2a"] = {Class="audio",Des="mpeg",IconID=-1,IconPath=""},
		[".m2v"] = {Class="video",Des="mpeg",IconID=-1,IconPath=""},
		[".m3u"] = {Class="audio",Des="x-mpequrl",IconID=-1,IconPath=""},
		[".man"] = {Class="application",Des="x-troff-man",IconID=-1,IconPath=""},
		[".map"] = {Class="application",Des="x-navimap",IconID=-1,IconPath=""},
		[".mar"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".mbd"] = {Class="application",Des="mbedlet",IconID=-1,IconPath=""},
		[".mc"] = {Class="application",Des="x-magic-cap-package-1.0",IconID=-1,IconPath=""},
		[".mcd"] = {Class="application",Des="mcad",IconID=-1,IconPath=""},
		[".mcd"] = {Class="application",Des="x-mathcad",IconID=-1,IconPath=""},
		[".mcf"] = {Class="image",Des="vasa",IconID=-1,IconPath=""},
		[".mcf"] = {Class="text",Des="mcf",IconID=-1,IconPath=""},
		[".mcp"] = {Class="application",Des="netmc",IconID=-1,IconPath=""},
		[".me"] = {Class="application",Des="x-troff-me",IconID=-1,IconPath=""},
		[".mht"] = {Class="message",Des="rfc822",IconID=-1,IconPath=""},
		[".mhtml"] = {Class="message",Des="rfc822",IconID=-1,IconPath=""},
		[".mid"] = {Class="application",Des="x-midi",IconID=-1,IconPath=""},
		[".mid"] = {Class="audio",Des="midi",IconID=-1,IconPath=""},
		[".mid"] = {Class="audio",Des="x-mid",IconID=-1,IconPath=""},
		[".mid"] = {Class="audio",Des="x-midi",IconID=-1,IconPath=""},
		[".mid"] = {Class="music",Des="crescendo",IconID=-1,IconPath=""},
		[".mid"] = {Class="x-music",Des="x-midi",IconID=-1,IconPath=""},
		[".midi"] = {Class="application",Des="x-midi",IconID=-1,IconPath=""},
		[".midi"] = {Class="audio",Des="midi",IconID=-1,IconPath=""},
		[".midi"] = {Class="audio",Des="x-mid",IconID=-1,IconPath=""},
		[".midi"] = {Class="audio",Des="x-midi",IconID=-1,IconPath=""},
		[".midi"] = {Class="music",Des="crescendo",IconID=-1,IconPath=""},
		[".midi"] = {Class="x-music",Des="x-midi",IconID=-1,IconPath=""},
		[".mif"] = {Class="application",Des="x-frame",IconID=-1,IconPath=""},
		[".mif"] = {Class="application",Des="x-mif",IconID=-1,IconPath=""},
		[".mime"] = {Class="message",Des="rfc822",IconID=-1,IconPath=""},
		[".mime"] = {Class="www",Des="mime",IconID=-1,IconPath=""},
		[".mjf"] = {Class="audio",Des="x-vnd.audioexplosion.mjuicemediafile",IconID=-1,IconPath=""},
		[".mjpg"] = {Class="video",Des="x-motion-jpeg",IconID=-1,IconPath=""},
		[".mm"] = {Class="application",Des="base64",IconID=-1,IconPath=""},
		[".mm"] = {Class="application",Des="x-meme",IconID=-1,IconPath=""},
		[".mme"] = {Class="application",Des="base64",IconID=-1,IconPath=""},
		[".mod"] = {Class="audio",Des="mod",IconID=-1,IconPath=""},
		[".mod"] = {Class="audio",Des="x-mod",IconID=-1,IconPath=""},
		[".moov"] = {Class="video",Des="quicktime",IconID=-1,IconPath=""},
		[".mov"] = {Class="video",Des="quicktime",IconID=-1,IconPath=""},
		[".movie"] = {Class="video",Des="x-sgi-movie",IconID=-1,IconPath=""},
		[".mp2"] = {Class="audio",Des="mpeg",IconID=-1,IconPath=""},
		[".mp2"] = {Class="audio",Des="x-mpeg",IconID=-1,IconPath=""},
		[".mp2"] = {Class="video",Des="mpeg",IconID=-1,IconPath=""},
		[".mp2"] = {Class="video",Des="x-mpeg",IconID=-1,IconPath=""},
		[".mp2"] = {Class="video",Des="x-mpeq2a",IconID=-1,IconPath=""},
		[".mp3"] = {Class="audio",Des="mpeg3",IconID=-1,IconPath=""},
		[".mp3"] = {Class="audio",Des="x-mpeg-3",IconID=-1,IconPath=""},
		[".mp3"] = {Class="video",Des="mpeg",IconID=-1,IconPath=""},
		[".mp3"] = {Class="video",Des="x-mpeg",IconID=-1,IconPath=""},
		[".mpa"] = {Class="audio",Des="mpeg",IconID=-1,IconPath=""},
		[".mpa"] = {Class="video",Des="mpeg",IconID=-1,IconPath=""},
		[".mpc"] = {Class="application",Des="x-project",IconID=-1,IconPath=""},
		[".mpe"] = {Class="video",Des="mpeg",IconID=-1,IconPath=""},
		[".mpeg"] = {Class="video",Des="mpeg",IconID=-1,IconPath=""},
		[".mpg"] = {Class="audio",Des="mpeg",IconID=-1,IconPath=""},
		[".mpg"] = {Class="video",Des="mpeg",IconID=-1,IconPath=""},
		[".mpga"] = {Class="audio",Des="mpeg",IconID=-1,IconPath=""},
		[".mpp"] = {Class="application",Des="vnd.ms-project",IconID=-1,IconPath=""},
		[".mpt"] = {Class="application",Des="x-project",IconID=-1,IconPath=""},
		[".mpv"] = {Class="application",Des="x-project",IconID=-1,IconPath=""},
		[".mpx"] = {Class="application",Des="x-project",IconID=-1,IconPath=""},
		[".mrc"] = {Class="application",Des="marc",IconID=-1,IconPath=""},
		[".ms"] = {Class="application",Des="x-troff-ms",IconID=-1,IconPath=""},
		[".mv"] = {Class="video",Des="x-sgi-movie",IconID=-1,IconPath=""},
		[".my"] = {Class="audio",Des="make",IconID=-1,IconPath=""},
		[".mzz"] = {Class="application",Des="x-vnd.audioexplosion.mzz",IconID=-1,IconPath=""},
		[".nap"] = {Class="image",Des="naplps",IconID=-1,IconPath=""},
		[".naplps"] = {Class="image",Des="naplps",IconID=-1,IconPath=""},
		[".nc"] = {Class="application",Des="x-netcdf",IconID=-1,IconPath=""},
		[".ncm"] = {Class="application",Des="vnd.nokia.configuration-message",IconID=-1,IconPath=""},
		[".nif"] = {Class="image",Des="x-niff",IconID=-1,IconPath=""},
		[".niff"] = {Class="image",Des="x-niff",IconID=-1,IconPath=""},
		[".nix"] = {Class="application",Des="x-mix-transfer",IconID=-1,IconPath=""},
		[".nsc"] = {Class="application",Des="x-conference",IconID=-1,IconPath=""},
		[".nvd"] = {Class="application",Des="x-navidoc",IconID=-1,IconPath=""},
		[".o"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".oda"] = {Class="application",Des="oda",IconID=-1,IconPath=""},
		[".omc"] = {Class="application",Des="x-omc",IconID=-1,IconPath=""},
		[".omcd"] = {Class="application",Des="x-omcdatamaker",IconID=-1,IconPath=""},
		[".omcr"] = {Class="application",Des="x-omcregerator",IconID=-1,IconPath=""},
		[".p"] = {Class="text",Des="x-pascal",IconID=-1,IconPath=""},
		[".p10"] = {Class="application",Des="pkcs10",IconID=-1,IconPath=""},
		[".p10"] = {Class="application",Des="x-pkcs10",IconID=-1,IconPath=""},
		[".p12"] = {Class="application",Des="pkcs-12",IconID=-1,IconPath=""},
		[".p12"] = {Class="application",Des="x-pkcs12",IconID=-1,IconPath=""},
		[".p7a"] = {Class="application",Des="x-pkcs7-signature",IconID=-1,IconPath=""},
		[".p7c"] = {Class="application",Des="pkcs7-mime",IconID=-1,IconPath=""},
		[".p7c"] = {Class="application",Des="x-pkcs7-mime",IconID=-1,IconPath=""},
		[".p7m"] = {Class="application",Des="pkcs7-mime",IconID=-1,IconPath=""},
		[".p7m"] = {Class="application",Des="x-pkcs7-mime",IconID=-1,IconPath=""},
		[".p7r"] = {Class="application",Des="x-pkcs7-certreqresp",IconID=-1,IconPath=""},
		[".p7s"] = {Class="application",Des="pkcs7-signature",IconID=-1,IconPath=""},
		[".part"] = {Class="application",Des="pro_eng",IconID=-1,IconPath=""},
		[".pas"] = {Class="text",Des="pascal",IconID=-1,IconPath=""},
		[".pbm"] = {Class="image",Des="x-portable-bitmap",IconID=-1,IconPath=""},
		[".pcl"] = {Class="application",Des="vnd.hp-pcl",IconID=-1,IconPath=""},
		[".pcl"] = {Class="application",Des="x-pcl",IconID=-1,IconPath=""},
		[".pct"] = {Class="image",Des="x-pict",IconID=-1,IconPath=""},
		[".pcx"] = {Class="image",Des="x-pcx",IconID=-1,IconPath=""},
		[".pdb"] = {Class="chemical",Des="x-pdb",IconID=-1,IconPath=""},
		[".pdf"] = {Class="application",Des="pdf",IconID=-1,IconPath=""},
		[".pfunk"] = {Class="audio",Des="make",IconID=-1,IconPath=""},
		[".pfunk"] = {Class="audio",Des="make.my.funk",IconID=-1,IconPath=""},
		[".pgm"] = {Class="image",Des="x-portable-graymap",IconID=-1,IconPath=""},
		[".pgm"] = {Class="image",Des="x-portable-greymap",IconID=-1,IconPath=""},
		[".pic"] = {Class="image",Des="pict",IconID=-1,IconPath=""},
		[".pict"] = {Class="image",Des="pict",IconID=-1,IconPath=""},
		[".pkg"] = {Class="application",Des="x-newton-compatible-pkg",IconID=-1,IconPath=""},
		[".pko"] = {Class="application",Des="vnd.ms-pki.pko",IconID=-1,IconPath=""},
		[".pl"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".pl"] = {Class="text",Des="x-script.perl",IconID=-1,IconPath=""},
		[".plx"] = {Class="application",Des="x-pixclscript",IconID=-1,IconPath=""},
		[".pm"] = {Class="image",Des="x-xpixmap",IconID=-1,IconPath=""},
		[".pm"] = {Class="text",Des="x-script.perl-module",IconID=-1,IconPath=""},
		[".pm4"] = {Class="application",Des="x-pagemaker",IconID=-1,IconPath=""},
		[".pm5"] = {Class="application",Des="x-pagemaker",IconID=-1,IconPath=""},
		[".png"] = {Class="image",Des="png",IconID=-1,IconPath=""},
		[".pnm"] = {Class="application",Des="x-portable-anymap",IconID=-1,IconPath=""},
		[".pnm"] = {Class="image",Des="x-portable-anymap",IconID=-1,IconPath=""},
		[".pot"] = {Class="application",Des="mspowerpoint",IconID=-1,IconPath=""},
		[".pot"] = {Class="application",Des="vnd.ms-powerpoint",IconID=-1,IconPath=""},
		[".pov"] = {Class="model",Des="x-pov",IconID=-1,IconPath=""},
		[".ppa"] = {Class="application",Des="vnd.ms-powerpoint",IconID=-1,IconPath=""},
		[".ppm"] = {Class="image",Des="x-portable-pixmap",IconID=-1,IconPath=""},
		[".pps"] = {Class="application",Des="mspowerpoint",IconID=-1,IconPath=""},
		[".pps"] = {Class="application",Des="vnd.ms-powerpoint",IconID=-1,IconPath=""},
		[".ppt"] = {Class="application",Des="mspowerpoint",IconID=-1,IconPath=""},
		[".ppt"] = {Class="application",Des="powerpoint",IconID=-1,IconPath=""},
		[".ppt"] = {Class="application",Des="vnd.ms-powerpoint",IconID=-1,IconPath=""},
		[".ppt"] = {Class="application",Des="x-mspowerpoint",IconID=-1,IconPath=""},
		[".ppz"] = {Class="application",Des="mspowerpoint",IconID=-1,IconPath=""},
		[".pre"] = {Class="application",Des="x-freelance",IconID=-1,IconPath=""},
		[".prt"] = {Class="application",Des="pro_eng",IconID=-1,IconPath=""},
		[".ps"] = {Class="application",Des="postscript",IconID=-1,IconPath=""},
		[".psd"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".pvu"] = {Class="paleovu",Des="x-pv",IconID=-1,IconPath=""},
		[".pwz"] = {Class="application",Des="vnd.ms-powerpoint",IconID=-1,IconPath=""},
		[".py"] = {Class="text",Des="x-script.phyton",IconID=-1,IconPath=""},
		[".pyc"] = {Class="application",Des="x-bytecode.python",IconID=-1,IconPath=""},
		[".qcp"] = {Class="audio",Des="vnd.qcelp",IconID=-1,IconPath=""},
		[".qd3"] = {Class="x-world",Des="x-3dmf",IconID=-1,IconPath=""},
		[".qd3d"] = {Class="x-world",Des="x-3dmf",IconID=-1,IconPath=""},
		[".qif"] = {Class="image",Des="x-quicktime",IconID=-1,IconPath=""},
		[".qt"] = {Class="video",Des="quicktime",IconID=-1,IconPath=""},
		[".qtc"] = {Class="video",Des="x-qtc",IconID=-1,IconPath=""},
		[".qti"] = {Class="image",Des="x-quicktime",IconID=-1,IconPath=""},
		[".qtif"] = {Class="image",Des="x-quicktime",IconID=-1,IconPath=""},
		[".ra"] = {Class="audio",Des="x-pn-realaudio",IconID=-1,IconPath=""},
		[".ra"] = {Class="audio",Des="x-pn-realaudio-plugin",IconID=-1,IconPath=""},
		[".ra"] = {Class="audio",Des="x-realaudio",IconID=-1,IconPath=""},
		[".ram"] = {Class="audio",Des="x-pn-realaudio",IconID=-1,IconPath=""},
		[".ras"] = {Class="application",Des="x-cmu-raster",IconID=-1,IconPath=""},
		[".ras"] = {Class="image",Des="cmu-raster",IconID=-1,IconPath=""},
		[".ras"] = {Class="image",Des="x-cmu-raster",IconID=-1,IconPath=""},
		[".rast"] = {Class="image",Des="cmu-raster",IconID=-1,IconPath=""},
		[".rexx"] = {Class="text",Des="x-script.rexx",IconID=-1,IconPath=""},
		[".rf"] = {Class="image",Des="vnd.rn-realflash",IconID=-1,IconPath=""},
		[".rgb"] = {Class="image",Des="x-rgb",IconID=-1,IconPath=""},
		[".rm"] = {Class="application",Des="vnd.rn-realmedia",IconID=-1,IconPath=""},
		[".rm"] = {Class="audio",Des="x-pn-realaudio",IconID=-1,IconPath=""},
		[".rmi"] = {Class="audio",Des="mid",IconID=-1,IconPath=""},
		[".rmm"] = {Class="audio",Des="x-pn-realaudio",IconID=-1,IconPath=""},
		[".rmp"] = {Class="audio",Des="x-pn-realaudio",IconID=-1,IconPath=""},
		[".rmp"] = {Class="audio",Des="x-pn-realaudio-plugin",IconID=-1,IconPath=""},
		[".rng"] = {Class="application",Des="ringing-tones",IconID=-1,IconPath=""},
		[".rng"] = {Class="application",Des="vnd.nokia.ringing-tone",IconID=-1,IconPath=""},
		[".rnx"] = {Class="application",Des="vnd.rn-realplayer",IconID=-1,IconPath=""},
		[".roff"] = {Class="application",Des="x-troff",IconID=-1,IconPath=""},
		[".rp"] = {Class="image",Des="vnd.rn-realpix",IconID=-1,IconPath=""},
		[".rpm"] = {Class="audio",Des="x-pn-realaudio-plugin",IconID=-1,IconPath=""},
		[".rt"] = {Class="text",Des="richtext",IconID=-1,IconPath=""},
		[".rt"] = {Class="text",Des="vnd.rn-realtext",IconID=-1,IconPath=""},
		[".rtf"] = {Class="application",Des="rtf",IconID=-1,IconPath=""},
		[".rtf"] = {Class="application",Des="x-rtf",IconID=-1,IconPath=""},
		[".rtf"] = {Class="text",Des="richtext",IconID=-1,IconPath=""},
		[".rtx"] = {Class="application",Des="rtf",IconID=-1,IconPath=""},
		[".rtx"] = {Class="text",Des="richtext",IconID=-1,IconPath=""},
		[".rv"] = {Class="video",Des="vnd.rn-realvideo",IconID=-1,IconPath=""},
		[".s"] = {Class="text",Des="x-asm",IconID=-1,IconPath=""},
		[".s3m"] = {Class="audio",Des="s3m",IconID=-1,IconPath=""},
		[".saveme"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".sbk"] = {Class="application",Des="x-tbook",IconID=-1,IconPath=""},
		[".scm"] = {Class="application",Des="x-lotusscreencam",IconID=-1,IconPath=""},
		[".scm"] = {Class="text",Des="x-script.guile",IconID=-1,IconPath=""},
		[".scm"] = {Class="text",Des="x-script.scheme",IconID=-1,IconPath=""},
		[".scm"] = {Class="video",Des="x-scm",IconID=-1,IconPath=""},
		[".sdml"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".sdp"] = {Class="application",Des="sdp",IconID=-1,IconPath=""},
		[".sdp"] = {Class="application",Des="x-sdp",IconID=-1,IconPath=""},
		[".sdr"] = {Class="application",Des="sounder",IconID=-1,IconPath=""},
		[".sea"] = {Class="application",Des="sea",IconID=-1,IconPath=""},
		[".sea"] = {Class="application",Des="x-sea",IconID=-1,IconPath=""},
		[".set"] = {Class="application",Des="set",IconID=-1,IconPath=""},
		[".sgm"] = {Class="text",Des="sgml",IconID=-1,IconPath=""},
		[".sgm"] = {Class="text",Des="x-sgml",IconID=-1,IconPath=""},
		[".sgml"] = {Class="text",Des="sgml",IconID=-1,IconPath=""},
		[".sgml"] = {Class="text",Des="x-sgml",IconID=-1,IconPath=""},
		[".sh"] = {Class="application",Des="x-bsh",IconID=-1,IconPath=""},
		[".sh"] = {Class="application",Des="x-sh",IconID=-1,IconPath=""},
		[".sh"] = {Class="application",Des="x-shar",IconID=-1,IconPath=""},
		[".sh"] = {Class="text",Des="x-script.sh",IconID=-1,IconPath=""},
		[".shar"] = {Class="application",Des="x-bsh",IconID=-1,IconPath=""},
		[".shar"] = {Class="application",Des="x-shar",IconID=-1,IconPath=""},
		[".shtml"] = {Class="text",Des="html",IconID=-1,IconPath=""},
		[".shtml"] = {Class="text",Des="x-server-parsed-html",IconID=-1,IconPath=""},
		[".sid"] = {Class="audio",Des="x-psid",IconID=-1,IconPath=""},
		[".sit"] = {Class="application",Des="x-sit",IconID=-1,IconPath=""},
		[".sit"] = {Class="application",Des="x-stuffit",IconID=-1,IconPath=""},
		[".skd"] = {Class="application",Des="x-koan",IconID=-1,IconPath=""},
		[".skm"] = {Class="application",Des="x-koan",IconID=-1,IconPath=""},
		[".skp"] = {Class="application",Des="x-koan",IconID=-1,IconPath=""},
		[".skt"] = {Class="application",Des="x-koan",IconID=-1,IconPath=""},
		[".sl"] = {Class="application",Des="x-seelogo",IconID=-1,IconPath=""},
		[".smi"] = {Class="application",Des="smil",IconID=-1,IconPath=""},
		[".smil"] = {Class="application",Des="smil",IconID=-1,IconPath=""},
		[".snd"] = {Class="audio",Des="basic",IconID=-1,IconPath=""},
		[".snd"] = {Class="audio",Des="x-adpcm",IconID=-1,IconPath=""},
		[".sol"] = {Class="application",Des="solids",IconID=-1,IconPath=""},
		[".spc"] = {Class="application",Des="x-pkcs7-certificates",IconID=-1,IconPath=""},
		[".spc"] = {Class="text",Des="x-speech",IconID=-1,IconPath=""},
		[".spl"] = {Class="application",Des="futuresplash",IconID=-1,IconPath=""},
		[".spr"] = {Class="application",Des="x-sprite",IconID=-1,IconPath=""},
		[".sprite"] = {Class="application",Des="x-sprite",IconID=-1,IconPath=""},
		[".src"] = {Class="application",Des="x-wais-source",IconID=-1,IconPath=""},
		[".ssi"] = {Class="text",Des="x-server-parsed-html",IconID=-1,IconPath=""},
		[".ssm"] = {Class="application",Des="streamingmedia",IconID=-1,IconPath=""},
		[".sst"] = {Class="application",Des="vnd.ms-pki.certstore",IconID=-1,IconPath=""},
		[".step"] = {Class="application",Des="step",IconID=-1,IconPath=""},
		[".stl"] = {Class="application",Des="sla",IconID=-1,IconPath=""},
		[".stl"] = {Class="application",Des="vnd.ms-pki.stl",IconID=-1,IconPath=""},
		[".stl"] = {Class="application",Des="x-navistyle",IconID=-1,IconPath=""},
		[".stp"] = {Class="application",Des="step",IconID=-1,IconPath=""},
		[".sv4cpio"] = {Class="application",Des="x-sv4cpio",IconID=-1,IconPath=""},
		[".sv4crc"] = {Class="application",Des="x-sv4crc",IconID=-1,IconPath=""},
		[".svf"] = {Class="image",Des="vnd.dwg",IconID=-1,IconPath=""},
		[".svf"] = {Class="image",Des="x-dwg",IconID=-1,IconPath=""},
		[".svr"] = {Class="application",Des="x-world",IconID=-1,IconPath=""},
		[".svr"] = {Class="x-world",Des="x-svr",IconID=-1,IconPath=""},
		[".swf"] = {Class="application",Des="x-shockwave-flash",IconID=-1,IconPath=""},
		[".t"] = {Class="application",Des="x-troff",IconID=-1,IconPath=""},
		[".talk"] = {Class="text",Des="x-speech",IconID=-1,IconPath=""},
		[".tar"] = {Class="application",Des="x-tar",IconID=-1,IconPath=""},
		[".tbk"] = {Class="application",Des="toolbook",IconID=-1,IconPath=""},
		[".tbk"] = {Class="application",Des="x-tbook",IconID=-1,IconPath=""},
		[".tcl"] = {Class="application",Des="x-tcl",IconID=-1,IconPath=""},
		[".tcl"] = {Class="text",Des="x-script.tcl",IconID=-1,IconPath=""},
		[".tcsh"] = {Class="text",Des="x-script.tcsh",IconID=-1,IconPath=""},
		[".tex"] = {Class="application",Des="x-tex",IconID=-1,IconPath=""},
		[".texi"] = {Class="application",Des="x-texinfo",IconID=-1,IconPath=""},
		[".texinfo"] = {Class="application",Des="x-texinfo",IconID=-1,IconPath=""},
		[".text"] = {Class="application",Des="plain",IconID=-1,IconPath=""},
		[".text"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".tgz"] = {Class="application",Des="gnutar",IconID=-1,IconPath=""},
		[".tgz"] = {Class="application",Des="x-compressed",IconID=-1,IconPath=""},
		[".tif"] = {Class="image",Des="tiff",IconID=-1,IconPath=""},
		[".tif"] = {Class="image",Des="x-tiff",IconID=-1,IconPath=""},
		[".tiff"] = {Class="image",Des="tiff",IconID=-1,IconPath=""},
		[".tiff"] = {Class="image",Des="x-tiff",IconID=-1,IconPath=""},
		[".tr"] = {Class="application",Des="x-troff",IconID=-1,IconPath=""},
		[".tsi"] = {Class="audio",Des="tsp-audio",IconID=-1,IconPath=""},
		[".tsp"] = {Class="application",Des="dsptype",IconID=-1,IconPath=""},
		[".tsp"] = {Class="audio",Des="tsplayer",IconID=-1,IconPath=""},
		[".tsv"] = {Class="text",Des="tab-separated-values",IconID=-1,IconPath=""},
		[".turbot"] = {Class="image",Des="florian",IconID=-1,IconPath=""},
		[".txt"] = {Class="text",Des="plain",IconID=-1,IconPath=""},
		[".uil"] = {Class="text",Des="x-uil",IconID=-1,IconPath=""},
		[".uni"] = {Class="text",Des="uri-list",IconID=-1,IconPath=""},
		[".unis"] = {Class="text",Des="uri-list",IconID=-1,IconPath=""},
		[".unv"] = {Class="application",Des="i-deas",IconID=-1,IconPath=""},
		[".uri"] = {Class="text",Des="uri-list",IconID=-1,IconPath=""},
		[".uris"] = {Class="text",Des="uri-list",IconID=-1,IconPath=""},
		[".ustar"] = {Class="application",Des="x-ustar",IconID=-1,IconPath=""},
		[".ustar"] = {Class="multipart",Des="x-ustar",IconID=-1,IconPath=""},
		[".uu"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".uu"] = {Class="text",Des="x-uuencode",IconID=-1,IconPath=""},
		[".uue"] = {Class="text",Des="x-uuencode",IconID=-1,IconPath=""},
		[".vcd"] = {Class="application",Des="x-cdlink",IconID=-1,IconPath=""},
		[".vcs"] = {Class="text",Des="x-vcalendar",IconID=-1,IconPath=""},
		[".vda"] = {Class="application",Des="vda",IconID=-1,IconPath=""},
		[".vdo"] = {Class="video",Des="vdo",IconID=-1,IconPath=""},
		[".vew"] = {Class="application",Des="groupwise",IconID=-1,IconPath=""},
		[".viv"] = {Class="video",Des="vivo",IconID=-1,IconPath=""},
		[".viv"] = {Class="video",Des="vnd.vivo",IconID=-1,IconPath=""},
		[".vivo"] = {Class="video",Des="vivo",IconID=-1,IconPath=""},
		[".vivo"] = {Class="video",Des="vnd.vivo",IconID=-1,IconPath=""},
		[".vmd"] = {Class="application",Des="vocaltec-media-desc",IconID=-1,IconPath=""},
		[".vmf"] = {Class="application",Des="vocaltec-media-file",IconID=-1,IconPath=""},
		[".voc"] = {Class="audio",Des="voc",IconID=-1,IconPath=""},
		[".voc"] = {Class="audio",Des="x-voc",IconID=-1,IconPath=""},
		[".vos"] = {Class="video",Des="vosaic",IconID=-1,IconPath=""},
		[".vox"] = {Class="audio",Des="voxware",IconID=-1,IconPath=""},
		[".vqe"] = {Class="audio",Des="x-twinvq-plugin",IconID=-1,IconPath=""},
		[".vqf"] = {Class="audio",Des="x-twinvq",IconID=-1,IconPath=""},
		[".vql"] = {Class="audio",Des="x-twinvq-plugin",IconID=-1,IconPath=""},
		[".vrml"] = {Class="application",Des="x-vrml",IconID=-1,IconPath=""},
		[".vrml"] = {Class="model",Des="vrml",IconID=-1,IconPath=""},
		[".vrml"] = {Class="x-world",Des="x-vrml",IconID=-1,IconPath=""},
		[".vrt"] = {Class="x-world",Des="x-vrt",IconID=-1,IconPath=""},
		[".vsd"] = {Class="application",Des="x-visio",IconID=-1,IconPath=""},
		[".vst"] = {Class="application",Des="x-visio",IconID=-1,IconPath=""},
		[".vsw"] = {Class="application",Des="x-visio",IconID=-1,IconPath=""},
		[".w60"] = {Class="application",Des="wordperfect6.0",IconID=-1,IconPath=""},
		[".w61"] = {Class="application",Des="wordperfect6.1",IconID=-1,IconPath=""},
		[".w6w"] = {Class="application",Des="msword",IconID=-1,IconPath=""},
		[".wav"] = {Class="audio",Des="wav",IconID=-1,IconPath=""},
		[".wav"] = {Class="audio",Des="x-wav",IconID=-1,IconPath=""},
		[".wb1"] = {Class="application",Des="x-qpro",IconID=-1,IconPath=""},
		[".wbmp"] = {Class="image",Des="vnd.wap.wbmp",IconID=-1,IconPath=""},
		[".web"] = {Class="application",Des="vnd.xara",IconID=-1,IconPath=""},
		[".wiz"] = {Class="application",Des="msword",IconID=-1,IconPath=""},
		[".wk1"] = {Class="application",Des="x-123",IconID=-1,IconPath=""},
		[".wmf"] = {Class="windows",Des="metafile",IconID=-1,IconPath=""},
		[".wml"] = {Class="text",Des="vnd.wap.wml",IconID=-1,IconPath=""},
		[".wmlc"] = {Class="application",Des="vnd.wap.wmlc",IconID=-1,IconPath=""},
		[".wmls"] = {Class="text",Des="vnd.wap.wmlscript",IconID=-1,IconPath=""},
		[".wmlsc"] = {Class="application",Des="vnd.wap.wmlscriptc",IconID=-1,IconPath=""},
		[".word"] = {Class="application",Des="msword",IconID=-1,IconPath=""},
		[".wp"] = {Class="application",Des="wordperfect",IconID=-1,IconPath=""},
		[".wp5"] = {Class="application",Des="wordperfect",IconID=-1,IconPath=""},
		[".wp5"] = {Class="application",Des="wordperfect6.0",IconID=-1,IconPath=""},
		[".wp6"] = {Class="application",Des="wordperfect",IconID=-1,IconPath=""},
		[".wpd"] = {Class="application",Des="wordperfect",IconID=-1,IconPath=""},
		[".wpd"] = {Class="application",Des="x-wpwin",IconID=-1,IconPath=""},
		[".wq1"] = {Class="application",Des="x-lotus",IconID=-1,IconPath=""},
		[".wri"] = {Class="application",Des="mswrite",IconID=-1,IconPath=""},
		[".wri"] = {Class="application",Des="x-wri",IconID=-1,IconPath=""},
		[".wrl"] = {Class="application",Des="x-world",IconID=-1,IconPath=""},
		[".wrl"] = {Class="model",Des="vrml",IconID=-1,IconPath=""},
		[".wrl"] = {Class="x-world",Des="x-vrml",IconID=-1,IconPath=""},
		[".wrz"] = {Class="model",Des="vrml",IconID=-1,IconPath=""},
		[".wrz"] = {Class="x-world",Des="x-vrml",IconID=-1,IconPath=""},
		[".wsc"] = {Class="text",Des="scriplet",IconID=-1,IconPath=""},
		[".wsrc"] = {Class="application",Des="x-wais-source",IconID=-1,IconPath=""},
		[".wtk"] = {Class="application",Des="x-wintalk",IconID=-1,IconPath=""},
		[".xbm"] = {Class="image",Des="x-xbitmap",IconID=-1,IconPath=""},
		[".xbm"] = {Class="image",Des="x-xbm",IconID=-1,IconPath=""},
		[".xbm"] = {Class="image",Des="xbm",IconID=-1,IconPath=""},
		[".xdr"] = {Class="video",Des="x-amt-demorun",IconID=-1,IconPath=""},
		[".xgz"] = {Class="xgl",Des="drawing",IconID=-1,IconPath=""},
		[".xif"] = {Class="image",Des="vnd.xiff",IconID=-1,IconPath=""},
		[".xl"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xla"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xla"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xla"] = {Class="application",Des="x-msexcel",IconID=-1,IconPath=""},
		[".xlb"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xlb"] = {Class="application",Des="vnd.ms-excel",IconID=-1,IconPath=""},
		[".xlb"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xlc"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xlc"] = {Class="application",Des="vnd.ms-excel",IconID=-1,IconPath=""},
		[".xlc"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xld"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xld"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xlk"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xlk"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xll"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xll"] = {Class="application",Des="vnd.ms-excel",IconID=-1,IconPath=""},
		[".xll"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xlm"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xlm"] = {Class="application",Des="vnd.ms-excel",IconID=-1,IconPath=""},
		[".xlm"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xls"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xls"] = {Class="application",Des="vnd.ms-excel",IconID=-1,IconPath=""},
		[".xls"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xls"] = {Class="application",Des="x-msexcel",IconID=-1,IconPath=""},
		[".xlt"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xlt"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xlv"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xlv"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xlw"] = {Class="application",Des="excel",IconID=-1,IconPath=""},
		[".xlw"] = {Class="application",Des="vnd.ms-excel",IconID=-1,IconPath=""},
		[".xlw"] = {Class="application",Des="x-excel",IconID=-1,IconPath=""},
		[".xlw"] = {Class="application",Des="x-msexcel",IconID=-1,IconPath=""},
		[".xm"] = {Class="audio",Des="xm",IconID=-1,IconPath=""},
		[".xml"] = {Class="application",Des="xml",IconID=-1,IconPath=""},
		[".xml"] = {Class="text",Des="xml",IconID=-1,IconPath=""},
		[".xmz"] = {Class="xgl",Des="movie",IconID=-1,IconPath=""},
		[".xpix"] = {Class="application",Des="x-vnd.ls-xpix",IconID=-1,IconPath=""},
		[".xpm"] = {Class="image",Des="x-xpixmap",IconID=-1,IconPath=""},
		[".xpm"] = {Class="image",Des="xpm",IconID=-1,IconPath=""},
		[".x"] = {Class="image",Des="png",IconID=-1,IconPath=""},
		[".xsr"] = {Class="video",Des="x-amt-showrun",IconID=-1,IconPath=""},
		[".xwd"] = {Class="image",Des="x-xwd",IconID=-1,IconPath=""},
		[".xwd"] = {Class="image",Des="x-xwindowdump",IconID=-1,IconPath=""},
		[".xyz"] = {Class="chemical",Des="x-pdb",IconID=-1,IconPath=""},
		[".z"] = {Class="application",Des="x-compress",IconID=-1,IconPath=""},
		[".z"] = {Class="application",Des="x-compressed",IconID=-1,IconPath=""},
		[".zip"] = {Class="application",Des="x-compressed",IconID=-1,IconPath=""},
		[".zip"] = {Class="application",Des="x-zip-compressed",IconID=-1,IconPath=""},
		[".zip"] = {Class="application",Des="zip",IconID=-1,IconPath=""},
		[".zip"] = {Class="multipart",Des="x-zip",IconID=-1,IconPath=""},
		[".zoo"] = {Class="application",Des="octet-stream",IconID=-1,IconPath=""},
		[".zsh"] = {Class="text",Des="x-script.zsh",IconID=-1,IconPath=""},
	},
	RootFolder = _Icons.."\\MimeTypes",
};



local function ProcessClassesTable()

for sExtension, tMimeType in pairs(tMimeTypes.MimeTypes) do
local bAddMe = true;

	for nClassID, sClass in pairs(tMimeTypes.Classes) do

	if tMimeType.Class == sClass then
		bAddMe = false;
		break;
		end
		
	end
	
	if bAddMe then
	table.insert(tMimeTypes.Classes, 1, tMimeType.Class);
	end
	
end

table.sort(tMimeTypes.Classes);
end




function MimeType.GetFolderIconPath()
return tMimeTypes.FolderIcon.IconPath
end


function MimeType.GetFolderIconID()
return tMimeTypes.FolderIcon.IconID
end


function MimeType.SetFolderIconPath(pFile)
tMimeTypes.FolderIcon.IconPath = pFile;
end


function MimeType.SetFolderIconID(nID)
tMimeTypes.FolderIcon.IconID = nID;
end


function MimeType.GetClassIconPath(sClass)
sClass = string.lower(sClass)
local pRet = "";

if tMimeTypes.Classes[sClass] then
local pIcon = tMimeTypes.RootFolder.."\\class\\"..sClass..tMimeTypes.Ext;
	
	if File.DoesExist(pIcon) then
	pRet = pIcon;
	end
	
end

return pRet
end




function MimeType.Init()
ProcessClassesTable();
--TextFile.WriteFromTable(_ExeFolder.."\\test.lua", tMimeTypes.Classes, false);

MimeType.SetFolderIconPath(tMimeTypes.RootFolder.."\\folder.ico");

for nIndex, sClass in pairs(tMimeTypes.Classes) do
local sFolder = tMimeTypes.RootFolder.."\\ext\\"..sClass;
	
	if Folder.DoesExist(sFolder) then	
	local tIcons = File.Find(sFolder.."\\", "*"..tMimeTypes.Ext, true, false, nil, nil);

		if tIcons then
		
			for nID, pIcon in pairs(tIcons) do	
			local sMimeType = "."..String.SplitPath(pIcon).Filename;
				
				if tMimeTypes.MimeTypes[sMimeType] then				
				tMimeTypes.MimeTypes[sMimeType].IconPath = pIcon;
				end
				
			end
			
		end
	
	end
	
end

end


--make this search through a list of known mietypes and retrun the "unknown file type" icon id for that particular class (such as text, image etc.)
function MimeType.GetIconID(sFileExt)
local nRet = -1;
sFileExt = string.lower(sFileExt);

if tMimeTypes.MimeTypes[sFileExt] then
nRet = tMimeTypes.MimeTypes[sFileExt].IconID
end

return nRet
end



function MimeType.GetIconPath(sFileExt)
local sRet = "";
sFileExt = string.lower(sFileExt);

if tMimeTypes.MimeTypes[sFileExt] then
	
	if File.DoesExist(tMimeTypes.MimeTypes[sFileExt].IconPath) then
	sRet = tMimeTypes.MimeTypes[sFileExt].IconPath;
	
	else
	sRet = MimeType.GetClassIconPath(MimeType.GetClass(sFileExt));
	
	end

end

return sRet
end



function MimeType.GetClass(sFileExt)
sFileExt = string.lower(sFileExt);
local sClass = "";

if tMimeTypes.MimeTypes[sFileExt] then
sClass = tMimeTypes.MimeTypes[sFileExt].Class;
end

return sClass
end


function MimeType.GetTypes()
return tMimeTypes.MimeTypes
end




function MimeType.SetIconID(sFileExt, nID)
sFileExt = string.lower(sFileExt);

if tMimeTypes.MimeTypes[sFileExt] then
tMimeTypes.MimeTypes[sFileExt].IconID = nID;
return true
end

return false
end


function MimeType.SetIconPath(sFileExt, pIcon)
sFileExt = string.lower(sFileExt);

if tMimeTypes.MimeTypes[sFileExt] then
tMimeTypes.MimeTypes[sFileExt].IconPath = pIcon;
return true
end

return false
end


