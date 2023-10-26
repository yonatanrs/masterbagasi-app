import '../../misc/load_data_result.dart';
import '../../misc/processing/dummy_future_processing.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/product_detail_other_interested_product_brand_list_parameter.dart';
import '../entity/product/productbrand/product_brand.dart';
import '../repository/product_repository.dart';

class GetProductDetailOtherInterestedProductBrandListUseCase {
  final ProductRepository productRepository;

  const GetProductDetailOtherInterestedProductBrandListUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<List<ProductBrand>>> execute(ProductDetailOtherInterestedProductBrandListParameter productDetailOtherInterestedProductBrandListParameter) {
    return productRepository.productDetailOtherInterestedProductBrandListParameter(productDetailOtherInterestedProductBrandListParameter);
  }
}