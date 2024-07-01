---@diagnostic disable: deprecated
--[[
---------------------------------------
Fun and Chemicals mod
By 0xHenryMC and moches (for suggestions)
---------------------------------------
Presenting...
The best of TPT Lua API abus- i mean...
More 13 fun and destructive elements for you to enjoy

--
Name (In-game Symbol)     In game desc
Sodium (NA):              Sodium... Yeah, explode violently in water
Potassium (K):            Potassium... Heats up in water
White Phosphorus (P4):    White phosphorus. Very unethical for use on stickmen or fighters.
Red Phosphorus (P4):      Red phosphorus. Not very reactive. Cure it with heat and >7 pressure.
Flashbang (FBNG):         WIP
Potassium Fluoride (KF):  Potassium Fluoride. Use it as cleaner because it kills bacteria.
Chloride (CL):            Chloride. Harmful to stickmen & fighters
Extinguish Gas (EXGS):    Extinguish gas. Created to effectively treat white phosphorus, though it can also extinguish coal and wood as well...
Methane (CH4):            Methane gas. Flammability on another level
Ammonia (NH3):            Ammonia.
... and much much more!
]]

----------------------- Chemistry -----------------------
print("\bt[FM]\bw Fun n' Chemicals loaded!")
print("\bt[FM]\bw Fights against ads!")
tpt.register_keyevent(function (k, c, m, e) 
    if k == "o"and e == 1 and m == 64+256 then
        tpt.log("Greetings from USA, by 0xHenryMC.")
    elseif k == "," and e == 1 then
        interface.beginInput("Called: interface.beginInput", "This is a prompt", "Hello, World!", "", function(data) 
            if data == "restart" then
                tpt.log("Restarting...")
                plat.restart()
            end
            if data ~= nil then
                tpt.log(data)
                graphics.drawText(100,100, data)
            elseif data == "" then
                tpt.log("Nothing got entered. Cancelling")
                graphics.drawText(100,100, "Nothin'")
            end
        end)
    end
end)

-- Chemicals
local na = elem.allocate("FUNPK1", "Na")
local k = elem.allocate("FUNPK1", "K")
local p = elem.allocate("FUNPK1", "P4")
local redp = elem.allocate("FUNPK1", "REDP4")
local fb = elem.allocate("FUNPK1", "FB")

---- Sodium ----
elem.property(na, "Name", "NA")
elem.property(na, "Description", "Sodium... Yeah, explode violently in water")
elem.property(na, "Falldown", 1)
elem.property(na, "Advection", 0.03)
elem.property(na, "Weight", 20)
elem.property(na, "Gravity", 0.08)
elem.property(na, "Meltable", 1)
elem.property(na, "HighTemperature", 273.15 + 882.8)
elem.property(na, "HighTemperatureTransition", elem.DEFAULT_PT_LAVA)
elem.property(na, "MenuSection", elem.SC_EXPLOSIVE)
elem.property(na, "MenuVisible", 1)
elem.property(na, "Properties", elem.PROP_CONDUCTS + elem.TYPE_PART)
elem.property(na, "Colour", 0xF3F4FD)
elem.property(na, "Temperature", 22 + 273.15)
elem.property(na, "Update", function (i,x,y,s,n)
    local thatx = x+math.random(-1,1)
    local thaty = y+math.random(-1,1)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == elem.DEFAULT_PT_WATR or
    nearby == elem.DEFAULT_PT_DSTW or 
    nearby == elem.DEFAULT_PT_SNOW or 
    nearby == elem.DEFAULT_PT_ICE then 
        sim.partCreate(-3, x+1, y+1, elem.DEFAULT_PT_FIRE)
        tpt.set_property("life", 80, x+1, y+1)
        tpt.set_property("temp", tpt.get_property("temp", x+1, y+1) + math.random(81, 931), x, y-1)
        tpt.set_property("temp", sim.partProperty(i, "temp") + math.random(19, 31), x, y)
        sim.partProperty(i, "tmp", sim.partProperty(i, "tmp") + 1)
        sim.pressure((x/4),(y/4), 1)
        sim.partKill(thatx, thaty)
    elseif nearby == cl then
        sim.partCreate(-2, x-1, y+1, elem.DEFAULT_PT_SALT)
        sim.partKill(x,y)
    end
    if sim.partProperty(i, "life") > 0 then
        sim.partProperty(i, "life", sim.partProperty(i, "life") - 2)
    end
    if sim.partProperty(i, "tmp") == 200 then sim.pressure((x/4),(y/4), 200); local plm = sim.partCreate(-3, x, y+3, elem.DEFAULT_PT_BOMB); sim.partProperty(i, "temp", 9000); sim.partKill(i); end
end)
elem.property(na, "Graphics", function(i, colr, colg, colb)
    return 1, ren.PMODE_GLOW, colr, colg, colb
end)

