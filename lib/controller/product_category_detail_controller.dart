import '../domain/entity/product/productcategory/product_category_detail.dart';
import '../domain/entity/product/productcategory/product_category_detail_parameter.dart';
import '../domain/usecase/get_product_category_detail_use_case.dart';
import '../misc/load_data_result.dart';
import 'base_getx_controller.dart';

class ProductCategoryDetailController extends BaseGetxController {
  final GetProductCategoryDetailUseCase getProductCategoryDetailUseCase;

  ProductCategoryDetailController(super.controllerManager, this.getProductCategoryDetailUseCase);

  Future<LoadDataResult<ProductCategoryDetail>> getProductCategoryDetail(ProductCategoryDetailParameter productCategoryDetailParameter) {
    return getProductCategoryDetailUseCase.execute(productCategoryDetailParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("product-category-detail").value
    );
  }
}