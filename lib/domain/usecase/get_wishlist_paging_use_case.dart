import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/wishlist/wishlist.dart';
import '../entity/wishlist/wishlist_paging_parameter.dart';
import '../repository/product_repository.dart';

class GetWishlistPagingUseCase {
  final ProductRepository productRepository;

  const GetWishlistPagingUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<Wishlist>>> execute(WishlistPagingParameter wishlistPagingParameter) {
    return productRepository.wishlistPaging(wishlistPagingParameter);
  }
}