---- Potassium ----
local kf = elem.allocate("FUNPK1", "KF")
elem.property(k, "Name", "K")
elem.property(k, "Description", "Potassium... Heats up in water")
elem.property(k, "Falldown", 1)
elem.property(k, "Weight", 50)
elem.property(k, "Advection", 0.03)
elem.property(k, "Gravity", 0.04)
elem.property(k, "Meltable", 1)
elem.property(k, "HighTemperature", 273.15 + 758.8)
elem.property(k, "HighTemperatureTransition", elem.DEFAULT_PT_LAVA)
elem.property(k, "MenuSection", elem.SC_POWDERS)
elem.property(k, "MenuVisible", 1)
elem.property(k, "Properties", elem.PROP_CONDUCTS + elem.TYPE_PART)
elem.property(k, "Colour", 0xfaf9f2)
elem.property(k, "Temperature", 22 + 273.15)
elem.property(k, "Update", function (i,x,y,s,n)
    local thatx = x+math.random(-1,1)
    local thaty = y+math.random(-1,1)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == elem.DEFAULT_PT_WATR or
    nearby == elem.DEFAULT_PT_DSTW or 
    nearby == elem.DEFAULT_PT_SLTW or 
    nearby == elem.DEFAULT_PT_SNOW or 
    nearby == elem.DEFAULT_PT_ICE then 
        tpt.set_property("temp", sim.partProperty(i, "temp") + 12, i)
        sim.pressure((x/4),(y/4), 0.1)
    elseif nearby == elem.FUNPK1_PT_F2 then
        sim.partCreate(-2, x-1, y+1, elem.FUNPK1_PT_KF)
        sim.partKill(x,y)
    end

    if sim.partProperty(i, "life") ~= nil and sim.partProperty(i, "life") > 0 then
        sim.partProperty(i, "life", sim.partProperty(i, "life") - 2)
    end
end)

elem.property(kf, "Name", "KF")
elem.property(kf, "Description", "Potassium Fluoride. Use it as cleaner because it kills bacteria.")
elem.property(kf, "Falldown", 1)
elem.property(kf, "Weight", 50)
elem.property(kf, "Advection", 0.03)
elem.property(kf, "Gravity", 0.04)
elem.property(kf, "Meltable", 1)
elem.property(kf, "HighTemperature", 273.15 + 758.8)
elem.property(kf, "HighTemperatureTransition", elem.DEFAULT_PT_LAVA)
elem.property(kf, "MenuSection", elem.SC_POWDERS)
elem.property(kf, "MenuVisible", 1)
elem.property(kf, "Properties", elem.PROP_CONDUCTS + elem.TYPE_PART)
elem.property(kf, "Colour", 0xfaf9f2)
elem.property(kf, "Temperature", 22 + 273.15)
elem.property(kf, "Update", function (i,x,y,s,n)
    local thatx = x+math.random(-1,1)
    local thaty = y+math.random(-1,1)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == elem.DEFAULT_PT_WATR or
    nearby == elem.DEFAULT_PT_DSTW or 
    nearby == elem.DEFAULT_PT_SLTW then
        sim.partKill(x, y)
        local owo = sim.partCreate(-1, x-1, y, elem.FUNPK2_PT_CLNW)
        tpt.set_property("tmp", 5, thatx, thaty)
    end
end)


---- White (and Red) Phosphorus ----
elem.property(p, "Name", "P4")
elem.property(p, "Description", "White phosphorus. Very unethical for use on stickmen or fighters.")
elem.property(p, "Falldown", 1)
elem.property(p, "Advection", 0.088)
elem.property(p, "Weight", 75)
elem.property(p, "Gravity", 0.09)
elem.property(p, "MenuSection", elem.SC_POWDERS)
elem.property(p, "MenuVisible", 1)
elem.property(p, "Properties", elem.TYPE_PART + elem.PROP_DEADLY)
elem.property(p, "Colour", 0xfaf9f2)
elem.property(p, "Temperature", 22 + 273.15)
elem.property(p, "Update", function (i,x,y,s,n)
    local _ = sim.partCreate(-2, x, y-1, elem.DEFAULT_PT_FIRE)
    sim.partProperty(_, "temp", 273.15 + 250)
    local randx = x+math.random(-1,1)
    local randy = y+math.random(-1,1)
    if sim.partProperty(i, "tmp2") ~= nil and sim.partProperty(i, "tmp2") == 0 then sim.partProperty(i, "tmp", sim.partProperty(i, "tmp")+1) end
    if tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_P4 and 
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_DMND and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_ACID and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_FIRE and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_WATR and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_DSTW and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_SLTW and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_SMKE and
    tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_REDP4 and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_NONE
    then 
        if math.random(1, 20) == 1 and tpt.get_property("type",randx,y+1) ~= elem.FUNPK1_PT_P4 and 
        tpt.get_property("type",randx,y+1) ~= elem.DEFAULT_PT_DMND and
        tpt.get_property("type",randx,y+1) ~= elem.DEFAULT_PT_ACID and
        tpt.get_property("type",randx,y+1) ~= elem.DEFAULT_PT_FIRE and
        tpt.get_property("type",randx,y+1) ~= elem.DEFAULT_PT_WATR and
        tpt.get_property("type",randx,y+1) ~= elem.DEFAULT_PT_DSTW and
        tpt.get_property("type",randx,y+1) ~= elem.DEFAULT_PT_SLTW and
        tpt.get_property("type",randx,y+1) ~= elem.DEFAULT_PT_SMKE and
        tpt.get_property("type",randx,y+1) ~= elem.DEFAULT_PT_NONE then sim.partKill(randx, y+1) end
    end
    if sim.partProperty(i, "tmp") ~= nil and sim.partProperty(i, "tmp") > 1200 and
    sim.partProperty(i, "tmp2") ~= nil and sim.partProperty(i, "tmp2") == 0 then 
        sim.partKill(i)
        sim.partCreate(-3, x, y, elem.FUNPK1_PT_REDP4)
    end
end)

