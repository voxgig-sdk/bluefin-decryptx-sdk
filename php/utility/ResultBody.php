<?php
declare(strict_types=1);

// BluefinDecryptx SDK utility: result_body

class BluefinDecryptxResultBody
{
    public static function call(BluefinDecryptxContext $ctx): ?BluefinDecryptxResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
