local Number = {matrix={}; bezier={}}

--- Number customs ---

function Number.clamp(__number: number, min: number, max: number): number
	return math.max(min, math.min(max, __number))
end

function Number.map(__number: number, in_min: number, in_max: number, out_min: number, out_max: number): number
	return (__number - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

function Number.is_even(__number: number): boolean
	return __number % 2 == 0
end

function Number.is_odd(__number: number): boolean
	return __number % 2 ~= 0
end

function Number.round(__number: number, decimal_places: number): number
	local shift = 10 ^ decimal_places
	return math.floor(__number * shift + 0.5) / shift
end

function Number.random_range(min: number, max: number): number
	return math.random() * (max - min) + min
end

function Number.percent_to_value(percent: number, total: number): number
	return (percent / 100) * total
end

function Number.value_to_percent(value: number, total: number): number
	return (value / total) * 100
end

function Number.difference_percentage(old_value: number, new_value: number): number
	return ((new_value - old_value) / old_value) * 100
end

function Number.factors(__number: number): table
	local factors = {}
	for i = 1, __number do
		if __number % i == 0 then
			table.insert(factors, i)
		end
	end
	return factors
end

function Number.gcd(a: number, b: number): number
	while b ~= 0 do
		a, b = b, a % b
	end
	return a
end

function Number.lcm(a: number, b: number): number
	return (a * b) / Number.gcd(a, b)
end

function Number.from_binary(__string: string): string
	if (#__string % 8 ~= 0)
	then
		error('Malformed binary sequence', 2)
	end
	local Result = ''
	for i = 1, (#__string), 8 do
		Result = Result..string.char(tonumber(__string:sub(i, i + 7), 2))
	end
	return Result
end

function Number.to_binary(__string: string): number
	local function NumberString(__number: number): string
		local __string = ''
		repeat
			local Remainder = __number % 2
			__string = Remainder .. __string
			__number = (__number - Remainder) / 2
		until __number == 0
		return __string
	end

	if (#__string > 0)
	then
		local Result = ''
		for i = 1, (#__string)
		do
			Result  = Result .. string.format('%08d', NumberString(string.byte(string.sub(__string, i, i))))
		end
		return Result
	else
		return nil
	end
end

function Number.to_hexadecimal(__number: number): string
	return string.format("%X", __number)
end

function Number.to_roman_numerals(__number: number): string
	local numerals = {
		{1000, "M"},
		{900, "CM"}, {500, "D"}, {400, "CD"}, {100, "C"},
		{90, "XC"}, {50, "L"}, {40, "XL"}, {10, "X"},
		{9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"}
	}

	local roman = ""
	for _, pair in ipairs(numerals) do
		local value, symbol = unpack(pair)
		while __number >= value do
			roman = roman .. symbol
			__number = __number - value
		end
	end
	return roman
end

function Number.is_prime(__number: number): boolean
	if __number <= 1 then
		return false
	end
	for i = 2, math.sqrt(__number) do
		if __number % i == 0 then
			return false
		end
	end
	return true
end

function Number.factorial(__number: number): number
	if __number == 0 then
		return 1
	else
		return __number * Number.factorial(__number - 1)
	end
end

function Number.log_base(__number: number, base: number): number
	return math.log(__number) / math.log(base)
end

function Number.is_power_of(__number: number, base: number): boolean
	if base == 0 then
		return __number == 1
	end
	local result = Number.log_base(__number, base)
	return math.floor(result) == result
end

--- Bezier customs ---

type Vector = Vector3 | Vector2

function Number.bezier.quadratic_point(p0: Vector, p1: Vector, p2: Vector, t: number): Vector
	local u = 1 - t
	return u*u*p0 + 2*u*t*p1 + t*t*p2
end

function Number.bezier.cubic_point(p0: Vector, p1: Vector, p2: Vector, p3: Vector, t: number): Vector
	local u = 1 - t
	return u*u*u*p0 + 3*u*u*t*p1 + 3*u*t*t*p2 + t*t*t*p3
end

function Number.bezier.quadratic_tangent(p0: Vector, p1: Vector, p2: Vector, t: number): Vector
	local u = 1 - t
	return 2*u*(p1 - p0) + 2*t*(p2 - p1)
end

function Number.bezier.cubic_tangent(p0: Vector, p1: Vector, p2: Vector, p3: Vector, t: number): Vector
	local u = 1 - t
	return 3*u*u*(p1 - p0) + 6*u*t*(p2 - p1) + 3*t*t*(p3 - p2)
end

function Number.bezier.evaluate_curve(control_points: Array<Vector>, t: number): Vector
	local n = #control_points - 1
	local point = control_points[1]:Lerp(control_points[2], t) -- Initialize with the first point
	for i = 1, n do
		point = point:Lerp(control_points[i + 1], t)
	end
	return point
end

--- Matrix customs ---
type Matrix2D = Array<Array<number>>
type Matrix3D = Array<Matrix2D>

local function matrix_operation(a: Matrix2D | Matrix3D, b: Matrix2D | Matrix3D, operation: (number, number) -> number): Matrix2D | Matrix3D
	local result = {}
	if type(a[1][1]) == "number" then -- 2D matrix
		for i = 1, #a do
			local row = {}
			for j = 1, #a[i] do
				row[j] = operation(a[i][j], b[i][j])
			end
			result[i] = row
		end
	elseif type(a[1][1][1]) == "number" then -- 3D matrix
		for i = 1, #a do
			local matrix = {}
			for j = 1, #a[i] do
				local row = {}
				for k = 1, #a[i][j] do
					row[k] = operation(a[i][j][k], b[i][j][k])
				end
				matrix[j] = row
			end
			result[i] = matrix
		end
	else
		error("Unsupported matrix type")
	end
	return result
end

function Number.matrix.add(a: Matrix2D | Matrix3D, b: Matrix2D | Matrix3D): Matrix2D | Matrix3D
	return matrix_operation(a, b, function(x, y) return x + y end)
end

function Number.matrix.subtract(a: Matrix2D | Matrix3D, b: Matrix2D | Matrix3D): Matrix2D | Matrix3D
	return matrix_operation(a, b, function(x, y) return x - y end)
end

function Number.matrix.multiply(a: Matrix2D | Matrix3D, b: Matrix2D | Matrix3D): Matrix2D | Matrix3D
	local result = {}
	if #a[1] ~= #b then
		error("Matrix dimensions are not compatible for multiplication")
	end
	if type(a[1][1]) == "number" then -- 2D matrix
		for i = 1, #a do
			local row = {}
			for j = 1, #b[1] do
				local sum = 0
				for k = 1, #b do
					sum = sum + a[i][k] * b[k][j]
				end
				row[j] = sum
			end
			result[i] = row
		end
	elseif type(a[1][1][1]) == "number" then -- 3D matrix
		for i = 1, #a do
			local matrix = {}
			for j = 1, #b[1] do
				local row = {}
				for k = 1, #b[1][1] do
					local sum = 0
					for m = 1, #b do
						sum = sum + a[i][m][k] * b[m][j][k]
					end
					row[k] = sum
				end
				matrix[j] = row
			end
			result[i] = matrix
		end
	else
		error("Unsupported matrix type")
	end
	return result
end

function Number.matrix.scalar_multiply(a: Matrix2D | Matrix3D, scalar: number): Matrix2D | Matrix3D
	return matrix_operation(a, a, function(x) return x * scalar end)
end

function Number.matrix.determinant(a: Matrix2D | Matrix3D): number
	local n = #a
	if n == 2 then
		return a[1][1] * a[2][2] - a[1][2] * a[2][1]
	end

	local det = 0
	for col = 1, n do
		local minor = {}
		for i = 2, n do
			local newRow = {}
			for j = 1, n do
				if j ~= col then
					table.insert(newRow, a[i][j])
				end
			end
			table.insert(minor, newRow)
		end
		det = det + a[1][col] * math.pow(-1, col) * Number.matrix.determinant(minor)
	end

	return det
end

function Number.matrix.transpose(a: Matrix2D | Matrix3D): Matrix2D | Matrix3D
	local result = {}
	if type(a[1][1]) == "number" then -- 2D matrix
		for i = 1, #a[1] do
			local row = {}
			for j = 1, #a do
				row[j] = a[j][i]
			end
			result[i] = row
		end
	elseif type(a[1][1][1]) == "number" then -- 3D matrix
		for i = 1, #a[1][1] do
			local matrix = {}
			for j = 1, #a[1] do
				local row = {}
				for k = 1, #a do
					row[k] = a[k][j][i]
				end
				matrix[j] = row
			end
			result[i] = matrix
		end
	else
		error("Unsupported matrix type")
	end
	return result
end

function Number.matrix.invert(a: Matrix2D | Matrix3D): Matrix2D | Matrix3D
	local det = Number.matrix.determinant(a)
	if det == 0 then
		error("Matrix is not invertible")
	end

	local n = #a
	local adjugate = {}
	for i = 1, n do
		local row = {}
		for j = 1, n do
			local minor = {}
			for m = 1, n do
				local newRow = {}
				for k = 1, n do
					if m ~= i and k ~= j then
						table.insert(newRow, a[m][k])
					end
				end
				if #newRow > 0 then
					table.insert(minor, newRow)
				end
			end
			table.insert(row, math.pow(-1, i + j) * Number.matrix.determinant(minor))
		end
		table.insert(adjugate, row)
	end

	local inverse = {}
	for i = 1, n do
		local row = {}
		for j = 1, n do
			table.insert(row, adjugate[j][i] / det)
		end
		table.insert(inverse, row)
	end

	return inverse
end

return Number