elem.property(redp, "Name", "P4")
elem.property(redp, "Description", "Red phosphorus. Not very reactive. Cure it with heat and >7 pressure.")
elem.property(redp, "Falldown", 1)
elem.property(redp, "Advection", 0.018)
elem.property(redp, "Weight", 75)
elem.property(redp, "Gravity", 0.1)
elem.property(redp, "MenuSection", elem.SC_POWDERS)
elem.property(redp, "MenuVisible", 1)
elem.property(redp, "Properties", elem.TYPE_PART)
elem.property(redp, "Colour", 0xb86b58)
elem.property(redp, "Temperature", 22 + 273.15)
elem.property(redp, "Update", function (i, x, y, s, n) 
    if sim.partProperty(i, "temp") ~= nil and sim.partProperty(i, "temp") > 310
    and sim.pressure(x/4, y/4) ~= nil and sim.pressure(x/4, y/4) > 7 then
        sim.partKill(i)
        sim.partCreate(-3, x, y, elem.FUNPK1_PT_P4)
    end
end)

-- Gases
local cl = elem.allocate("FUNPK1", "Cl")
local exgs = elem.allocate("FUNPK1", "EXGS")
local ammonia = elem.allocate("FUNPK1", "NH3")
local methane = elem.allocate("FUNPK1", "CH4")
elem.property(cl, "Name", "CL")
elem.property(cl, "Description", "Chloride. Harmful to stickmen & fighters")
elem.property(cl, "Falldown", 0)
elem.property(cl, "Weight", 1)
elem.property(cl, "Advection", 0.03)
elem.property(cl, "Gravity", -0.03)
elem.property(cl, "Diffusion", 0.75)
elem.property(cl, "MenuSection", elem.SC_GAS)
elem.property(cl, "MenuVisible", 1)
elem.property(cl, "Properties", elem.TYPE_GAS + elem.PROP_DEADLY)
elem.property(cl, "Colour", 0xAAE868)
elem.property(cl, "Temperature", 22 + 273.15)
elem.property(cl, "Update", function (i,x,y,s,n)
    local thatx = x+math.random(-5,5)
    local thaty = y+math.random(-5,5)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == na then
        sim.partCreate(-3, x-1, y+1, elem.DEFAULT_PT_SALT)
        sim.partKill(x, y)
    elseif nearby == elem.DEFAULT_PT_HYGN then
        sim.partCreate(-3, x, y-1, elem.FUNPK1_PT_HCL)
        sim.partKill(x, y)
    elseif nearby == elem.DEFAULT_PT_STKM or
    nearby == elem.DEFAULT_PT_STK2 or
    nearby == elem.DEFAULT_PT_FIGH then
        tpt.set_property("life", tpt.get_property("life",thatx,thaty) - 5, thatx, thaty)
    end
end) 

elem.property(exgs, "Name", "EXGS")
elem.property(exgs, "Description", "Extinguish gas. Created to effectively treat white phosphorus, though it can also extinguish coal and wood as well...")
elem.property(exgs, "Falldown", 0)
elem.property(exgs, "Weight", 41)
elem.property(exgs, "Advection", 0.007)
elem.property(exgs, "Gravity", 0.024)
elem.property(exgs, "Diffusion", 0.1)
elem.property(exgs, "MenuSection", elem.SC_GAS)
elem.property(exgs, "MenuVisible", 1)
elem.property(exgs, "Properties", elem.TYPE_GAS)
elem.property(exgs, "Colour", 0x505050)
elem.property(exgs, "Temperature", 22 + 273.15)

elem.property(methane, "Name", "CH4")
elem.property(methane, "Description", "Methane gas. Flammability on another level")
elem.property(methane, "Falldown", 0)
elem.property(methane, "Weight", 1)
elem.property(methane, "Flammable", 600)
elem.property(methane, "Advection", 0.007)
elem.property(methane, "Gravity", -0.002)
elem.property(methane, "Diffusion", 0.36)
elem.property(methane, "MenuSection", elem.SC_GAS)
elem.property(methane, "MenuVisible", 1)
elem.property(methane, "Properties", elem.TYPE_GAS)
elem.property(methane, "Colour", 0x808080)
elem.property(methane, "Temperature", 22 + 273.15)

