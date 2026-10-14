-- Global debug printer utility (uses native vim.print on Neovim 0.10+)
_G.P = (vim and vim.print) or function(v)
  if vim and vim.inspect then
    print(vim.inspect(v))
  else
    print(v)
  end
  return v
end
