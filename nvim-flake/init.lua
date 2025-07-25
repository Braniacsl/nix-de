require("core.options")
require("core.keymaps")

local default_ok, _ = pcall(require, "profiles.default")
if default_ok then
  vim.notify("nvim: Loaded default profile", vim.log.levels.INFO)
else
  vim.notify("nvim: no default profile found.", vim.log.levels.WARN)
end

local function split(str, sep)
  local result = {}
  for s in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(result, s)
  end
  return result
end

local profile_env = vim.fn.getenv("NVIM_PROFILE")

if profile_env ~= vim.NIL and profile_env ~= nil then
  local profile_string = tostring(profile_env)
  if profile_string ~= "" then
    local profiles = split(profile_string, ",")
    vim.notify("nvim: Loading profiles: " .. profile_string, vim.log.levels.INFO)
    for _, profile_name in ipairs(profiles) do
      local profile_ok, module = pcall(require, "profiles." .. profile_name)
      if not profile_ok then
        vim.notify("nvim: could not load profile '" .. profile_name .. "': " .. module, vim.log.levels.ERROR)
      end
    end
  end
end
