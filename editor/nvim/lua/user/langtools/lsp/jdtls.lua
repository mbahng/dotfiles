local M = {}

function M.get_config()
  local root_markers = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}
  local root_dir = require('jdtls.setup').find_root(root_markers)
  
  -- If no root marker, try to find the directory containing 'com' or 'src'
  if root_dir == "" then
    local src_root = vim.fs.find({'com', 'src'}, { upward = true, path = vim.fn.expand('%:p:h') })[1]
    if src_root then
      root_dir = vim.fs.dirname(src_root)
    end
  end

  -- Final fallback to the directory of the current file
  if root_dir == "" or not root_dir then 
    root_dir = vim.fn.expand('%:p:h') 
  end

  local bundles = {
    vim.fn.glob("/Users/mbahng/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
  }
  local test_jars = vim.fn.glob("/Users/mbahng/.local/share/nvim/mason/packages/java-test/extension/server/com.microsoft.java.test.plugin-*.jar", 1)
  if test_jars ~= "" then vim.list_extend(bundles, vim.split(test_jars, "\n")) end

  local workspace_id = vim.fn.sha256(root_dir):sub(1, 8)
  local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/' .. workspace_id
  local project_name = vim.fn.fnamemodify(root_dir, ":p:t")

  return {
    cmd = {
      'bash', '-c',
      string.format('jdtls -data %q --jvm-arg=-Xlog:disable 2>/dev/null', workspace_dir)
    },
    root_dir = root_dir,
    projectName = project_name,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    init_options = {
      bundles = bundles,
      projectName = project_name,
      extendedClientCapabilities = {
        classFileContentsSupport = true,
        generateTypeHierarchySupport = true,
        advancedExtractMethodSupport = true,
        advancedOrganizeImportsSupport = true,
      },
    },
    settings = {
      java = {
        home = "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home",
        project = {
          sourcePaths = { "." },
        },
        import = {
          gradle = { enabled = false },
          maven = { enabled = false },
        }
      }
    }
  }
end

return M
