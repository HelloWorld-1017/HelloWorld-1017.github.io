/* Include files */

#include "ex_sdl_flexible_shaft_lstm_sfun.h"
#include "c2_ex_sdl_flexible_shaft_lstm.h"
#include "MWCudaDimUtility.hpp"
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

#include <cstring>
#include <cstdlib>

/* Forward Declarations */

/* Type Definitions */

/* Named Constants */
const int32_T CALL_EVENT{ -1 };

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;

/* Function Declarations */
static void initialize_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void initialize_params_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void mdl_start_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void mdl_terminate_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void mdl_setup_runtime_resources_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void mdl_cleanup_runtime_resources_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void enable_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void disable_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void sf_gateway_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void ext_mode_exec_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void c2_do_animation_call_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void set_sim_state_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance, const mxArray
   *c2_st);
static void initSimStructsc2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);
static void c2_DeepLearningNetwork_delete
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj);
static void c2_DeepLearningNetwork_callDelete
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj);
static void c2_eML_blk_kernel(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct
  *chartInstance, real_T c2_b_in_1[3], real32_T c2_b_out_1_predict[2]);
static void c2_DeepLearningNetwork_setup
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj);
static void c2_DeepLearningNetwork_predictAndUpdateState
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj, real_T
   c2_indata[3], real32_T c2_out[2]);
static void c2_DeepLearningNetwork_callPredictForCustomLayers
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj);
static void c2_emlrt_marshallIn(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct
  *chartInstance, const mxArray *c2_b_out_1_predict, const char_T *c2_identifier,
  real32_T c2_y[2]);
static void c2_b_emlrt_marshallIn(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real32_T c2_y[2]);
static uint8_T c2_c_emlrt_marshallIn
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance, const mxArray
   *c2_b_is_active_c2_ex_sdl_flexible_shaft_lstm, const char_T *c2_identifier);
static uint8_T c2_d_emlrt_marshallIn
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance, const mxArray
   *c2_u, const emlrtMsgIdentifier *c2_parentId);
static __global__ void c2_eML_blk_kernel_kernel1(const real32_T c2_varargout_1[2],
  real32_T c2_b_out_1_predict[2]);
static __global__ void c2_DeepLearningNetwork_predictAndUpdateState_kernel2(
  const real_T c2_indata[3], real32_T c2_minibatch[3]);
static void c2_checkCleanupCudaError(cudaError_t c2_errCode, const char_T
  *c2_file, uint32_T c2_line);
static emlrtRTEInfo c2_createEmlrtInfoStruct(const char_T *c2_file, uint32_T
  c2_line);
static void init_dsm_address_info(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *
  chartInstance);
static void init_simulink_io_address
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  emlrtLicenseCheckR2022a(chartInstance->c2_fEmlrtCtx, (const char_T *)
    "EMLRT:runTime:MexFunctionNeedsLicense", (const char_T *)
    "distrib_computing_toolbox", 2);
  emlrtLicenseCheckR2022a(chartInstance->c2_fEmlrtCtx, (const char_T *)
    "EMLRT:runTime:MexFunctionNeedsLicense", (const char_T *)
    "neural_network_toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c2_network_not_empty = false;
  chartInstance->c2_is_active_c2_ex_sdl_flexible_shaft_lstm = 0U;
  chartInstance->c2_network.matlabCodegenIsDeleted = true;
  emlrtInitGPU(chartInstance->c2_fEmlrtCtx);
  cudaGetLastError();
  cudaMalloc(&chartInstance->c2_gpu_out_1_predict, 8ULL);
  cudaMalloc(&chartInstance->c2_gpu_varargout_1, 8ULL);
}

static void initialize_params_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
}

static void mdl_start_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
}

static void mdl_terminate_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  cudaError_t c2_errCode;
  cudaFree(*chartInstance->c2_gpu_out_1_predict);
  cudaFree(*chartInstance->c2_gpu_varargout_1);
  c2_errCode = cudaGetLastError();
  if (c2_errCode != cudaSuccess) {
    emlrtThinCUDAError((uint32_T)c2_errCode, (char_T *)cudaGetErrorName
                       (c2_errCode), (char_T *)cudaGetErrorString(c2_errCode),
                       (char_T *)"SimGPUErrorChecks",
                       chartInstance->c2_fEmlrtCtx);
  }
}

static void mdl_setup_runtime_resources_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  setDebuggerFlag(chartInstance->S, false);
  sim_mode_is_external(chartInstance->S);
}

static void mdl_cleanup_runtime_resources_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  if (!chartInstance->c2_network.matlabCodegenIsDeleted) {
    chartInstance->c2_network.matlabCodegenIsDeleted = true;
    c2_DeepLearningNetwork_delete(chartInstance, &chartInstance->c2_network);
  }
}

