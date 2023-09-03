local String = {}

function String.byte(__string: string, i: number, j: number): number
	return __string:byte(i, j)
end

function String.char(...: number): string
	return string.char(...)
end

function String.find(__string: string, pattern: string, init: number, plain: boolean): number
	return __string:find(pattern, init, plain)
end

function String.format(format_string: string, ...: string): string
	return string.format(format_string, ...)
end

function String.gmatch(__string: string, pattern: string): ()->()
	return __string:gmatch(pattern)
end

function String.gsub(__string: string, pattern: string, replacement: Variant, replacements: number): string
	return __string:gsub(pattern, replacement, replacements)
end

function String.len(__string: string): number
	return __string:len()
end

function String.lower(__string: string): string
	return __string:lower()
end

function String.match(__string: string, pattern: string, init: number): string
	return __string:match(pattern, init)
end

function String.pack(format: string, ...: Varient): string
	return string.pack(format, ...)
end

function String.packsize(format: string): number
	return string.packsize(format)
end

function String.rep(__string: string, n: number): string
	return __string:rep(n)
end

function String.reverse(__string: string): string
	return __string:reverse()
end

function String.split(__string: string, separator: string): table
	return __string:split(separator)
end

function String.sub(__string: string, i: number, j: number): string
	return __string:sub(i, j)
end

function String.unpack(format: string, data: string, read_start: string): tuple
	return string.unpack(format, data, read_start)
end

function String.upper(__string: string): string
	return __string:upper()
end

--- Customs ---

function String.rstrip(__string: string): string
	return (__string:gsub("%s+$", ""))
end

function String.lstrip(__string: string): string
	return (__string:gsub("^%s+", ""))
end

function String.strip(__string: string): string
	return (__string:gsub("^%s+", ""):gsub("%s+$", ""))
end

function String.title(__string: string): string
	return (" ".. __string):gsub("%W%l", string.upper):sub(2)
end

function String.concat(separator: string?, ...: string): string
	return table.concat({...}, separator or ", ")
end

function String.starts_with(__string: string, substring: string): string?
	return __string:match("^".. substring)
end

function String.ends_with(__string, substring): string?
	return __string:match(substring .."$")
end

function String.occurrences(__string: string, substring: string): number
	return select(2, __string:gsub(substring, ""))
end

function String.is_palindrome(__string: string): boolean
	return __string:reverse() == __string
end

function String.wrap(__string: string, maxLineLength: number): string
	local wrappedLines = {}
	local lineStart = 1

	while lineStart <= #__string do
		local lineEnd = math.min(lineStart + maxLineLength - 1, #__string)
		table.insert(wrappedLines, __string:sub(lineStart, lineEnd))
		lineStart = lineEnd + 1
	end

	return table.concat(wrappedLines, "\n")
end

function String.count_lines(__string: string): number
	local _, lineCount = __string:gsub("\n", "\n")
	return lineCount + 1
end

function String.lpadding(__string: string, length: number, padding: string): string
	if #__string >= length then return __string end
	return padding:rep(length - #__string) .. __string
end

function String.rpadding(__string: string, length: number, padding: string): string
	if #__string >= length then return __string end
	return __string .. padding:rep(length - #__string)
end

function String.padding(__string: string, length: number, padding: string): string
	if #__string >= length then return __string end
	return padding:rep(length - #__string) .. __string .. padding:rep(length - #__string) 
end

function String.truncate(__string: string, length: number, ellipsis: string): string
	if #__string > length then
		return __string:sub(1, length - #ellipsis) .. ellipsis
	else
		return __string
	end
end

function String.replace(__string: string, search: string, replace: string): string
	return __string:gsub(search, replace)
end

function String.random(length: number, characters: string)
	if not characters then
		characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+{}[]|;:,.<>?`~"
	end

	local result = ""

	for _ = 1, length do
		local randomIndex = math.random(#characters)
		result = result .. characters:sub(randomIndex, randomIndex)
	end

	return result
end

function String.to_slug(__string: string): string
	return __string:lower():gsub("[%s%W]+", "-")
end

function String.extract_numbers(__string: string): Array
	local numbers = {}
	for number in __string:gmatch("%d+") do
		table.insert(numbers, tonumber(number))
	end
	return numbers
end

function String.remove_duplicates(__string: string): string
	return __string:gsub("(.)%1+", "%1")
end

return String

