--use the application's current page background image in this function...just place the image in the DialogEx; DO NOT make it the dialog's background
function TransparentDialog(hWndApp, hWndDialogEx, sImage)
Application.SetRedraw(false);
local tAppSize = Window.GetSize(hWndApp);
local tPos = Window.GetPos(hWndDialogEx);

Image.SetSize(sImage, tAppSize.Width, tAppSize.Height);
Image.SetPos(sImage, -tPos.X - 2, -tPos.Y -2);
Application.SetRedraw(true);
end

--Example Usage
local hWndDialogEx = DialogEx.GetWndHandle();
local hWndApp = Application.GetWndHandle();

TransparentDialog(hWndApp, hWndDialogEx, "img background");


--Add a function to the OnSize Event too...