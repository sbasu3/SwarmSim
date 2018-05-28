require "SimEngine"

function love.load()
	iteration = 1
	time = 0;
	--love.graphics.setMode(SIZE,SIZE,false,true,0);
	love.window.setMode(MAX_SIZE,MAX_SIZE,{fullscreen = false,vsync = true,resizable = false, borderless = false,centered = true});
	init();
end


function love.update(dt)
	time = time + dt;
	if time > 60 then
		exit = true;
	end
	runsim();
	--GS = GameState(A);	
end


function love.draw()
	love.graphics.clear();
	love.graphics.reset();

	for i=1,botcount do
		if ant[i] ~= nil then
			love.graphics.setColor(color[ ant[i].team ].r, color[ ant[i].team ].g, color[ ant[i].team ].b);
    		love.graphics.circle("fill", ant[i].pos.x, ant[i].pos.y, 5 );
		end
	end

	for i=1,#food do
		love.graphics.setColor(255, 255, 255);
    	love.graphics.circle("fill", food[i].x, food[i].y, 5 );
	end	
end
	
