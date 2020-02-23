AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("storerob_core/config/sh_config.lua")
include("shared.lua")
include("storerob_core/config/sh_config.lua")

local canrob = true
local joballow = false

function ENT:Initialize()
	self:SetModel(NPCRobSystem.Config.RobMoneybagModel)
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()

end

function ENT:AcceptInput(name, activator, caller)
	robmoneyamount = NPCRobSystem.Config.RobAmount
	activator:addMoney( robmoneyamount )
	net.Start( "ncprobmsg" )
		net.WriteString( string.format( "You collected $"..robmoneyamount.." from the moneybag!" ) )
	net.Send(activator)

	self:Remove()
end


function ENT:Think()
end
