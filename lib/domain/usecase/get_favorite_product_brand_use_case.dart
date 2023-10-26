import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productbrand/favorite_product_brand_paging_parameter.dart';
import '../entity/product/productbrand/product_brand.dart';
import '../entity/product/productbrand/product_brand_paging_parameter.dart';
import '../repository/product_repository.dart';

class GetFavoriteProductBrandPagingUseCase {
  final ProductRepository productRepository;

  const GetFavoriteProductBrandPagingUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<ProductBrand>>> execute(FavoriteProductBrandPagingParameter favoriteProductBrandPagingParameter) {
    return productRepository.favoriteProductBrandPaging(favoriteProductBrandPagingParameter);
  }
}