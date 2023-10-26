import '../domain/entity/product/productbundle/product_bundle.dart';
import '../domain/entity/product/productbundle/product_bundle_paging_parameter.dart';
import '../domain/usecase/get_product_bundle_paging_use_case.dart';
import '../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../misc/load_data_result.dart';
import '../misc/paging/pagingresult/paging_data_result.dart';
import 'base_getx_controller.dart';

class ProductBundleController extends BaseGetxController {
  final GetProductBundlePagingUseCase getProductBundlePagingUseCase;
  final WishlistAndCartControllerContentDelegate wishlistAndCartControllerContentDelegate;

  ProductBundleController(
    super.controllerManager,
    this.getProductBundlePagingUseCase,
    this.wishlistAndCartControllerContentDelegate
  ) {
    wishlistAndCartControllerContentDelegate.setApiRequestManager(
      () => apiRequestManager
    );
  }

  Future<LoadDataResult<PagingDataResult<ProductBundle>>> getProductBundlePaging(ProductBundlePagingParameter productBundlePagingParameter) {
    return getProductBundlePagingUseCase.execute(productBundlePagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("product-bundle").value
    );
  }
}