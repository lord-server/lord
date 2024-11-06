
-- moved AS IS from lottpotion. Added doc-block.

return {
	--- @param pipes {f:number,h1:number,h2:number}[]
	make_pipe = function(pipes, horizontal)
		local result = {};
		for i, v in pairs(pipes) do
			local f  = v.f;
			local h1 = v.h1;
			local h2 = v.h2;
			if (not (v.b) or v.b == 0) then
				table.insert( result,   {-0.37*f,  h1,-0.37*f, -0.28*f, h2,-0.28*f});
				table.insert( result,   {-0.37*f,  h1, 0.28*f, -0.28*f, h2, 0.37*f});
				table.insert( result,   { 0.37*f,  h1,-0.28*f,  0.28*f, h2,-0.37*f});
				table.insert( result,   { 0.37*f,  h1, 0.37*f,  0.28*f, h2, 0.28*f});
				table.insert( result,   {-0.30*f,  h1,-0.42*f, -0.20*f, h2,-0.34*f});
				table.insert( result,   {-0.30*f,  h1, 0.34*f, -0.20*f, h2, 0.42*f});
				table.insert( result,   { 0.20*f,  h1,-0.42*f,  0.30*f, h2,-0.34*f});
				table.insert( result,   { 0.20*f,  h1, 0.34*f,  0.30*f, h2, 0.42*f});
				table.insert( result,   {-0.42*f,  h1,-0.30*f, -0.34*f, h2,-0.20*f});
				table.insert( result,   { 0.34*f,  h1,-0.30*f,  0.42*f, h2,-0.20*f});
				table.insert( result,   {-0.42*f,  h1, 0.20*f, -0.34*f, h2, 0.30*f});
				table.insert( result,   { 0.34*f,  h1, 0.20*f,  0.42*f, h2, 0.30*f});
				table.insert( result,   {-0.25*f,  h1,-0.45*f, -0.10*f, h2,-0.40*f});
				table.insert( result,   {-0.25*f,  h1, 0.40*f, -0.10*f, h2, 0.45*f});
				table.insert( result,   { 0.10*f,  h1,-0.45*f,  0.25*f, h2,-0.40*f});
				table.insert( result,   { 0.10*f,  h1, 0.40*f,  0.25*f, h2, 0.45*f});
				table.insert( result,   {-0.45*f,  h1,-0.25*f, -0.40*f, h2,-0.10*f});
				table.insert( result,   { 0.40*f,  h1,-0.25*f,  0.45*f, h2,-0.10*f});
				table.insert( result,   {-0.45*f,  h1, 0.10*f, -0.40*f, h2, 0.25*f});
				table.insert( result,   { 0.40*f,  h1, 0.10*f,  0.45*f, h2, 0.25*f});
				table.insert( result,   {-0.15*f,  h1,-0.50*f,  0.15*f, h2,-0.45*f});
				table.insert( result,   {-0.15*f,  h1, 0.45*f,  0.15*f, h2, 0.50*f});
				table.insert( result,   {-0.50*f,  h1,-0.15*f, -0.45*f, h2, 0.15*f});
				table.insert( result,   { 0.45*f,  h1,-0.15*f,  0.50*f, h2, 0.15*f});
			else
				table.insert( result,   {-0.35*f,  h1,-0.40*f,  0.35*f, h2,0.40*f});
				table.insert( result,   {-0.40*f,  h1,-0.35*f,  0.40*f, h2,0.35*f});
				table.insert( result,   {-0.25*f,  h1,-0.45*f,  0.25*f, h2,0.45*f});
				table.insert( result,   {-0.45*f,  h1,-0.25*f,  0.45*f, h2,0.25*f});
				table.insert( result,   {-0.15*f,  h1,-0.50*f,  0.15*f, h2,0.50*f});
				table.insert( result,   {-0.50*f,  h1,-0.15*f,  0.50*f, h2,0.15*f});
			end
		end
		if (horizontal == 1) then
			for i, v in ipairs(result) do
				result[i] = { v[2], v[1], v[3], v[5], v[4], v[6] };
			end
		end

		return result;
	end
}
