local Math = {matrix={}; bezier={}}

function Math.clamp(x: number, min: number, max: number): number
	return math.max(min, math.min(max, x))
end

function Math.map(x: number, in_min: number, in_max: number, out_min: number, out_max: number): number
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

function Math.abs(x: number): number
	return math.abs(x)
end

function Math.acos(x: number): number
	return math.acos(x)
end

function Math.asin(x: number): number
	return math.asin(x)
end

function Math.atan(x: number): number
	return math.atan(x)
end

function Math.atan2(x: number, y:number): number
	return math.atan2(y, x)
end

function Math.ceil(x: number): number
	return math.ceil(x)
end

function Math.cos(x: number): number
	return math.cos(x)
end

function Math.cosh(x: number): number
	return math.cosh(x)
end

function Math.deg(x: number): number
	return math.deg(x)
end

function Math.exp(x: number): number
	return math.exp(x)
end

function Math.floor(x: number): number
	return math.floor(x)
end

function Math.fmod(x: number, y: number): number
	return math.fmod(x, y)
end

function Math.frexp(x: number): number
	return math.frexp(x)
end

function Math.ldexp(x: number, e: number): number
	return math.ldexp(x, e)
end

function Math.log(x: number, base: number?): number
	return math.log(x, base)
end

function Math.log10(x: number): number
	return math.log10(x)
end

function Math.max(x: number, ...: number): number
	return math.max(x, ...)
end

function Math.min(x: number, ...: number): number
	return math.min(x, ...)
end

function Math.mod(x: number): number
	return math.mod(x)
end

function Math.modf(x: number): number
	return math.modf(x)
end

function Math.noise(x: number, y: number, z: number): number
	return math.noise(x, y, z)
end

function Math.pow(x: number, y: number): number
	return math.pow(x, y)
end

function Math.rad(x: number): number
	return math.rad(x)
end

function Math.random(m: number?, n: number?): number
	return math.random(m, n)
end

function Math.randomseed(x: number): number
	math.randomseed(x)
end

function Math.sign(x: number): number
	return math.sign(x)
end

function Math.sin(x: number): number
	return math.sin(x)
end

function Math.sinh(x: number): number
	return math.sinh(x)
end

function Math.sqrt(x: number): number
	return math.sqrt(x)
end

function Math.tan(x: number): number
	return math.tan(x)
end

function Math.tanh(x: number): number
	return math.tanh(x)
end

--- Customs ---

function Math.is_even(__number: number): boolean
	return __number % 2 == 0
end

function Math.is_odd(__number: number): boolean
	return __number % 2 ~= 0
end

function Math.round(__number: number, decimal_places: number): number
	local shift = 10 ^ decimal_places
	return math.floor(__number * shift + 0.5) / shift
end

function Math.random_range(min: number, max: number): number
	return math.random() * (max - min) + min
end

function Math.percent_to_value(percent: number, total: number): number
	return (percent / 100) * total
end

function Math.value_to_percent(value: number, total: number): number
	return (value / total) * 100
end

function Math.difference_percentage(old_value: number, new_value: number): number
	return ((new_value - old_value) / old_value) * 100
end

function Math.factors(__number: number): table
	local factors = {}
	for i = 1, __number do
		if __number % i == 0 then
			table.insert(factors, i)
		end
	end
	return factors
end

function Math.gcd(a: number, b: number): number
	while b ~= 0 do
		a, b = b, a % b
	end
	return a
end

function Math.lcm(a: number, b: number): number
	return (a * b) / Math.gcd(a, b)
end

function Math.from_binary(__string: string): string
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

function Math.to_binary(__string: string): number
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

function Math.to_hexadecimal(__number: number): string
	return string.format("%X", __number)
end

function Math.to_roman_numerals(__number: number): string
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

function Math.is_prime(__number: number): boolean
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

function Math.factorial(__number: number): number
	if __number == 0 then
		return 1
	else
		return __number * Math.factorial(__number - 1)
	end
end

function Math.log_base(__number: number, base: number): number
	return math.log(__number) / math.log(base)
end

function Math.is_power_of(__number: number, base: number): boolean
	if base == 0 then
		return __number == 1
	end
	local result = Math.log_base(__number, base)
	return math.floor(result) == result
end

function Math.mean(numbers: {number}): number
	local sum = 0
	for _, num in ipairs(numbers) do
		sum = sum + num
	end
	return sum / #numbers
end

function Math.variance(numbers: {number}): number
	local mean = Math.mean(numbers)
	local sum_of_squares = 0
	for _, num in ipairs(numbers) do
		sum_of_squares = sum_of_squares + (num - mean)^2
	end
	return sum_of_squares / #numbers
end

--- Bezier customs ---

type Vector = Vector3 | Vector2

function Math.bezier.quadratic_point(p0: Vector, p1: Vector, p2: Vector, t: number): Vector
	local u = 1 - t
	return u*u*p0 + 2*u*t*p1 + t*t*p2
end

function Math.bezier.cubic_point(p0: Vector, p1: Vector, p2: Vector, p3: Vector, t: number): Vector
	local u = 1 - t
	return u*u*u*p0 + 3*u*u*t*p1 + 3*u*t*t*p2 + t*t*t*p3
end

function Math.bezier.quadratic_tangent(p0: Vector, p1: Vector, p2: Vector, t: number): Vector
	local u = 1 - t
	return 2*u*(p1 - p0) + 2*t*(p2 - p1)
end

function Math.bezier.cubic_tangent(p0: Vector, p1: Vector, p2: Vector, p3: Vector, t: number): Vector
	local u = 1 - t
	return 3*u*u*(p1 - p0) + 6*u*t*(p2 - p1) + 3*t*t*(p3 - p2)
end

function Math.bezier.evaluate_curve(control_points: Array<Vector>, t: number): Vector
	local n = #control_points - 1
	local point = control_points[1]:Lerp(control_points[2], t) -- Initialize with the first point
	for i = 1, n do
		point = point:Lerp(control_points[i + 1], t)
	end
	return point
end

function Math.bezier.curve_length(control_points: Array<Vector>, segments: number): number
	local length = 0
	local last_point = control_points[1]

	for t = 0, 1, 1/segments do
		local point = Math.bezier.evaluate_curve(control_points, t)
		length = length + (point - last_point).Magnitude
		last_point = point
	end

	return length
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

function Math.matrix.add(a: Matrix2D | Matrix3D, b: Matrix2D | Matrix3D): Matrix2D | Matrix3D
	return matrix_operation(a, b, function(x, y) return x + y end)
end

function Math.matrix.subtract(a: Matrix2D | Matrix3D, b: Matrix2D | Matrix3D): Matrix2D | Matrix3D
	return matrix_operation(a, b, function(x, y) return x - y end)
end

function Math.matrix.multiply(a: Matrix2D | Matrix3D, b: Matrix2D | Matrix3D): Matrix2D | Matrix3D
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

function Math.matrix.scalar_multiply(a: Matrix2D | Matrix3D, scalar: number): Matrix2D | Matrix3D
	return matrix_operation(a, a, function(x) return x * scalar end)
end

function Math.matrix.determinant(a: Matrix2D | Matrix3D): number
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
		det = det + a[1][col] * math.pow(-1, col) * Math.matrix.determinant(minor)
	end

	return det
end

function Math.matrix.transpose(a: Matrix2D | Matrix3D): Matrix2D | Matrix3D
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

function Math.matrix.invert(a: Matrix2D | Matrix3D): Matrix2D | Matrix3D
	local det = Math.matrix.determinant(a)
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
			table.insert(row, math.pow(-1, i + j) * Math.matrix.determinant(minor))
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

return Math
