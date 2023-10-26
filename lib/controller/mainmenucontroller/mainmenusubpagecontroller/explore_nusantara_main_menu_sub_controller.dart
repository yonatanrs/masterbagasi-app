import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/rx_ext.dart';

import '../../../domain/entity/province/province_map.dart';
import '../../../domain/entity/province/province_map_list_parameter.dart';
import '../../../domain/usecase/get_province_map_use_case.dart';
import '../../../misc/controllerstate/explore_nusantara_main_menu_controller_state.dart';
import '../../../misc/getextended/get_extended.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/manager/controller_manager.dart';
import '../../base_getx_controller.dart';

class ExploreNusantaraMainMenuSubController extends BaseGetxController {
  final GetProvinceMapUseCase getProvinceMapUseCase;

  bool _hasLoadingProvinceMap = false;
  final ExploreNusantaraMainMenuControllerState _exploreNusantaraMainMenuControllerState = ExploreNusantaraMainMenuControllerState(
    provinceMapListLoadDataResult: NoLoadDataResult<List<ProvinceMap>>(),
    selectedProvinceMap: null,
    selectedProvinceMapIndex: null
  );
  late Rx<ExploreNusantaraMainMenuControllerState> exploreNusantaraMainMenuControllerStateRx;

  ExploreNusantaraMainMenuSubController(
    super.controllerManager,
    this.getProvinceMapUseCase
  ) {
    exploreNusantaraMainMenuControllerStateRx = _exploreNusantaraMainMenuControllerState.obs;
  }

  void loadProvinceMap() async {
    if (_hasLoadingProvinceMap) {
      return;
    }
    _hasLoadingProvinceMap = true;
    _exploreNusantaraMainMenuControllerState.provinceMapListLoadDataResult = IsLoadingLoadDataResult<List<ProvinceMap>>();
    _updateExploreNusantaraState();
    _exploreNusantaraMainMenuControllerState.provinceMapListLoadDataResult = await getProvinceMapUseCase.execute(
      ProvinceMapListParameter()
    ).future(
      parameter: apiRequestManager.addRequestToCancellationPart("province-map").value
    );
    if (_exploreNusantaraMainMenuControllerState.provinceMapListLoadDataResult.isSuccess) {
      List<ProvinceMap> provinceMapList = _exploreNusantaraMainMenuControllerState.provinceMapListLoadDataResult.resultIfSuccess!;
      if (provinceMapList.isNotEmpty) {
        _exploreNusantaraMainMenuControllerState.selectedProvinceMap = provinceMapList.first;
        _exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex = 0;
      }
    }
    _updateExploreNusantaraState();
  }

  void selectProvinceMap(ProvinceMap selectedProvinceMap) {
    LoadDataResult<List<ProvinceMap>> provinceMapLoadDataResult = _exploreNusantaraMainMenuControllerState.provinceMapListLoadDataResult;
    if (provinceMapLoadDataResult.isSuccess) {
      List<ProvinceMap> provinceMapList = provinceMapLoadDataResult.resultIfSuccess!;
      if (provinceMapList.isNotEmpty) {
        int i = 0;
        while (i < provinceMapList.length) {
          ProvinceMap provinceMap = provinceMapList[i];
          if (selectedProvinceMap.id == provinceMap.id) {
            break;
          }
          i++;
        }
        _exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex = i;
      }
    }
    _exploreNusantaraMainMenuControllerState.selectedProvinceMap = selectedProvinceMap;
    _updateExploreNusantaraState();
  }

  void nextProvinceMap() {
    LoadDataResult<List<ProvinceMap>> provinceMapLoadDataResult = _exploreNusantaraMainMenuControllerState.provinceMapListLoadDataResult;
    if (provinceMapLoadDataResult.isSuccess) {
      List<ProvinceMap> provinceMapList = provinceMapLoadDataResult.resultIfSuccess!;
      if (provinceMapList.isNotEmpty) {
        if (_exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex != null) {
          int currentIndex = _exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex!;
          if (currentIndex < provinceMapList.length - 1) {
            currentIndex += 1;
            _exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex = currentIndex;
            _exploreNusantaraMainMenuControllerState.selectedProvinceMap = provinceMapList[_exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex!];
            _updateExploreNusantaraState();
          }
        } else {
          _exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex = 0;
          _exploreNusantaraMainMenuControllerState.selectedProvinceMap = provinceMapList[_exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex!];
          _updateExploreNusantaraState();
        }
      }
    }
  }

  void previousProvinceMap() {
    LoadDataResult<List<ProvinceMap>> provinceMapLoadDataResult = _exploreNusantaraMainMenuControllerState.provinceMapListLoadDataResult;
    if (provinceMapLoadDataResult.isSuccess) {
      List<ProvinceMap> provinceMapList = provinceMapLoadDataResult.resultIfSuccess!;
      if (provinceMapList.isNotEmpty) {
        if (_exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex != null) {
          int currentIndex = _exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex!;
          if (currentIndex > 0) {
            currentIndex -= 1;
            _exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex = currentIndex;
            _exploreNusantaraMainMenuControllerState.selectedProvinceMap = provinceMapList[_exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex!];
            _updateExploreNusantaraState();
          }
        } else {
          _exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex = 0;
          _exploreNusantaraMainMenuControllerState.selectedProvinceMap = provinceMapList[_exploreNusantaraMainMenuControllerState.selectedProvinceMapIndex!];
          _updateExploreNusantaraState();
        }
      }
    }
  }

  void _updateExploreNusantaraState() {
    exploreNusantaraMainMenuControllerStateRx.valueFromLast((value) {
      return _exploreNusantaraMainMenuControllerState.copy();
    });
    update();
  }
}

class ExploreNusantaraMainMenuSubControllerInjectionFactory {
  final GetProvinceMapUseCase getProvinceMapUseCase;

  ExploreNusantaraMainMenuSubControllerInjectionFactory({
    required this.getProvinceMapUseCase
  });

  ExploreNusantaraMainMenuSubController inject(ControllerManager controllerManager, String pageName) {
    return GetExtended.put<ExploreNusantaraMainMenuSubController>(
      ExploreNusantaraMainMenuSubController(
        controllerManager,
        getProvinceMapUseCase
      ),
      tag: pageName
    );
  }
}