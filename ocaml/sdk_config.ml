(* Generated API configuration (mirrors go core/config.go).
 *
 * make_config () — the embedded API model as a voxgig struct value.
 * make_feature name — the N-feature-safe factory the client uses. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Sdk_features

let make_config () : value =
  (jo [
    ("main", (jo [
      ("name", (Str "BluefinDecryptx")) ]));
    ("feature", (jo [
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ])) ])) ]));
    ("options", (jo [
      ("base", (Str "https://secure-prod.decryptx.com/api"));
      ("headers", (jo [
        ("content-type", (Str "application/json")) ]));
      ("entity", (jo [
        ("decrypt", (empty_map ()));
        ("decrypt_ext", (empty_map ()));
        ("validation", (empty_map ())) ]));
      ("auth", (jo [
        ("prefix", (Str "")) ])) ]));
    ("entity", (jo [
      ("decrypt", (jo [
        ("fields", (ja [
          (jo [
            ("active", (Bool true));
            ("name", (Str "client_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "code"));
            ("req", (Bool false));
            ("type", (Str "`$INTEGER`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "decrypted"));
            ("req", (Bool false));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (2.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "decryption_parameter"));
            ("req", (Bool true));
            ("type", (Str "`$OBJECT`"));
            ("index$", (Num (3.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "encrypted"));
            ("req", (Bool true));
            ("type", (Str "`$ARRAY`"));
            ("index$", (Num (4.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "failed"));
            ("req", (Bool false));
            ("type", (Str "`$BOOLEAN`"));
            ("index$", (Num (5.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "firmware"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (6.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "has_cc_data"));
            ("req", (Bool true));
            ("type", (Str "`$BOOLEAN`"));
            ("index$", (Num (7.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "message"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (8.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "message_id"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (9.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "name"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (10.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "partner_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (11.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "partner_key"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (12.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "reference"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool false));
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (13.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "serial"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (14.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "success"));
            ("req", (Bool true));
            ("type", (Str "`$BOOLEAN`"));
            ("index$", (Num (15.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "value"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (16.))) ]) ]));
        ("name", (Str "decrypt"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/decrypt"));
                ("parts", (ja [
                  (Str "decrypt") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "create")) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "client_id"));
                      ("orig", (Str "client_id"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("example", (Str "param 1"));
                      ("kind", (Str "query"));
                      ("name", (Str "encrypted_name"));
                      ("orig", (Str "encrypted_name"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("example", (Str "nlj/tULUuiMlM3io0JZ+9jFBTKH7KCPwVg7PFjvWUMzMa7XE/QbegA=="));
                      ("kind", (Str "query"));
                      ("name", (Str "encrypted_value"));
                      ("orig", (Str "encrypted_value"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "partner_id"));
                      ("orig", (Str "partner_id"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "partner_key"));
                      ("orig", (Str "partner_key"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "reference"));
                      ("orig", (Str "reference"));
                      ("reqd", (Bool false));
                      ("type", (Str "`$STRING`")) ]);
                    (jo [
                      ("active", (Bool true));
                      ("kind", (Str "query"));
                      ("name", (Str "serial"));
                      ("orig", (Str "serial"));
                      ("reqd", (Bool true));
                      ("type", (Str "`$STRING`")) ]) ])) ]));
                ("method", (Str "GET"));
                ("orig", (Str "/healthcheck"));
                ("parts", (ja [
                  (Str "healthcheck") ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "client_id");
                    (Str "encrypted_name");
                    (Str "encrypted_value");
                    (Str "partner_id");
                    (Str "partner_key");
                    (Str "reference");
                    (Str "serial") ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "list")) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("decrypt_ext", (jo [
        ("fields", (ja [
          (jo [
            ("active", (Bool true));
            ("name", (Str "client_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "completed"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "decrypted"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$NUMBER`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (2.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "encrypted"));
            ("req", (Bool true));
            ("type", (Str "`$NUMBER`"));
            ("index$", (Num (3.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "ip"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (4.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "message_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (5.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "partner_id"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (6.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "partner_key"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (7.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "reference"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (8.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "serial"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (9.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "success"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool true));
                ("type", (Str "`$BOOLEAN`")) ])) ]));
            ("req", (Bool false));
            ("type", (Str "`$BOOLEAN`"));
            ("index$", (Num (10.))) ]) ]));
        ("name", (Str "decrypt_ext"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/decrypt-ext"));
                ("parts", (ja [
                  (Str "decrypt-ext") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]) ]));
            ("key$", (Str "create")) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("validation", (jo [
        ("fields", (ja [
          (jo [
            ("active", (Bool true));
            ("name", (Str "client_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (0.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "firmware"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (1.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "message_id"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (2.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "partner_id"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (3.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "partner_key"));
            ("req", (Bool false));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (4.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "reference"));
            ("op", (jo [
              ("create", (jo [
                ("req", (Bool false));
                ("type", (Str "`$STRING`")) ])) ]));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (5.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "serial"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`"));
            ("index$", (Num (6.))) ]);
          (jo [
            ("active", (Bool true));
            ("name", (Str "success"));
            ("req", (Bool true));
            ("type", (Str "`$BOOLEAN`"));
            ("index$", (Num (7.))) ]) ]));
        ("name", (Str "validation"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/device/validate"));
                ("parts", (ja [
                  (Str "device");
                  (Str "validate") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (0.))) ]);
              (jo [
                ("active", (Bool true));
                ("args", (empty_map ()));
                ("method", (Str "POST"));
                ("orig", (Str "/partner/validate"));
                ("parts", (ja [
                  (Str "partner");
                  (Str "validate") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("index$", (Num (1.))) ]) ]));
            ("key$", (Str "create")) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ])) ])) ])

let make_feature (name : string) : feature =
  match name with
  | "test" -> test_feature ()
  | _ -> base_feature ()
