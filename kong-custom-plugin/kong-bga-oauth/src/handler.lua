-- Custom Plugin Token Instrospect with Authorization Server
local http = require "resty.http"
local cjson = require "cjson.safe"
local pl_stringx = require "pl.stringx"
local encode_base64 = ngx.encode_base64

local MyToken = {}

MyToken.PRIORITY = 1000
MyToken.VERSION = "1.0.0"

-- Function Error Response
local function error_response(status, error_type, message, error_detail)
  local json_message = '{"code":' .. status .. ',"errorType":"'.. error_type ..'", "description":"' .. message .. '", "errorDetail":[{"code":"ER0001","description":"' .. error_detail ..'"}]}'
  return kong.response.exit(status, json_message, {
    ["Content-Type"] = "application/json"
  })
end

-- Implement Logic
function MyToken:access(conf)

  -- Get Access Token
  local request_header = kong.request.get_header(conf.token_header)
  if not request_header then
    return error_response(401,"Technical","Unauthenticated","Request is missing required Authorization")
  end

  -- replace Bearer prefix
  local access_token = pl_stringx.replace(request_header, "Bearer ", "", 1)
  kong.log.err("Access Token: ", access_token)

  kong.log.err(request_header)

  local request_method = "POST"
  local uri = conf.introspection_endpoint

  -- Send Request Token Instrospect
  local authorization = 'Basic '..encode_base64(conf.client_id..':'..conf.client_secret)
  local client = http.new()
  local res, err = client:request_uri(uri, {
    method = request_method,
    body = "token=" .. access_token,
    headers = {["Authorization"]= authorization, ["Content-Type"] = "application/x-www-form-urlencoded"},
    ssl_verify = conf.https_verify,
  })
  kong.log.err("Response Authorization Server Body",res.body)
  kong.log.err("Response Authorization Server Status",res.status)
  kong.log.err("Response Authorization Server Headers",res.headers)
  kong.log.err("Error Authorization Server",err)

    -- Validate Not Response
  if not res then
    kong.log.err(err)
    kong.log.err(res)
    return error_response(501,"Technical","Service Unvailable","An unexpected error occurred.")
  end

  -- Validate Active Access Token
  local data = cjson.decode(res.body)
  if data["active"] ~= true then
    return error_response(401,"Technical","UnAuthorized","The resource owner or authorization server denied the request.")
  end 
end

return MyToken