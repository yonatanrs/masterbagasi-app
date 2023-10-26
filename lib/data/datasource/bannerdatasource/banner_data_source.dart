import '../../../domain/entity/banner/transparent_banner.dart';
import '../../../domain/entity/banner/transparent_banner_list_parameter.dart';
import '../../../domain/entity/banner/transparent_banner_with_type_list_parameter.dart';
import '../../../misc/processing/future_processing.dart';

abstract class BannerDataSource {
  FutureProcessing<List<TransparentBanner>> transparentBannerList(TransparentBannerListParameter transparentBannerListParameter);
  FutureProcessing<List<TransparentBanner>> transparentBannerWithTypeList(TransparentBannerWithTypeListParameter transparentBannerWithTypeListParameter);
}