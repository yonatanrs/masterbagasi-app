import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/banner_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../../domain/entity/banner/transparent_banner.dart';
import '../../../domain/entity/banner/transparent_banner_list_parameter.dart';
import '../../../domain/entity/banner/transparent_banner_with_type_list_parameter.dart';
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'banner_data_source.dart';

class DefaultBannerDataSource implements BannerDataSource {
  final Dio dio;

  const DefaultBannerDataSource({
    required this.dio,
  });

  @override
  FutureProcessing<List<TransparentBanner>> transparentBannerList(TransparentBannerListParameter transparentBannerListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/banner", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToTransparentBannerList());
    });
  }

  @override
  FutureProcessing<List<TransparentBanner>> transparentBannerWithTypeList(TransparentBannerWithTypeListParameter transparentBannerWithTypeListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/banner/${transparentBannerWithTypeListParameter.type}", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToTransparentBannerList());
    });
  }
}