return {
  'smartpde/debuglog',
  name = 'logger',
  disable = true,
  config = function()
    local log = require('debuglog');
    log.setup({
      log_to_console = true,
      log_to_file = true,
      -- The highlight group for printing the time column in console
      time_hl_group = "Comment",
    });

    log.enable("*")
  end
};
