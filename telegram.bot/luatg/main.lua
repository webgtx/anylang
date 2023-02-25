local fs = require("lfs")
local curl = require("cURL")
local inspect = require("inspect")
local tg_token = os.getenv("TOKEN") -- string.gsub(sh("echo $TOKEN"), "\n", "")
local tui = {
  info = function()
    io.write(
    [[
  
          Lua Test Featuers v0.1
      
        1) Fetch telegram data
        2) Somthing more
    ]],
    "\n"
    )
  end,
  keymap = {
    function()
      curl.easy{
        url = "https://api.telegram.org/bot"..tg_token.."/getUpdates",
        post = true,
        httpheader = {
          "Content-Type: application/json"
        },
        postfields = '{"limits": "3"}'
      }:perform()
    end,
    function()
      print("something")
    end
  }
}

tui.info()
io.write("  [$]: ")
local option = tui.keymap[tonumber(io.read("*l"))]
if option then option() else print("Unkown option") end
