local BasePlugin = require "kong.plugins.base_plugin"
local http = require "resty.http"

local kong = kong

local ExternalAuthHandler = BasePlugin:extend()

function ExternalAuthHandler:new()
  ExternalAuthHandler.super.new(self, "external-auth")
end

function ExternalAuthHandler:access(conf)
  ExternalAuthHandler.super.access(self)

  local client = http.new()
  client:set_timeouts(conf.connect_timeout, send_timeout, read_timeout)

  local res, err = client:request_uri(conf.url, {
    method = kong.request.get_method(),
    path = kong.request.get_path(),
    query = kong.request.get_raw_query(),
    headers = kong.request.get_headers(),
    body = ""
  })

  if not res then
    return kong.response.exit(500, {message=err})
  end

  if res.status ~= 200 then
    return kong.response.exit(401, {message="Invalid authentication credentials"})
  end
end

ExternalAuthHandler.PRIORITY = 900
ExternalAuthHandler.VERSION = "0.2.0"

return ExternalAuthHandler
