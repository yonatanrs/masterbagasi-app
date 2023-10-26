import '../../../domain/entity/wishlist/remove_wishlist_parameter.dart';
import '../../../domain/entity/wishlist/remove_wishlist_response.dart';
import '../../../domain/entity/wishlist/wishlist.dart';
import '../../../domain/entity/wishlist/wishlist_paging_parameter.dart';
import '../../../domain/usecase/add_to_cart_use_case.dart';
import '../../../domain/usecase/get_wishlist_paging_use_case.dart';
import '../../../domain/usecase/remove_wishlist_use_case.dart';
import '../../../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../../../misc/getextended/get_extended.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/manager/controller_manager.dart';
import '../../../misc/on_observe_load_product_delegate.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../base_getx_controller.dart';

class WishlistMainMenuSubController extends BaseGetxController {
  final GetWishlistPagingUseCase getWishlistPagingUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveWishlistUseCase removeWishlistUseCase;
  final WishlistAndCartControllerContentDelegate wishlistAndCartControllerContentDelegate;

  WishlistMainMenuSubController(
    super.controllerManager,
    this.getWishlistPagingUseCase,
    this.addToCartUseCase,
    this.removeWishlistUseCase,
    this.wishlistAndCartControllerContentDelegate
  ) {
    wishlistAndCartControllerContentDelegate.setApiRequestManager(
      () => apiRequestManager
    );
  }

  Future<LoadDataResult<PagingDataResult<Wishlist>>> getWishlistPaging(WishlistPagingParameter wishlistPagingParameter) {
    return getWishlistPagingUseCase.execute(wishlistPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("wishlist").value
    );
  }

  Future<LoadDataResult<RemoveWishlistResponse>> removeWishlist(RemoveWishlistParameter removeWishlistParameter) {
    return removeWishlistUseCase.execute(removeWishlistParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("remove-wishlist").value
    );
  }
}

class WishlistMainMenuSubControllerInjectionFactory {
  final GetWishlistPagingUseCase getWishlistPagingUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveWishlistUseCase removeWishlistUseCase;
  final WishlistAndCartControllerContentDelegate wishlistAndCartControllerContentDelegate;

  WishlistMainMenuSubControllerInjectionFactory({
    required this.getWishlistPagingUseCase,
    required this.addToCartUseCase,
    required this.removeWishlistUseCase,
    required this.wishlistAndCartControllerContentDelegate
  });

  WishlistMainMenuSubController inject(ControllerManager controllerManager, String pageName) {
    return GetExtended.put<WishlistMainMenuSubController>(
      WishlistMainMenuSubController(
        controllerManager,
        getWishlistPagingUseCase,
        addToCartUseCase,
        removeWishlistUseCase,
        wishlistAndCartControllerContentDelegate
      ),
      tag: pageName
    );
  }
}

class WishlistMainMenuSubDelegate {
  OnObserveLoadProductDelegate onObserveLoadProductDelegate;

  WishlistMainMenuSubDelegate({
    required this.onObserveLoadProductDelegate
  });
}