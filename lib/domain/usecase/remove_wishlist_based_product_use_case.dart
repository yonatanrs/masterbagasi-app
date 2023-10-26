import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/wishlist/remove_wishlist_based_product_parameter.dart';
import '../entity/wishlist/remove_wishlist_response.dart';
import '../repository/product_repository.dart';

class RemoveWishlistBasedProductUseCase {
  final ProductRepository productRepository;

  const RemoveWishlistBasedProductUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<RemoveWishlistResponse>> execute(RemoveWishlistBasedProductParameter removeWishlistBasedProductParameter) {
    return productRepository.removeWishlistBasedProduct(removeWishlistBasedProductParameter);
  }
}