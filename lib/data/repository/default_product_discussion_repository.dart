import '../../domain/entity/product/productdiscussion/product_discussion.dart';
import '../../domain/entity/product/productdiscussion/product_discussion_dialog.dart';
import '../../domain/entity/product/productdiscussion/product_discussion_dialog_paging_parameter.dart';
import '../../domain/entity/product/productdiscussion/product_discussion_paging_parameter.dart';
import '../../domain/repository/product_discussion_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/productdiscussiondatasource/product_discussion_data_source.dart';

class DefaultProductDiscussionRepository implements ProductDiscussionRepository {
  final ProductDiscussionDataSource productDiscussionDataSource;

  const DefaultProductDiscussionRepository({
    required this.productDiscussionDataSource
  });

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<ProductDiscussion>>> productDiscussionPaging(ProductDiscussionPagingParameter productDiscussionPagingParameter) {
    return productDiscussionDataSource.productDiscussionPaging(productDiscussionPagingParameter).mapToLoadDataResult<PagingDataResult<ProductDiscussion>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<ProductDiscussionDialog>>> productDiscussionDialogPaging(ProductDiscussionDialogPagingParameter productDiscussionDialogPagingParameter) {
    return productDiscussionDataSource.productDiscussionDialogPaging(productDiscussionDialogPagingParameter).mapToLoadDataResult<PagingDataResult<ProductDiscussionDialog>>();
  }
}