static void enable_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void sf_gateway_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  chartInstance->c2_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  c2_eML_blk_kernel(chartInstance, *chartInstance->c2_in_1,
                    *chartInstance->c2_out_1_predict);
  c2_do_animation_call_c2_ex_sdl_flexible_shaft_lstm(chartInstance);
}

static void ext_mode_exec_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
}

static void c2_do_animation_call_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static const mxArray *get_sim_state_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  const mxArray *c2_b_y{ NULL };

  const mxArray *c2_c_y{ NULL };

  const mxArray *c2_st;
  const mxArray *c2_y{ NULL };

  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellmatrix(2, 1), false);
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", *chartInstance->c2_out_1_predict, 1,
    0U, 1U, 0U, 2, 2, 1), false);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y",
    &chartInstance->c2_is_active_c2_ex_sdl_flexible_shaft_lstm, 3, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c2_y, 1, c2_c_y);
  sf_mex_assign(&c2_st, c2_y, false);
  return c2_st;
}

static void set_sim_state_c2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance, const mxArray
   *c2_st)
{
  const mxArray *c2_u;
  c2_u = sf_mex_dup(c2_st);
  c2_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 0)),
                      "out_1_predict", *chartInstance->c2_out_1_predict);
  chartInstance->c2_is_active_c2_ex_sdl_flexible_shaft_lstm =
    c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 1)),
    "is_active_c2_ex_sdl_flexible_shaft_lstm");
  sf_mex_destroy(&c2_u);
  sf_mex_destroy(&c2_st);
}

static void initSimStructsc2_ex_sdl_flexible_shaft_lstm
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
}

static void c2_DeepLearningNetwork_delete
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj)
{
  c2_DeepLearningNetwork_callDelete(chartInstance, c2_obj);
}

static void c2_DeepLearningNetwork_callDelete
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj)
{
  if (c2_obj->isInitialized) {
    c2_obj->cleanup();
  }
}

