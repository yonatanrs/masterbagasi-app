import '../../../domain/entity/province/province_map.dart';
import '../../../domain/entity/province/province_map_detail_parameter.dart';
import '../../../domain/entity/province/province_map_list_parameter.dart';
import '../../../misc/processing/future_processing.dart';

abstract class MapDataSource {
  FutureProcessing<List<ProvinceMap>> provinceMapList(ProvinceMapListParameter provinceMapParameter);
  FutureProcessing<ProvinceMap> provinceMapDetail(ProvinceMapDetailParameter provinceMapDetailParameter);
}