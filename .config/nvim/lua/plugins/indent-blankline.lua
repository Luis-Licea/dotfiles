-- Show indentation lines.
return {
    'lukas-reineke/indent-blankline.nvim',
    commit = "4541d690816cb99a7fc248f1486aa87f3abce91c",
    branch = "master",
    config = function()
        require("indent_blankline").setup({
            show_current_context = true,
        })
    end
}
