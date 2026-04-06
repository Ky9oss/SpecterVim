--- @param str string
--- @param size integer
--- @return string
function LimitStr(str, size)
	local len = #str
	if len >= size then
		return "..." .. str:sub(-size)
	else
		return str
	end
end

--- @param s string
--- @return string
function trim(s)
	if not s then
		return ""
	end
	return s:match("^%s*(.-)%s*$") or ""
end

--- Example: 
---   vim.notify(vim.inspect(split_respect_double_quotes('git commit -m "hello world"')))
--- Result:
---   { "git", "commit", "-m", "hello world" }
---
--- @param str string
--- @return table
function split_respect_double_quotes(str)
	local i = 1
	local start
	local _end
	local results = {}

	str = trim(str)
	local length = #str

	while i < length do
		while str:sub(i, i):match(" ") do
			i = i + 1
		end

		if str:sub(i, i):match('"') then
			i = i + 1
			start = i

			while i < length and not str:sub(i, i):match('"') do
				i = i + 1
			end

			_end = i - 1
		else
			start = i

			while i <= length and not str:sub(i, i):match(" ") do
				i = i + 1
			end

			_end = i - 1
		end
		table.insert(results, str:sub(start, _end))

		if i >= length then
			return results
		end
	end
end
