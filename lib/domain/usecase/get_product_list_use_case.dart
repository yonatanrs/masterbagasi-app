import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/product.dart';
import '../entity/product/product_list_parameter.dart';
import '../repository/product_repository.dart';

class GetProductListUseCase {
  final ProductRepository productRepository;

  const GetProductListUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<List<Product>>> execute(ProductListParameter productListParameter) {
    return productRepository.productList(productListParameter);
  }
}