vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost modules/init.lua source <afile> | PackerCompile
    autocmd BufWritePost nvimrc.lua source <afile> | PackerCompile
  augroup end
]]
