import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productdiscussion/product_discussion.dart';
import '../entity/product/productdiscussion/product_discussion_dialog.dart';
import '../entity/product/productdiscussion/product_discussion_dialog_paging_parameter.dart';
import '../entity/product/productdiscussion/product_discussion_paging_parameter.dart';

abstract class ProductDiscussionRepository {
  FutureProcessing<LoadDataResult<PagingDataResult<ProductDiscussion>>> productDiscussionPaging(ProductDiscussionPagingParameter productDiscussionPagingParameter);
  FutureProcessing<LoadDataResult<PagingDataResult<ProductDiscussionDialog>>> productDiscussionDialogPaging(ProductDiscussionDialogPagingParameter productDiscussionDialogPagingParameter);
}