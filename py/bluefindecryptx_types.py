# Typed models for the BluefinDecryptx SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class DecryptRequired(TypedDict):
    decryption_parameter: dict
    encrypted: list
    has_cc_data: bool
    message_id: str
    name: str
    reference: str
    serial: str
    success: bool


class Decrypt(DecryptRequired, total=False):
    client_id: str
    code: int
    decrypted: list
    failed: bool
    firmware: str
    message: str
    partner_id: str
    partner_key: str
    value: str


class DecryptListMatch(TypedDict, total=False):
    client_id: str
    code: int
    decrypted: list
    decryption_parameter: dict
    encrypted: list
    failed: bool
    firmware: str
    has_cc_data: bool
    message: str
    message_id: str
    name: str
    partner_id: str
    partner_key: str
    reference: str
    serial: str
    success: bool
    value: str


class DecryptCreateDataRequired(TypedDict):
    decryption_parameter: dict
    encrypted: list
    has_cc_data: bool
    message_id: str
    name: str
    reference: str
    serial: str
    success: bool


class DecryptCreateData(DecryptCreateDataRequired, total=False):
    client_id: str
    code: int
    decrypted: list
    failed: bool
    firmware: str
    message: str
    partner_id: str
    partner_key: str
    value: str


class DecryptExtRequired(TypedDict):
    encrypted: float
    partner_id: str
    serial: str


class DecryptExt(DecryptExtRequired, total=False):
    client_id: str
    completed: str
    decrypted: float
    ip: str
    message_id: str
    partner_key: str
    reference: str
    success: bool


class DecryptExtCreateDataRequired(TypedDict):
    encrypted: float
    partner_id: str
    serial: str


class DecryptExtCreateData(DecryptExtCreateDataRequired, total=False):
    client_id: str
    completed: str
    decrypted: float
    ip: str
    message_id: str
    partner_key: str
    reference: str
    success: bool


class ValidationRequired(TypedDict):
    message_id: str
    reference: str
    serial: str
    success: bool


class Validation(ValidationRequired, total=False):
    client_id: str
    firmware: str
    partner_id: str
    partner_key: str


class ValidationCreateDataRequired(TypedDict):
    message_id: str
    reference: str
    serial: str
    success: bool


class ValidationCreateData(ValidationCreateDataRequired, total=False):
    client_id: str
    firmware: str
    partner_id: str
    partner_key: str
