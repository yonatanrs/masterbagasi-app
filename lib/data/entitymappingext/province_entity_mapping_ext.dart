import '../../domain/entity/province/province.dart';
import '../../domain/entity/province/province_map.dart';
import '../../domain/entity/province/province_map_metadata.dart';
import '../../misc/response_wrapper.dart';

extension ProvinceDetailMappingExt on ResponseWrapper {
  List<ProvinceMap> mapFromResponseToProvinceMapList() {
    return response.map<ProvinceMap>(
      (provinceMapResponse) => ResponseWrapper(provinceMapResponse).mapFromResponseToProvinceMap()
    ).toList();
  }
}

extension ProvinceDetailEntityMappingExt on ResponseWrapper {
  Province mapFromResponseToProvince() {
    return Province(
      id: response["id"],
      name: response["name"],
      description: response["description"],
      slug: response["slug"],
      icon: response["icon"],
      background: response["background"],
      bannerDesktop: response["banner_desktop"],
      bannerMobile: response["banner_mobile"],
    );
  }

  ProvinceMap mapFromResponseToProvinceMap() {
    Province province = ResponseWrapper(response).mapFromResponseToProvince();
    return ProvinceMap(
      id: province.id,
      name: province.name,
      description: province.description,
      slug: province.slug,
      icon: province.icon,
      background: province.background,
      bannerDesktop: province.bannerDesktop,
      bannerMobile: province.bannerMobile,
      provinceMapMetadata: ResponseWrapper(response["province_map"]).mapFromResponseToProvinceMapMetadata(),
    );
  }

  ProvinceMapMetadata mapFromResponseToProvinceMapMetadata() {
    List<dynamic> responseList = response as List<dynamic>;
    Map<String, dynamic> responseMap = responseList.first as Map<String, dynamic>;
    return ProvinceMapMetadata(
      id: responseMap["id"],
      provinceId: responseMap["province_id"],
      svg: responseMap["svg"]
    );
  }
}