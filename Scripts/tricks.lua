--finds any occurance of a number NOT in the set of digits....if there are none, nil is returned
string.find(sString, '[^%d]', 1)




local tTable = {"First Entry", "Second Entry", "Third Entry", "Fourth Entry", "Fifth Entry"};

local tReversed = {};

for K = #tTable, 1, -1 do
	table.insert(tReversed, tTable[K]);
end







[PHP]local tTable = {};
tTable[1] = "First Entry";
tTable[2] = "Second Entry";
tTable[3] = "Third Entry";
tTable[4] = "Fourth Entry";
tTable[5] = "Fifth Entry";[/PHP]


local tNewTable = {};

if tTable then
local nTotal = Table.Count(tTable);

	for x = 1, nTotal do
	-- I left 'nIndex' here as a local so you can see
	-- what's going on and in case you want to create sub tables.
	local nIndex = (nTotal - x) + 1; 
	tNewTable[x] = tTable[nIndex];
	end

end



DOS Tricks
--[[
& 
 command1 & command2 
 Execute Command1 and then execute Command2
 
&& 
 command1 && command2
 Runs the command2 only when command1 Completed successfully
 
|| 
 command1 || command2
 Runs the second command if the first command had an error
 
() 
 (command1 || command2) || (command3 & command4) 
 Defines the order in which commands are to be executed
 
 
 
 
 
 
 
 
 More Info .. Copied From "ntcmds.chm" Present In "%SystemRoot%\Help"

>
Writes the command output to a file or a device, such as a printer, instead of the Command Prompt window.

<
Reads the command input from a file, instead of reading input from the keyboard.

>>
Appends the command output to the end of a file without deleting the information that is already in the file.

>&
Writes the output from one handle to the input of another handle.

<&
Reads the input from one handle and writes it to the output of another handle.

|
Reads the output from one command and writes it to the input of another command. Also known as a pipe.
 
 
 
 
 
 
Long Commands and long filenames

Under Windows XP, the CMD command line is limited to 8,191 characters.
For all versions of Windows, NTFS and FAT allows pathnames of up to 260 characters.

A workaround for the limited pathname length is to prefix \\?\
for example:
\\?\C:\TEMP\Long_Directory\Long_Filename.txt

 ]]