elem.property(ammonia, "Name", "NH3")
elem.property(ammonia, "Description", "Ammonia.")
elem.property(ammonia, "Falldown", 0)
elem.property(ammonia, "Weight", 1)
elem.property(ammonia, "Flammable", 250)
elem.property(ammonia, "Advection", 0.007)
elem.property(ammonia, "Gravity", -0.002)
elem.property(ammonia, "Diffusion", 0.4)
elem.property(ammonia, "MenuSection", elem.SC_GAS)
elem.property(ammonia, "MenuVisible", 1)
elem.property(ammonia, "Properties", elem.TYPE_GAS)
elem.property(ammonia, "Colour", 0x393912)
elem.property(ammonia, "Temperature", 22 + 273.15)
elem.property(ammonia, "Update", function (i,x,y,s,n)
    local thatx = x+math.random(-5,5)
    local thaty = y+math.random(-5,5)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == elem.DEFAULT_PT_WATR then
        if tpt.get_property("type", thatx, thaty) == elem.DEFAULT_PT_BHOL or tpt.get_property("type", thatx, thaty) == elem.DEFAULT_PT_WATR then 
            sim.partKill(thatx, thaty)
        end
        sim.partKill(thatx, thaty)
        sim.partCreate(-1, thatx, thaty, elem.DEFAULT_PT_DSTW)
        sim.partCreate(-1, thatx, y-1, elem.DEFAULT_PT_DSTW)
    end
end) 


local neon = elem.allocate("FUNPK1", "NEON")
elem.property(neon, "Name", "NEON")
elem.property(neon, "Description", "Neon. Spark it to glow")
elem.property(neon, "Falldown", 0)
elem.property(neon, "Advection", 0.018)
elem.property(neon, "Weight", 1)
elem.property(neon, "Gravity", -0.001)
elem.property(neon, "MenuSection", elem.SC_GAS)
elem.property(neon, "MenuVisible", 1)
elem.property(neon, "Properties", elem.TYPE_GAS + elem.PROP_CONDUCTS)
elem.property(neon, "Colour", 0x202020)
elem.property(neon, "Diffusion", 0.001)
elem.property(neon, "Temperature", 22 + 273.15)
elem.property(neon, "Update", function (i, x, y, s, n) 
    local thatx = x+math.random(-5,5)
    local thaty = y+math.random(-5,5)
    local nearby = tpt.get_property("type",thatx,thaty);
    if sim.partProperty(i, "life") == 4 then sim.partProperty(i, "life", 0); sim.partProperty(i, "tmp", 1) end
end)
elem.property(neon, "Graphics", function (i, r, g, b)
    if sim.partProperty(i, "tmp") ~= nil and sim.partProperty(i, "tmp") == 1 then 
        return 0,ren.FIRE_BLEND+ren.NO_DECO,255,255,255,125,255,255,125 
    end
    return 0,ren.FIRE_BLEND+ren.NO_DECO,255,r,g,b,r/2,g/2,b/2
end)

-- Sulfur and its relatives
local sul = elem.allocate("FUNPK1", "SULF")
local sulo2 = elem.allocate("FUNPK1", "SO2")
local sulo3 = elem.allocate("FUNPK1", "SO3")
local bpd = elem.allocate("FUNPK1", "BKP")

elem.property(sul, "Name", "SULF")
elem.property(sul, "Description", "Sulfur. Used for black powder and H2SO4 production.")
elem.property(sul, "Falldown", 1)
elem.property(sul, "Flammable", 50)
elem.property(sul, "Advection", 0.018)
elem.property(sul, "Weight", 75)
elem.property(sul, "Gravity", 0.1)
elem.property(sul, "MenuSection", elem.SC_EXPLOSIVE)
elem.property(sul, "MenuVisible", 1)
elem.property(sul, "Properties", elem.TYPE_PART + elem.PROP_DEADLY)
elem.property(sul, "Colour", 0xf2e607)
elem.property(sul, "Temperature", 22 + 273.15)
elem.property(sul, "Update", function (i, x, y, s, n) 
    local thatx = x+math.random(-5,5)
    local thaty = y+math.random(-5,5)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == elem.DEFAULT_PT_FIRE or nearby == elem.DEFAULT_PT_PLSM then 
        sim.partCreate(-3, x-1, y-1, elem.FUNPK1_PT_SO2)
        sim.partKill(x, y)
    elseif nearby == elem.DEFAULT_PT_BCOL then
        if tpt.get_property("type", thatx, thaty) == elem.DEFAULT_PT_BHOL then 
            sim.partKill(thatx, thaty)
        end
        sim.partKill(thatx, thaty)
        sim.partCreate(-1, x, y-1, elem.FUNPK1_PT_BKP)
    end
end)

