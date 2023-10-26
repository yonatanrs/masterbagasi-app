import '../domain/entity/product/productbrand/add_to_favorite_product_brand_parameter.dart';
import '../domain/entity/product/productbrand/add_to_favorite_product_brand_response.dart';
import '../domain/entity/product/productbrand/product_brand_detail.dart';
import '../domain/entity/product/productbrand/product_brand_detail_parameter.dart';
import '../domain/entity/product/productbrand/remove_from_favorite_product_brand_parameter.dart';
import '../domain/entity/product/productbrand/remove_from_favorite_product_brand_response.dart';
import '../domain/usecase/add_to_favorite_product_brand_use_case.dart';
import '../domain/usecase/get_product_brand_detail_use_case.dart';
import '../domain/usecase/remove_from_favorite_product_brand_use_case.dart';
import '../misc/load_data_result.dart';
import 'base_getx_controller.dart';

class ProductBrandDetailController extends BaseGetxController {
  final GetProductBrandDetailUseCase getProductBrandDetailUseCase;
  final AddToFavoriteProductBrandUseCase addToFavoriteProductBrandUseCase;
  final RemoveFromFavoriteProductBrandUseCase removeFromFavoriteProductBrandUseCase;

  ProductBrandDetailController(
    super.controllerManager,
    this.getProductBrandDetailUseCase,
    this.addToFavoriteProductBrandUseCase,
    this.removeFromFavoriteProductBrandUseCase
  );

  Future<LoadDataResult<ProductBrandDetail>> getProductBrandDetail(ProductBrandDetailParameter productBrandDetailParameter) {
    return getProductBrandDetailUseCase.execute(productBrandDetailParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("product-brand-detail").value
    );
  }

  Future<LoadDataResult<AddToFavoriteProductBrandResponse>> addToFavoriteProductBrand(AddToFavoriteProductBrandParameter addToFavoriteProductBrandParameter) {
    return addToFavoriteProductBrandUseCase.execute(addToFavoriteProductBrandParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("add-to-favorite-product-brand").value
    );
  }

  Future<LoadDataResult<RemoveFromFavoriteProductBrandResponse>> removeFromFavoriteProductBrand(RemoveFromFavoriteProductBrandParameter removeFromFavoriteProductBrandParameter) {
    return removeFromFavoriteProductBrandUseCase.execute(removeFromFavoriteProductBrandParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("remove-from-favorite-product-brand").value
    );
  }
}