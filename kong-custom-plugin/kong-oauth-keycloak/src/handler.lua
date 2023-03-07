local access = require "kong.plugins.oauthbga.access"

local TokenHandler = {
    VERSION  = "1.0.0",
    PRIORITY = 10,
}

function TokenHandler:access(conf)
    access.run(conf)
end

return TokenHandler