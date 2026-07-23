package voxgig.bluefindecryptxsdk.utility;

import java.util.LinkedHashMap;
import java.util.Map;

import voxgig.bluefindecryptxsdk.core.Context;
import voxgig.bluefindecryptxsdk.core.Feature;
import voxgig.bluefindecryptxsdk.core.Helpers;
import voxgig.bluefindecryptxsdk.utility.struct.Struct;

final class FeatureInit {

  private FeatureInit() {}

  static void featureInit(Context ctx, Feature f) {
    String fname = f.getName();
    Map<String, Object> fopts = new LinkedHashMap<>();

    if (ctx.options != null) {
      Map<String, Object> featureOpts =
          Helpers.toMapAny(Struct.getprop(ctx.options, "feature"));
      if (featureOpts != null) {
        Map<String, Object> fo = Helpers.toMapAny(Struct.getprop(featureOpts, fname));
        if (fo != null) {
          fopts = fo;
        }
      }
    }

    Object active = fopts.get("active");
    if (Boolean.TRUE.equals(active)) {
      f.init(ctx, fopts);
    }
  }
}
