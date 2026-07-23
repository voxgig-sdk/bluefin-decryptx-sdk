// Typed reference models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Dictionary<string, object?> / object?) at
// runtime, so these types are not wired into the op signatures — use them to
// describe a payload before converting it to a dictionary. Optional (req:false)
// keys are modelled as nullable properties.

namespace BluefinDecryptxSdk.Types;

public record Decrypt
{
    public string? client_id { get; init; }
    public long? code { get; init; }
    public List<object?>? decrypted { get; init; }
    public Dictionary<string, object?> decryption_parameter { get; init; }
    public List<object?> encrypted { get; init; }
    public bool? failed { get; init; }
    public string? firmware { get; init; }
    public bool has_cc_data { get; init; }
    public string? message { get; init; }
    public string message_id { get; init; }
    public string name { get; init; }
    public string? partner_id { get; init; }
    public string? partner_key { get; init; }
    public string reference { get; init; }
    public string serial { get; init; }
    public bool success { get; init; }
    public string? value { get; init; }
}

public record DecryptListMatch
{
    public string? client_id { get; init; }
    public long? code { get; init; }
    public List<object?>? decrypted { get; init; }
    public Dictionary<string, object?>? decryption_parameter { get; init; }
    public List<object?>? encrypted { get; init; }
    public bool? failed { get; init; }
    public string? firmware { get; init; }
    public bool? has_cc_data { get; init; }
    public string? message { get; init; }
    public string? message_id { get; init; }
    public string? name { get; init; }
    public string? partner_id { get; init; }
    public string? partner_key { get; init; }
    public string? reference { get; init; }
    public string? serial { get; init; }
    public bool? success { get; init; }
    public string? value { get; init; }
}

public record DecryptCreateData
{
    public string? client_id { get; init; }
    public long? code { get; init; }
    public List<object?>? decrypted { get; init; }
    public Dictionary<string, object?> decryption_parameter { get; init; }
    public List<object?> encrypted { get; init; }
    public bool? failed { get; init; }
    public string? firmware { get; init; }
    public bool has_cc_data { get; init; }
    public string? message { get; init; }
    public string message_id { get; init; }
    public string name { get; init; }
    public string? partner_id { get; init; }
    public string? partner_key { get; init; }
    public string reference { get; init; }
    public string serial { get; init; }
    public bool success { get; init; }
    public string? value { get; init; }
}

public record DecryptExt
{
    public string? client_id { get; init; }
    public string? completed { get; init; }
    public double? decrypted { get; init; }
    public double encrypted { get; init; }
    public string? ip { get; init; }
    public string? message_id { get; init; }
    public string partner_id { get; init; }
    public string? partner_key { get; init; }
    public string? reference { get; init; }
    public string serial { get; init; }
    public bool? success { get; init; }
}

public record DecryptExtCreateData
{
    public string? client_id { get; init; }
    public string? completed { get; init; }
    public double? decrypted { get; init; }
    public double encrypted { get; init; }
    public string? ip { get; init; }
    public string? message_id { get; init; }
    public string partner_id { get; init; }
    public string? partner_key { get; init; }
    public string? reference { get; init; }
    public string serial { get; init; }
    public bool? success { get; init; }
}

public record Validation
{
    public string? client_id { get; init; }
    public string? firmware { get; init; }
    public string message_id { get; init; }
    public string? partner_id { get; init; }
    public string? partner_key { get; init; }
    public string reference { get; init; }
    public string serial { get; init; }
    public bool success { get; init; }
}

public record ValidationCreateData
{
    public string? client_id { get; init; }
    public string? firmware { get; init; }
    public string message_id { get; init; }
    public string? partner_id { get; init; }
    public string? partner_key { get; init; }
    public string reference { get; init; }
    public string serial { get; init; }
    public bool success { get; init; }
}

