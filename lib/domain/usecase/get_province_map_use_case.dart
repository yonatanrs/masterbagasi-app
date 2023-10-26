import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/province/province_map.dart';
import '../entity/province/province_map_list_parameter.dart';
import '../repository/map_repository.dart';

class GetProvinceMapUseCase {
  final MapRepository mapRepository;

  const GetProvinceMapUseCase({
    required this.mapRepository
  });

  FutureProcessing<LoadDataResult<List<ProvinceMap>>> execute(ProvinceMapListParameter provinceMapListParameter) {
    return mapRepository.provinceMapList(provinceMapListParameter);
  }
}