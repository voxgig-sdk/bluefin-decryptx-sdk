# BluefinDecryptx SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

BluefinDecryptxUtility.registrar = ->(u) {
  u.clean = BluefinDecryptxUtilities::Clean
  u.done = BluefinDecryptxUtilities::Done
  u.make_error = BluefinDecryptxUtilities::MakeError
  u.feature_add = BluefinDecryptxUtilities::FeatureAdd
  u.feature_hook = BluefinDecryptxUtilities::FeatureHook
  u.feature_init = BluefinDecryptxUtilities::FeatureInit
  u.fetcher = BluefinDecryptxUtilities::Fetcher
  u.make_fetch_def = BluefinDecryptxUtilities::MakeFetchDef
  u.make_context = BluefinDecryptxUtilities::MakeContext
  u.make_options = BluefinDecryptxUtilities::MakeOptions
  u.make_request = BluefinDecryptxUtilities::MakeRequest
  u.make_response = BluefinDecryptxUtilities::MakeResponse
  u.make_result = BluefinDecryptxUtilities::MakeResult
  u.make_point = BluefinDecryptxUtilities::MakePoint
  u.make_spec = BluefinDecryptxUtilities::MakeSpec
  u.make_url = BluefinDecryptxUtilities::MakeUrl
  u.param = BluefinDecryptxUtilities::Param
  u.prepare_auth = BluefinDecryptxUtilities::PrepareAuth
  u.prepare_body = BluefinDecryptxUtilities::PrepareBody
  u.prepare_headers = BluefinDecryptxUtilities::PrepareHeaders
  u.prepare_method = BluefinDecryptxUtilities::PrepareMethod
  u.prepare_params = BluefinDecryptxUtilities::PrepareParams
  u.prepare_path = BluefinDecryptxUtilities::PreparePath
  u.prepare_query = BluefinDecryptxUtilities::PrepareQuery
  u.result_basic = BluefinDecryptxUtilities::ResultBasic
  u.result_body = BluefinDecryptxUtilities::ResultBody
  u.result_headers = BluefinDecryptxUtilities::ResultHeaders
  u.transform_request = BluefinDecryptxUtilities::TransformRequest
  u.transform_response = BluefinDecryptxUtilities::TransformResponse
}
