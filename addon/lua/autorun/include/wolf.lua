AddCSLuaFile()

pk_pills.packStart("Foxymations","Foxymations","icon/foxy_mations.png") --the icon of the pill PACK (would be inside material folder, then another folder named icon)

pk_pills.register("pill_bigbadwolf",{ -- to give the PILL ITSELF an icon go into the same materials folder but instead of using the ICON folder put it inside a "pills" folder, and name it the same as your pill_

    printName="The Big Bad Wolf",
	
    model="models/dark/wolf/bigbadwolf.mdl", -- the same name as at the top of the qc just with models/ attatched
	
	modelScale="50",
	
    anims={
        default={
            idle="idle",
			run="run",
            walk="walk",
			attack="kill",
			jumpscare="kill",
            crouch="crouchidle",
            crouch_walk="crouchwalk",
            dead="dead",
            speed="speed",
            twerk="twerk",
            BurntAlive="BurntAlive",
        },
    },
	
    moveSpeed={
        walk=36,
        run=560,
        ducked=100,
    },
	
    sounds={
		jumpscare=pk_pills.helpers.makeList("dark/wolf/kill#.mp3", 3),
        rclick="dark/wolf/path.wav",
    },
	

    type="ply",

    camera={
        dist=120
    },
	
    jumpPower=0,
	
    health=250000,
	
	movePoseMode="xy",
		aim={
		xPose="aim_yaw",
		yPose="aim_pitch",
		nocrosshair = true
	},
	
	canAim=function(ply,ent)
		return ent.active
	end,
	
    --Left Click Attack Function
	attack={
         mode = 'trigger',
    func = function(ply, ent)
        local entity = nil
local targetOrigin = ent:LocalToWorld(Vector(0, 0, 50))
if SherlockHNS then
    entity = SherlockHNS.FindVictim(ply, targetOrigin, 200)
else
    for k, v in pairs(ents.FindInSphere(ent:LocalToWorld(Vector(0, 0, 50)), 200)) do
                if v:IsPlayer() or v:IsNextBot() or v:IsNPC() then
                    if v == ent or v == ply then continue end
                    if (v:IsPlayer() and v:Team() ~= TEAM_SPECTATOR) or (v:IsNPC() or v:IsNextBot()) and v:Health() > 0 then
                        entity = v
                        break
                    end
                end
            end
end

if SherlockHNS and IsValid(entity) and entity:IsPlayer() then
            return pk_pills.playHNSJumpscare(ply, ent, entity, 4.8, {
                camera = "PILLSJUMPCAM",
                offset = 40,
                animation = "jumpscare",
                sound = "jumpscare",
            })
        end

        if IsValid(entity) then
            local pill = ent:GetPuppet()

            -- Handling players
            if entity:IsPlayer() then
                entity:Freeze(true)
                entity:AddFlags(FL_NOTARGET)
                entity:DrawViewModel(false)
                entity:SetActiveWeapon(nil)

                -- Start the jump scare camera effect
                net.Start('PILLSJUMPCAM')
                net.WriteEntity(pill)
                net.WriteBool(true)
                net.Send(entity)
            else
                -- Disable NPC's future thinking to simulate freezing them
                entity:NextThink(CurTime() + 1e9) 
            end

            -- Move the entity into position relative to the pill
            entity:SetPos(pill:GetPos() + pill:GetForward() * 40)

            ply:Freeze(true)

            -- Play the animation and sound for the entity performing the attack
            ent:PillAnim('jumpscare')
            ent:PillSound('jumpscare')

            entity:TakeDamage(1, ply)


            timer.Simple(2.2, function()
                entity:TakeDamage(1, ply)

                local offset = ply:GetRight() * math.Rand(0, 0) +
                pill:GetForward() * math.Rand(40, 40) +
		        ply:GetUp() * math.Rand(80, 80)
                
                local effectdata = EffectData()
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("bloodspray", effectdata)
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("BloodImpact", effectdata)
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("BloodSplash", effectdata)
            end)

             timer.Simple(2.5, function()
                entity:TakeDamage(1, ply)

                local offset = ply:GetRight() * math.Rand(0, 0) +
                pill:GetForward() * math.Rand(40, 40) +
		        ply:GetUp() * math.Rand(80, 80)
                
                local effectdata = EffectData()
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("bloodspray", effectdata)
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("BloodImpact", effectdata)
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("BloodSplash", effectdata)
            end)

            timer.Simple(3, function()
                entity:TakeDamage(1, ply)

                local offset = ply:GetRight() * math.Rand(0, 0) +
                pill:GetForward() * math.Rand(40, 40) +
		        ply:GetUp() * math.Rand(80, 80)
                
                local effectdata = EffectData()
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("bloodspray", effectdata)
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("BloodImpact", effectdata)
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("BloodSplash", effectdata)
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("BloodSplash", effectdata)
                effectdata:SetOrigin(ply:GetPos() + offset)
                effectdata:SetNormal(ent:GetAngles():Forward())
                effectdata:SetMagnitude(3)
                effectdata:SetScale(15)
                effectdata:SetColor(0)
                effectdata:SetFlags(3)
                util.Effect("BloodSplash", effectdata)
            end)

            -- Timer to handle the next steps after the animation
            timer.Simple(4.8, function()
                if not IsValid(entity) or not IsValid(ent) then return end
                -- Handling Players
                if entity:IsPlayer() then
                    local finalRagdoll = ents.Create("prop_ragdoll")
                    finalRagdoll:SetModel(entity:GetModel())
                    finalRagdoll:SetPos(entity:GetPos())
                    finalRagdoll:SetAngles(entity:GetAngles())
                    finalRagdoll:Spawn()
                    timer.Simple(5, function()
                        finalRagdoll:Remove()
                    end)

                    -- Set ragdoll physics
                    for i = 0, entity:GetBoneCount() - 1 do
                        local phys = finalRagdoll:GetPhysicsObjectNum(i)
                        if IsValid(phys) then
                            local pos, ang = entity:GetBonePosition(i)
                            phys:SetPos(pos)
                            phys:SetAngles(ang)
                            phys:Wake()
                        end
                    end   
                end

                -- Freeze and reset player settings
                ply:Freeze(false)

                -- Kill the player or damage the NPC
                if entity:IsPlayer() then
                    entity:TakeDamage(999999, ply)
                    net.Start('PILLSJUMPCAM')
                    net.WriteEntity(pill)
                    net.WriteBool(false)
                    net.Send(entity)
                    entity:RemoveFlags(FL_NOTARGET)
                    entity:Freeze(false)
                    entity:DrawViewModel(true)
                else
                    entity:NextThink(CurTime()) 
                    entity:TakeDamage(1e9, ply)
                end
            end)
        else
            -- No valid target, perform normal attack animation
        end

        timer.Simple(3, function()
            ply.OnHold = false
        end)
    end,
    },
	
    --Right Click Attack Function
	attack2={
        mode = "trigger",
        func = function(ply, ent)

    end,
},
    

noragdoll=true,
	
	-- R click function
    reload = function(ply, ent)
        ent:PillAnim("speed",true)
    end,
	
    
    flashlight=function(ply,ent)
        
    end,
	
	-- Jump Attack Spacebar Function 
    jump=function(ply,ent)
        
    end
}, function(form)
    -- The legacy damage branches are for Sandbox and NPCs.
    form.hnsKillAPI = true
    form.hnsAbilities = {
        { id = "attack", name = "Ataque", key = IN_ATTACK, OnUse = form.attack.func },
        { id = "run", name = "Animação de corrida", key = IN_RELOAD, OnUse = form.reload },
    }
    form.attack, form.attack2, form.reload = nil, nil, nil
end)


hook.Add( "PlayerFootstep", "bigbadwolfStepFix", function( ply, pos, foot, sound, volume, rf )
	if ply.pk_pill_ent and ply.pk_pill_ent.formTable and ply.pk_pill_ent.formTable.name and ply.pk_pill_ent.formTable.name == "pill_bigbadwolf" then
        return true
    end
end )