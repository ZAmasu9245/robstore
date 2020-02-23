AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("storerob_core/config/sh_config.lua")
include("shared.lua")
include("storerob_core/config/sh_config.lua")

local joballow = false

function ENT:Initialize()
	self:SetModel(NPCRobSystem.Config.NPCModel)
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self.data = {}
	self.data.canrob = true
	self.data.robber = nil

	local sequence = self:LookupSequence( "cower" )
	self:SetSequence( sequence )

end

function ENT:AcceptInput(name, activator, caller)

	if activator:IsPlayer() == false then return end

	if timer.Exists("npcrobid"..self:EntIndex()) then
		net.Start("ncprobmsg")
			net.WriteString("The store is currently being robbed! This will take "..math.Round(timer.TimeLeft( "npcrobid"..self:EntIndex() ) ).." more seconds")
		net.Send(activator)
	else
		net.Start("npcstoreui")
		net.Send(activator)
	end

	net.Receive("ncprobdoact", function(name, activator, caller)
		if activator:GetPos():Distance( self:GetPos() ) > 100 then
			net.Start("ncprobmsg")
				net.WriteString("You are too far away to rob the store!")
			net.Send(activator)
			return
		end

		if !(activator:Alive()) then 
			net.Start("ncprobmsg")
				net.WriteString("You are dead!")
			net.Send(activator)
			return
		end

		local joballow = false
		for _, job in pairs(NPCRobSystem.Config.CanRobJobs) do
			if activator:Team() == job then
				joballow = true
				break
			end
		end

		local cops = 0
		for _, job in pairs(NPCRobSystem.Config.ConsideredCops) do
			cops = cops + #team.GetPlayers(job)
		end
 	
		if self.data.canrob == true then
			if joballow == true then
				if ( #player.GetAll() * NPCRobSystem.Config.RobGovernmentAmount ) > cops then
					net.Start("ncprobmsg")
						net.WriteString("Not enough government")
					net.Send(activator)
				elseif ( #player.GetAll() * NPCRobSystem.Config.RobGovernmentAmount ) <= cops then
					if (#player.GetAll() >= NPCRobSystem.Config.RobPlayerAmount) then
						self.data.canrob = false
						self.data.robber = activator
						sound.Add( {
							name = "alarmnoise",
							channel = CHAN_STREAM,
							volume = 1.0,
							level = 80,
							pitch = { 95, 110 },
							sound = NPCRobSystem.Config.RobAlarmDir
						} )

						if NPCRobSystem.Config.RobAlarmActive then
							self:EmitSound("alarmnoise")
						end

						net.Start("ncprobdoani")
							net.WriteEntity(self)
						net.Broadcast()

						net.Start( "ncprobmsg" )
							net.WriteString( string.format( activator:Nick().." is holding up a General Store for $"..NPCRobSystem.Config.RobAmount..", it will be done in "..NPCRobSystem.Config.RobTime.."s" ) )
						net.Broadcast()

						self:EmitSound("vo/npc/male01/help01.wav") 
						timer.Create("npcscream"..self:EntIndex(), math.random(1,NPCRobSystem.Config.RobShouttime), 0, function()
							local ranscream = math.random(1,2)
							if ranscream == 1 then
								self:EmitSound("vo/npc/male01/help01.wav")
							elseif ranscream == 2 then
								self:EmitSound("ambient/voices/m_scream1.wav")
							end
						end)

						for _, v in pairs(player.GetAll()) do
							for _, n in pairs(NPCRobSystem.Config.ConsideredCops) do
								if v:Team() == n then
									net.Start( "ncprobpolicecall" )
										net.WriteEntity(self)
									net.Send(v)
								end
							end
						end


						timer.Create("npcrobid"..self:EntIndex(), NPCRobSystem.Config.RobTime, 1, function()

							self:StopSound("alarmnoise"	)

							net.Start("ncprobdoanires")
								net.WriteEntity(self)
							net.Broadcast()

							self.data.canrob = false
							for _, v in pairs(player.GetAll()) do
								for _, n in pairs(NPCRobSystem.Config.ConsideredCops) do
									if v:Team() == n then
										net.Start( "ncprobpolicecallend" )
										net.Send(v)
									end
								end
							end		

							timer.Destroy("npcscream"..self:EntIndex())
							self.data.robber = nil
							local cops = nil
						 	if activator:IsValid() then
								net.Start( "ncprobmsg" )
									net.WriteString( string.format( activator:Nick().." has robbed a General Store for $"..NPCRobSystem.Config.RobAmount ) )
								net.Broadcast()
							end	
							if NPCRobSystem.Config.RobMoneybagSystem == true then
								local entity = ents.Create( "storerob_moneybag" )
								if ( !IsValid( entity ) ) then return end 
								entity:SetPos( self:GetPos() + Vector(-20,0,60) )
								entity:Spawn()
							elseif NPCRobSystem.Config.RobMoneybagSystem == false then
								activator:addMoney( NPCRobSystem.Config.RobAmount )
							end
							timer.Create("npccooldown"..self:EntIndex(), NPCRobSystem.Config.RobCoodownTime, 1, function()
								if IsValid(self) then
									self.data.canrob = true
								end
	
							end)
						end)
	
					elseif (#player.GetAll() < NPCRobSystem.Config.RobPlayerAmount) then
						net.Start("ncprobmsg")
							net.WriteString("Not enough players")
						net.Send(activator)
					end
				else
					net.Start("ncprobmsg")
						net.WriteString("Not enough government")
					net.Send(activator)
				end

			elseif joballow == false then
				net.Start("ncprobmsg")
					net.WriteString("You are not the right job to rob")
				net.Send(activator)
			end
	
		elseif self.data.canrob == false then
			if timer.Exists("npcrobid"..self:EntIndex()) then
				net.Start("ncprobmsg")
					net.WriteString("The store is currently being robbed! This will take "..math.Round(timer.TimeLeft( "npcrobid"..self:EntIndex() ) ).." more seconds")
				net.Send(activator)
			elseif timer.Exists("npccooldown"..self:EntIndex()) then
				net.Start("ncprobmsg")
					net.WriteString("This NPC can't be robbed for another "..math.Round(timer.TimeLeft( "npccooldown"..self:EntIndex() )).."s!")
				net.Send(activator)
			else 
				self.data.canrob = true
			end
		end

	end)

end


function ENT:RobAbort()
	net.Start("ncprobdoanires")
		net.WriteEntity(self)
	net.Broadcast()
	self:StopSound("alarmnoise"	)
	if !IsValid(self.data.robber) then return end

	timer.Destroy("npcrobid"..self:EntIndex())
	timer.Destroy("npcscream"..self:EntIndex())
	self.data.canrob = false
	for _, v in pairs(player.GetAll()) do
		for _, n in pairs(NPCRobSystem.Config.ConsideredCops) do
			if v:Team() == n then
				net.Start( "ncprobpolicecallend" )
				net.Send(v)
			end
		end
	end	
	timer.Create("npccooldown"..self:EntIndex(), NPCRobSystem.Config.RobCoodownTime, 1, function()
		if IsValid(self) then
			self.data.canrob = true
		end
	end)

	net.Start( "ncprobmsg" )
		net.WriteString( self.data.robber:Nick().." has failed to rob the store for $"..NPCRobSystem.Config.RobAmount )
	net.Broadcast()
	self.data.robber = nil
	local cops = nil

end

function ENT:Think()
	if not IsValid( self.data.robber ) then return end

	if self.data.robber:GetPos():Distance( self:GetPos() ) > NPCRobSystem.Config.RobMaxDistance then
		self:RobAbort()
	end
end

function ENT:OnRemove()
	if timer.Exists("npcrobid"..self:EntIndex()) then
		self:RobAbort()
		timer.Destroy("npccooldown"..self:EntIndex())
	end
end


--
-- Hooks
--


hook.Add( "PlayerDeath", "rob_robberkilled", function( victim, inflictor, attacker )
	for _, npctorob in pairs( ents.FindByClass( "storerob_corenpc" ) ) do
		if npctorob.data.robber == victim then
			npctorob:RobAbort()
		end
	end

end)

hook.Add( "PlayerDisconnected", "rob_robberkilled", function( ply )
	for _, npctorob in pairs( ents.FindByClass( "storerob_corenpc" ) ) do
		if npctorob.data.robber == ply then
			npctorob:RobAbort()
		end
	end

end)

hook.Add("OnPlayerChangedTeam", "rob_robberchangejob", function( ply )
	for _, npctorob in pairs( ents.FindByClass( "storerob_corenpc" ) ) do
		if npctorob.data.robber == ply then
			npctorob:RobAbort()
		end
	end
end)

concommand.Add( "savestorerob", function(ply)

	if !NPCRobSystem.Config.SaveComGroup[ply:GetUserGroup()] then
	net.Start("ncprobmsg")
		net.WriteString("You do not have access to that command!")
	net.Send(ply)
	return
	end

	savedStores = {}
	for i, store in pairs( ents.FindByClass( "storerob_corenpc" ) ) do
		savedStores[ i ] = { pos = store:GetPos(), ang = store:GetAngles() }
		file.Write( "stores/storefile.txt", util.TableToJSON( savedStores ) )
	end

	net.Start("ncprobmsg")
		net.WriteString("NPC's saved")
	net.Send(ply)

end )

