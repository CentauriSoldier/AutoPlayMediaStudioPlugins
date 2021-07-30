---------------------------------------------------------------------------
--Function Resize_OnSize;
--This function is in place to reduce the amount of code that must go on
--each pages "On Size" event
---------------------------------------------------------------------------
function Resize_OnSize (PageWidth,PageHeight)
	if bFirstRun then
		setOriginalPageSize(PageWidth,PageHeight);
		bFirstRun = false;
	end
	SetSize(PageWidth,PageHeight);
end

---------------------------------------------------------------------------
--Function Resize_OnPreLoad();
--This function is in place to reduce the amount of code that must go on
--each pages "On Preload" event
---------------------------------------------------------------------------
function Resize_OnPreLoad()
	getOriginalPositions();
	Size = Page.GetSize();
	if not bFirstRun then
		SetSize(Size.Width,Size.Height);
	end
end


-- This is a global variable that is used to determine the first time that 
-- This page has been Accessed
bFirstRun = true;

---------------------------------------------------------------------------
--Function setOriginalPageSize
--This function is used to set a global table with the original page
--size of your project
---------------------------------------------------------------------------
function setOriginalPageSize(WidthO,HeightO)
	-- Store these values in a global table. This action is only
	-- performed once.
	tblOriginalSize = {Width=WidthO,Height=HeightO};
end

---------------------------------------------------------------------------
--Function RevertSize
--This function puts all objects back to their original position and size
--This makes the page look proper if the project is resized on a different
--page.
---------------------------------------------------------------------------
function Resize_OnClose ()
	
	-- Stop the page from redrawing temporarily. If this was not in place
	-- you would see a flash of the original objects before it is resized
	-- when you jump pages.
	Application.SetRedraw(false);
	
	-- The loop will go through all of the entries in the global table tblOriginalPos
	-- and set all of the objects back to their original state.
	for i = 1, Table.Count(tblOriginalPos) do
		-- Get the table that is stored in the global table on every itteration of
		-- the loop
		tblPos = tblOriginalPos[i];
		
		-- The next if -> elseif block determines which type of object
		-- is currently in the table tblPos
		if tblPos.ObType == OBJECT_BUTTON then
			-- If it is a Button then set it back to its original size
			Button.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			-- If it is a Button then set it back to its original Position
			Button.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_LABEL then
			Label.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Label.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_PARAGRAPH then
			Paragraph.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Paragraph.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_IMAGE then
			Image.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Image.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_FLASH then
			Flash.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Flash.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_VIDEO then
			Video.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Video.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_WEB then
			Web.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Web.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_INPUT then
			Input.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Input.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_HOTSPOT then
			Hotspot.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Hotspot.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_LISTBOX then
			ListBox.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			ListBox.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_COMBOBOX then
			ComboBox.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			ComboBox.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_PROGRESS then
			Progress.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Progress.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_TREE then
			Tree.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Tree.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_PLUGIN then	

		end		
	end
end

