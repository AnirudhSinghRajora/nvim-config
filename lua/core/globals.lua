-- Global debug printer utility
_G.P = function(v)
  print(vim.inspect(v))
  return v
end
P = _G.P
