import '../../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../itemtypelistsubinterceptor/additional_loading_indicator_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/address_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/builder_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/card_container_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/carousel_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/cart_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/chat_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/column_container_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/compound_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/country_delivery_review_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/country_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/coupon_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/decorated_container_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/delivery_cart_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/delivery_review_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/dynamic_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/expandable_description_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/faq_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/favorite_product_brand_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/notification_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/order_detail_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/order_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/padding_container_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/page_keyed_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/product_bundle_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/product_discussion_container_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/product_entry_header_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/profile_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/row_container_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/search_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/verticalgriditemtypelistsubinterceptor/vertical_grid_item_type_list_sub_interceptor.dart';
import '../../itemtypelistsubinterceptor/wishlist_item_type_list_sub_interceptor.dart';
import '../../typedef.dart';
import '../item_type_list_interceptor_parameter.dart';
import '../item_type_list_interceptor_result.dart';
import 'item_type_list_interceptor_checker.dart';

class ListItemControllerStateItemTypeInterceptorChecker extends ItemTypeListInterceptorChecker<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;

  late List<BaseItemTypeListSubInterceptor> _cachedItemTypeListSubInterceptorList;
  ItemTypeListInterceptorParameter? _cachedItemTypeListInterceptorParameter;

  ListItemControllerStateItemTypeInterceptorChecker({
    required this.padding,
    required this.itemSpacing
  }) : super();

  void interceptEachListItem(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList,
    {bool Function(ItemTypeListSubInterceptor)? interceptorChecking}
  ) {
    bool hasAllowIntercept(ItemTypeListSubInterceptor itemTypeListSubInterceptor) {
      if (interceptorChecking != null) {
        return interceptorChecking(itemTypeListSubInterceptor);
      }
      return true;
    }
    int j = 0;
    while (j < _cachedItemTypeListSubInterceptorList.length) {
      BaseItemTypeListSubInterceptor baseItemTypeListSubInterceptor = _cachedItemTypeListSubInterceptorList[j];
      if (baseItemTypeListSubInterceptor is ItemTypeListSubInterceptor) {
        if (hasAllowIntercept(baseItemTypeListSubInterceptor)) {
          if (baseItemTypeListSubInterceptor.intercept(i, oldItemTypeWrapper, oldItemTypeList, newItemTypeList)) {
            break;
          }
        }
      } else if (baseItemTypeListSubInterceptor is ParameterizedItemTypeListSubInterceptor) {
        if (_cachedItemTypeListInterceptorParameter != null) {
          if (baseItemTypeListSubInterceptor.interceptWithParameter(i, oldItemTypeWrapper, oldItemTypeList, newItemTypeList, _cachedItemTypeListInterceptorParameter!)) {
            break;
          }
        } else {
          throw Exception("Cached item type list interceptor parameter cannot be null");
        }
      }
      if (j == _cachedItemTypeListSubInterceptorList.length - 1) {
        newItemTypeList.add(oldItemTypeWrapper.listItemControllerState);
        break;
      }
      j++;
    }
  }

  @override
  ItemTypeListInterceptorResult<ListItemControllerState> intercept(
    List<ListItemControllerState> oldItemTypeList,
    ItemTypeListInterceptorParameter<ListItemControllerState> itemTypeListInterceptorParameter
  ) {
    int i = 0;
    _cachedItemTypeListInterceptorParameter = itemTypeListInterceptorParameter;

    i = 0;
    List<ListItemControllerState> interceptedItemTypeList = [];
    _initItemTypeListSubInterceptor(oldItemTypeList, interceptedItemTypeList);
    while (i < oldItemTypeList.length) {
      ListItemControllerStateWrapper oldItemTypeWrapper = ListItemControllerStateWrapper(oldItemTypeList[i]);
      interceptEachListItem(i, oldItemTypeWrapper, oldItemTypeList, interceptedItemTypeList);
      i++;
    }

    i = 0;
    List<ListItemControllerState> oldAdditionalItemTypeList = itemTypeListInterceptorParameter.additionalItemTypeList;
    List<ListItemControllerState> interceptedAdditionalItemTypeList = [];
    _initItemTypeListSubInterceptor(oldAdditionalItemTypeList, interceptedAdditionalItemTypeList);
    while (i < oldAdditionalItemTypeList.length) {
      ListItemControllerStateWrapper oldAdditionalItemTypeWrapper = ListItemControllerStateWrapper(oldAdditionalItemTypeList[i]);
      interceptEachListItem(i, oldAdditionalItemTypeWrapper, oldAdditionalItemTypeList, interceptedAdditionalItemTypeList);
      i++;
    }
    return ItemTypeListInterceptorResult<ListItemControllerState>(
      allInterceptedItemTypeList: interceptedItemTypeList + interceptedAdditionalItemTypeList,
      interceptedItemTypeList: interceptedItemTypeList,
      interceptedAdditionalItemTypeList: interceptedAdditionalItemTypeList,
    );
  }

  void _initItemTypeListSubInterceptor(List<ListItemControllerState> oldItemTypeList, List<ListItemControllerState> outputInterceptedItemTypeList) {
    int i = 0;
    _cachedItemTypeListSubInterceptorList = itemTypeListSubInterceptorList;
    while (i < _cachedItemTypeListSubInterceptorList.length) {
      _cachedItemTypeListSubInterceptorList[i].onInit(oldItemTypeList, outputInterceptedItemTypeList);
      i++;
    }
  }

  List<BaseItemTypeListSubInterceptor> get itemTypeListSubInterceptorList => [
    PageKeyedItemTypeListSubInterceptor(),
    VerticalGridItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    ExpandableDescriptionItemTypeListSubInterceptor(),
    AdditionalLoadingIndicatorItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    CarouselItemTypeListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    CompoundItemListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    DecoratedContainerItemTypeListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    CardContainerItemTypeListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    PaddingContainerItemTypeListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    ProfileItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    CartItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    OrderItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    NotificationItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    OrderDetailItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    DeliveryCartItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    ProductEntryHeaderItemTypeListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    ProductBundleItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing
    ),
    ProductDiscussionContainerItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    CouponItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    CountryItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    AddressItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    DeliveryReviewItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    CountryDeliveryReviewItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    FavoriteProductBrandItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    WishlistItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    SearchItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    FaqItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    ChatItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    PaddingContainerItemTypeListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    DynamicItemTypeListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    ColumnContainerItemTypeListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    RowContainerItemTypeListSubInterceptor(
      listItemControllerStateItemTypeInterceptorChecker: this
    ),
    BuilderItemTypeListSubInterceptor(
      padding: padding,
      itemSpacing: itemSpacing,
      listItemControllerStateItemTypeInterceptorChecker: this
    )
  ];
}