import 'package:dio/dio.dart';

import '../../../domain/dummy/userdummy/user_dummy.dart';
import '../../../domain/entity/product/productdiscussion/product_discussion.dart';
import '../../../domain/entity/product/productdiscussion/product_discussion_dialog.dart';
import '../../../domain/entity/product/productdiscussion/product_discussion_dialog_paging_parameter.dart';
import '../../../domain/entity/product/productdiscussion/product_discussion_paging_parameter.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/dummy_future_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'product_discussion_data_source.dart';

class DefaultProductDiscussionDataSource implements ProductDiscussionDataSource {
  final Dio dio;
  final UserDummy userDummy;

  const DefaultProductDiscussionDataSource({
    required this.dio,
    required this.userDummy
  });

  @override
  FutureProcessing<PagingDataResult<ProductDiscussion>> productDiscussionPaging(ProductDiscussionPagingParameter productDiscussionPagingParameter) {
    return DummyFutureProcessing((parameter) async {
      return PagingDataResult<ProductDiscussion>(
        page: 1,
        totalPage: 1,
        totalItem: 1,
        itemList: [
          ProductDiscussion(
            id: "1",
            title: "Product Discussion",
            imageUrl: "",
            discussionCount: 3,
            productDiscussionDialog: ProductDiscussionDialog(
              id: "1",
              discussion: "This is product discussion?",
              discussionDate: DateTime.now(),
              user: userDummy.generateDefaultDummy()
            )
          )
        ]
      );
    });
  }

  @override
  FutureProcessing<PagingDataResult<ProductDiscussionDialog>> productDiscussionDialogPaging(ProductDiscussionDialogPagingParameter productDiscussionDialogPagingParameter) {
    return DummyFutureProcessing((parameter) async {
      await Future.delayed(const Duration(seconds: 1));
      return PagingDataResult<ProductDiscussionDialog>(
        page: 1,
        totalPage: 1,
        totalItem: 1,
        itemList: [
          ProductDiscussionDialog(
            id: "1",
            discussion: "This is product discussion answer?",
            discussionDate: DateTime.now(),
            user: userDummy.generateDefaultDummy()
          )
        ]
      );
    });
  }
}