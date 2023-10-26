import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/banner/transparent_banner.dart';
import '../entity/banner/transparent_banner_list_parameter.dart';
import '../entity/banner/transparent_banner_with_type_list_parameter.dart';

abstract class BannerRepository {
  FutureProcessing<LoadDataResult<List<TransparentBanner>>> transparentBannerList(TransparentBannerListParameter transparentBannerListParameter);
  FutureProcessing<LoadDataResult<List<TransparentBanner>>> transparentBannerWithTypeList(TransparentBannerWithTypeListParameter transparentBannerWithTypeListParameter);
}