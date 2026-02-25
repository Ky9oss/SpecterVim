require("../utils/encrypter")

-- load .env
function _G.load_env(path)
	local env = {}
	local file = io.open(path, "r")
	if not file then
		return env
	end

	local content = file:read("*a")
	file:close()

	for line in (content .. "\n"):gmatch("(.-)\n") do
		line = line:match("^%s*(.-)%s*$") -- trim
		if line == "" or line:match("^#") then
			goto skip
		end

		local key, value = line:match("^([A-Za-z_][%w_]*)%s*=%s*(.*)$")
		if not key then
			goto skip
		end

		value = value:match("^[\"']?(.-)[\"']?$") or value
		value = value:gsub('\\"', '"'):gsub("\\'", "'"):gsub("\\n", "\n"):gsub("\\t", "\t"):gsub("\\\\", "\\")

		env[key] = value
		::skip::
	end

	if env["SSHPASS"] ~= nil then
		local lines = {}
		env["ENCRYPTED1"] = encrypt_s1(env["SSHPASS"])

		for line in (content .. "\n"):gmatch("(.-)\n") do
			line = line:match("^%s*(.-)%s*$") -- trim
			if not (line:find("SSHPASS", 1, true) or line:gsub("%s+", "") == "") then
				table.insert(lines, line)
			end
		end
		table.insert(lines, "ENCRYPTED1=" .. env["ENCRYPTED1"])
		local file = io.open(path, "w")
		for _, line in ipairs(lines) do
			file:write(line .. "\n")
		end
		file:close()
	elseif env["ENCRYPTED1"] ~= nil then
		env["SSHPASS"] = decrypt_s1(env["ENCRYPTED1"])
	end

	return env
end

vim.g.myenv = _G.load_env(vim.fn.stdpath("config") .. "/.env")
