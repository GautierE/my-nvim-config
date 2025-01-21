-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

require('lspconfig').ts_ls.setup({
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  }
})

require('lspconfig').intelephense.setup({})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})


local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    { name = 'path' },
    {name = 'nvim_lsp_signature_help'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping.confirm({select = true}),
  }),
})

-- Shortcut to import element on cursor for js/ts files
vim.keymap.set("n", "<leader>i", function()
  if vim.bo.filetype == "typescript" or vim.bo.filetype == "javascript" then
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.addMissingImports.ts" } }
    vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, actions)
      if err then
        vim.notify("Error fetching code actions: " .. err.message, vim.log.levels.ERROR)
        return
      end
      if not actions or vim.tbl_isempty(actions) then
        vim.notify("No code actions available", vim.log.levels.INFO)
        return
      end
      if #actions == 1 then
        local action = actions[1]
        if action.edit or type(action.command) == "table" then
          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
          end
          if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.command)
          end
        else
          vim.lsp.buf.execute_command(action)
        end
      else
        vim.ui.select(actions, {
          prompt = "Select a code action:",
          format_item = function(action)
            return action.title
          end,
        }, function(selected)
          if selected then
            if selected.edit or type(selected.command) == "table" then
              if selected.edit then
                vim.lsp.util.apply_workspace_edit(selected.edit, "utf-16")
              end
              if type(selected.command) == "table" then
                vim.lsp.buf.execute_command(selected.command)
              end
            else
              vim.lsp.buf.execute_command(selected)
            end
          end
        end)
      end
    end)
  else
    vim.lsp.buf.code_action()
  end
end, { desc = "Add missing import or perform code action" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = "rounded"}
)
