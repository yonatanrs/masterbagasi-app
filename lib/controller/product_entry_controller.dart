import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../domain/entity/componententity/dynamic_item_carousel_directly_component_entity.dart';
import '../domain/entity/componententity/i_component_entity.dart';
import '../domain/entity/product/product_with_condition_paging_parameter.dart';
import '../domain/entity/product/productentry/product_entry.dart';
import '../domain/entity/product/productentry/product_entry_header_content_parameter.dart';
import '../domain/entity/product/productentry/product_entry_header_content_response.dart';
import '../domain/entity/wishlist/add_wishlist_parameter.dart';
import '../domain/entity/wishlist/add_wishlist_response.dart';
import '../domain/entity/wishlist/support_wishlist.dart';
import '../domain/usecase/add_to_cart_use_case.dart';
import '../domain/usecase/add_wishlist_use_case.dart';
import '../domain/usecase/get_product_entry_header_content_use_case.dart';
import '../domain/usecase/get_product_entry_with_condition_paging_use_case.dart';
import '../domain/usecase/remove_wishlist_use_case.dart';
import '../misc/controllercontentdelegate/product_brand_favorite_controller_content_delegate.dart';
import '../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../misc/error/message_error.dart';
import '../misc/load_data_result.dart';
import '../misc/multi_language_string.dart';
import '../misc/on_observe_load_product_delegate.dart';
import '../misc/paging/pagingresult/paging_data_result.dart';
import '../misc/typedef.dart';
import 'base_getx_controller.dart';

class ProductEntryController extends BaseGetxController {
  final GetProductEntryWithConditionPagingUseCase getProductEntryWithConditionPagingUseCase;
  final GetProductEntryHeaderContentUseCase getProductEntryHeaderContentUseCase;
  final WishlistAndCartControllerContentDelegate wishlistAndCartControllerContentDelegate;
  final ProductBrandFavoriteControllerContentDelegate productBrandFavoriteControllerContentDelegate;
  ProductEntryDelegate? _productEntryDelegate;

  ProductEntryController(
    super.controllerManager,
    this.getProductEntryWithConditionPagingUseCase,
    this.getProductEntryHeaderContentUseCase,
    this.wishlistAndCartControllerContentDelegate,
    this.productBrandFavoriteControllerContentDelegate
  ) {
    wishlistAndCartControllerContentDelegate.setApiRequestManager(() => apiRequestManager);
    productBrandFavoriteControllerContentDelegate.setApiRequestManager(() => apiRequestManager);
  }

  IComponentEntity getProductEntryHeader(ProductEntryHeaderContentParameter productEntryHeaderContentParameter) {
    return DynamicItemCarouselDirectlyComponentEntity(
      title: MultiLanguageString(""),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<ProductEntryHeaderContentResponse>());
        LoadDataResult<ProductEntryHeaderContentResponse> productEntryHeaderContentResponseLoadDataResult = await getProductEntryHeaderContentUseCase.execute(
          productEntryHeaderContentParameter
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("product-entry-header").value
        );
        if (productEntryHeaderContentResponseLoadDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, productEntryHeaderContentResponseLoadDataResult);
      },
      observeDynamicItemActionStateDirectly: (title, description, itemLoadDataResult, errorProvider) {
        LoadDataResult<ProductEntryHeaderContentResponse> productEntryHeaderContentResponseLoadDataResult = itemLoadDataResult.castFromDynamic<ProductEntryHeaderContentResponse>();
        if (_productEntryDelegate != null) {
          return _productEntryDelegate!.onObserveLoadProductEntryHeaderContentDirectly(
            _OnObserveLoadProductEntryHeaderContentDirectlyParameter(
              productEntryHeaderContentResponseLoadDataResult: productEntryHeaderContentResponseLoadDataResult
            )
          );
        } else {
          throw MessageError(title: "Product Entry delegate must be not null");
        }
      },
    );
  }

  Future<LoadDataResult<PagingDataResult<ProductEntry>>> getProductEntryPaging(ProductWithConditionPagingParameter productWithConditionPagingParameter) {
    return getProductEntryWithConditionPagingUseCase.execute(productWithConditionPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("product-entry-paging").value
    );
  }

  void setProductEntryDelegate(ProductEntryDelegate productEntryDelegate) {
    _productEntryDelegate = productEntryDelegate;
  }
}

class ProductEntryDelegate {
  ListItemControllerState Function(_OnObserveLoadProductEntryHeaderContentDirectlyParameter) onObserveLoadProductEntryHeaderContentDirectly;

  ProductEntryDelegate({
    required this.onObserveLoadProductEntryHeaderContentDirectly,
  });
}

class _OnObserveLoadProductEntryHeaderContentDirectlyParameter {
  LoadDataResult<ProductEntryHeaderContentResponse> productEntryHeaderContentResponseLoadDataResult;

  _OnObserveLoadProductEntryHeaderContentDirectlyParameter({
    required this.productEntryHeaderContentResponseLoadDataResult
  });
}