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