const mxArray *sf_c2_ex_sdl_flexible_shaft_lstm_get_eml_resolved_functions_info()
{
  const mxArray *c2_nameCaptureInfo{ NULL };

  const char_T *c2_data[21]{
    "789ced5dcb6fe3c619978b2cb06d918ddba069d2439002390430a04a5a79d7ee29b2e487d6962c59965fcbc0a2c891448b22693e64d9e841f7a2ed9e5aa02dd2"
    "055ab445df3d15bd15480e457bc9a94dff8b1e935b2891638b94c7239b34351ecf77903cfe38f3fb6686fc7dc36f1e8acde40b33b158ec51cc11ed23e7fb5537",
    "3deb7e7f29e615bf7ec6fdfeb62f0de541ec154f3ea8ff91fb2da88a097aa69350f80e38cf29aa1d49e11573fb5403311d18aadc05e250d39064b02d75406534"
    "511ca43a2b23aaf3c44035f83bdb0242bb6275627acbb8b0501e4d9cb7470d51df5730ede1177f7bf8afbb2f78ffb8211e2c7f1f8307f5cfab1f64bfcb550da0",
    "1bdcb621294d2e078cb6a96a5cd94eb42cbec0c79b92d9b2ea7149e50e459d6f9806974aa452f1642a9e5ae41a32e8497519545ab66643e5c52230e31ddef4d5"
    "a786b0f7b509ebe3ffbeb8fee1f0fbf0edffcd4489f7d3079faf448907655a783d447993de8f6f20f0667d7aa358dd6daa6beb99a58cbcf8acc2e7c5fab342ee",
    "c28e12060767470c918eaafc7f22f24fda8ec0978ef9ae83fae7f9bde50fdeb59f4399afebaa6abecb99aa2ad7d51e67b4781d889c280baa08f4c33a6f006f62"
    "6ef8373727d99e4657789993eda73a0780b601785db159c17ec24f54bd1dd746ead50f58afb730f582faa16df14bac71f541f97ac677ddb83d8e46b05b71140f",
    "5e7853bc97483caffe793e3b20ec92ae3675be93e34d9e2b64b637324b5cc5d23455374bbcd0e69bc0e0b60624cd5fd9ed86934583599c6b0e45f9d0e4f526b0"
    "89debd17debfa4c1b94b6f89a8f8e9add73f8d94ef63fff9573d523c5768e7fbe326bff064b9ab3f5929ed57770455da3d351e53c4f78c17bcbc10f4befa26a6",
    "3da0def113c34fd786aa29c9c6d4c6f341ef839f63f0a07e4af7c158437363ff190e1722e3b30f67a2f50ffd1faece4589078576ff30af0a0b275259e8cd2753"
    "c77ac2c83e2dc8a5157afc430d91ffb67848bb211e2cff912fedc7837a0398eec35f1c06a9487d4f980dc8cb7fc1d803f5cff39b643be8196f8fdd171ea31d2f",
    "2a9eae1e14779eac567247c5b5e3ea51f3b4c43f2e09ab8ca7fd72dbf16658fe03249ea3b19f768be4f8cdc380bcfc1b8c3d507f2778d9eea9fbc257b4e3313e"
    "0ea7fc1a223fa9e3e62f63f0a05ee065b9e272f3287e3f203e69e3e6df63ec817af2f9d9db63f785c768c7633c1d4ef9d1c5bfa7c313e3814f1d3425c3047a0e",
    "684011812248c060f16f16ff66f1ef30f1a0d0ee1f688f7f33ff10ae7f7813d31e502fcaaea571c11215c5f9cc68d2b4fcc3ff6f8807cbff01060fea6fd53f34"
    "35cbd18ede08e72d6ddf138346e660537bd64fd510f5bbb3eb653ed9fa7ea478aed0ee0f8a99dcee4aa1dc681f6752ed76698bdf2f96ba4bf4f8831a22ff6df1",
    "4ed07efb06060fea359b3c24c1cc286255137913544cfb23466e7c2768fcfd97187ba09ea4f8cea57d148f36aef3e74fff1b2d4f7faff551a478aed0ced33963"
    "dd382b2faecda756ba8bf2dec941b9b1d65ba687a7193f5cce0f7d44bd276d97b731ed02f5481e77c23c53f3a741e7057e87c1837a72d6bb3a6f7528857b7b50",
    "eb3ffa5f9ff9384a3c28b4fb0f71db4894d77bddf6fa3cdfeacdab62219d6c53342f700fd7773844d1e565e9dc79342c39cbcb725c0bedfe62f30397e3b1f901"
    "783d9b1f88028fcd0f84537e0d919fd4753eaffad27e3ca877df2556547dab588c911b070acacb3fc3d803f504f969ced3372cfe132e9e2b779597278df7f65a",
    "ab3bd6c24e3591ac341a4979afa734caad183dbccc7821dcb80f29e71ff825aaf1fb4b0c1ed49313f761e71fdc2a9e2b77d54fb0f30fdceb03f2c29f10e5cffa"
    "f464f909550086915734cbac4867c0761825bfeb607ec37b21f31b8ed410f5657e63423c5798dfb81a0767470c91be2bef172f11e58ff302397ec300e6a8cf18",
    "7a0ad81e2f10f59db43dbe83690fa877fc043cfa2d2ea92d5e1165dbc8b8ae28f1a1798336b2fd9966574d9f9adf7833e0fdf1370c1ed44fc76f5c9cbd3777d1"
    "03dc9cdd05dcfb637dc08dfd271edd7ee1c8e79bdf79efdf51e241a1dd9f4867e9cdd2d30ad8cb49d5837a79c7dcabe61314cd37337fe2f5277d447dd93aa5ab",
    "f160f96c9dd2d5ed439cdf60eb9486c2d6295daf7ce637c2f51b2c5e75351ed493e33758bcea56f15ca1dd4fd01eafaa21f293ba4e69d2f3886c5f90518496aa"
    "fbf0fb01f1c3f6039f05b4e727187ba09e303fedf40dc5f11eb63ec991b0f9b8f0b87e52e093cf9ad9673b566f433de1addd55b66e744ca2e2e347beb41f0fea",
    "2f4ee9cd2b0d955c3e0e3a4e9e7c3d3f517c3cd237d1aee767f194dbc58b8a974b95e2e27625dd910ef4553d9d492573e5d52245f1941a223fa9e7283ff4a52f"
    "f01c0ddcce452a0f071d17ff18630fd493c4c3b04f46d759d510f564fc3b191e14daf977b79c5edd3cdd6a27f70f4c21df5d308fe6c10a1b178fc9a4fc1bd579",
    "66f6d82b6b19a6dad9e04f816eb3900674530206a9bc1c74fff3af31f6403d49bc8cea239a799ac52f1c097d9c7cd4d969168493467bde28a6ab8b4f96f38912"
    "45f1e4a0efcfb4edaf7a81a8efa4ed91c0b407d45fbdfe71d3327d4beda6e557df09787ffc1d8307f5e4ad7f1cef036efc5f70390bb57e85ad8374246cbf62ed",
    "ef2793dbf95d0ba8e574b3bdd5aa6c1a698afc4a0d919fd4f1ffa4fda6390f7e4152a43a6f0a2d78b002ade3ff5f61ec817ac2fcfb257d44779c9c8dff1d09fb"
    "795fad9f2ca6b2c762b5bbb65ca9d4577ac55c3541114f337eb89c1f82be07b07d50def2d93ea8c9da8934bfc2c6ff8eb07d50d72bffbd807cf131a2fc599f7e",
    "4a7ee57a84e13a9cac2a5b1da5c01fa9fa0e104c551f5ee9f53b7d44bbb0fd5257e3c1f2d97ea9abdb8738ffc2e69787c2f64b5daf7cf6de72f97b0b3bd7f97a"
    "78b07c76aeb3b7fe385e63e73adf2e1e3bd7399cf26b88fca4aecfff2a060feadd5f031f6c9df5e0f703e293f6fbed7fc4d803f524f9e92b7fbfddedb1fbc263",
    "b4e3b1df6f0fa7fc1a223fa9f3c55fc3e041fde0a9f71ccae9b3a31fd00ed2f653fd02630fd493c4d7637d44713c9fcd133b12363f1be564aa5338c88b8b5db3"
    "95de2e9ee616f6f7b3f4f033e3052f2fbc40d497ad13bd1e1e2c9fad1375e4aefa15364fec085b277abdf26b88fca4c66750f59bf57ddbec3188d32f0de2f483",
    "577e5ac7fb1f62ec817a92fcbabf6fd8be30c6cbd7e565dd6acd771367675ba5b36de9e98695107793674b8c97fd32292ff76f8807cbff16060feabd63fa916d"
    "a246b8f690b68effb7187ba09e249e46f75574e74232bebe5dbca8f83a6f2d957bda5eaa9e3f05a79b4fd7abd5726a9df1f59844358e7ecd97f6e341fd8003aa",
    "daf90f9913cbcf41d7c7ff15630fd493c4cfe879ced11ef3b6530dd10eb4f019ed786cbe339cf26b88fca4f2f5573078503f78fa734006f0c12795af83ae4bf9"
    "03c61ea8bf1b7c7dd163f785c768c7633c1dacfc2f00ef7e789a", "" };

  c2_nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&c2_data[0], 50056U, &c2_nameCaptureInfo);
  return c2_nameCaptureInfo;
}

