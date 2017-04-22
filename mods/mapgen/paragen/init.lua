-- paragen 0.1.0 by paramat
-- For latest stable Minetest and back to 0.4.3
-- Depends default
-- Licenses: Code WTFPL. Texture: CC BY-SA, redstone is a desert stone texture by celeron55

-- Variables

local ONGEN = true -- (true / false) Enable / disable generation.

local XMIN = -16000 -- Approx West edge. -- These parameters will be rounded down or up to chunk edges.
local XMAX = 16000 -- Approx East edge.
local ZMIN = -16000 -- Approx South edge.
local ZMAX = 16000 -- Approx North edge.
local YMIN = 12000 -- Approx bottom.
local YMAX = 12080 -- Approx top.

local GRAD = 40 -- Surface generating noise gradient. Controls height of hills.
local PERSAV = 0.5 --  -- Persistence average. Terrain roughness.
local PERSAMP = 0.1 --  -- Persistence amplitude. Roughness variation.
local STAV = 0.05 --  -- Stone threshold average. Sand depth.
local STAMP = 0.05 --  -- Stone threshold amplitude. Depth variation.

local FISTS = 0.01 --  -- Fissure threshold surface. Fissure size at surface.
local CAVTS = 1.4 --  -- Cave threshold surface. Cave size at surface.
local FISTU = 0.03 --  -- Fissure threshold underground. Fissure size underground.
local CAVTU = 0.5 --  -- Cave threshold underground. Cave size underground.

local PROG = true

-- 3D Perlin1 for terrain
local perl1 = {
	SEED1 = 5829058,
	OCTA1 = 6, --
	SCAL1 = 256, --
}

-- 2D Perlin2 for alt terrain
local perl2 = {
	SEED2 = 76906,
	OCTA2 = 6, --
	SCAL2 = 207, --
}

-- 3D Perlin3 for terrain select
local perl3 = {
	SEED3 = 848,
	OCTA3 = 5, --
	PERS3 = 0.5, --
	SCAL3 = 256, --
}

-- 3D Perlin4 for fissures and caves
local perl4 = {
	SEED4 = 98275470284,
	OCTA4 = 6, --
	PERS4 = 0.5, --
	SCAL4 = 207, --
}

-- 3D Perlin5 for perlin1 perlin2 persistence and sand depth
local perl5 = {
	SEED5 = 7028411255342,
	OCTA5 = 4, --
	PERS5 = 0.5, --
	SCAL5 = 414, --
}

-- Nodes

minetest.register_node("paragen:redstone", {
	description = "PG Redstone",
	tiles = {"paragen_redstone.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

-- Stuff

paragen = {}

local xminq = (80 * math.floor((XMIN + 32) / 80)) - 32
local yminq = (80 * math.floor((YMIN + 32) / 80)) - 32
local zminq = (80 * math.floor((ZMIN + 32) / 80)) - 32

local xmaxq = (80 * math.floor((XMAX + 32) / 80)) + 47
local ymaxq = (80 * math.floor((YMAX + 32) / 80)) + 47
local zmaxq = (80 * math.floor((ZMAX + 32) / 80)) + 47

local offcen = math.floor((ymaxq + yminq) / 2)

-- On generated function

if ONGEN then
	minetest.register_on_generated(function(minp, maxp, seed)
		if minp.x >= xminq and maxp.x <= xmaxq
		and minp.y >= yminq and maxp.y <= ymaxq
		and minp.z >= zminq and maxp.z <= zmaxq then
			local env = minetest.env
			local perlin3 = env:get_perlin(perl3.SEED3, perl3.OCTA3, perl3.PERS3, perl3.SCAL3)
			local perlin4 = env:get_perlin(perl4.SEED4, perl4.OCTA4, perl4.PERS4, perl4.SCAL4)
			local perlin5 = env:get_perlin(perl5.SEED5, perl5.OCTA5, perl5.PERS5, perl5.SCAL5)
			local x1 = maxp.x
			local y1 = maxp.y
			local z1 = maxp.z
			local x0 = minp.x
			local y0 = minp.y
			local z0 = minp.z
			for x = x0, x1 do -- for each plane do
				if PROG then
					print ("[paragen] "..(x - x0 + 1).." ("..minp.x.." "..minp.y.." "..minp.z..")")
				end
				for z = z0, z1 do -- for each column do
					local noise7 = perlin5:get2d({x=x+777,y=z+777}) -- sand depth
					local stothr = STAV + noise7 * STAMP
					for y = y0, y1 do -- for each node do
						local noise6 = perlin5:get3d({x=x,y=y,z=z}) -- persistence
						local pepers = PERSAV + noise6 * PERSAMP
						local noise3 = perlin3:get3d({x=x,y=y,z=z}) -- terrain select
						if noise3 < 0 then
							local perlin1 = env:get_perlin(perl1.SEED1, perl1.OCTA1, pepers, perl1.SCAL1)
							noise = perlin1:get3d({x=x,y=y,z=z}) -- terrain
						else -- alternative terrain
							local perlin2 = env:get_perlin(perl2.SEED2, perl2.OCTA2, pepers, perl2.SCAL2)
							noise = perlin2:get3d({x=x,y=y,z=z}) -- alt terrain
						end
						local offset = (offcen - y) / GRAD
						local noiseoff = noise + offset
						if noiseoff >= 0 then -- if terrain then
							if noiseoff < 1 then
								fist = FISTS + noiseoff * (FISTU - FISTS)
								cavt = CAVTS + noiseoff * (CAVTU - CAVTS)
							else
								fist = FISTU
								cavt = CAVTU
							end
							local noise4 = perlin4:get3d({x=x,y=y,z=z}) -- fissures
							local noise5 = perlin4:get3d({x=x*2,y=y*2,z=z*2}) -- caves
							if math.abs(noise4) > fist and math.abs(noise5) < cavt then -- if no fissures and no cave then
								if noiseoff < stothr then
									env:add_node({x=x,y=y,z=z},{name="default:desert_sand"})
								elseif (noiseoff >= stothr and noiseoff < 0.13)
								or (noiseoff >= 0.19 and noiseoff < 0.23)
								or (noiseoff >= 0.32 and noiseoff < 0.37)
								or (noiseoff >= 0.47 and noiseoff < 0.60)
								or (noiseoff >= 0.69 and noiseoff < 0.73)
								or noiseoff >= 0.90 then
									env:add_node({x=x,y=y,z=z},{name="paragen:redstone"})
								else
									env:add_node({x=x,y=y,z=z},{name="soil:sandstone"})
								end
							end
						end
					end
				end
			end
		end
	end)
end
