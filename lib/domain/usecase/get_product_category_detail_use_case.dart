import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productcategory/product_category_detail.dart';
import '../entity/product/productcategory/product_category_detail_parameter.dart';
import '../repository/product_repository.dart';

class GetProductCategoryDetailUseCase {
  final ProductRepository productRepository;

  const GetProductCategoryDetailUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<ProductCategoryDetail>> execute(ProductCategoryDetailParameter productCategoryDetailParameter) {
    return productRepository.productCategoryDetail(productCategoryDetailParameter);
  }
}