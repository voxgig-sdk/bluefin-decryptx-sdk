// DecryptExt entity client (generated). Shared entity runtime (data/match
// state, entity context, the runOp pipeline + feature hooks) lives in
// EntityBase (core/types.hpp); this class binds the entity name and its
// supported CRUD operations.

#pragma once

#include <memory>

#include "../core/types.hpp"

namespace sdk {

class DecryptExtEntity : public EntityBase {
public:
  DecryptExtEntity(SdkClient* client, Value entopts = Value::undef())
      : EntityBase("decrypt_ext", client, entopts) {}

  EntityPtr make() override {
    Value opts = vmap();
    if (this->entopts.is_map()) {
      for (const auto& kv : *this->entopts.as_map()) {
        map_put(opts, kv.first, kv.second);
      }
    }
    return std::make_shared<DecryptExtEntity>(this->client, opts);
  }

  Value load(const Value& reqmatch, const Value& ctrl) override {
      (void)reqmatch; (void)ctrl;
      throw Helpers::unsupportedOp("load", this->name_);
    }

  Value list(const Value& reqmatch, const Value& ctrl) override {
      (void)reqmatch; (void)ctrl;
      throw Helpers::unsupportedOp("list", this->name_);
    }


    Value create(const Value& reqdata, const Value& ctrl) override {
      CtxSpec cs;
      cs.setOpname("create");
      cs.ctrlMap = ctrl.is_map() ? ctrl : vmap();
      cs.match = this->match_;
      cs.data = this->data_;
      cs.reqdata = reqdata.is_map() ? reqdata : vmap();
      CtxPtr ctx = this->utility->makeContext(cs, this->entctx);
  
      return runOp(ctx, [this, ctx]() {
        if (ctx->result) {
          if (!is_nullish(ctx->result->resdata)) {
            Value d = Helpers::toMapAny(Struct::clone(ctx->result->resdata));
            this->data_ = d.is_map() ? d : vmap();
          }
        }
      });
    }
  

  Value update(const Value& reqdata, const Value& ctrl) override {
      (void)reqdata; (void)ctrl;
      throw Helpers::unsupportedOp("update", this->name_);
    }

  Value remove(const Value& reqmatch, const Value& ctrl) override {
      (void)reqmatch; (void)ctrl;
      throw Helpers::unsupportedOp("remove", this->name_);
    }
};

} // namespace sdk
