// BluefinDecryptxError - the SDK error type. Carries the pipeline error code,
// the originating context and cleaned result/spec snapshots.

namespace BluefinDecryptxSdk;

public class BluefinDecryptxError : Exception
{
    public bool IsBluefinDecryptxError = true;
    public string Sdk = "BluefinDecryptx";
    public string Code;
    public Context? Ctx;
    public object? ResultVal;
    public object? SpecVal;

    public BluefinDecryptxError(string code, string msg, Context? ctx)
        : base(msg)
    {
        Code = code;
        Ctx = ctx;
    }
}
