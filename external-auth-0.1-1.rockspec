package = "external-auth"

version = "0.1-1"

source = {
  url = "https://github.com/aunkenlabs/kong-external-auth",
  tag = "0.1"
}

description = {
  summary = "Kong plugin to authenticate requests using http services.",
  license = "MIT"
}

dependencies = {
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.external-auth.handler"] = "src/handler.lua",
    ["kong.plugins.external-auth.schema"] = "src/schema.lua"
  }
}