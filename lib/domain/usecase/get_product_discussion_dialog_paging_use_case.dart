import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productdiscussion/product_discussion_dialog.dart';
import '../entity/product/productdiscussion/product_discussion_dialog_paging_parameter.dart';
import '../repository/product_discussion_repository.dart';

class GetProductDiscussionDialogPagingUseCase {
  final ProductDiscussionRepository productDiscussionRepository;

  const GetProductDiscussionDialogPagingUseCase({
    required this.productDiscussionRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<ProductDiscussionDialog>>> execute(ProductDiscussionDialogPagingParameter productDiscussionDialogPagingParameter) {
    return productDiscussionRepository.productDiscussionDialogPaging(productDiscussionDialogPagingParameter);
  }
}