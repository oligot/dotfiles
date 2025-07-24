vim.filetype.add {
  pattern = {
    [".*"] = {
      priority = math.huge,
      function(_, bufnr)
        local line1 = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
        local line2 = vim.api.nvim_buf_get_lines(bufnr, 1, 2, false)[1] or ""
        if
          vim.regex([[^AWSTemplateFormatVersion]]):match_str(line1) ~= nil
          or vim.regex([[AWS::Serverless-2016-10-31]]):match_str(line1) ~= nil
        then
          return "yaml.cloudformation"
        elseif
          vim.regex([[["']AWSTemplateFormatVersion]]):match_str(line1) ~= nil
          or vim.regex([[["']AWSTemplateFormatVersion]]):match_str(line2) ~= nil
          or vim.regex([[AWS::Serverless-2016-10-31]]):match_str(line1) ~= nil
          or vim.regex([[AWS::Serverless-2016-10-31]]):match_str(line2) ~= nil
        then
          return "json.cloudformation"
        end
      end,
    },
  },
}
