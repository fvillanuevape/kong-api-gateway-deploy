return {
    name = "mytoken",
    fields = {
      { config = {
          type = "record",
          fields = {
            { introspection_endpoint = { type = "string", required = true,default = "roar"}, },
            { client_id  = { type = "string", required = true,default = "roar"}, },
            { client_secret  = { type = "string", required = true,default = "roar"}, },
            { token_header = { type = "string",required = true, default = "Authorization", }, },
            { https_verify = { type = "boolean",required = true, default = false, }, },
          },
    }, },
  }
}