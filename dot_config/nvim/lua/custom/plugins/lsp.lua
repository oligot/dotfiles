return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },
    -- Allows extra capabilities provided by blink.cmp
    "saghen/blink.cmp",
    -- "b0o/schemastore.nvim",
  },

  config = function()
    local servers = {
      bashls = {},
      gopls = {},
      jsonls = {},
      lua_ls = {},
      marksman = {},
      ty = {
        settings = {
          ty = {
            experimental = {
              rename = true,
              -- autoImport = true,
            },
          },
        },
      },
      yamlls = {
        validate = true,
        -- disable the schema store
        schemaStore = {
          enable = false,
          url = "",
        },
        -- Based on https://www.arthurkoziel.com/json-schemas-in-neovim/
        schemas = {
          ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
          ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = "template.{yml,yaml}",
          ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "*compose*.{yml,yaml}",
          ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd-application.yaml",
        },
        -- schemas = require("schemastore").yaml.schemas {
        --   -- select subset from the JSON schema catalog
        --   select = {
        --     "kustomization.yaml",
        --     "docker-compose.yml",
        --   },
        --
        --   -- additional schemas (not in the catalog)
        --   extra = {
        --     url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
        --     name = "Argo CD Application",
        --     fileMatch = "argocd-application.yaml",
        --   },
        -- },
      },
    }

    for server, config in pairs(servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end

    vim.lsp.config("cfn-lsp-extra", {
      cmd = { os.getenv "HOME" .. "/.local/bin/cfn-lsp-extra" },
      filetypes = { "yaml.cloudformation", "json.cloudformation" },
      root_markers = { ".git" },
      settings = {
        documentFormatting = false,
      },
    })
    vim.lsp.enable "cfn-lsp-extra"

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local fzf = require "fzf-lua"
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. (desc or "") })
        end
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")
        map("K", vim.lsp.buf.hover)
        map("gr", fzf.lsp_references, "[G]oto [R]eferences")
      end,
    })

    vim.keymap.set("", "<leader>l", function()
      local config = vim.diagnostic.config() or {}
      if config.virtual_text then
        vim.diagnostic.config { virtual_text = false, virtual_lines = true }
      else
        vim.diagnostic.config { virtual_text = true, virtual_lines = false }
      end
    end, { desc = "Toggle virtual text" })
  end,
}
