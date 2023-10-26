import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productbundle/product_bundle.dart';
import '../entity/product/productbundle/product_bundle_list_parameter.dart';
import '../repository/product_repository.dart';

class GetProductBundleListUseCase {
  final ProductRepository productRepository;

  const GetProductBundleListUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<List<ProductBundle>>> execute(ProductBundleListParameter productBundleListParameter) {
    return productRepository.productBundleList(productBundleListParameter);
  }
}