<?php
declare(strict_types=1);

// BluefinDecryptx SDK utility: prepare_body

class BluefinDecryptxPrepareBody
{
    public static function call(BluefinDecryptxContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
