import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productbundle/product_bundle_detail.dart';
import '../entity/product/productbundle/product_bundle_detail_parameter.dart';
import '../repository/product_repository.dart';

class GetProductBundleDetailUseCase {
  final ProductRepository productRepository;

  const GetProductBundleDetailUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<ProductBundleDetail>> execute(ProductBundleDetailParameter productBundleDetailParameter) {
    return productRepository.productBundleDetail(productBundleDetailParameter);
  }
}