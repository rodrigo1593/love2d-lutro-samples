-- ./informatique/RetroArch/retroarch -L informatique/libretro-lutro/lutro_libretro.so informatique/lutro-game-of-life/main.lua

require "Point"
require "World"
require "Cell"
require "AliveCell"
require "DeadCell"


function love.conf(t)
	t.width  = 600
	t.height = 600
end

function love.load()
	points = {}
	math.randomseed( os.time() )
	for i=0,math.random(50,100) do
	 	points[i]= Point.new(math.random(40,60),math.random(40,60))
	end 
	w1 = World.new()
	w1:init(points)
end

function love.update(dt)
	local JOY_A = love.keyboard.isDown("a")
	w1:nextGeneration()
	if JOY_A == 1 then
		for i=0,math.random(50,100) do
		 	points[i]= Point.new(math.random(40,60),math.random(40,60))
		end 
		w1 = World.new()
		w1:init(points)		
	end
end

function love.draw()
	w1:draw()
end
