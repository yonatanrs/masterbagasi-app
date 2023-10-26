import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/province_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../../domain/entity/province/province_map.dart';
import '../../../domain/entity/province/province_map_detail_parameter.dart';
import '../../../domain/entity/province/province_map_list_parameter.dart';
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'map_data_source.dart';

class DefaultMapDataSource implements MapDataSource {
  final Dio dio;

  const DefaultMapDataSource({
    required this.dio
  });

  @override
  FutureProcessing<List<ProvinceMap>> provinceMapList(ProvinceMapListParameter provinceMapParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/province/explore/map", cancelToken: cancelToken)
        .map<List<ProvinceMap>>(onMap: (value) => value.wrapResponse().mapFromResponseToProvinceMapList());
    });
  }

  @override
  FutureProcessing<ProvinceMap> provinceMapDetail(ProvinceMapDetailParameter provinceMapDetailParameter) {
    return DioHttpClientProcessing((cancelToken) {
      late String lastPathEndpoint;
      if (provinceMapDetailParameter.provinceMapDetailParameterType == ProvinceMapDetailParameterType.slug) {
        lastPathEndpoint = "slug/${provinceMapDetailParameter.provinceMapId}";
      } else {
        lastPathEndpoint = provinceMapDetailParameter.provinceMapId;
      }
      return dio.get("/province/$lastPathEndpoint", cancelToken: cancelToken)
        .map<ProvinceMap>(onMap: (value) => value.wrapResponse().mapFromResponseToProvinceMap());
    });
  }
}