static void c2_eML_blk_kernel(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct
  *chartInstance, real_T c2_b_in_1[3], real32_T c2_b_out_1_predict[2])
{
  real32_T c2_varargout_1[2];
  if (!chartInstance->c2_network_not_empty) {
    c2_DeepLearningNetwork_setup(chartInstance, &chartInstance->c2_network);
    chartInstance->c2_network.matlabCodegenIsDeleted = false;
    chartInstance->c2_network_not_empty = true;
  }

  c2_DeepLearningNetwork_predictAndUpdateState(chartInstance,
    &chartInstance->c2_network, c2_b_in_1, c2_varargout_1);
  cudaMemcpy(*chartInstance->c2_gpu_varargout_1, c2_varargout_1, 8ULL,
             cudaMemcpyHostToDevice);
  c2_eML_blk_kernel_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
    (*chartInstance->c2_gpu_varargout_1, *chartInstance->c2_gpu_out_1_predict);
  cudaMemcpy(c2_b_out_1_predict, *chartInstance->c2_gpu_out_1_predict, 8ULL,
             cudaMemcpyDeviceToHost);
}

static void c2_DeepLearningNetwork_setup
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj)
{
  c2_obj->setup(chartInstance);
}

static void c2_DeepLearningNetwork_predictAndUpdateState
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj, real_T
   c2_indata[3], real32_T c2_out[2])
{
  real_T (*c2_gpu_indata)[3];
  int32_T c2_sequenceLengths[1];
  real32_T (*c2_gpu_minibatch)[3];
  real32_T (*c2_gpu_out)[2];
  cudaMalloc(&c2_gpu_out, 8ULL);
  cudaMalloc(&c2_gpu_minibatch, 12ULL);
  cudaMalloc(&c2_gpu_indata, 24ULL);
  cudaMemcpy(*c2_gpu_indata, c2_indata, 24ULL, cudaMemcpyHostToDevice);
  c2_DeepLearningNetwork_predictAndUpdateState_kernel2<<<dim3(1U, 1U, 1U), dim3
    (32U, 1U, 1U)>>>(*c2_gpu_indata, *c2_gpu_minibatch);
  c2_sequenceLengths[0] = 1;
  c2_obj->setSize(&c2_sequenceLengths[0]);
  cudaMemcpy(c2_obj->getInputDataPointer(0), *c2_gpu_minibatch,
             c2_obj->getLayerOutputSize(0, 0), cudaMemcpyDeviceToDevice);
  c2_obj->predict();
  cudaMemcpy(*c2_gpu_out, c2_obj->getLayerOutput(7, 0),
             c2_obj->getLayerOutputSize(7, 0), cudaMemcpyDeviceToDevice);
  c2_DeepLearningNetwork_callPredictForCustomLayers(chartInstance, c2_obj);
  c2_obj->updateState();
  cudaMemcpy(c2_out, *c2_gpu_out, 8ULL, cudaMemcpyDeviceToHost);
  cudaFree(*c2_gpu_indata);
  cudaFree(*c2_gpu_minibatch);
  cudaFree(*c2_gpu_out);
}

static void c2_DeepLearningNetwork_callPredictForCustomLayers
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance,
   c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0 *c2_obj)
{
}

