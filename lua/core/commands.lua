---------------------------------------------------------------------------
-- custom command to reload config file
---------------------------------------------------------------------------
vim.api.nvim_create_user_command(
	'ReloadConfig', 
	function()
		vim.cmd('source ~/.config/nvim/init.lua')
	end,
	{desc = 'Reload init.lua config file'}
)
