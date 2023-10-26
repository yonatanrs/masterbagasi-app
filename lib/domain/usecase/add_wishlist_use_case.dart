import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/wishlist/add_wishlist_parameter.dart';
import '../entity/wishlist/add_wishlist_response.dart';
import '../repository/product_repository.dart';

class AddWishlistUseCase {
  final ProductRepository productRepository;

  const AddWishlistUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<AddWishlistResponse>> execute(AddWishlistParameter addWishlistParameter) {
    return productRepository.addWishlist(addWishlistParameter);
  }
}