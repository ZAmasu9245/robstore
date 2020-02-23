NPCRobSystem.plyRobInterface = function()
	-- The rob amount
	local robmoneyamount = NPCRobSystem.Core.FormatFunc(NPCRobSystem.Config.RobAmount)

	-- Creates the base frame
	local frame = vgui.Create( "DFrame" )
	frame:SetSize(ScrW()*0.3, ScrH()*0.3)
	frame:Center()
	frame:SetTitle("")
	frame:SetVisible(true)
	frame:SetDraggable(true)
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame.Paint = function( self, w, h )
		NPCRobSystem.Core.BlurFunc(frame, 3)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
		draw.RoundedBox(0, 0, 0, w, 25, Color(40, 40, 40))
		draw.DrawText("Hold up the store for\n $"..robmoneyamount.."?", "npcrob44", w/2, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end

	-- Creating the close button
	local close = vgui.Create( "DButton", frame )
	close:SetPos(frame:GetWide()-25, 0)
	close:SetSize(25, 25)
	close:SetText("")
	local tablerp = 0
	close.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(100, 0, 0, 255))
		draw.DrawText("X", "npcrob25", w/2, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end
	close.DoClick = function()
		frame:Close()
	end

	-- The button to start a robbery
	local button = vgui.Create( "DButton", frame )
	button:SetSize( frame:GetWide()-40, (frame:GetTall()-49)/2)
	button:SetPos( 20, frame:GetTall()-((button:GetTall())+20) )
	button:SetText("")
	button.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(75, 0, 0, 255))
		draw.DrawText("Rob store!", "npcrob44", w/2, h/2-22, Color(255, 255, 255), TEXT_ALIGN_CENTER )
	end
	button.DoClick = function()
		frame:Close()
		net.Start("ncprobdoact")
		net.SendToServer()
	end

end

net.Receive("ncprobpolicecall", function()
	local entbeingrobbed = net.ReadEntity()

	-- This displays an active robbery notification to the police
	function RobNotificationHUD()
		for _, v in pairs(NPCRobSystem.NPCStores) do
			if v == entbeingrobbed then
				local pos = v:GetPos():ToScreen()
				draw.DrawText(NPCRobSystem.Config.NPCText.." is being robbed!", "npcrob30", pos.x, pos.y-60, Color(255, 0, 0), TEXT_ALIGN_CENTER)
				draw.DrawText("Distance: ".. math.Round(v:GetPos():Distance(LocalPlayer():GetPos())).."m", "npcrob30", pos.x, pos.y-30, Color(255, 255, 255), TEXT_ALIGN_CENTER)
			end
		end
	end
	hook.Add("HUDDrawTargetID", "ROB_GovernmentNotification", RobNotificationHUD)
end)
net.Receive("ncprobpolicecallend", function()
	hook.Remove("HUDDrawTargetID", "ROB_GovernmentNotification")
end)


net.Receive("ncprobdoani",function()
	local targetent = net.ReadEntity()
	targetent:SetSequence( targetent:LookupSequence( NPCRobSystem.Config.RobActiveAni ) )
end)

net.Receive("ncprobdoanires",function()
	local targetent = net.ReadEntity()
	print(targetent)
	targetent:SetSequence( targetent:LookupSequence( "idle_subtle" ) )
end)