static void c2_emlrt_marshallIn(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct
  *chartInstance, const mxArray *c2_b_out_1_predict, const char_T *c2_identifier,
  real32_T c2_y[2])
{
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = const_cast<const char_T *>(c2_identifier);
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_out_1_predict),
                        &c2_thisId, c2_y);
  sf_mex_destroy(&c2_b_out_1_predict);
}

static void c2_b_emlrt_marshallIn(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *
  chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real32_T c2_y[2])
{
  int32_T c2_i;
  real32_T c2_fv[2];
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_fv, 0, 1, 0U, 1, 0U, 2, 2, 1);
  for (c2_i = 0; c2_i < 2; c2_i++) {
    c2_y[c2_i] = c2_fv[c2_i];
  }

  sf_mex_destroy(&c2_u);
}

static uint8_T c2_c_emlrt_marshallIn
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance, const mxArray
   *c2_b_is_active_c2_ex_sdl_flexible_shaft_lstm, const char_T *c2_identifier)
{
  emlrtMsgIdentifier c2_thisId;
  uint8_T c2_y;
  c2_thisId.fIdentifier = const_cast<const char_T *>(c2_identifier);
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_y = c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_ex_sdl_flexible_shaft_lstm), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_ex_sdl_flexible_shaft_lstm);
  return c2_y;
}

static uint8_T c2_d_emlrt_marshallIn
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance, const mxArray
   *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_b_u;
  uint8_T c2_y;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_b_u, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_b_u;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static __global__ __launch_bounds__(32, 1) void c2_eML_blk_kernel_kernel1(const
  real32_T c2_varargout_1[2], real32_T c2_b_out_1_predict[2])
{
  uint64_T c2_threadId;
  int32_T c2_i;
  c2_threadId = (uint64_T)mwGetGlobalThreadIndexInXDimension();
  c2_i = (int32_T)c2_threadId;
  if (c2_i < 2) {
    c2_b_out_1_predict[c2_i] = c2_varargout_1[c2_i];
  }
}

static __global__ __launch_bounds__(32, 1) void
  c2_DeepLearningNetwork_predictAndUpdateState_kernel2(const real_T c2_indata[3],
  real32_T c2_minibatch[3])
{
  uint64_T c2_threadId;
  int32_T c2_i;
  c2_threadId = (uint64_T)mwGetGlobalThreadIndexInXDimension();
  c2_i = (int32_T)c2_threadId;
  if (c2_i < 3) {
    c2_minibatch[c2_i] = (real32_T)c2_indata[c2_i];
  }
}

void c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::allocate()
{
  int32_T c2_idx;
  targetImpl->allocate(globalMaxSequenceLength * 200, 2);
  for (c2_idx = 0; c2_idx < 8; c2_idx++) {
    layers[c2_idx]->allocate();
  }

  (static_cast<MWTensor<real32_T> *>(inputTensors[0]))->setData(layers[0]
    ->getLayerOutput(0));
}

void c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::postsetup()
{
  targetImpl->postSetup(layers, numLayers);
}

c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::
  c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0()
{
  numLayers = 8;
  isInitialized = false;
  targetImpl = 0;
  layers[0] = new MWSequenceInputLayer;
  layers[0]->setName("sequenceinput");
  layers[1] = new MWElementwiseAffineLayer;
  layers[1]->setName("sequenceinput_normalization");
  layers[1]->setInPlaceIndex(0, 0);
  layers[2] = new MWFCLayer;
  layers[2]->setName("fc_1");
  layers[3] = new MWReLULayer;
  layers[3]->setName("relu_1");
  layers[3]->setInPlaceIndex(0, 0);
  layers[4] = new MWRNNLayer;
  layers[4]->setName("lstm_1_fused");
  layers[5] = new MWReLULayer;
  layers[5]->setName("relu_2");
  layers[5]->setInPlaceIndex(0, 0);
  layers[6] = new MWFCLayer;
  layers[6]->setName("fc_2");
  layers[7] = new MWOutputLayer;
  layers[7]->setName("regressionoutput");
  layers[7]->setInPlaceIndex(0, 0);
  targetImpl = new MWCudnnTarget::MWTargetNetworkImpl;
  inputTensors[0] = new MWTensor<real32_T>;
  inputTensors[0]->setHeight(1);
  inputTensors[0]->setWidth(1);
  inputTensors[0]->setChannels(3);
  inputTensors[0]->setBatchSize(1);
  globalMaxSequenceLength = -1;
  maxSequenceLengths[0] = -1;
}

void c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::deallocate()
{
  int32_T c2_idx;
  targetImpl->deallocate();
  for (c2_idx = 0; c2_idx < 8; c2_idx++) {
    layers[c2_idx]->deallocate();
  }
}

