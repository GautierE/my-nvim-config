local function apply_code_action(action)
  if not action then return end
  if action.edit then
    vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
  end
  if action.command and type(action.command) == "table" and action.command.command then
    vim.lsp.buf.execute_command(action.command)
  end
end

local function handle_code_actions(err, actions)
  if err then
    vim.notify("Error fetching code actions: " .. err.message, vim.log.levels.ERROR)
    return
  end

  if not actions or vim.tbl_isempty(actions) then
    vim.notify("No code actions available", vim.log.levels.INFO)
    return
  end

  if #actions == 1 then
    apply_code_action(actions[1])
  else
    vim.ui.select(actions, {
      prompt = "Select a code action:",
      format_item = function(action) return action.title end
    }, function(selected)
      apply_code_action(selected)
    end)
  end
end

local function get_ts_import_action()
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.addMissingImports.ts" } }
  vim.lsp.buf_request(0, "textDocument/codeAction", params, handle_code_actions)
end

local function trigger_code_action()
  if vim.bo.filetype == "typescript" or vim.bo.filetype == "javascript" then
    get_ts_import_action()
  else
    vim.lsp.buf.code_action()
  end
end

vim.keymap.set("n", "<leader>i", trigger_code_action, { desc = "Add missing import or perform code action" })

