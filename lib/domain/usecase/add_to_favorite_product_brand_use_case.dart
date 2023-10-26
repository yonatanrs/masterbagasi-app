import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productbrand/add_to_favorite_product_brand_parameter.dart';
import '../entity/product/productbrand/add_to_favorite_product_brand_response.dart';
import '../repository/product_repository.dart';

class AddToFavoriteProductBrandUseCase {
  final ProductRepository productRepository;

  const AddToFavoriteProductBrandUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<AddToFavoriteProductBrandResponse>> execute(AddToFavoriteProductBrandParameter addToFavoriteProductBrandParameter) {
    return productRepository.addToFavoriteProductBrand(addToFavoriteProductBrandParameter);
  }
}