void c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::setSize(int32_T
  *c2_seqLengthPtr)
{
  int32_T c2_i;
  int32_T c2_idx;
  int32_T c2_originalMax;
  boolean_T c2_doReallocation;
  if (c2_seqLengthPtr[0] != inputTensors[0]->getSequenceLength()) {
    inputTensors[0]->setSequenceLength(c2_seqLengthPtr[0]);
    targetImpl->setProposedWorkSpaceSize(0);
    for (c2_idx = 0; c2_idx < 8; c2_idx++) {
      layers[c2_idx]->propagateSize();
    }

    c2_doReallocation = false;
    c2_originalMax = globalMaxSequenceLength;
    for (c2_i = 0; c2_i < 1; c2_i++) {
      if (c2_seqLengthPtr[c2_i] > maxSequenceLengths[c2_i]) {
        maxSequenceLengths[c2_i] = c2_seqLengthPtr[c2_i];
        c2_doReallocation = true;
      }

      if (maxSequenceLengths[c2_i] > globalMaxSequenceLength) {
        globalMaxSequenceLength = maxSequenceLengths[c2_i];
      }
    }

    if (c2_doReallocation) {
      if (c2_originalMax != -1) {
        deallocate();
      }

      allocate();
    }

    postsetup();
  }
}

void c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::resetState()
{
  (dynamic_cast<MWRNNLayer *>(layers[4]))->resetState();
}

void c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::updateState()
{
  (dynamic_cast<MWRNNLayer *>(layers[4]))->updateState();
}

void c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::setup
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  if (isInitialized) {
    resetState();
  } else {
    targetImpl->preSetup();
    targetImpl->setAutoTune(false);
    (static_cast<MWSequenceInputLayer *>(layers[0]))->createSequenceInputLayer
      (targetImpl, inputTensors[0], false, "CBT", 0);
    (static_cast<MWElementwiseAffineLayer *>(layers[1]))
      ->createElementwiseAffineLayer(targetImpl, layers[0]->getOutputTensor(0),
      1, 1, 3, 1, 1, 3, true, 0, 1,
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_sequenceinput_scale.bin",
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_sequenceinput_offset.bin",
      "CBT", 0);
    (static_cast<MWFCLayer *>(layers[2]))->createFCLayer(targetImpl, layers[1]
      ->getOutputTensor(0), 3, 200,
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_fc_1_w.bin",
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_fc_1_b.bin", "CBT", 1);
    (static_cast<MWReLULayer *>(layers[3]))->createReLULayer<real32_T, real32_T>
      (targetImpl, layers[2]->getOutputTensor(0), 0, "FLOAT", 1, "CBT", 1);
    (static_cast<MWRNNLayer *>(layers[4]))->createRNNLayer(targetImpl, layers[3
      ]->getOutputTensor(0), 200, 200, false, false, 0, 0, 0, "tanh", "sigmoid",
      2,
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_lstm_1_w_fused.bin",
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_lstm_1_b_fused.bin",
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_lstm_1_hx_fused.bin",
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_lstm_1_cx_fused.bin", "CBT",
      0);
    (static_cast<MWReLULayer *>(layers[5]))->createReLULayer<real32_T, real32_T>
      (targetImpl, layers[4]->getOutputTensor(0), 0, "FLOAT", 1, "CBT", 0);
    (static_cast<MWFCLayer *>(layers[6]))->createFCLayer(targetImpl, layers[5]
      ->getOutputTensor(0), 200, 2,
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_fc_2_w.bin",
      "C:\\Users\\Tsing\\Desktop\\QinghuaMa.github.io\\_drafts\\2022.12.29\\slprj\\_sfprj\\ex_sdl_flexible_shaft_lstm\\_self\\sfun\\src\\cnn_c2_flex"
      "ibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0_fc_2_b.bin", "CBT", 1);
    (static_cast<MWOutputLayer *>(layers[7]))->createOutputLayer(targetImpl,
      layers[6]->getOutputTensor(0), "CBT", 1);
    outputTensors[0] = layers[7]->getOutputTensor(0);
  }

  isInitialized = true;
}

void c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::predict()
{
  int32_T c2_idx;
  for (c2_idx = 0; c2_idx < 8; c2_idx++) {
    layers[c2_idx]->predict();
  }
}

void c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::cleanup()
{
  int32_T c2_idx;
  deallocate();
  for (c2_idx = 0; c2_idx < 8; c2_idx++) {
    layers[c2_idx]->cleanup();
  }

  if (targetImpl) {
    targetImpl->cleanup();
  }

  inputTensors[0]->setSequenceLength(-1);
  globalMaxSequenceLength = -1;
  maxSequenceLengths[0] = -1;
  isInitialized = false;
  c2_checkCleanupCudaError(cudaGetLastError(), __FILE__, __LINE__);
}

