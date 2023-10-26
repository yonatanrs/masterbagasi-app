import '../../domain/entity/banner/transparent_banner.dart';
import '../../domain/entity/banner/transparent_banner_list_parameter.dart';
import '../../domain/entity/banner/transparent_banner_with_type_list_parameter.dart';
import '../../domain/repository/banner_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/bannerdatasource/banner_data_source.dart';

class DefaultBannerRepository implements BannerRepository {
  final BannerDataSource bannerDataSource;

  const DefaultBannerRepository({
    required this.bannerDataSource
  });

  @override
  FutureProcessing<LoadDataResult<List<TransparentBanner>>> transparentBannerList(TransparentBannerListParameter transparentBannerListParameter) {
    return bannerDataSource.transparentBannerList(transparentBannerListParameter).mapToLoadDataResult<List<TransparentBanner>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<TransparentBanner>>> transparentBannerWithTypeList(TransparentBannerWithTypeListParameter transparentBannerWithTypeListParameter) {
    return bannerDataSource.transparentBannerWithTypeList(transparentBannerWithTypeListParameter).mapToLoadDataResult<List<TransparentBanner>>();
  }
}