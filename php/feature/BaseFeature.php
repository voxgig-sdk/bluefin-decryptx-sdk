<?php
declare(strict_types=1);

// BluefinDecryptx SDK base feature

class BluefinDecryptxBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(BluefinDecryptxContext $ctx, array $options): void {}
    public function PostConstruct(BluefinDecryptxContext $ctx): void {}
    public function PostConstructEntity(BluefinDecryptxContext $ctx): void {}
    public function SetData(BluefinDecryptxContext $ctx): void {}
    public function GetData(BluefinDecryptxContext $ctx): void {}
    public function GetMatch(BluefinDecryptxContext $ctx): void {}
    public function SetMatch(BluefinDecryptxContext $ctx): void {}
    public function PrePoint(BluefinDecryptxContext $ctx): void {}
    public function PreSpec(BluefinDecryptxContext $ctx): void {}
    public function PreRequest(BluefinDecryptxContext $ctx): void {}
    public function PreResponse(BluefinDecryptxContext $ctx): void {}
    public function PreResult(BluefinDecryptxContext $ctx): void {}
    public function PreDone(BluefinDecryptxContext $ctx): void {}
    public function PreUnexpected(BluefinDecryptxContext $ctx): void {}
}
