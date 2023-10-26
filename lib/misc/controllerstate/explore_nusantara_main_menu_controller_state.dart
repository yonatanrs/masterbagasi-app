import '../../domain/entity/province/province_map.dart';
import '../load_data_result.dart';

class ExploreNusantaraMainMenuControllerState {
  LoadDataResult<List<ProvinceMap>> provinceMapListLoadDataResult;
  ProvinceMap? selectedProvinceMap;
  int? selectedProvinceMapIndex;

  ExploreNusantaraMainMenuControllerState({
    required this.provinceMapListLoadDataResult,
    required this.selectedProvinceMap,
    required this.selectedProvinceMapIndex
  });

  ExploreNusantaraMainMenuControllerState copy({
    LoadDataResult<List<ProvinceMap>>? provinceMapListLoadDataResult,
    ProvinceMap? selectedProvinceMap,
    int? selectedProvinceMapIndex
  }) {
    return ExploreNusantaraMainMenuControllerState(
      provinceMapListLoadDataResult: provinceMapListLoadDataResult ?? this.provinceMapListLoadDataResult,
      selectedProvinceMap: selectedProvinceMap ?? this.selectedProvinceMap,
      selectedProvinceMapIndex: selectedProvinceMapIndex ?? this.selectedProvinceMapIndex
    );
  }
}