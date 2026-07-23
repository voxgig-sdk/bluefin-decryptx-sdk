# Typed models for the BluefinDecryptx SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels. The SDK carries data as string-keyed struct value
# nodes, so each alias is an open string-keyed map; the @typedoc member lists
# document the concrete shapes. Do not edit by hand.

defmodule BluefinDecryptx.Types do
  @moduledoc """
  Documented shapes for the BluefinDecryptx SDK entities and operation payloads.

  Every alias resolves to an open string-keyed map because the SDK carries
  data as string-keyed struct value nodes; consult each type's member list for
  the concrete field/param types.
  """

  @typedoc """
  Decrypt entity data model.

  Members:
    * `"client_id"` — String.t() (optional)
    * `"code"` — integer() (optional)
    * `"decrypted"` — list() (optional)
    * `"decryption_parameter"` — map() (required)
    * `"encrypted"` — list() (required)
    * `"failed"` — boolean() (optional)
    * `"firmware"` — String.t() (optional)
    * `"has_cc_data"` — boolean() (required)
    * `"message"` — String.t() (optional)
    * `"message_id"` — String.t() (required)
    * `"name"` — String.t() (required)
    * `"partner_id"` — String.t() (optional)
    * `"partner_key"` — String.t() (optional)
    * `"reference"` — String.t() (required)
    * `"serial"` — String.t() (required)
    * `"success"` — boolean() (required)
    * `"value"` — String.t() (optional)
  """
  @type decrypt :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Decrypt list.

  Members:
    * `"client_id"` — String.t() (optional)
    * `"code"` — integer() (optional)
    * `"decrypted"` — list() (optional)
    * `"decryption_parameter"` — map() (optional)
    * `"encrypted"` — list() (optional)
    * `"failed"` — boolean() (optional)
    * `"firmware"` — String.t() (optional)
    * `"has_cc_data"` — boolean() (optional)
    * `"message"` — String.t() (optional)
    * `"message_id"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"partner_id"` — String.t() (optional)
    * `"partner_key"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"serial"` — String.t() (optional)
    * `"success"` — boolean() (optional)
    * `"value"` — String.t() (optional)
  """
  @type decrypt_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Decrypt create.

  Members:
    * `"client_id"` — String.t() (optional)
    * `"code"` — integer() (optional)
    * `"decrypted"` — list() (optional)
    * `"decryption_parameter"` — map() (required)
    * `"encrypted"` — list() (required)
    * `"failed"` — boolean() (optional)
    * `"firmware"` — String.t() (optional)
    * `"has_cc_data"` — boolean() (required)
    * `"message"` — String.t() (optional)
    * `"message_id"` — String.t() (required)
    * `"name"` — String.t() (required)
    * `"partner_id"` — String.t() (optional)
    * `"partner_key"` — String.t() (optional)
    * `"reference"` — String.t() (required)
    * `"serial"` — String.t() (required)
    * `"success"` — boolean() (required)
    * `"value"` — String.t() (optional)
  """
  @type decrypt_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  DecryptExt entity data model.

  Members:
    * `"client_id"` — String.t() (optional)
    * `"completed"` — String.t() (optional)
    * `"decrypted"` — float() (optional)
    * `"encrypted"` — float() (required)
    * `"ip"` — String.t() (optional)
    * `"message_id"` — String.t() (optional)
    * `"partner_id"` — String.t() (required)
    * `"partner_key"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"serial"` — String.t() (required)
    * `"success"` — boolean() (optional)
  """
  @type decrypt_ext :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for DecryptExt create.

  Members:
    * `"client_id"` — String.t() (optional)
    * `"completed"` — String.t() (optional)
    * `"decrypted"` — float() (optional)
    * `"encrypted"` — float() (required)
    * `"ip"` — String.t() (optional)
    * `"message_id"` — String.t() (optional)
    * `"partner_id"` — String.t() (required)
    * `"partner_key"` — String.t() (optional)
    * `"reference"` — String.t() (optional)
    * `"serial"` — String.t() (required)
    * `"success"` — boolean() (optional)
  """
  @type decrypt_ext_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Validation entity data model.

  Members:
    * `"client_id"` — String.t() (optional)
    * `"firmware"` — String.t() (optional)
    * `"message_id"` — String.t() (required)
    * `"partner_id"` — String.t() (optional)
    * `"partner_key"` — String.t() (optional)
    * `"reference"` — String.t() (required)
    * `"serial"` — String.t() (required)
    * `"success"` — boolean() (required)
  """
  @type validation :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Validation create.

  Members:
    * `"client_id"` — String.t() (optional)
    * `"firmware"` — String.t() (optional)
    * `"message_id"` — String.t() (required)
    * `"partner_id"` — String.t() (optional)
    * `"partner_key"` — String.t() (optional)
    * `"reference"` — String.t() (required)
    * `"serial"` — String.t() (required)
    * `"success"` — boolean() (required)
  """
  @type validation_create_data :: %{optional(String.t()) => any()}

end