---------------------------------------------------------------------------
--Function getOriginalPositions
--This function enumerates all objects on the current page. It then stores
--information about the objects in a global table to be used for a 
--reference point to perform the position and size adjustments
--The following information is stored about each object:
-- Object Name
-- Object Type
-- Width
-- Height
-- Position X
-- Position Y
---------------------------------------------------------------------------
function getOriginalPositions ()
	-- The master table that contains information about each object on the page
	tblOriginalPos = {};
	-- The table that will be stored in the above master table. Each objects 
	-- information will be stored in the below table
	Pos = {};
	-- Get all of the objects on a page
	Objects = Page.EnumerateObjects();
	-- Loop through each object on the page
	for i = 1, Table.Count(Objects) do
		-- Find out what TYPE of object it is.
		Type = Page.GetObjectType(Objects[i]);
		-- If it is a Button then
		if Type == OBJECT_BUTTON then
			-- Get the size
			Size = Button.GetSize(Objects[i]);
			-- Get the Position
			Position = Button.GetPos(Objects[i]);
			-- Set the table up to store this information
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_BUTTON};
			-- Store the 'Pos' table in the master table tblOriginalPos
			tblOriginalPos[i] = Pos;	
		elseif Type == OBJECT_LABEL then
			Size = Label.GetSize(Objects[i]);
			Position = Label.GetPos(Objects[i]);	
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_LABEL};
			tblOriginalPos[i] = Pos; 
		elseif Type == OBJECT_PARAGRAPH then
			Size = Paragraph.GetSize(Objects[i]);
			Position = Paragraph.GetPos(Objects[i]);
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_PARAGRAPH};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_IMAGE then
			Size = Image.GetSize(Objects[i]);
			Position = Image.GetPos(Objects[i]);	
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_IMAGE};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_FLASH then
			Size = Flash.GetSize(Objects[i]);
			Position = Flash.GetPos(Objects[i]);
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_FLASH};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_VIDEO then
			Size = Video.GetSize(Objects[i]);
			Position = Video.GetPos(Objects[i]);	
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_VIDEO};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_WEB then
			Size = Web.GetSize(Objects[i]);
			Position = Web.GetPos(Objects[i]);
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_WEB};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_INPUT then
			Size = Input.GetSize(Objects[i]);
			Position = Input.GetPos(Objects[i]);
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_INPUT};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_HOTSPOT then
			Size = Hotspot.GetSize(Objects[i]);
			Position = Hotspot.GetPos(Objects[i]);	
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_HOTSPOT};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_LISTBOX then
			Size = ListBox.GetSize(Objects[i]);
			Position = ListBox.GetPos(Objects[i]);
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_LISTBOX};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_COMBOBOX then
			Size = ComboBox.GetSize(Objects[i]);
			Position = ComboBox.GetPos(Objects[i]);	
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_COMBOBOX};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_PROGRESS then
			Size = Progress.GetSize(Objects[i]);
			Position = Progress.GetPos(Objects[i]);
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_PROGRESS};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_TREE then
			Size = Tree.GetSize(Objects[i]);			
			Position = Tree.GetPos(Objects[i]);
			Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_TREE};
			tblOriginalPos[i] = Pos;
		elseif Type == OBJECT_PLUGIN then	
		end	
	end
end

---------------------------------------------------------------------------
--Function SetSize
--This function is where the calculations for resizing and repositioning
--takes place. It accepts a page Width and Height as parameters. It then
--finds the ration between the original paage size and the current page size.
--Every object on the page is then repositioned and resized by the ration
--of the difference in size.
---------------------------------------------------------------------------
function SetSize (Width,Height)
	-- Get the original size of the page/project
	OriginalWidth = tblOriginalSize.Width;
	OriginalHeight = tblOriginalSize.Height;

	-- Calculate the difference between the original page size and the current
	RatioW = Width / OriginalWidth;
	RatioH = Height  / OriginalHeight;
	
	-- Turn off the redraw
	Application.SetRedraw(false);
	
	-- Now loop through the table that stores information about each object
	--and reposition and resize them according to the above ratio
	for i=1, Table.Count(tblOriginalPos) do
		-- Each item in tblOriginalPos is a table that holds specific informtion about 
		-- that object
		tblProps = tblOriginalPos[i];
		-- If the item is a Button
		if tblProps.ObType == OBJECT_BUTTON then
			-- Set the position of the object
			Button.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			-- Set the size of the object
			Button.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_LABEL then
			Label.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Label.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_PARAGRAPH then
			Paragraph.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Paragraph.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_IMAGE then
			Image.SetPos(tblProps.ObName, tblProps.X * RatioW, tblProps.Y * RatioH);
			Image.SetSize(tblProps.ObName, tblProps.W * RatioW, tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_FLASH then
			Flash.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Flash.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_VIDEO then
			Video.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Video.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_WEB then
			Web.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Web.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_INPUT then
			Input.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Input.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_HOTSPOT then
			Hotspot.SetPos(tblProps.ObName, tblProps.X * RatioW, tblProps.Y * RatioH);
			Hotspot.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_LISTBOX then
			ListBox.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			ListBox.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_COMBOBOX then
			ComboBox.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			ComboBox.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_PROGRESS then
			Progress.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Progress.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_TREE then
			Tree.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Tree.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		end
	end

	-- Allow the page to redraw once all objects have been adjusted
	Application.SetRedraw(true);

end

