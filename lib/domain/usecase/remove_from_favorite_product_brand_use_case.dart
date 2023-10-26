import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productbrand/remove_from_favorite_product_brand_parameter.dart';
import '../entity/product/productbrand/remove_from_favorite_product_brand_response.dart';
import '../repository/product_repository.dart';

class RemoveFromFavoriteProductBrandUseCase {
  final ProductRepository productRepository;

  const RemoveFromFavoriteProductBrandUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<RemoveFromFavoriteProductBrandResponse>> execute(RemoveFromFavoriteProductBrandParameter removeFromFavoriteProductBrandParameter) {
    return productRepository.removeFromFavoriteProductBrand(removeFromFavoriteProductBrandParameter);
  }
}