static void c2_checkCleanupCudaError(cudaError_t c2_errCode, const char_T
  *c2_file, uint32_T c2_line)
{
  emlrtRTEInfo c2_rtInfo;
  if ((c2_errCode != cudaSuccess) && (c2_errCode != cudaErrorCudartUnloading)) {
    c2_rtInfo = c2_createEmlrtInfoStruct(c2_file, c2_line);
    emlrtCUDAWarning((uint32_T)c2_errCode, (char_T *)cudaGetErrorName(c2_errCode),
                     (char_T *)cudaGetErrorString(c2_errCode), &c2_rtInfo);
  }
}

static emlrtRTEInfo c2_createEmlrtInfoStruct(const char_T *c2_file, uint32_T
  c2_line)
{
  emlrtRTEInfo c2_b_rtInfo;
  uint32_T c2_len;
  char_T *c2_brk;
  char_T *c2_fn;
  char_T *c2_pn;
  c2_len = (uint32_T)strlen(c2_file);
  c2_pn = (char_T *)calloc(c2_len + 1U, 1U);
  c2_fn = (char_T *)calloc(c2_len + 1U, 1U);
  memcpy(c2_pn, c2_file, c2_len);
  memcpy(c2_fn, c2_file, c2_len);
  c2_brk = strrchr(c2_fn, '.');
  *c2_brk = '\x00';
  c2_brk = NULL;
  c2_brk = strrchr(c2_fn, '/');
  if (c2_brk == NULL) {
    c2_brk = strrchr(c2_fn, '\\');
  }

  if (c2_brk == NULL) {
    c2_brk = c2_fn;
  } else {
    c2_brk++;
  }

  c2_b_rtInfo.lineNo = c2_line;
  c2_b_rtInfo.colNo = 0;
  c2_b_rtInfo.fName = c2_brk;
  c2_b_rtInfo.pName = c2_pn;
  return c2_b_rtInfo;
}

real32_T *c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::
  getLayerOutput(int32_T c2_layerIndex, int32_T c2_portIndex)
{
  return layers[c2_layerIndex]->getLayerOutput(c2_portIndex);
}

int32_T c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::
  getLayerOutputSize(int32_T c2_layerIndex, int32_T c2_portIndex)
{
  return layers[c2_layerIndex]->getOutputTensor(c2_portIndex)->getNumElements() *
    sizeof(real32_T);
}

real32_T *c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::
  getInputDataPointer(int32_T c2_index)
{
  return (static_cast<MWTensor<real32_T> *>(inputTensors[c2_index]))->getData();
}

real32_T *c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::
  getInputDataPointer()
{
  return (static_cast<MWTensor<real32_T> *>(inputTensors[0]))->getData();
}

real32_T *c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::
  getOutputDataPointer(int32_T c2_index)
{
  return (static_cast<MWTensor<real32_T> *>(outputTensors[c2_index]))->getData();
}

real32_T *c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::
  getOutputDataPointer()
{
  return (static_cast<MWTensor<real32_T> *>(outputTensors[0]))->getData();
}

int32_T c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::getBatchSize()
{
  return inputTensors[0]->getBatchSize();
}

c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0::
  ~c2_c2_flexibleShaftLoadNet0_ex_sdl_flexible_shaft_lstm0()
{
  int32_T c2_idx;
  if (isInitialized) {
    cleanup();
  }

  for (c2_idx = 0; c2_idx < 8; c2_idx++) {
    delete layers[c2_idx];
  }

  if (targetImpl) {
    delete targetImpl;
  }

  delete inputTensors[0];
}

static void init_dsm_address_info(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *
  chartInstance)
{
}

static void init_simulink_io_address
  (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance)
{
  chartInstance->c2_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c2_in_1 = (real_T (*)[3])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c2_out_1_predict = (real32_T (*)[2])
    ssGetOutputPortSignal_wrapper(chartInstance->S, 1);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c2_ex_sdl_flexible_shaft_lstm_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3342944126U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(76655546U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1238704172U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(575617463U);
}

mxArray *sf_c2_ex_sdl_flexible_shaft_lstm_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,1);
  mxSetCell(mxcell3p, 0, mxCreateString("dltargets.cudnn.cudnnApi"));
  return(mxcell3p);
}

