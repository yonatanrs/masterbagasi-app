import '../../domain/entity/province/province_map.dart';
import '../../domain/entity/province/province_map_list_parameter.dart';
import '../../domain/repository/map_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/mapdatasource/map_data_source.dart';

class DefaultMapRepository implements MapRepository {
  final MapDataSource mapDataSource;

  const DefaultMapRepository({
    required this.mapDataSource
  });

  @override
  FutureProcessing<LoadDataResult<List<ProvinceMap>>> provinceMapList(ProvinceMapListParameter provinceMapParameter) {
    return mapDataSource.provinceMapList(provinceMapParameter).mapToLoadDataResult<List<ProvinceMap>>();
  }
}