elem.property(sulo2, "Name", "SO2")
elem.property(sulo2, "Description", "Sulfur dioxide. Turn into Sulfur Trioxide after exposed to oxygen")
elem.property(sulo2, "Falldown", 0)
elem.property(sulo2, "Advection", 0.018)
elem.property(sulo2, "Weight", 1)
elem.property(sulo2, "Gravity", -0.001)
elem.property(sulo2, "MenuSection", elem.SC_GAS)
elem.property(sulo2, "MenuVisible", 0)
elem.property(sulo2, "Properties", elem.TYPE_GAS + elem.PROP_DEADLY)
elem.property(sulo2, "Diffusion", 0.001)
elem.property(sulo2, "Colour", 0x020202)
elem.property(sulo2, "Temperature", 22 + 273.15)
elem.property(sulo2, "Update", function (i, x, y, s, n) 
    local thatx = x+math.random(-5,5)
    local thaty = y+math.random(-5,5)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == elem.DEFAULT_PT_OXYG then 
        sim.partCreate(-3, x-1, y+1, elem.FUNPK1_PT_SO3)
        sim.partKill(x, y)
    end
end)

elem.property(sulo3, "Name", "SO3")
elem.property(sulo3, "Description", "Sulfur dioxide. Turn into Sulfur Trioxide after exposed to oxygen")
elem.property(sulo3, "Falldown", 0)
elem.property(sulo3, "Advection", 0.018)
elem.property(sulo3, "Weight", 1)
elem.property(sulo3, "Gravity", -0.001)
elem.property(sulo3, "MenuSection", elem.SC_GAS)
elem.property(sulo3, "MenuVisible", 0)
elem.property(sulo3, "Properties", elem.TYPE_GAS + elem.PROP_DEADLY)
elem.property(sulo3, "Colour", 0x232524)
elem.property(sulo3, "Diffusion", 0.001)
elem.property(sulo3, "Temperature", 22 + 273.15)
elem.property(sulo3, "Update", function (i, x, y, s, n) 
    local thatx = x+math.random(-5,5)
    local thaty = y+math.random(-5,5)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == elem.DEFAULT_PT_WTRV then 
        sim.partCreate(-3, x-1, y+1, elem.FUNPK1_PT_H2SO4)
        sim.partKill(x, y)
    end
end)

elem.property(bpd, "Name", "BPWD")
elem.property(bpd, "Description", "Black powder. Think of it...")
elem.property(bpd, "Falldown", 1)
elem.property(bpd, "Weight", 49)
-- elem.property(bpd, "Flammable", 500)
-- elem.property(bpd, "Explosive", 1)
elem.property(bpd, "Gravity", 0.06)
elem.property(bpd, "MenuSection", elem.SC_EXPLOSIVE)
elem.property(bpd, "MenuVisible", 1)
elem.property(bpd, "Properties", elem.TYPE_PART + elem.PROP_DEADLY)
elem.property(bpd, "Colour", 0x323337)
elem.property(bpd, "Temperature", 22 + 273.15)
elem.property(bpd, "HighPressure", 5)
elem.property(bpd, "HighPressureTransition", elem.DEFAULT_PT_FIRE)
elem.property(bpd, "HighTemperature", 273.15 + 392)
elem.property(bpd, "HighTemperatureTransition", elem.DEFAULT_PT_FIRE)
elem.property(bpd, "Update", function (i, x, y, s, n)
    local thatx = x+math.random(-5,5)
    local thaty = y+math.random(-5,5)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == elem.DEFAULT_PT_FIRE or nearby == elem.DEFAULT_PT_PLSM then 
        sim.partProperty(i, "temp", math.random(4999, 5999))
        sim.partCreate(-3, x+math.random(-1,1), y+1, elem.DEFAULT_PT_FIRE)
        sim.pressure((x-4)/4,(y-4)/4,50)
        sim.partKill(i)
    end
end)


