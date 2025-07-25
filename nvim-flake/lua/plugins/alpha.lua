local status, alpha = pcall(require, "alpha")
if not status then return end

local function button(sc, txt)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "t", false)
    end,
  }
end

alpha.setup({
  layout = {
    { type = "padding", val = 4 },
    {
      type = "text",
      val = {
       "      ╔╗                                                                      ",
       "   ███║║███     ██████╗ ██████╗  █████╗ ███╗   ██╗██╗ █████╗  ██████╗███████╗",
       " ██╔══║║══╗██   ██╔══██╗██╔══██╗██╔══██╗████╗  ██║██║██╔══██╗██╔════╝██╔════╝",
       "██║   ║║   ║██  ██████╔╝██████╔╝███████║██╔██╗ ██║██║███████║██║     ███████╗",
       "██║   ║║   ║██  ██╔══██╗██╔══██╗██╔══██║██║╚██╗██║██║██╔══██║██║     ╚════██║",
       " ██╚══║║══╝██   ██████╔╝██║  ██║██║  ██║██║ ╚████║██║██║  ██║╚██████╗███████║",
       "   ███║║███     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝",
       "      ║║                                                                    ",
       "      ╚╝                                                                    ",
      },
      opts = {
        hl = "Type",
        shrink_margin = false,
      },
    },
    { type = "padding", val = 2 },
    button("SPC f f", "  Find File"),
    button("SPC f g", "  Find Text"),
    {
      type = "button",
      val = "  Open Directory [-]",
      on_press = function()
        vim.cmd("Oil")
      end,
    },
    {
      type = "button",
      val = "  Quit",
      on_press = function()
        vim.cmd("qa")
      end,
    },
  },
})
