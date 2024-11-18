return {
  settings = {
    python = {
      analysis = {
        -- Type checking configuration
        typeCheckingMode = "on", -- Can be "off", "basic", "strict"
        diagnosticMode = "workspace", -- Can be "workspace" or "openFilesOnly"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        
        -- Import organization
        autoImportCompletions = true,
        importFormat = "absolute", -- Can be "absolute" or "relative"
        
        -- Advanced analysis settings
        diagnosticSeverityOverrides = {
          reportGeneralTypeIssues = "warning",
          reportOptionalMemberAccess = "warning",
          reportOptionalCall = "warning",
          reportOptionalOperand = "warning",
          reportOptionalSubscript = "warning",
          reportPrivateImportUsage = "warning",
        },
        
        -- Environment settings
        pythonPath = "", -- Set your Python path or leave empty for auto-detection
        pythonVersion = "3.10", -- Specify Python version
        
        -- Extra paths
        extraPaths = {}, -- Additional import search paths
        
        -- Stub paths
        stubPath = "", -- Path to custom stub files
        
        -- Memory/Performance settings
        logLevel = "Information", -- Logging level
        maxImportDepth = 5, -- Maximum depth for import resolution
      },
    },
  },
}