mxArray *sf_c2_ex_sdl_flexible_shaft_lstm_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "hiddenFallbackType", "hiddenFallbackReason", "incompatibleSymbol" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 5, infoFields);
  mxArray *fallbackType = mxCreateString("pre");
  mxArray *fallbackReason = mxCreateString("GPUAcceleration");
  mxArray *hiddenFallbackType = mxCreateString("late");
  mxArray *hiddenFallbackReason = mxCreateString("ir_function_calls");
  mxArray *incompatibleSymbol = mxCreateString("#__setup__");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], hiddenFallbackType);
  mxSetField(mxInfo, 0, infoFields[3], hiddenFallbackReason);
  mxSetField(mxInfo, 0, infoFields[4], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c2_ex_sdl_flexible_shaft_lstm_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c2_ex_sdl_flexible_shaft_lstm(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiAWYGJgYAPSHEDMxAABrFA+I1SMES7OAhdXAOKSyoJUkHhxUbJnCpDOS8wF8xN"
    "LKzzz0vLB5lswIMxnw2I+I5L5nFBxCPhgT5l+EQeQfgck/SxY9PMi6ReA8vNLS+IN4wuKUlMyk0"
    "ug4QQLL/Ldo+BAmX6I/REE/KOO5h8QP7M4PjG5JLMsNT7ZKD61Ir44JSc+LSe1IjMpJzW+OCMxr"
    "SQ+p7gkF+5PADOcI58="
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_ex_sdl_flexible_shaft_lstm_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "skNRIPMlsTnEP7LcoWxCUTB";
}

static void sf_opaque_initialize_c2_ex_sdl_flexible_shaft_lstm(void
  *chartInstanceVar)
{
  initialize_params_c2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar);
  initialize_c2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c2_ex_sdl_flexible_shaft_lstm(void
  *chartInstanceVar)
{
  enable_c2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c2_ex_sdl_flexible_shaft_lstm(void
  *chartInstanceVar)
{
  disable_c2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c2_ex_sdl_flexible_shaft_lstm(void
  *chartInstanceVar)
{
  sf_gateway_c2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c2_ex_sdl_flexible_shaft_lstm
  (SimStruct* S)
{
  return get_sim_state_c2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c2_ex_sdl_flexible_shaft_lstm(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*)sf_get_chart_instance_ptr(S),
     st);
}

static void sf_opaque_cleanup_runtime_resources_c2_ex_sdl_flexible_shaft_lstm
  (void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_ex_sdl_flexible_shaft_lstm_optimization_info();
    }

    mdl_cleanup_runtime_resources_c2_ex_sdl_flexible_shaft_lstm
      ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar);
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar)->
      ~SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct();
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_mdl_start_c2_ex_sdl_flexible_shaft_lstm(void
  *chartInstanceVar)
{
  mdl_start_c2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_mdl_terminate_c2_ex_sdl_flexible_shaft_lstm(void
  *chartInstanceVar)
{
  mdl_terminate_c2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_ex_sdl_flexible_shaft_lstm
    ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_ex_sdl_flexible_shaft_lstm(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c2_ex_sdl_flexible_shaft_lstm
      ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*)sf_get_chart_instance_ptr
       (S));
    initSimStructsc2_ex_sdl_flexible_shaft_lstm
      ((SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct*)sf_get_chart_instance_ptr
       (S));
  }
}

const char* sf_c2_ex_sdl_flexible_shaft_lstm_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [60] = {
    "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",
    ""
  };

  static char newstr [4393] = "";
  newstr[0] = '\0';
  for (i = 0; i < 60; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c2_ex_sdl_flexible_shaft_lstm(SimStruct *S)
{
  const char* newstr = sf_c2_ex_sdl_flexible_shaft_lstm_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(1978984996U));
  ssSetChecksum1(S,(2567590540U));
  ssSetChecksum2(S,(2599845333U));
  ssSetChecksum3(S,(2462756014U));
}

static void mdlRTW_c2_ex_sdl_flexible_shaft_lstm(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlSetupRuntimeResources_c2_ex_sdl_flexible_shaft_lstm(SimStruct *S)
{
  SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *chartInstance;
  chartInstance = (SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct *)utMalloc
    (sizeof(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct));
  chartInstance = new (chartInstance)
    SFc2_ex_sdl_flexible_shaft_lstmInstanceStruct;
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0 &&
      !supportsLegacyBehaviorForPersistentVarInContinuousTime(S)) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.mdlStart =
    sf_opaque_mdl_start_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.mdlTerminate =
    sf_opaque_mdl_terminate_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.mdlCleanupRuntimeResources =
    sf_opaque_cleanup_runtime_resources_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c2_ex_sdl_flexible_shaft_lstm;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartEventFcn = NULL;
  chartInstance->chartInfo.chartStateSetterFcn = NULL;
  chartInstance->chartInfo.chartStateGetterFcn = NULL;
  chartInstance->S = S;
  chartInstance->chartInfo.dispatchToExportedFcn = NULL;
  sf_init_ChartRunTimeInfo(S, &(chartInstance->chartInfo), false, 0,
    chartInstance->c2_JITStateAnimation,
    chartInstance->c2_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_setup_runtime_resources_c2_ex_sdl_flexible_shaft_lstm(chartInstance);
}

void c2_ex_sdl_flexible_shaft_lstm_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_SETUP_RUNTIME_RESOURCES:
    mdlSetupRuntimeResources_c2_ex_sdl_flexible_shaft_lstm(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_ex_sdl_flexible_shaft_lstm(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_ex_sdl_flexible_shaft_lstm(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_ex_sdl_flexible_shaft_lstm_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
