<?php
declare(strict_types=1);

// Typed models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Decrypt entity data model. */
class Decrypt
{
    public ?string $client_id = null;
    public ?int $code = null;
    public ?array $decrypted = null;
    public array $decryption_parameter;
    public array $encrypted;
    public ?bool $failed = null;
    public ?string $firmware = null;
    public bool $has_cc_data;
    public ?string $message = null;
    public string $message_id;
    public string $name;
    public ?string $partner_id = null;
    public ?string $partner_key = null;
    public string $reference;
    public string $serial;
    public bool $success;
    public ?string $value = null;
}

/** Request payload for Decrypt#list. */
class DecryptListMatch
{
    public ?string $client_id = null;
    public ?int $code = null;
    public ?array $decrypted = null;
    public ?array $decryption_parameter = null;
    public ?array $encrypted = null;
    public ?bool $failed = null;
    public ?string $firmware = null;
    public ?bool $has_cc_data = null;
    public ?string $message = null;
    public ?string $message_id = null;
    public ?string $name = null;
    public ?string $partner_id = null;
    public ?string $partner_key = null;
    public ?string $reference = null;
    public ?string $serial = null;
    public ?bool $success = null;
    public ?string $value = null;
}

/** Request payload for Decrypt#create. */
class DecryptCreateData
{
    public ?string $client_id = null;
    public ?int $code = null;
    public ?array $decrypted = null;
    public array $decryption_parameter;
    public array $encrypted;
    public ?bool $failed = null;
    public ?string $firmware = null;
    public bool $has_cc_data;
    public ?string $message = null;
    public string $message_id;
    public string $name;
    public ?string $partner_id = null;
    public ?string $partner_key = null;
    public string $reference;
    public string $serial;
    public bool $success;
    public ?string $value = null;
}

/** DecryptExt entity data model. */
class DecryptExt
{
    public ?string $client_id = null;
    public ?string $completed = null;
    public ?float $decrypted = null;
    public float $encrypted;
    public ?string $ip = null;
    public ?string $message_id = null;
    public string $partner_id;
    public ?string $partner_key = null;
    public ?string $reference = null;
    public string $serial;
    public ?bool $success = null;
}

/** Request payload for DecryptExt#create. */
class DecryptExtCreateData
{
    public ?string $client_id = null;
    public ?string $completed = null;
    public ?float $decrypted = null;
    public float $encrypted;
    public ?string $ip = null;
    public ?string $message_id = null;
    public string $partner_id;
    public ?string $partner_key = null;
    public ?string $reference = null;
    public string $serial;
    public ?bool $success = null;
}

/** Validation entity data model. */
class Validation
{
    public ?string $client_id = null;
    public ?string $firmware = null;
    public string $message_id;
    public ?string $partner_id = null;
    public ?string $partner_key = null;
    public string $reference;
    public string $serial;
    public bool $success;
}

/** Request payload for Validation#create. */
class ValidationCreateData
{
    public ?string $client_id = null;
    public ?string $firmware = null;
    public string $message_id;
    public ?string $partner_id = null;
    public ?string $partner_key = null;
    public string $reference;
    public string $serial;
    public bool $success;
}

