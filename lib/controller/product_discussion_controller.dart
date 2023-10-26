import '../domain/entity/product/productdiscussion/product_discussion.dart';
import '../domain/entity/product/productdiscussion/product_discussion_dialog.dart';
import '../domain/entity/product/productdiscussion/product_discussion_dialog_paging_parameter.dart';
import '../domain/entity/product/productdiscussion/product_discussion_paging_parameter.dart';
import '../domain/usecase/get_product_discussion_dialog_paging_use_case.dart';
import '../domain/usecase/get_product_discussion_paging_use_case.dart';
import '../misc/load_data_result.dart';
import '../misc/paging/pagingresult/paging_data_result.dart';
import 'base_getx_controller.dart';

class ProductDiscussionController extends BaseGetxController {
  final GetProductDiscussionPagingUseCase getProductDiscussionPagingUseCase;
  final GetProductDiscussionDialogPagingUseCase getProductDiscussionDialogPagingUseCase;

  ProductDiscussionController(
    super.controllerManager,
    this.getProductDiscussionPagingUseCase,
    this.getProductDiscussionDialogPagingUseCase
  );

  Future<LoadDataResult<PagingDataResult<ProductDiscussion>>> getProductDiscussionPaging(ProductDiscussionPagingParameter productDetailPagingParameter) {
    return getProductDiscussionPagingUseCase.execute(productDetailPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("product-discussion").value
    );
  }

  Future<LoadDataResult<PagingDataResult<ProductDiscussionDialog>>> getProductDiscussionDialogPaging(ProductDiscussionDialogPagingParameter productDiscussionDialogPagingParameter) {
    return getProductDiscussionDialogPagingUseCase.execute(productDiscussionDialogPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("product-discussion-dialog").value
    );
  }
}