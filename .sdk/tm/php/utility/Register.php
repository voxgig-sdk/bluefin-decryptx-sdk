<?php
declare(strict_types=1);

// BluefinDecryptx SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

BluefinDecryptxUtility::setRegistrar(function (BluefinDecryptxUtility $u): void {
    $u->clean = [BluefinDecryptxClean::class, 'call'];
    $u->done = [BluefinDecryptxDone::class, 'call'];
    $u->make_error = [BluefinDecryptxMakeError::class, 'call'];
    $u->feature_add = [BluefinDecryptxFeatureAdd::class, 'call'];
    $u->feature_hook = [BluefinDecryptxFeatureHook::class, 'call'];
    $u->feature_init = [BluefinDecryptxFeatureInit::class, 'call'];
    $u->fetcher = [BluefinDecryptxFetcher::class, 'call'];
    $u->make_fetch_def = [BluefinDecryptxMakeFetchDef::class, 'call'];
    $u->make_context = [BluefinDecryptxMakeContext::class, 'call'];
    $u->make_options = [BluefinDecryptxMakeOptions::class, 'call'];
    $u->make_request = [BluefinDecryptxMakeRequest::class, 'call'];
    $u->make_response = [BluefinDecryptxMakeResponse::class, 'call'];
    $u->make_result = [BluefinDecryptxMakeResult::class, 'call'];
    $u->make_point = [BluefinDecryptxMakePoint::class, 'call'];
    $u->make_spec = [BluefinDecryptxMakeSpec::class, 'call'];
    $u->make_url = [BluefinDecryptxMakeUrl::class, 'call'];
    $u->param = [BluefinDecryptxParam::class, 'call'];
    $u->prepare_auth = [BluefinDecryptxPrepareAuth::class, 'call'];
    $u->prepare_body = [BluefinDecryptxPrepareBody::class, 'call'];
    $u->prepare_headers = [BluefinDecryptxPrepareHeaders::class, 'call'];
    $u->prepare_method = [BluefinDecryptxPrepareMethod::class, 'call'];
    $u->prepare_params = [BluefinDecryptxPrepareParams::class, 'call'];
    $u->prepare_path = [BluefinDecryptxPreparePath::class, 'call'];
    $u->prepare_query = [BluefinDecryptxPrepareQuery::class, 'call'];
    $u->result_basic = [BluefinDecryptxResultBasic::class, 'call'];
    $u->result_body = [BluefinDecryptxResultBody::class, 'call'];
    $u->result_headers = [BluefinDecryptxResultHeaders::class, 'call'];
    $u->transform_request = [BluefinDecryptxTransformRequest::class, 'call'];
    $u->transform_response = [BluefinDecryptxTransformResponse::class, 'call'];
});
