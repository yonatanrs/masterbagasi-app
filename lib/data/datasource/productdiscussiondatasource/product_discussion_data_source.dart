import '../../../domain/entity/product/productdiscussion/product_discussion.dart';
import '../../../domain/entity/product/productdiscussion/product_discussion_dialog.dart';
import '../../../domain/entity/product/productdiscussion/product_discussion_dialog_paging_parameter.dart';
import '../../../domain/entity/product/productdiscussion/product_discussion_paging_parameter.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/future_processing.dart';

abstract class ProductDiscussionDataSource {
  FutureProcessing<PagingDataResult<ProductDiscussion>> productDiscussionPaging(ProductDiscussionPagingParameter productDiscussionPagingParameter);
  FutureProcessing<PagingDataResult<ProductDiscussionDialog>> productDiscussionDialogPaging(ProductDiscussionDialogPagingParameter productDiscussionDialogPagingParameter);
}