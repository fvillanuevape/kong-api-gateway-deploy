local url = require "socket.url"
local function validate_url(value)
    local parsed_url = url.parse(value)
    if parsed_url.scheme and parsed_url.host then
        parsed_url.scheme = parsed_url.scheme:lower()
        if not (parsed_url.scheme == "http" or parsed_url.scheme == "https") then
            return false, "Supported protocols are HTTP and HTTPS"
        end
    end

    return true
end
return {
    name = "bga-token-instrospection",
    fields = {
      { config = {
          type = "record",
          fields = {
            { introspection_endpoint = { type = "string", required = true,default = "roar",custom_validator=validate_url,}, },
            { client_id  = { type = "string", required = true,default = "roar"}, },
            { client_secret  = { type = "string", required = true,default = "roar"}, },
            { token_header = { type = "string",required = true, default = "Authorization", }, },
            { https_verify = { type = "boolean",required = true, default = false, }, },
          },
    }, },
  }
}