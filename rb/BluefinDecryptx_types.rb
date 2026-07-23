# frozen_string_literal: true

# Typed models for the BluefinDecryptx SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Decrypt entity data model.
#
# @!attribute [rw] client_id
#   @return [String, nil]
#
# @!attribute [rw] code
#   @return [Integer, nil]
#
# @!attribute [rw] decrypted
#   @return [Array, nil]
#
# @!attribute [rw] decryption_parameter
#   @return [Hash]
#
# @!attribute [rw] encrypted
#   @return [Array]
#
# @!attribute [rw] failed
#   @return [Boolean, nil]
#
# @!attribute [rw] firmware
#   @return [String, nil]
#
# @!attribute [rw] has_cc_data
#   @return [Boolean]
#
# @!attribute [rw] message
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String]
#
# @!attribute [rw] name
#   @return [String]
#
# @!attribute [rw] partner_id
#   @return [String, nil]
#
# @!attribute [rw] partner_key
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String]
#
# @!attribute [rw] serial
#   @return [String]
#
# @!attribute [rw] success
#   @return [Boolean]
#
# @!attribute [rw] value
#   @return [String, nil]
Decrypt = Struct.new(
  :client_id,
  :code,
  :decrypted,
  :decryption_parameter,
  :encrypted,
  :failed,
  :firmware,
  :has_cc_data,
  :message,
  :message_id,
  :name,
  :partner_id,
  :partner_key,
  :reference,
  :serial,
  :success,
  :value,
  keyword_init: true
)

# Request payload for Decrypt#list.
#
# @!attribute [rw] client_id
#   @return [String, nil]
#
# @!attribute [rw] code
#   @return [Integer, nil]
#
# @!attribute [rw] decrypted
#   @return [Array, nil]
#
# @!attribute [rw] decryption_parameter
#   @return [Hash, nil]
#
# @!attribute [rw] encrypted
#   @return [Array, nil]
#
# @!attribute [rw] failed
#   @return [Boolean, nil]
#
# @!attribute [rw] firmware
#   @return [String, nil]
#
# @!attribute [rw] has_cc_data
#   @return [Boolean, nil]
#
# @!attribute [rw] message
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] partner_id
#   @return [String, nil]
#
# @!attribute [rw] partner_key
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] serial
#   @return [String, nil]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
#
# @!attribute [rw] value
#   @return [String, nil]
DecryptListMatch = Struct.new(
  :client_id,
  :code,
  :decrypted,
  :decryption_parameter,
  :encrypted,
  :failed,
  :firmware,
  :has_cc_data,
  :message,
  :message_id,
  :name,
  :partner_id,
  :partner_key,
  :reference,
  :serial,
  :success,
  :value,
  keyword_init: true
)

# Request payload for Decrypt#create.
#
# @!attribute [rw] client_id
#   @return [String, nil]
#
# @!attribute [rw] code
#   @return [Integer, nil]
#
# @!attribute [rw] decrypted
#   @return [Array, nil]
#
# @!attribute [rw] decryption_parameter
#   @return [Hash]
#
# @!attribute [rw] encrypted
#   @return [Array]
#
# @!attribute [rw] failed
#   @return [Boolean, nil]
#
# @!attribute [rw] firmware
#   @return [String, nil]
#
# @!attribute [rw] has_cc_data
#   @return [Boolean]
#
# @!attribute [rw] message
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String]
#
# @!attribute [rw] name
#   @return [String]
#
# @!attribute [rw] partner_id
#   @return [String, nil]
#
# @!attribute [rw] partner_key
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String]
#
# @!attribute [rw] serial
#   @return [String]
#
# @!attribute [rw] success
#   @return [Boolean]
#
# @!attribute [rw] value
#   @return [String, nil]
DecryptCreateData = Struct.new(
  :client_id,
  :code,
  :decrypted,
  :decryption_parameter,
  :encrypted,
  :failed,
  :firmware,
  :has_cc_data,
  :message,
  :message_id,
  :name,
  :partner_id,
  :partner_key,
  :reference,
  :serial,
  :success,
  :value,
  keyword_init: true
)

# DecryptExt entity data model.
#
# @!attribute [rw] client_id
#   @return [String, nil]
#
# @!attribute [rw] completed
#   @return [String, nil]
#
# @!attribute [rw] decrypted
#   @return [Float, nil]
#
# @!attribute [rw] encrypted
#   @return [Float]
#
# @!attribute [rw] ip
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] partner_id
#   @return [String]
#
# @!attribute [rw] partner_key
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] serial
#   @return [String]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
DecryptExt = Struct.new(
  :client_id,
  :completed,
  :decrypted,
  :encrypted,
  :ip,
  :message_id,
  :partner_id,
  :partner_key,
  :reference,
  :serial,
  :success,
  keyword_init: true
)

# Request payload for DecryptExt#create.
#
# @!attribute [rw] client_id
#   @return [String, nil]
#
# @!attribute [rw] completed
#   @return [String, nil]
#
# @!attribute [rw] decrypted
#   @return [Float, nil]
#
# @!attribute [rw] encrypted
#   @return [Float]
#
# @!attribute [rw] ip
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String, nil]
#
# @!attribute [rw] partner_id
#   @return [String]
#
# @!attribute [rw] partner_key
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String, nil]
#
# @!attribute [rw] serial
#   @return [String]
#
# @!attribute [rw] success
#   @return [Boolean, nil]
DecryptExtCreateData = Struct.new(
  :client_id,
  :completed,
  :decrypted,
  :encrypted,
  :ip,
  :message_id,
  :partner_id,
  :partner_key,
  :reference,
  :serial,
  :success,
  keyword_init: true
)

# Validation entity data model.
#
# @!attribute [rw] client_id
#   @return [String, nil]
#
# @!attribute [rw] firmware
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String]
#
# @!attribute [rw] partner_id
#   @return [String, nil]
#
# @!attribute [rw] partner_key
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String]
#
# @!attribute [rw] serial
#   @return [String]
#
# @!attribute [rw] success
#   @return [Boolean]
Validation = Struct.new(
  :client_id,
  :firmware,
  :message_id,
  :partner_id,
  :partner_key,
  :reference,
  :serial,
  :success,
  keyword_init: true
)

# Request payload for Validation#create.
#
# @!attribute [rw] client_id
#   @return [String, nil]
#
# @!attribute [rw] firmware
#   @return [String, nil]
#
# @!attribute [rw] message_id
#   @return [String]
#
# @!attribute [rw] partner_id
#   @return [String, nil]
#
# @!attribute [rw] partner_key
#   @return [String, nil]
#
# @!attribute [rw] reference
#   @return [String]
#
# @!attribute [rw] serial
#   @return [String]
#
# @!attribute [rw] success
#   @return [Boolean]
ValidationCreateData = Struct.new(
  :client_id,
  :firmware,
  :message_id,
  :partner_id,
  :partner_key,
  :reference,
  :serial,
  :success,
  keyword_init: true
)

