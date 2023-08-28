local Table = {}

function Table.clear(__table: table)
	return table.clear(__table)
end

function Table.clone(__table: table): table
	return table.clone(__table)
end

function Table.concat(__array: Array, separator: string, i: number, j: number): string
	return table.concat(__array, separator, i, j)
end

function Table.create(count: number, value: any): table
	return table.create(count, value)
end

function Table.findvalue(haystack: table, needle: Variant, init: number): number  
	return table.find(haystack, needle, init)
end

function Table.foreach(__table: table, __function: (any, any)->())
	for i, v in __table do
		__function(i, v)
	end
end

function Table.foreachi(__table: Array, __function: (number, any)->())
	for i, v in __table do
		__function(i, v)
	end
end

function Table.freeze(__table: table): table
	return table.freeze(__table)
end

function Table.getn(__array: Array): number
	return #__array
end

function Table.insert(__array: Array, position: number, value: any): table?
	return table.insert(__array, position, value)
end

function Table.isfrozen(__table: table): boolean  
	return table.isfrozen(__table)
end

function Table.maxn(__table: table): number
	return #__table
end

function Table.move(source: table, a: number, b: number, t: number, destination: table): table
	return table.move(source, a, b, t, destination)
end

function Table.pack(...: any): table?
	return table.pack(...)
end

function Table.remove(__array: Array, position: number): table?
	return table.remove(__array, position)
end

function Table.sort(__array: Array, comparison: ((any, any)->boolean)?)
	return table.sort(__array, comparison)
end

function Table.unpack(__table: table, i: number, j: number): Tuple  
	return table.unpack(__table, i, j)
end

--- Customs ---

function Table.match(a: table, b: table, strict: boolean): boolean
	for i, v in a do
		if b[i] == nil then
			if not strict and v == false then continue end
			return false
		elseif b[i] ~= v then
			return false
		end
	end
	
	for i, v in b do
		if a[i] == nil then
			if not strict and v == false then continue end
			return false
		elseif a[i] ~= v then
			return false
		end
	end
	
	return true
end

function Table.findtable(haystack: table, needle: table, init: number): (string | number)?
	init = init or 1

	for i = init, #haystack do
		if type(haystack[i]) == "table" and Table.match(haystack[i], needle, true) then
			return i
		end
	end

	return nil
end

function Table.print(haystack: table, index: string): string?
	local Indent = "  "
	local Output = {"\n"}

	local function IncreaseDepth(tbl, Depth)
		Depth = Depth or Indent

		for i, v in pairs(tbl) do
			if typeof(v) == "table" then
				i = typeof(i) == "string" and "\"".. i .. "\"" or tostring(i)
				table.insert(Output, Depth .. "[" .. i .. "] = {")
				IncreaseDepth(v, Depth .. Indent)
				table.insert(Output, Depth .. "};")
			else
				i = typeof(i) == "string" and "\"".. i .. "\"" or tostring(i)
				v = typeof(v) == "string" and "\"".. v .. "\"" or tostring(v)
				table.insert(Output, Depth .. "[" .. i .. "] = " .. v .. ";")
			end
		end

		task.wait()
	end

	if next(haystack) ~= nil then
		table.insert(Output, "[\"" .. (index ~= nil and tostring(index) or "Table") .. "\"] = {")
		IncreaseDepth(haystack)
	end

	table.insert(Output, "}")

	return table.concat(Output, "\n")
end

function Table.filter(__array: Array, condition: ((any)->boolean)?): Array
	local filteredArray = {}

	for _, value in ipairs(__array) do
		if condition(value) then
			table.insert(filteredArray, value)
		end
	end
	
	return filteredArray
end

function Table.shuffle(__array: Array): table
	local shuffledArray = Table.clone(__array)
	local n = #shuffledArray

	for i = n, 2, -1 do
		local j = math.random(i)
		shuffledArray[i], shuffledArray[j] = shuffledArray[j], shuffledArray[i]
	end

	return shuffledArray
end

function Table.keys(__table: table): Array
	local keysArray = {}

	for key, _ in pairs(__table) do
		table.insert(keysArray, key)
	end

	return keysArray
end

function Table.values(__table: table): Array
	local valuesArray = {}

	for _, value in pairs(__table) do
		table.insert(valuesArray, value)
	end

	return valuesArray
end

function Table.every(__array: Array, condition: (()->boolean)?): boolean
	for _, value in ipairs(__array) do
		if not condition(value) then
			return false
		end
	end
	return true
end

function Table.reverse(__array: Array): table
	local reversedArray = {}
	local n = #__array

	for i = n, 1, -1 do
		table.insert(reversedArray, __array[i])
	end

	return reversedArray
end

function Table.unique(__array: Array): Array
	local uniqueValues = {}
	local valueSet = {}

	for _, value in ipairs(__array) do
		if not valueSet[value] then
			table.insert(uniqueValues, value)
			valueSet[value] = true
		end
	end

	return uniqueValues
end

return Table