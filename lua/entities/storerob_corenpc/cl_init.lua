include("shared.lua")
include("storerob_core/config/sh_config.lua")
include("storerob_core/dermas/cl_fonts.lua")

NPCRobSystem.NPCStores = {}

function ENT:Initialize()
	table.insert(NPCRobSystem.NPCStores, self)

	--self:SetSequence( 85 )
	--print(self:LookupSequence( "Fear_Reaction" ))
	--print(self:SequenceDuration( 85 ))
	--timer.Simple(self:SequenceDuration( 85 ), function()
	--	self:SetSequence( 86 )
	--end)

	--local sequence = self:LookupSequence( "cower_Idle" )
	--self:SetSequence( sequence )

end

function ENT:Draw()
	self:DrawModel()
	local ang = self:GetAngles();

	ang:RotateAroundAxis(ang:Forward(), 90);
	ang:RotateAroundAxis(ang:Right(), -90);

	cam.Start3D2D(self:GetPos()+self:GetUp()*80, Angle(0, self:GetAngles().y+90, 90), 0.07);
		draw.SimpleTextOutlined(NPCRobSystem.Config.NPCText, "npcrob120", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	cam.End3D2D()
	cam.Start3D2D(self:GetPos()+self:GetUp()*80, Angle(180, self:GetAngles().y+90, -90), 0.07);
		draw.SimpleTextOutlined(NPCRobSystem.Config.NPCText, "npcrob120", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	cam.End3D2D()
end

function ENT:OnRemove()
	for k, v in ipairs(NPCRobSystem.NPCStores) do
		if v == self then
			table.remove(NPCRobSystem.NPCStores, k)
		end
	end
end