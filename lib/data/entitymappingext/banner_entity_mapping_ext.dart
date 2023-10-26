import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../domain/entity/banner/transparent_banner.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/response_wrapper.dart';

extension BannerEntityMappingExt on ResponseWrapper {
  List<TransparentBanner> mapFromResponseToTransparentBannerList() {
    return response.map<TransparentBanner>((bannerResponse) => ResponseWrapper(bannerResponse).mapFromResponseToTransparentBanner()).toList();
  }

  PagingDataResult<TransparentBanner> mapFromResponseToTransparentBannerPaging() {
    return ResponseWrapper(response).mapFromResponseToPagingDataResult(
      (dataResponse) => dataResponse.map<TransparentBanner>(
        (transparentResponse) => ResponseWrapper(transparentResponse).mapFromResponseToTransparentBanner()
      ).toList()
    );
  }
}

extension TransparentBannerDetailEntityMappingExt on ResponseWrapper {
  TransparentBanner mapFromResponseToTransparentBanner() {
    return TransparentBanner(
      id: response["id"],
      title: response["title"],
      type: response["type"],
      imageUrl: response["image_mobile"],
    );
  }
}