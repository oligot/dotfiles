local function make_rds_url(opts)
  return function()
    local host = opts.host
    local port = opts.port or 5432
    local region = opts.region
    local user = opts.user
    local dbname = opts.dbname
    local profile = opts.profile

    local cmd = string.format(
      "aws rds generate-db-auth-token --hostname %s --port %d --region %s --username '%s' --profile %s",
      host,
      port,
      region,
      user,
      profile
    )

    local handle = io.popen(cmd)
    local token = handle:read "*a"
    handle:close()

    token = token:gsub("\n", "")
    local encoded_token = vim.fn["db#url#encode"](token)
    local encoded_user = vim.fn["db#url#encode"](user)

    return string.format("postgresql://%s:%s@%s:%d/%s", encoded_user, encoded_token, host, port, dbname)
  end
end

return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1

    local status, secrets = pcall(require, "db_secrets")
    if not status then
      vim.notify("DB Secrets file not found. Database connections disabled.", vim.log.levels.WARN)
      vim.g.dbs = {}
    else
      local db_connections = {}
      for name, config in pairs(secrets) do
        db_connections[name] = make_rds_url(config)
      end
      vim.g.dbs = db_connections
    end
  end,
}