-- Liquids
local sulfuric = elem.allocate("FUNPK1", "H2SO4")
local hcl = elem.allocate("FUNPK1", "HCL")
local nplm = elem.allocate("FUNPK1", "NPLM")
elem.property(sulfuric, "Name", "H2SO4")
elem.property(sulfuric, "Description", "Sulfuric Acid. Very powerful corrosive compound. EXTREME OXIDIZER!! Turn into toxic gas and plasma when burn.")
elem.property(sulfuric, "Falldown", 2)
elem.property(sulfuric, "Weight", 21)
elem.property(sulfuric, "Gravity", 0.04)
elem.property(sulfuric, "MenuSection", elem.SC_LIQUID)
elem.property(sulfuric, "MenuVisible", 1)
elem.property(sulfuric, "Properties", elem.TYPE_LIQUID + elem.PROP_DEADLY)
elem.property(sulfuric, "Colour", 0xbf9280)
elem.property(sulfuric, "Temperature", 22 + 273.15)
elem.property(sulfuric, "Update", function (i,x,y,s,n)
    local thatx = x+math.random(-5,5)
    local thaty = y+math.random(-5,5)
    local nearby = tpt.get_property("type",thatx,thaty);
    if nearby == elem.DEFAULT_PT_FIRE or nearby == elem.DEFAULT_PT_PLSM then
        sim.partProperty(i, "type", elem.DEFAULT_PT_PLSM)
        sim.partProperty(i, "life", math.random(120,440))
        sim.partProperty(i, "temp", math.random(1910,2440))
        sim.pressure((x/4),(y/4), 4, 4, 2)
    else
        local randx = x+math.random(-1,1)
        local randy = y+math.random(-1,1)
        if sim.partProperty(i, "tmp") == 16 then sim.partKill(i) end
        local nearby = tpt.get_property("type",randx,randy)
        if nearby ~= nil and nearby ~= elem.FUNPK1_PT_H2SO4 and
        nearby ~= elem.FUNPK1_PT_HCL and
        nearby ~= elem.FUNPK1_PT_NPLM and
        nearby ~= elem.DEFAULT_PT_DMND and
        nearby ~= elem.DEFAULT_PT_ACID and
        nearby ~= elem.DEFAULT_PT_GLAS and
        nearby ~= elem.DEFAULT_PT_WATR and -- WATR, for good reason
        nearby ~= elem.DEFAULT_PT_DSTW and 
        nearby ~= elem.DEFAULT_PT_CAUS and 
        nearby ~= elem.DEFAULT_PT_NONE and
        nearby ~= elem.DEFAULT_PT_FIRE and
        bit.band(elem.property(nearby, "Properties"), elem.TYPE_GAS) == 0 and
        bit.band(elem.property(nearby, "Properties"), elem.TYPE_ENERGY) == 0 and
        sim.partProperty(i, "tmp") ~= nil
        then
            sim.partProperty(i, "temp", sim.partProperty(i, "temp") + math.random(19,25))
            if math.random(1, 5) == 1 then sim.partProperty(i, "tmp", sim.partProperty(i, "tmp") + 2); sim.partKill(randx, randy) end
        elseif tpt.get_property("type",randx,randy) == elem.DEFAULT_PT_WATR or tpt.get_property("type",randx,randy) == elem.DEFAULT_PT_DSTW or tpt.get_property("type", randx, randy) == elem.DEFAULT_PT_SLTW then
            sim.partProperty(i, "temp", 273.15 + math.random(112,125))
            local that = sim.partCreate(-3, x-1, y+1, elem.DEFAULT_PT_CAUS); sim.partProperty(that, "life", 250); if tpt.get_property("type",x,y) ~= elem.DEFAULT_PT_CAUS then sim.partKill(x,y) end
        end
        if sim.partProperty(i, "temp") ~= nil and sim.partProperty(i, "temp") > 273.15 + 337 then
            local that = sim.partCreate(-3, x, y-1, elem.DEFAULT_PT_CAUS)
            sim.partProperty(that, "life", 500)
            sim.partKill(i)
        end
    end
end)

elem.property(hcl, "Name", "HCL")
elem.property(hcl, "Description", "HCl (Hydrochloric Acid). Safer than H2SO4! Gives heat after eating something")
elem.property(hcl, "Falldown", 2)
elem.property(hcl, "Weight", 19)
elem.property(hcl, "Gravity", 0.04)
elem.property(hcl, "MenuSection", elem.SC_LIQUID)
elem.property(hcl, "MenuVisible", 1)
elem.property(hcl, "HighTemperature", 273.15 + 503)
elem.property(hcl, "HighTemperatureTransition", elem.DEFAULT_PT_FIRE)
elem.property(hcl, "Properties", elem.TYPE_LIQUID + elem.PROP_DEADLY)
elem.property(hcl, "Colour", 0xd9e3bf)
elem.property(hcl, "Temperature", 22 + 273.15)
elem.property(hcl, "Update", function (i,x,y,s,n)
    local randx = x+math.random(-1,1)
    local randy = y+math.random(-1,1)
    local nearby = tpt.get_property("type",randx,randy)
    if nearby ~= nil and nearby ~= elem.FUNPK1_PT_H2SO4 and
    nearby ~= elem.FUNPK1_PT_HCL and
    nearby ~= elem.FUNPK1_PT_NPLM and
    nearby ~= elem.DEFAULT_PT_DMND and
    nearby ~= elem.DEFAULT_PT_ACID and
    nearby ~= elem.DEFAULT_PT_GLAS and
    nearby ~= elem.DEFAULT_PT_WATR and -- WATR, for good reason
    nearby ~= elem.DEFAULT_PT_DSTW and 
    nearby ~= elem.DEFAULT_PT_CAUS and 
    nearby ~= elem.DEFAULT_PT_NONE and
    nearby ~= elem.DEFAULT_PT_FIRE and
    bit.band(elem.property(nearby, "Properties"), elem.TYPE_GAS) == 0 and
    bit.band(elem.property(nearby, "Properties"), elem.TYPE_ENERGY) == 0 and
    sim.partProperty(i, "tmp") ~= nil
    then
        sim.partKill(randx, randy)
        sim.partProperty(i, "temp", sim.partProperty(i, "temp") + 31)
        sim.partProperty(i, "tmp", sim.partProperty(i, "tmp") + 2)
        if sim.partProperty(i, "tmp") == 10 then sim.partCreate(0, x, y-1, elem.DEFAULT_PT_HYGN); sim.partKill(i) end
    elseif tpt.get_property("type",randx,randy) == elem.DEFAULT_PT_WATR then
        sim.partProperty(i, "temp", 273.15 + math.random(98,119))
        if math.random(1, 2) == 1 then sim.partCreate(-2, x-1, y+1, elem.DEFAULT_PT_CAUS); if tpt.get_property("type",x,y) ~= elem.DEFAULT_PT_CAUS then sim.partKill(x,y) end end
    end
    if sim.partProperty(i, "temp") ~= nil and sim.partProperty(i, "temp") > 273.15 + 110 then
        local that = sim.partCreate(-3, x, y-1, elem.DEFAULT_PT_CAUS)
        sim.partProperty(that, "life", 150)
        sim.partKill(i)
    end
end)

