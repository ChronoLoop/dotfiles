return {
    cmd = { 'gopls', 'serve' },
    settings = {
        gopls = {
            staticcheck = true,
            analyses = {
                ST1000 = false,
            },
        },
    },
}
