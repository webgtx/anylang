package = "luatg"
version = "dev-1"
source = {
   url = "git+https://github.com/webgtx/anylang.git"
}
description = {
   homepage = "https://github.com/webgtx/anylang",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      main = "main.lua",
      post = "post.lua"
   }
}

dependencies = {
   ["luacurl"],
   ["inpsect"],
   ["luafilesystem"]
}
