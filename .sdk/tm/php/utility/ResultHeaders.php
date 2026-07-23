<?php
declare(strict_types=1);

// BluefinDecryptx SDK utility: result_headers

class BluefinDecryptxResultHeaders
{
    public static function call(BluefinDecryptxContext $ctx): ?BluefinDecryptxResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
