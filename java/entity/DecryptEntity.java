package voxgig.bluefindecryptxsdk.entity;

import java.util.LinkedHashMap;
import java.util.Map;

import voxgig.bluefindecryptxsdk.core.Context;
import voxgig.bluefindecryptxsdk.core.Entity;
import voxgig.bluefindecryptxsdk.core.Helpers;
import voxgig.bluefindecryptxsdk.core.SdkClient;
import voxgig.bluefindecryptxsdk.utility.struct.Struct;

/** Decrypt entity client for the BluefinDecryptx SDK. */
@SuppressWarnings({"unchecked", "unused"})
public class DecryptEntity extends EntityBase {

  public DecryptEntity(SdkClient client, Map<String, Object> entopts) {
    super("decrypt", client, entopts);
  }

  @Override
  public Entity make() {
    Map<String, Object> opts = new LinkedHashMap<>(this.entopts);
    return new DecryptEntity(this.client, opts);
  }

  @Override
  public Object load(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("load", this.name);
  }



  @Override
  public Object list(Map<String, Object> reqmatch, Map<String, Object> ctrl) {
    Map<String, Object> ctxmap = new LinkedHashMap<>();
    ctxmap.put("opname", "list");
    ctxmap.put("ctrl", ctrl);
    ctxmap.put("match", this.match);
    ctxmap.put("data", this.data);
    ctxmap.put("reqmatch", reqmatch);
    Context ctx = this.utility.makeContext.apply(ctxmap, this.entctx);

    return runOp(ctx, () -> {
      if (ctx.result != null) {
        if (ctx.result.resmatch != null) {
          this.match = ctx.result.resmatch;
        }
      }
    });
  }




  @Override
  public Object create(Map<String, Object> reqdata, Map<String, Object> ctrl) {
    Map<String, Object> ctxmap = new LinkedHashMap<>();
    ctxmap.put("opname", "create");
    ctxmap.put("ctrl", ctrl);
    ctxmap.put("match", this.match);
    ctxmap.put("data", this.data);
    ctxmap.put("reqdata", reqdata);
    Context ctx = this.utility.makeContext.apply(ctxmap, this.entctx);

    return runOp(ctx, () -> {
      if (ctx.result != null) {
        if (ctx.result.resdata != null) {
          Map<String, Object> d = Helpers.toMapAny(Struct.clone(ctx.result.resdata));
          this.data = d == null ? new LinkedHashMap<>() : d;
        }
      }
    });
  }



  @Override
  public Object update(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("update", this.name);
  }


  @Override
  public Object remove(Map<String, Object> req, Map<String, Object> ctrl) {
    throw Helpers.unsupportedOp("remove", this.name);
  }

}
