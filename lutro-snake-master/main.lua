WIDTH = 32
HEIGHT = 32
LEN = 5

function love.conf(t)
	t.width  = WIDTH*12
	t.height = HEIGHT*12
end

function HSL(h, s, l, a)
    if s<=0 then return l,l,l,a end
    h, s, l = h/256*6, s/255, l/255
    local c = (1-math.abs(2*l-1))*s
    local x = (1-math.abs(h%2-1))*c
    local m,r,g,b = (l-.5*c), 0,0,0
    if h < 1     then r,g,b = c,x,0
    elseif h < 2 then r,g,b = x,c,0
    elseif h < 3 then r,g,b = 0,c,x
    elseif h < 4 then r,g,b = 0,x,c
    elseif h < 5 then r,g,b = x,0,c
    else              r,g,b = c,0,x
    end return (r+m)*255,(g+m)*255,(b+m)*255,a
end

function init()
	S = {}
	for i=1,LEN do
		table.insert(S, {WIDTH/2, HEIGHT/2})
	end

	dir = 0
	t = 0

	lum = 0

	math.randomseed(os.time())
	T = {math.random(WIDTH-2), math.random(HEIGHT-2)}
end

function love.load()
	init()
end

function love.update(dt)
	t = t + 1

	lum = math.sin(t/300) * 8 + 40
	love.graphics.setBackgroundColor(HSL(t/100, 128, lum))

	local JOY_UP = love.keyboard.isDown("up")
	local JOY_DOWN = love.keyboard.isDown("down")
	local JOY_LEFT = love.keyboard.isDown("left")
	local JOY_RIGHT = love.keyboard.isDown("right")

	if JOY_UP    == true then dir = 1 end
	if JOY_DOWN  == true then dir = 2 end
	if JOY_LEFT  == true then dir = 3 end
	if JOY_RIGHT == true then dir = 4 end

	if t % 5 ~= 0 then return end

	local head = S[#S]

	if dir == 1 then table.insert(S, {head[1]+0, head[2]-1}) end
	if dir == 2 then table.insert(S, {head[1]+0, head[2]+1}) end
	if dir == 3 then table.insert(S, {head[1]-1, head[2]+0}) end
	if dir == 4 then table.insert(S, {head[1]+1, head[2]+0}) end

	head = S[#S]

	if head[1] == 0 or head[1] == WIDTH
	or head[2] == 0 or head[2] == HEIGHT then
		init()
	end

	for i=1,#S-1 do
		if head[1] == S[i][1] and head[2] == S[i][2] and dir > 0 then
			init()
		end
	end

	if head[1] == T[1] and head[2] == T[2] then
		math.randomseed(os.time())
		T = {math.random(WIDTH-2), math.random(HEIGHT-2)}
	elseif dir > 0 then
		table.remove(S, 1)
	end
end

function love.draw()
	love.graphics.clear()
	
	love.graphics.setColor(HSL(t/100, 128, lum + 10))

	for y=0,HEIGHT do
		for x=0,WIDTH do
			love.graphics.rectangle("fill", x*12, y*12, 11, 11)
		end
	end

	love.graphics.setColor(255, 255, 255)

	for i=1,#S do
		love.graphics.rectangle("fill", S[i][1]*12, S[i][2]*12, 11, 11)
	end
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", T[1]*12, T[2]*12, 11, 11)
end
