return {
  settings = {
    python = {
      analysis = {
        -- Type checking configuration - optimized for performance
        typeCheckingMode = "basic", -- Should be off or basic
        diagnosticMode = "workspace", -- Changed from "workspace" to improve performance
        autoSearchPaths = false, -- Changed to false to reduce indexing
        useLibraryCodeForTypes = false, -- Disabled to prevent deep analysis of libraries
        
        -- Import organization
        autoImportCompletions = false, -- Disabled for performance
        importFormat = "absolute",
        
        -- Advanced analysis settings
        diagnosticSeverityOverrides = {
          -- Turn down severity or disable noisy diagnostics
          reportGeneralTypeIssues = "none", -- Changed from "warning" to "none"
          reportOptionalMemberAccess = "none", -- Changed from "warning" to "none"
          reportOptionalCall = "none", -- Changed from "warning" to "none"
          reportOptionalOperand = "none", -- Changed from "warning" to "none"
          reportOptionalSubscript = "none", -- Changed from "warning" to "none"
          reportPrivateImportUsage = "none", -- Changed from "warning" to "none"
          reportUnknownArgumentType = "none",
          reportUnknownMemberType = "none",
          reportUnknownVariableType = "none",
          reportMissingTypeStubs = "none"
        },
        
        -- Environment settings
        pythonPath = "", -- Auto-detect
        
        -- Extra paths
        extraPaths = {}, -- Keep empty for performance
        
        -- Stub paths
        stubPath = "",
        
        -- Memory/Performance settings
        logLevel = "Error", -- Changed from "Information" to reduce logging
        maxImportDepth = 2, -- Reduced from 5 to improve performance
        indexing = false, -- Disable background indexing
        maxAnalysisTimeInSeconds = 2.0, -- Limit analysis time per file
      },

      -- Keep your existing exclusions
      exclude = {
        "**/node_modules",
        "**/__pycache__",
        "**/venv",
        "**/env",
        "**/build",
        "**/dist",
        "**/migrations",
        "**/data",
        "**/test",
        "**/backbones",
        "**/logs",
        "**/outputs",
        "**/pre_existing_datasets",

        -- Add library paths to exclude
        "**/site-packages/torch/**",
        "**/site-packages/numpy/**",
        "**/site-packages/pandas/**",
        "**/site-packages/matplotlib/**",
        "**/site-packages/xarray/**",
        "**/dist-packages/torch/**",
        "**/dist-packages/numpy/**"
      }

    },
  },
}
