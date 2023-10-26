import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/wishlist/remove_wishlist_parameter.dart';
import '../entity/wishlist/remove_wishlist_response.dart';
import '../repository/product_repository.dart';

class RemoveWishlistUseCase {
  final ProductRepository productRepository;

  const RemoveWishlistUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<RemoveWishlistResponse>> execute(RemoveWishlistParameter removeWishlistParameter) {
    return productRepository.removeWishlist(removeWishlistParameter);
  }
}