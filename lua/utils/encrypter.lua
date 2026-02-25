function encrypt_s1(s)
  local encrypted = "$$"
  for i = 1, #s do
    encrypted = encrypted .. string.byte(s:sub(i, i)) * (i + 5) .. "$"
  end

  return encrypted
end

function decrypt_s1(s)
  local encrypted_array = {}
  local decrypted = ""

  if s:sub(1, 2) ~= "$$" then
    return s
  end

  for word in s:gmatch("[^%$]+") do
    table.insert(encrypted_array, word)
  end

  for i = 1, #encrypted_array do
    decrypted = decrypted .. string.char(encrypted_array[i] / (i + 5))
  end

  return decrypted
end
