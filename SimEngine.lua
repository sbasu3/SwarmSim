--[[
The MIT License (MIT)

Copyright (c) 2016 Subhojit Basu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

----------------------------
function push_env_table(t)
 local g = getfenv(0)
    setmetatable(t, {__index=g})
 setfenv(0, t)
end
 
function pop_env_table()
 local t = getfenv(0)
    local g = getmetatable(t).__index
 setfenv(0, g)
end

require "config"
bot = {};
bot[1] = {};
push_env_table(bot[1]);
require"Bot1"
pop_env_table();
bot[2] = {};
push_env_table(bot[2]);
require"Bot2"
pop_env_table();
bot[3] = {};
push_env_table(bot[3]);
require"Bot3"
pop_env_table();



function init()
	ant = {};
	food= {};
	team = {};
	color = {};
	exit = false;
	botcount = MAX_BOTS;
	math.randomseed(os.time());
	for i=1,MAX_BOTS do
		ant[i] = {team=i,pos={x=math.random(MAX_SIZE),y=math.random(MAX_SIZE)}};
		--ant[i] = {team=i,pos={x=(i+10)^2,y=(i+10)^2}};
		team[i] = 0;
		color[i] = {r=math.random(255),g=math.random(255),b=math.random(255)}
	end

	for i=1,MAX_FOOD do
		food[i] = {x=math.random(MAX_SIZE),y=math.random(MAX_SIZE)};
	end
end

function isCollision(num,move)
	for i=1,botcount do
		if i~=num and ant[i] ~= nil then
			if math.abs(move.x-ant[i].pos.x) < BOT_SIZE and math.abs(move.y-ant[i].pos.y) < BOT_SIZE then
				print("Collision:",num,"with",i,"Time:",time);
				return true,"ANT", i
			end
		end
	end
	for i =1,#food do
		if food[i] ~= nil then
			if math.abs(move.x - food[i].x) < BOT_SIZE and math.abs(move.y-food[i].y) < BOT_SIZE then
				return true,"FOOD",i
			end
		end
	end

	return false,"NONE",-1
end

function runsim()
	if exit then
		return
	end

	if #food == 0 or table.getn(ant) == 0 then
		print("----------------------Score----------------------------");
		for i,v in ipairs(team) do
			print("Team",i,":",team[i]);
		end
		print("----------------------Score----------------------------");
		print("----------------------Bots-----------------------------");
		for i=1,botcount do
			if ant[i] ~= nil then
				print("Bot:",i,"Team:",ant[i].team);
			end	
		end 
		print("----------------------Bots-----------------------------");
		exit = true;
	end



	for i=1,botcount do
		if ant[i] ~= nil then
			local myloc = ant[i].pos;
			local frnd = {};
			for j=1,botcount do
				--print("I am ant ",i);
				if j~=i and ant[j] ~= nil and ant[j].team == i then
					table.insert(frnd,ant[j].pos);
				end
			end

			local move = bot[ant[i].team].bot(myloc,food,frnd);
			myloc.x = move.x + myloc.x;
			myloc.y = move.y + myloc.y;
			
			if myloc.x > MAX_SIZE then
				myloc.x = myloc.x - MAX_SIZE;
			elseif myloc.x < 0 then
				myloc.x = myloc.x + MAX_SIZE;
			end
		
			if myloc.y > MAX_SIZE then
				myloc.y = myloc.y - MAX_SIZE;
			elseif myloc.y < 0 then
				myloc.y = myloc.y + MAX_SIZE;
			end

			local collide,with,num = isCollision(i,myloc);

			--print("I am ant ",i);
			if collide then
				--print("I am ant ",i);
				if with == "ANT" then
					ant[i] = nil;
					ant[num] = nil;
				elseif with == "FOOD" then
					ant[botcount + 1] = {team=ant[i].team,pos={x=math.random(MAX_SIZE),y=math.random(MAX_SIZE)}};
					botcount = botcount + 1;
					team[ant[i].team]=team[ant[i].team] + 1;
					table.remove(food,num);
				end
			end
			
			if ant[i] ~= nil then
				ant[i].pos = myloc;
				--print("I am ant ",i);
			end
		end		
	end
	--print("Exiting runsim....");
end