elem.property(nplm, "Name", "NPLM")
elem.property(nplm, "Description", "Napalm. Mixture of thickener and petrol (irl).")
elem.property(nplm, "Falldown", 2)
elem.property(nplm, "Weight", 19)
elem.property(nplm, "Gravity", 0.04)
elem.property(nplm, "MenuSection", elem.SC_EXPLOSIVE)
elem.property(nplm, "MenuVisible", 1)
elem.property(nplm, "HighTemperature", 273.15 + 503)
elem.property(nplm, "HighTemperatureTransition", elem.DEFAULT_PT_FIRE)
elem.property(nplm, "Properties", elem.TYPE_LIQUID + elem.PROP_DEADLY)
elem.property(nplm, "Colour", 0xFF2003)
elem.property(nplm, "Temperature", 22 + 273.15)
elem.property(nplm, "Update", function (i,x,y,s,n) -- Just realized that i can use Flammability in Properties... :')
    local randx = x + math.random(-2, 2)
    local randy = y + math.random(-1, 1)
    local nearby = tpt.get_property("type", randx, randy)
    if nearby == elem.DEFAULT_PT_FIRE or nearby == elem.DEFAULT_PT_PLSM then
        sim.partProperty(i, "temp", sim.partProperty(i, "temp") + 12)
        sim.partProperty(i, "tmp", sim.partProperty(i, "tmp") + 1)
    end
    if sim.partProperty(i, "tmp") > 0 and sim.partProperty(i, "tmp") < 300 then 
        sim.partProperty(i, "tmp", sim.partProperty(i, "tmp") + 1)
        if tpt.get_property("type", x, y+1) == elem.FUNPK1_PT_NPLM then 
            tpt.set_property("life", 1, x, y+1)
        end
        sim.partCreate(-2, x + math.random(0,5), y-math.random(0,5), elem.DEFAULT_PT_FIRE)
    elseif sim.partProperty(i, "tmp") == 300 then 
        sim.partKill(i)
    end
    if sim.partProperty(i, "life") == 1 then 
        if tpt.get_property("type", x, y-1) == elem.DEFAULT_PT_NONE then sim.partProperty(i, "tmp", sim.partProperty(i, "tmp")) end
    end
    if nearby == elem.FUNPK1_PT_NPLM and sim.partProperty(i, "tmp") > 0 then 
        tpt.set_property("tmp", 1, randx, y)
    end
end)

-- spekial
local f = elem.allocate("FUNPK1", "F2")
local bac = elem.allocate("FUNPK1", "BACT")
elem.property(fb, "Name", "FBNG")
elem.property(fb, "Description", "Flashbang.")
elem.property(fb, "Falldown", 0)
elem.property(fb, "Weight", 1)
elem.property(fb, "Gravity", 0)
elem.property(fb, "MenuSection", elem.SC_SPECIAL)
elem.property(fb, "MenuVisible", 1)
elem.property(fb, "Properties", elem.TYPE_SOLID + elem.PROP_LIFE_KILL_DEC)
elem.property(fb, "Colour", 0xFF2003)
elem.property(fb, "Temperature", 22 + 273.15)
elem.property(fb, "Update", function (i,x,y,s,n) -- Just realized that i can use Flammability in Properties... :')
    if sim.partProperty(i, "life") ~= nil and sim.partProperty(i, "tmp") ~= nil and
    sim.partProperty(i, "tmp") == 0
    then
        local alpha = 250
        function dr()
            if sim.partProperty(i, "life") ~= nil and
            sim.partProperty(i, "life") <= 10 then
                return false
            else
                graphics.fillRect(0,0,graphics.WIDTH, graphics.HEIGHT, 255,255,255,alpha)
                alpha = alpha - 12
            end
        end
        event.register(evt.BEFORESIMDRAW, dr)
        sim.partProperty(i, "life", 50)
        sim.partProperty(i, "tmp", 1)
    else 
        sim.partProperty(i, "life", sim.partProperty(i, "life") - 1)
    end
    if sim.partProperty(i, "life") ~= nil and sim.partProperty(i, "life") == 0 then
        sim.partKill(i);
    elseif sim.partProperty(i, "life") ~= nil and sim.partProperty(i, "life") == 10 then 
        event.unregister(evt.BEFORESIMDRAW, dr)
    end
end)
elem.property(fb, "ChangeType", function (i, x, y, t, ntype)
    if t == 0 then return nil  else
        event.unregister(evt.BEFORESIMDRAW, dr)
    end
end)

