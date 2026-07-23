package voxgig.bluefindecryptxsdk.entity

import voxgig.bluefindecryptxsdk.core.Context
import voxgig.bluefindecryptxsdk.core.Entity
import voxgig.bluefindecryptxsdk.core.Helpers
import voxgig.bluefindecryptxsdk.core.SdkClient
import voxgig.bluefindecryptxsdk.utility.struct.Struct

/** Validation entity client for the BluefinDecryptx SDK. */
@Suppress("UNCHECKED_CAST", "UNUSED_PARAMETER", "UNUSED_VARIABLE")
class ValidationEntity(clientIn: SdkClient, entoptsIn: MutableMap<String, Any?>?) :
  EntityBase("validation", clientIn, entoptsIn) {

  override fun make(): Entity {
    val opts = LinkedHashMap(this.entopts)
    return ValidationEntity(this.client, opts)
  }

  override fun load(req: MutableMap<String, Any?>?, ctrl: MutableMap<String, Any?>?): Any? {
    throw Helpers.unsupportedOp("load", this.name)
  }


  override fun list(req: MutableMap<String, Any?>?, ctrl: MutableMap<String, Any?>?): Any? {
    throw Helpers.unsupportedOp("list", this.name)
  }



  override fun create(reqdata: MutableMap<String, Any?>?, ctrl: MutableMap<String, Any?>?): Any? {
    val ctxmap = linkedMapOf<String, Any?>()
    ctxmap["opname"] = "create"
    ctxmap["ctrl"] = ctrl
    ctxmap["match"] = this.match
    ctxmap["data"] = this.data
    ctxmap["reqdata"] = reqdata
    val ctx = this.utility.makeContext(ctxmap, this.entctx)

    return runOp(ctx) {
      val result = ctx.result
      if (result != null) {
        if (result.resdata != null) {
          val d = Helpers.toMapAny(Struct.clone(result.resdata))
          this.data = d ?: linkedMapOf()
        }
      }
    }
  }



  override fun update(req: MutableMap<String, Any?>?, ctrl: MutableMap<String, Any?>?): Any? {
    throw Helpers.unsupportedOp("update", this.name)
  }


  override fun remove(req: MutableMap<String, Any?>?, ctrl: MutableMap<String, Any?>?): Any? {
    throw Helpers.unsupportedOp("remove", this.name)
  }

}
