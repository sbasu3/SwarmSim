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

function bot(myloc,food,frnd)
		--local dir = getDir(myloc,food[math.random(#food)]);
		if #food == 0 then
			return {x=0,y=0}
		end

		local dir = getDir(myloc,food[1]);
		local move;
		if dir < 90 then
			move = {x=0,y=-1};
		elseif dir < 180 then
			move = {x=-1,y=0};
		elseif dir < 270 then
			move = {x=0,y=1};
		else
			move = {x=1,y=0};
		end

		return move;
end

function getDir(loc1,loc2)
	local deg =  math.deg(math.atan((loc2.y-loc1.y)/(loc2.x-loc1.x)));
	while deg < 0 do
		deg = deg + 360;
	end
	return deg; 
end
