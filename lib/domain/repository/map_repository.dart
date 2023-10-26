import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/province/province_map.dart';
import '../entity/province/province_map_list_parameter.dart';

abstract class MapRepository {
  FutureProcessing<LoadDataResult<List<ProvinceMap>>> provinceMapList(ProvinceMapListParameter provinceMapParameter);
}