// Decrypt entity client for the BluefinDecryptx SDK.

import Foundation

public final class DecryptEntity: BluefinDecryptxEntityBase {
  public init(_ client: BluefinDecryptxSDK, _ entopts: VMap? = nil) {
    super.init(client, entopts, "decrypt")
  }

  public override func make() -> Entity {
    return DecryptEntity(client, cloneOpts())
  }

  // (load not defined by this API - base class throws unsupportedOp)

  public override func list(_ reqmatch: VMap?, _ ctrl: VMap?) throws -> Value {
    var ctxmap: [String: Any?] = ["opname": "list", "match": match, "data": data]
    if let ctrl = ctrl { ctxmap["ctrl"] = ctrl }
    if let reqmatch = reqmatch { ctxmap["reqmatch"] = reqmatch }
    let ctx = utility.makeContext(ctxmap, entctx)
  
    return try runOp(ctx) {
      if let result = ctx.result {
        if let rm = result.resmatch { self.match = rm }
      }
    }
  }

  public override func create(_ reqdata: VMap?, _ ctrl: VMap?) throws -> Value {
    var ctxmap: [String: Any?] = ["opname": "create", "match": match, "data": data]
    if let ctrl = ctrl { ctxmap["ctrl"] = ctrl }
    if let reqdata = reqdata { ctxmap["reqdata"] = reqdata }
    let ctx = utility.makeContext(ctxmap, entctx)
  
    return try runOp(ctx) {
      if let result = ctx.result {
        if !isNil(result.resdata) {
          self.data = clone(result.resdata).asMap ?? VMap()
        }
      }
    }
  }

  // (update not defined by this API - base class throws unsupportedOp)

  // (remove not defined by this API - base class throws unsupportedOp)
}
