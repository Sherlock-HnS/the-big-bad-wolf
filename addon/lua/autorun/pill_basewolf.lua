if !pcall(require,"pk_pills") then
	if SERVER then
		hook.Add("PlayerInitialSpawn","pk_pill_extfail_cl",function(ply)
			if game.SinglePlayer() || ply:IsListenServerHost() then
				ply:SendLua('notification.AddLegacy("One or more pill extensions failed to load. Did you forget to install Parakeet\'s Pill Pack?",NOTIFY_ERROR,30)')
			end
		end)
		hook.Add("Initialize","pk_pill_extfail_sv",function(ply)
			print("[ALERT] One or more pill extensions failed to load. Did you forget to install Parakeet's Pill Pack?")
		end)
	end
	return
end

AddCSLuaFile()
include("include/wolf.lua")

if SERVER then
	util.AddNetworkString('PILLSJUMPCAM')
end

if CLIENT then
	net.Receive('PILLSJUMPCAM', function()
		local ply = LocalPlayer()
		local ent = net.ReadEntity()
		local state = net.ReadBool()
		local hookname = 'IM_GAYYYY_GAY' .. tostring(ply)

		if not state then
			hook.Remove('CalcView', hookname)
			return
		end

		local transitionStart = RealTime()

		hook.Add('CalcView', hookname, function(ply, pos, angles, fov)
			if not IsValid(ply) or not ply:Alive() or not IsValid(ent) then
				hook.Remove('CalcView', hookname)
				return
			end	
			local transitionProgress = math.Clamp((RealTime() - transitionStart) / 0.25, 0, 1)
			local cam = ent:GetAttachment(1)


			return {
				origin = LerpVector(transitionProgress, pos, cam.Pos),
				angles = LerpAngle(transitionProgress, angles, cam.Ang),
				fov = 80,
				drawviewer = false
			}
		end)
	end)
end