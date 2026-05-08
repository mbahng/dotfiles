return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace", -- or "openFilesOnly"
        typeCheckingMode = "basic", -- "off", "basic", or "strict"
      },
    },
  },
}
