import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/cargo_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../domain/entity/cargo/cargo.dart';
import '../../../domain/entity/cargo/cargo_list_parameter.dart';
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'cargo_data_source.dart';

class DefaultCargoDataSource implements CargoDataSource {
  final Dio dio;

  const DefaultCargoDataSource({
    required this.dio
  });

  @override
  FutureProcessing<List<Cargo>> cargoList(CargoListParameter cargoListParameter) {
    String endpoint = "/cargo";
    if (cargoListParameter.zoneId.isNotEmptyString) {
      endpoint = "$endpoint/zone/${cargoListParameter.zoneId}";
    }
    return DioHttpClientProcessing((cancelToken) {
      return dio.get(endpoint, cancelToken: cancelToken)
        .map<List<Cargo>>(onMap: (value) => value.wrapResponse().mapFromResponseToCargoList());
    });
  }
}