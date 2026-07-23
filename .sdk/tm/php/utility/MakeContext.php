<?php
declare(strict_types=1);

// BluefinDecryptx SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class BluefinDecryptxMakeContext
{
    public static function call(array $ctxmap, ?BluefinDecryptxContext $basectx): BluefinDecryptxContext
    {
        return new BluefinDecryptxContext($ctxmap, $basectx);
    }
}
