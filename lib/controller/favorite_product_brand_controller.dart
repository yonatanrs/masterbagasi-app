import '../domain/entity/product/productbrand/favorite_product_brand_paging_parameter.dart';
import '../domain/entity/product/productbrand/product_brand.dart';
import '../domain/usecase/get_favorite_product_brand_use_case.dart';
import '../misc/controllercontentdelegate/product_brand_favorite_controller_content_delegate.dart';
import '../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../misc/load_data_result.dart';
import '../misc/paging/pagingresult/paging_data_result.dart';
import 'base_getx_controller.dart';

class FavoriteProductBrandController extends BaseGetxController {
  final GetFavoriteProductBrandPagingUseCase getFavoriteProductBrandPagingUseCase;
  final ProductBrandFavoriteControllerContentDelegate productBrandFavoriteControllerContentDelegate;

  FavoriteProductBrandController(
    super.controllerManager,
    this.getFavoriteProductBrandPagingUseCase,
    this.productBrandFavoriteControllerContentDelegate
  ) {
    productBrandFavoriteControllerContentDelegate.setApiRequestManager(() => apiRequestManager);
  }

  Future<LoadDataResult<PagingDataResult<ProductBrand>>> getFavoriteProductBrandPaging(FavoriteProductBrandPagingParameter favoriteProductBrandPagingParameter) {
    return getFavoriteProductBrandPagingUseCase.execute(favoriteProductBrandPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("favorite-product-brand-paging").value
    );
  }
}