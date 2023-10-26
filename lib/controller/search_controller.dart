import '../domain/entity/product/product_with_condition_paging_parameter.dart';
import '../domain/entity/product/productentry/product_entry.dart';
import '../domain/usecase/get_product_entry_with_condition_paging_use_case.dart';
import '../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../misc/load_data_result.dart';
import '../misc/paging/pagingresult/paging_data_result.dart';
import 'base_getx_controller.dart';

class SearchController extends BaseGetxController {
  final GetProductEntryWithConditionPagingUseCase getProductEntryWithConditionPagingUseCase;
  final WishlistAndCartControllerContentDelegate wishlistAndCartControllerContentDelegate;

  SearchController(
    super.controllerManager,
    this.getProductEntryWithConditionPagingUseCase,
    this.wishlistAndCartControllerContentDelegate
  ) {
    wishlistAndCartControllerContentDelegate.setApiRequestManager(() => apiRequestManager);
  }

  Future<LoadDataResult<PagingDataResult<ProductEntry>>> getProductEntrySearch(ProductWithConditionPagingParameter productWithConditionPagingParameter) {
    return getProductEntryWithConditionPagingUseCase.execute(productWithConditionPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("product-search").value
    );
  }
}