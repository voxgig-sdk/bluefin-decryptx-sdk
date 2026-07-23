(* Generated validation entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "validation.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.validation client Noval in
      check_str "name" ent.e_name "validation")
