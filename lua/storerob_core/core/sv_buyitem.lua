net.Receive("ncpstoredoact", function(len, pl)
	-- Remaps the table
	local TABLE = net.ReadTable()
	local buyer = pl
	local usergroupaccess = false

	-- Is the user the right user group?
	for b, n in pairs(NPCRobSystem.Config.RestrictedGroups) do
		if buyer:IsUserGroup(n) then 
			usergroupaccess = true
			break
		end
	end

	-- A few checks to make sure no cheating is happening
	for k, v in pairs(NPCRobSystem.Config.ShopContent) do
		if TABLE.ent == v.ent then
			if TABLE.price == v.price then
				if buyer:getDarkRPVar("money") >= v.price then
					if v.restrict == true then
						if usergroupaccess == true then

							-- Spawns the brought item
							local entity = ents.Create( v.ent )
							if ( !IsValid( entity ) ) then return end 
							entity:SetPos( buyer:GetPos() + Vector(-20,0,0) )
							entity:Spawn()
							buyer:addMoney(-v.price)
							net.Start( "ncpshopmsg" )
								net.WriteString( string.format( "You brought "..v.name.." for $"..v.price.."!" ) )
							net.Send(buyer)
							break

						else
							-- Chat message informing user they are not the right group
							net.Start( "ncpshopmsg" )
								net.WriteString( string.format( "You are not the right rank to buy "..v.name ) )
							net.Send(buyer)
							break
						end
					else
						-- Spawns the item
						local entity = ents.Create( v.ent )
						if ( !IsValid( entity ) ) then return end 
						entity:SetPos( buyer:GetPos() + Vector(-20,0,0) )
						entity:Spawn()
						buyer:addMoney(-v.price)
						net.Start( "ncpshopmsg" )
							net.WriteString( string.format( "You brought "..v.name.." for $"..v.price.."!" ) )
						net.Send(buyer)
						break
					end
				elseif buyer:getDarkRPVar("money") < v.price then
					-- Tells the user they don't have enough money
					net.Start( "ncpshopmsg" )
						net.WriteString( string.format( "Not enough money to buy "..v.name ) )
					net.Send(buyer)
					break
				end
			end
		end
	end
end)

