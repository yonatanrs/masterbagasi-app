import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productbundle/product_bundle.dart';
import '../entity/product/productbundle/product_bundle_highlight_parameter.dart';
import '../repository/product_repository.dart';

class GetProductBundleHighlightUseCase {
  final ProductRepository productRepository;

  const GetProductBundleHighlightUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<ProductBundle>> execute(ProductBundleHighlightParameter productBundleHighlightParameter) {
    return productRepository.productBundleHighlight(productBundleHighlightParameter);
  }
}