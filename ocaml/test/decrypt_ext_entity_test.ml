(* Generated decrypt_ext entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "decrypt_ext.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.decrypt_ext client Noval in
      check_str "name" ent.e_name "decrypt_ext")
