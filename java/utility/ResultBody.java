package voxgig.bluefindecryptxsdk.utility;

import voxgig.bluefindecryptxsdk.core.Context;
import voxgig.bluefindecryptxsdk.core.Response;
import voxgig.bluefindecryptxsdk.core.Result;

final class ResultBody {

  private ResultBody() {}

  static Result resultBody(Context ctx) {
    Response response = ctx.response;
    Result result = ctx.result;

    if (result != null) {
      if (response != null && response.jsonFunc != null && response.body != null) {
        result.body = response.jsonFunc.get();
      }
    }

    return result;
  }
}
