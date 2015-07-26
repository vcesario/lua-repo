--[[
	http://rubyquiz.com/quiz2.html
]]

--io.write('enter file name: ')
filename = 'santalist.txt' --io.read()
filevar = assert(io.open(filename,"r+"), "couldn't load file " .. filename .. ".")
io.input(filevar)

entries = {}

for line in io.lines() do
	local _,_,firstname, lattername, adress = string.find(line,"(%a+)%s*(%a+)%s*(%S+)")
	table.insert(entries,{
		email = adress,
		surname = lattername,
		name = firstname
	})
end

io.input(io.stdin)

function isInto(item, list)
	for i,v in ipairs(list) do
		if item == v then
			return true
		end
	end
	return false
end

math.randomseed(os.time())

function find_match(entries,matches,i)
	local i_match, n, eval
	n = 0 -- number of iterations
	i = i or 1
	if not matches then
		matches = {}
	end


	if i > #entries then -- end of solution
		return matches
	end

	::redo::

	repeat
		n = n + 1
		i_match = math.random(#entries)
		if n > #entries-#matches then
			return "impossible"
		end
	until entries[i].email ~= entries[i_match].email and
				entries[i].surname ~= entries[i_match].surname and
				not isInto(entries[i_match],matches)
	
	table.insert(matches, entries[i_match])
	
	eval = find_match(entries,matches,i+1)
	if eval == "impossible" then
		table.remove(matches)
		n = n - 1
		goto redo
	else
		return eval
	end
end

proper_match = find_match(entries)

for i = 1,#proper_match do
	print(entries[i].name.." got "..proper_match[i].name.."!")
end