-- BluefinDecryptx SDK error

local BluefinDecryptxError = {}
BluefinDecryptxError.__index = BluefinDecryptxError


function BluefinDecryptxError.new(code, msg, ctx)
  local self = setmetatable({}, BluefinDecryptxError)
  self.is_sdk_error = true
  self.sdk = "BluefinDecryptx"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function BluefinDecryptxError:error()
  return self.msg
end


function BluefinDecryptxError:__tostring()
  return self.msg
end


return BluefinDecryptxError
