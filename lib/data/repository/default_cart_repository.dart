import '../../domain/entity/additionalitem/add_additional_item_parameter.dart';
import '../../domain/entity/additionalitem/add_additional_item_response.dart';
import '../../domain/entity/additionalitem/additional_item.dart';
import '../../domain/entity/additionalitem/additional_item_list_parameter.dart';
import '../../domain/entity/additionalitem/change_additional_item_parameter.dart';
import '../../domain/entity/additionalitem/change_additional_item_response.dart';
import '../../domain/entity/additionalitem/remove_additional_item_parameter.dart';
import '../../domain/entity/additionalitem/remove_additional_item_response.dart';
import '../../domain/entity/cart/add_host_cart_parameter.dart';
import '../../domain/entity/cart/add_host_cart_response.dart';
import '../../domain/entity/cart/add_to_cart_parameter.dart';
import '../../domain/entity/cart/add_to_cart_response.dart';
import '../../domain/entity/cart/cart.dart';
import '../../domain/entity/cart/cart_list_parameter.dart';
import '../../domain/entity/cart/cart_paging_parameter.dart';
import '../../domain/entity/cart/cart_summary.dart';
import '../../domain/entity/cart/cart_summary_parameter.dart';
import '../../domain/entity/cart/remove_from_cart_parameter.dart';
import '../../domain/entity/cart/remove_from_cart_response.dart';
import '../../domain/entity/cart/shared_cart_paging_parameter.dart';
import '../../domain/entity/cart/take_friend_cart_parameter.dart';
import '../../domain/entity/cart/take_friend_cart_response.dart';
import '../../domain/repository/cart_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/cartdatasource/cart_data_source.dart';

class DefaultCartRepository implements CartRepository {
  final CartDataSource cartDataSource;

  const DefaultCartRepository({
    required this.cartDataSource
  });

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<Cart>>> cartPaging(CartPagingParameter cartPagingParameter) {
    return cartDataSource.cartPaging(cartPagingParameter).mapToLoadDataResult<PagingDataResult<Cart>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<Cart>>> cartList(CartListParameter cartListParameter) {
    return cartDataSource.cartList(cartListParameter).mapToLoadDataResult<List<Cart>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<Cart>>> sharedCartPaging(SharedCartPagingParameter sharedCartPagingParameter) {
    return cartDataSource.sharedCartPaging(sharedCartPagingParameter).mapToLoadDataResult<PagingDataResult<Cart>>();
  }

  @override
  FutureProcessing<LoadDataResult<AddToCartResponse>> addToCart(AddToCartParameter addToCartParameter) {
    return cartDataSource.addToCart(addToCartParameter).mapToLoadDataResult<AddToCartResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<RemoveFromCartResponse>> removeFromCart(RemoveFromCartParameter removeFromCartParameter) {
    return cartDataSource.removeFromCart(removeFromCartParameter).mapToLoadDataResult<RemoveFromCartResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<AddHostCartResponse>> addHostCart(AddHostCartParameter addHostCartParameter) {
    return cartDataSource.addHostCart(addHostCartParameter).mapToLoadDataResult<AddHostCartResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<TakeFriendCartResponse>> takeFriendCart(TakeFriendCartParameter takeFriendCartParameter) {
    return cartDataSource.takeFriendCart(takeFriendCartParameter).mapToLoadDataResult<TakeFriendCartResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<CartSummary>> cartSummary(CartSummaryParameter cartSummaryParameter) {
    return cartDataSource.cartSummary(cartSummaryParameter).mapToLoadDataResult<CartSummary>();
  }

  @override
  FutureProcessing<LoadDataResult<List<AdditionalItem>>> additionalItemList(AdditionalItemListParameter additionalItemListParameter) {
    return cartDataSource.additionalItemList(additionalItemListParameter).mapToLoadDataResult<List<AdditionalItem>>();
  }

  @override
  FutureProcessing<LoadDataResult<AddAdditionalItemResponse>> addAdditionalItem(AddAdditionalItemParameter addAdditionalItemParameter) {
    return cartDataSource.addAdditionalItem(addAdditionalItemParameter).mapToLoadDataResult<AddAdditionalItemResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<ChangeAdditionalItemResponse>> changeAdditionalItem(ChangeAdditionalItemParameter changeAdditionalItemParameter) {
    return cartDataSource.changeAdditionalItem(changeAdditionalItemParameter).mapToLoadDataResult<ChangeAdditionalItemResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<RemoveAdditionalItemResponse>> removeAdditionalItem(RemoveAdditionalItemParameter removeAdditionalItemParameter) {
    return cartDataSource.removeAdditionalItem(removeAdditionalItemParameter).mapToLoadDataResult<RemoveAdditionalItemResponse>();
  }
}