local fran = elem.allocate("FUNPK1", "OGNS")
elem.property(fran, "Name", "FRAN")
elem.property(fran, "Description", "France- Wait, it's Francium")
elem.property(fran, "Colour", 0xABE828)
elem.property(fran, "Falldown", 1)
elem.property(fran, "Properties", elem.TYPE_PART)
elem.property(fran, "Weight", 50)
elem.property(fran, "Gravity", 0.3)
elem.property(fran, "MenuSection", elem.SC_POWDERS)
elem.property(fran, "MenuVisible", 1)
elem.property(fran, "Properties", elem.TYPE_PART)
elem.property(fran, "Update", function (i,x,y,s,n)
    if math.random(1,100) == 21 then sim.partCreate(-3, x, y+1, elem.DEFAULT_PT_NEUT) end
    if sim.partProperty(i, "life") ~= nil and sim.partProperty(i, "tmp") ~= nil and
    sim.partProperty(i, "tmp") == 0
    then
        sim.partProperty(i, "life", math.random(200, 880))
        sim.partProperty(i, "tmp", 1)
    end
    if sim.partProperty(i, "life") ~= nil and sim.partProperty(i, "life") == 0 then 
        sim.partKill(i) 
    end
    if sim.partProperty(i, "life") ~= nil then sim.partProperty(i, "life", sim.partProperty(i, "life") -  1)
        sim.partProperty(i, "temp", 273.15 + 230) 
    end
end)

local bouncy = elem.allocate("FUNPK1", "BNCY")
elem.property(bouncy, "Name", "BNCY")
elem.property(bouncy, "Description", "Bouncy things")
elem.property(bouncy, "Colour", 0xFC2010)
elem.property(bouncy, "Falldown", 1)
elem.property(bouncy, "Loss", 1)
elem.property(bouncy, "Collision", -1.2)
elem.property(bouncy, "Properties", elem.TYPE_PART)
elem.property(bouncy, "Weight", 50)
elem.property(bouncy, "Gravity", 0.8)
elem.property(bouncy, "MenuSection", elem.SC_POWDERS)
elem.property(bouncy, "MenuVisible", 1)
elem.property(bouncy, "Properties", elem.TYPE_PART)

elem.property(f, "Name", "F2")
elem.property(f, "Description", "Fluorine")
elem.property(f, "Colour", 0xbdd149)
elem.property(f, "Falldown", 0)
elem.property(f, "Weight", 1)
elem.property(f, "Properties", elem.TYPE_GAS, elem.PROP_DEADLY)
elem.property(f, "Advection", 0.007)
elem.property(f, "Gravity", -0.002)
elem.property(f, "Diffusion", 0.09)
elem.property(f, "MenuSection", elem.SC_GAS)
elem.property(f, "MenuVisible", 1)
elem.property(f, "Update", function (i,x,y,s,n)
    local randx = x + math.random(-2, 2)
    local randy = y + math.random(-1, 1)
    local nearby = tpt.get_property("type", randx, randy)
    if nearby == elem.FUNPK1_PT_K then
        sim.partKill(randx, randy)
        sim.partCreate(-2, randx, randy, kf)
    end
end)

----------------------- Fun & Misc -----------------------
local btra = elem.allocate("FUNPK2", "BTRA")
local infw = elem.allocate("FUNPK2", "INFW")
local clnw = elem.allocate("FUNPK2", "CLNW")

elem.property(btra, "Name", "BTRA")
elem.property(btra, "Description", "Bacteria. WIP floating gas")
elem.property(btra, "Colour", 0x00cf01)
elem.property(btra, "Falldown", 0)
elem.property(btra, "Weight", 1)
elem.property(btra, "Properties", elem.TYPE_GAS + elem.PROP_DEADLY + elem.PROP_HOT_GLOW)
elem.property(btra, "Advection", 0.03)
elem.property(btra, "Gravity", -0.03)
elem.property(btra, "Diffusion", 0.75)
elem.property(btra, "MenuSection", elem.SC_SPECIAL)
elem.property(btra, "MenuVisible", 1)
elem.property(btra, "Update", function (i,x,y,s,n)
    local thatx = x + math.random(-1,1)
    local thaty = y + math.random(-1,1)
    local nearby = tpt.get_property("type", thatx, thaty)
    if bit.band(elem.property(nearby, "Properties"), elem.PROP_DEADLY)
    and sim.partProperty(i, "life") ~= nil then 
        sim.partProperty(i, "life", sim.partProperty(i, "life") - 1)
    end
    if sim.partProperty(i, "life") ~= nil and
    sim.partProperty(i, "life") == 0 then 
        sim.partKill(i)
    end
end)
elem.property(btra, "Create", function (i,x,y,s,n)
    sim.partProperty(i, "life", 100)
end)
