import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productdiscussion/product_discussion.dart';
import '../entity/product/productdiscussion/product_discussion_paging_parameter.dart';
import '../repository/product_discussion_repository.dart';

class GetProductDiscussionPagingUseCase {
  final ProductDiscussionRepository productDiscussionRepository;

  const GetProductDiscussionPagingUseCase({
    required this.productDiscussionRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<ProductDiscussion>>> execute(ProductDiscussionPagingParameter productDiscussionPagingParameter) {
    return productDiscussionRepository.productDiscussionPaging(productDiscussionPagingParameter);
  }
}