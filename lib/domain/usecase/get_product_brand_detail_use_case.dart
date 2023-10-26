import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productbrand/product_brand_detail.dart';
import '../entity/product/productbrand/product_brand_detail_parameter.dart';
import '../repository/product_repository.dart';

class GetProductBrandDetailUseCase {
  final ProductRepository productRepository;

  const GetProductBrandDetailUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<ProductBrandDetail>> execute(ProductBrandDetailParameter productBrandDetailParameter) {
    return productRepository.productBrandDetail(productBrandDetailParameter);
  }
}