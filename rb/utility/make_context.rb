# BluefinDecryptx SDK utility: make_context
require_relative '../core/context'
module BluefinDecryptxUtilities
  MakeContext = ->(ctxmap, basectx) {
    BluefinDecryptxContext.new(ctxmap, basectx)
  }
end
