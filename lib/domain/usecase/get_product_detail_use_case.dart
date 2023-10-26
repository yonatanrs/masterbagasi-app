import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/product.dart';
import '../entity/product/product_detail.dart';
import '../entity/product/product_detail_parameter.dart';
import '../repository/product_repository.dart';

class GetProductDetailUseCase {
  final ProductRepository productRepository;

  const GetProductDetailUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<ProductDetail>> execute(ProductDetailParameter productDetailParameter) {
    return productRepository.productDetail(productDetailParameter);
  }
}