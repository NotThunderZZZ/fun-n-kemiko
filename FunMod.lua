---@diagnostic disable: deprecated
print("\bt[FM]\bw Fun n' Chemicals loaded!")
tpt.register_keyevent(function (k, c, m, e) 
    if k == "o"and e == 1 and m == 64 then
        tpt.log("Greetings from USA, by 0xHenryMC.")
    elseif k == "," and e == 1 then
        interface.beginInput("Called: interface.beginInput", "This is a prompt", "Hello, World!", "", function(data) 
            if data ~= "" then
                tpt.log(data)
                graphics.drawText(100,100, data)
            elseif data == "" then
                tpt.log("Nothing got entered. Cancelling")
                graphics.drawText(100,100, "Nothin'")
            end
        end
        )
    elseif k == "'" then
        plat.restart()
    end
end)

-- Chemicals
local na = elem.allocate("FUNPK1", "Na")
local k = elem.allocate("FUNPK1", "K")
local kcl = elem.allocate("FUNPK1", "KCL")
local k2so4 = elem.allocate("FUNPK1", "K2SO4")
local p = elem.allocate("FUNPK1", "P4")
local redp = elem.allocate("FUNPK1", "REDP4")

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
elem.property(k, "Name", "K")
elem.property(k, "Description", "Potassium... Expose to Chloride for Potassium Chloride or SO4 for Potassium Sulfate")
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
    elseif nearby == cl then
        sim.partCreate(-2, x-1, y+1, kcl)
        sim.partKill(x,y)
    end

    if sim.partProperty(i, "life") > 0 then
        sim.partProperty(i, "life", sim.partProperty(i, "life") - 2)
    end
end)

elem.property(kcl, "Name", "KCL")
elem.property(kcl, "Description", "Potassium Chloride. TODO: Solute in water for better plant growth.")
elem.property(kcl, "Falldown", 1)
elem.property(kcl, "Advection", 0.03)
elem.property(kcl, "Weight", 50)
elem.property(kcl, "Gravity", 0.04)
elem.property(kcl, "Meltable", 1)
elem.property(kcl, "HighTemperature", 273.15 + 1420)
elem.property(kcl, "HighTemperatureTransition", elem.DEFAULT_PT_LAVA)
elem.property(kcl, "MenuSection", elem.SC_POWDERS)
elem.property(kcl, "MenuVisible", 1)
elem.property(kcl, "Properties", elem.TYPE_PART)
elem.property(kcl, "Colour", 0xfaf9f2)
elem.property(kcl, "Temperature", 22 + 273.15)


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
    elseif nearby == k then
        sim.partCreate(-3, x-1, y+1, kcl)
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
        if tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_H2SO4 and
        tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_HCL and
        tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_NPLM and
        tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_DMND and
        tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_ACID and
        tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_GLAS and
        tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_WATR and -- WATR, for good reason
        tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_DSTW and 
        tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_CAUS and 
        tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_NONE and
        tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_EXGS and
        tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_FIRE and
        tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_SMKE and
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
    if tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_H2SO4 and
    tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_HCL and
    tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_NPLM and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_DMND and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_ACID and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_GLAS and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_WATR and -- WATR, for good reason
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_DSTW and 
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_CAUS and 
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_NONE and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_FIRE and
    tpt.get_property("type",randx,randy) ~= elem.DEFAULT_PT_SMKE and
    tpt.get_property("type",randx,randy) ~= elem.FUNPK1_PT_EXGS and
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
