-- MARKDOWN STUFF
vim.g.markdown_folding = 2
vim.api.nvim_set_keymap(
	"n",            -- mode to use
	"<C-space>",            -- mapping
	"za",   -- what to do
	{ noremap = true}       --whether or not to remap
)

-- PLUGIN STUFF
	-- ULTISNIPS STUFF
vim.opt.runtimepath:append('~/.config/nvim/ultisnips/')
vim.opt.runtimepath:append('~/.config/nvim/vim-markdown/')
vim.g.UltiSnipsSnippetDirectories = {'~/gits/Confs'}
vim.g.UltiSnipsListSnippets="<F2>"

  -- MARKDOWN PLUGIN
  --
vim.api.nvim_set_keymap(
	"n",            -- mode to use
	"<F3>",            -- mapping
	":lua ToggleToc()<CR>",   -- what to do
	{ noremap = true, silent = true }       --whether or not to remap
)

function ToggleToc()
  vim.g.NoteBufNo = vim.fn.bufnr()
  if vim.b.toc_closed or vim.b.toc_closed == nil then
    vim.cmd("buffer " .. vim.g.NoteBufNo )
    vim.cmd("Toc")
    vim.cmd("vertical resize 60")
    vim.b.toc_closed = false
  else
    vim.cmd("wincmd h")
    vim.cmd("bd")
    vim.b.toc_closed = true
  end
end


-- GENERIC QUALITY OF LIFE
vim.g.mapleader = " "		--change my leader key to the spacebar
vim.opt.wildmode = "list:longest" --Completion mode that is used for the character specified with 'wildchar'.
vim.opt.wildmenu = true --show a menu
vim.opt.relativenumber = true --Show relative numbers to make moving around easier.
vim.opt.clipboard = "unnamedplus"
vim.api.nvim_set_keymap('v', '<leader>y', '"*y', { noremap = true, silent = true })


-- In terminal mode, use escape to exit terminal mode.  If you don't use terminal mode, then you don't need this.
local c_backslash = vim.api.nvim_replace_termcodes('<C-\\>', true, false, true)
local c_n = vim.api.nvim_replace_termcodes("<C-N>", true, false, true)

vim.api.nvim_set_keymap(
 	"t",            -- mode to use
 	"<esc>",            -- mapping
 	c_backslash .. c_n,   -- what to do
 	{ noremap = true}       --whether or not to remap
 )


-- USE 'Q' TO EXECUTE THE CURRENT LINE LOCALLY AND RETURN THE OUTPUT
vim.api.nvim_set_keymap(
	"n",            -- mode to use
	"Q",            -- mapping
	"!!bash<CR>",   -- what to do
	{ noremap = true}       --whether or not to remap
)

-- HACKER QUALITY OF LIFE
vim.opt.iskeyword:append('.') --This is hugely helpful for telling vim to use IP addresses as a word.  Otherwise, copying 127.0.0.1 will require typing all the numbers rather than 127 <C-x><C-p>
