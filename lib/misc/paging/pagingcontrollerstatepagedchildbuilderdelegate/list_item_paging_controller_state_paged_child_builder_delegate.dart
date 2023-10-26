import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart' hide Notification, Banner;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:masterbagasi/misc/ext/error_provider_ext.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/entity/address/address.dart';
import '../../../domain/entity/product/productentry/product_entry.dart';
import '../../../presentation/page/modaldialogpage/select_address_modal_dialog_page.dart';
import '../../../presentation/widget/additional_item_summary_widget.dart';
import '../../../presentation/widget/additional_item_widget.dart';
import '../../../presentation/widget/address/horizontal_address_item.dart';
import '../../../presentation/widget/address/vertical_address_item.dart';
import '../../../presentation/widget/carousel_list_item.dart';
import '../../../presentation/widget/cart/cart_header.dart';
import '../../../presentation/widget/cart/horizontal_cart_item.dart';
import '../../../presentation/widget/cart/shortcart/horizontal_short_cart_item.dart';
import '../../../presentation/widget/cart/shortcart/vertical_short_cart_item.dart';
import '../../../presentation/widget/cart/vertical_cart_item.dart';
import '../../../presentation/widget/chat/chat_bubble.dart';
import '../../../presentation/widget/colorful_chip_tab_bar.dart';
import '../../../presentation/widget/country/vertical_country_item.dart';
import '../../../presentation/widget/countrydeliveryreview/country_delivery_review_header_item.dart';
import '../../../presentation/widget/countrydeliveryreview/country_delivery_review_item.dart';
import '../../../presentation/widget/countrydeliveryreview/country_delivery_review_media_detail_item.dart';
import '../../../presentation/widget/countrydeliveryreview/country_delivery_review_media_short_content_item.dart';
import '../../../presentation/widget/countrydeliveryreview/country_delivery_review_select_country_item.dart';
import '../../../presentation/widget/coupon/horizontal_coupon_item.dart';
import '../../../presentation/widget/coupon/vertical_coupon_item.dart';
import '../../../presentation/widget/default_video_carousel_list_item.dart';
import '../../../presentation/widget/deliveryreview/deliveryreviewdetail/check_your_contribution_delivery_review_detail_item.dart';
import '../../../presentation/widget/deliveryreview/deliveryreviewdetail/horizontal_delivery_review_detail_item.dart';
import '../../../presentation/widget/deliveryreview/deliveryreviewdetail/vertical_delivery_review_detail_item.dart';
import '../../../presentation/widget/deliveryreview/horizontal_delivery_review_item.dart';
import '../../../presentation/widget/deliveryreview/vertical_delivery_review_item.dart';
import '../../../presentation/widget/faq/faq_detail_item.dart';
import '../../../presentation/widget/faq/faq_item.dart';
import '../../../presentation/widget/host_cart_indicator.dart';
import '../../../presentation/widget/icon_title_and_description_list_item.dart';
import '../../../presentation/widget/menu_profile_header.dart';
import '../../../presentation/widget/modified_carousel_slider.dart';
import '../../../presentation/widget/modified_shimmer.dart';
import '../../../presentation/widget/modifiedassetimage/modified_asset_image.dart';
import '../../../presentation/widget/modifiedcachednetworkimage/modified_cached_network_image.dart';
import '../../../presentation/widget/modified_colorful_divider.dart';
import '../../../presentation/widget/modified_divider.dart';
import '../../../presentation/widget/modified_svg_picture.dart';
import '../../../presentation/widget/modified_tab_bar.dart';
import '../../../presentation/widget/modifiedcachednetworkimage/product_modified_cached_network_image.dart';
import '../../../presentation/widget/news/horizontal_news_item.dart';
import '../../../presentation/widget/news/vertical_news_item.dart';
import '../../../presentation/widget/order/is_running_order_item.dart';
import '../../../presentation/widget/order/vertical_order_item.dart';
import '../../../presentation/widget/order/waiting_for_payment_order_item.dart';
import '../../../presentation/widget/product/horizontal_product_item.dart';
import '../../../presentation/widget/product/vertical_product_item.dart';
import '../../../presentation/widget/product_bundle_header_list_item.dart';
import '../../../presentation/widget/product_bundle_highlight_list_item.dart';
import '../../../presentation/widget/product_category_header_list_item.dart';
import '../../../presentation/widget/product_detail_brand_list_item.dart';
import '../../../presentation/widget/product_detail_short_header.dart';
import '../../../presentation/widget/product_entry_header.dart';
import '../../../presentation/widget/productbrand/circleproductbrand/horizontal_circle_product_brand_item.dart';
import '../../../presentation/widget/productbrand/circleproductbrand/vertical_circle_product_brand_item.dart';
import '../../../presentation/widget/productbrand/horizontal_product_brand_item.dart';
import '../../../presentation/widget/productbrand/vertical_product_brand_item.dart';
import '../../../presentation/widget/productbundle/horizontal_product_bundle_item.dart';
import '../../../presentation/widget/productbundle/support_vertical_grid_vertical_product_bundle_item.dart';
import '../../../presentation/widget/productbundle/vertical_product_bundle_item.dart';
import '../../../presentation/widget/productcategory/circleproductcategory/horizontal_circle_product_category_item.dart';
import '../../../presentation/widget/productcategory/circleproductcategory/vertical_circle_product_category_item.dart';
import '../../../presentation/widget/productcategory/horizontal_product_category_item.dart';
import '../../../presentation/widget/productcategory/vertical_product_category_item.dart';
import '../../../presentation/widget/productdiscussion/productdiscussiondialog/vertical_product_discussion_dialog_item.dart';
import '../../../presentation/widget/productdiscussion/vertical_product_discussion_item.dart';
import '../../../presentation/widget/prompt_indicator.dart';
import '../../../presentation/widget/province_map_header_list_item.dart';
import '../../../presentation/widget/shimmer_carousel_item.dart';
import '../../../presentation/widget/address/shipping_address_indicator.dart';
import '../../../presentation/widget/short_video_carousel_list_item.dart';
import '../../../presentation/widget/tap_area.dart';
import '../../../presentation/widget/titleanddescriptionitem/title_and_description_item.dart';
import '../../../presentation/widget/titledescriptionandcontentitem/title_description_and_content_item.dart';
import '../../../presentation/widget/product_detail_header.dart';
import '../../carouselbackground/asset_carousel_background.dart';
import '../../carouselbackground/carousel_background.dart';
import '../../constant.dart';
import '../../controllerstate/listitemcontrollerstate/additionalitemlistitemcontrollerstate/additional_item_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/additionalitemlistitemcontrollerstate/additional_item_summary_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/addresslistitemcontrollerstate/address_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/addresslistitemcontrollerstate/horizontal_address_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/addresslistitemcontrollerstate/vertical_address_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/card_container_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/carousel_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/cart_header_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/cart_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/horizontal_cart_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/shortcartlistitemcontrollerstate/horizontal_short_cart_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/shortcartlistitemcontrollerstate/short_cart_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/shortcartlistitemcontrollerstate/vertical_short_cart_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/vertical_cart_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/chatlistitemcontrollerstate/chat_bubble_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/colorful_chip_tab_bar_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/colorful_divider_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/column_container_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_header_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_media_detail_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_media_short_content_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_select_country_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/couponlistitemcontrollerstate/coupon_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/couponlistitemcontrollerstate/horizontal_coupon_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/couponlistitemcontrollerstate/vertical_coupon_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/decorated_container_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/delivery_to_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/delivery_review_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/base_delivery_review_detail_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/check_your_contribution_delivery_review_detail_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/delivery_review_detail_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/horizontal_delivery_review_detail_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/vertical_delivery_review_detail_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/horizontal_delivery_review_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/vertical_delivery_review_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/divider_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/dynamic_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/empty_container_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/failed_prompt_indicator_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/faqlistitemcontrollerstate/faq_detail_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/faqlistitemcontrollerstate/faq_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/fill_remaining_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/host_cart_indicator_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/icon_title_and_description_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/loading_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/menu_profile_header_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/multi_banner_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/newslistitemcontrollerstate/horizontal_news_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/newslistitemcontrollerstate/news_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/newslistitemcontrollerstate/vertical_news_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/non_expanded_item_in_row_child_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/non_expanded_item_in_row_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/orderlistitemcontrollerstate/base_order_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/orderlistitemcontrollerstate/is_running_order_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/orderlistitemcontrollerstate/vertical_order_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/orderlistitemcontrollerstate/waiting_for_payment_order_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/page_keyed_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/product_bundle_header_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/product_bundle_highlight_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/product_category_header_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/product_detail_brand_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/product_detail_header_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/product_detail_image_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/product_detail_short_header_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/product_entry_header_background_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/circleproductbrandlistitemcontrollerstate/circle_product_brand_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/circleproductbrandlistitemcontrollerstate/horizontal_circle_product_brand_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/circleproductbrandlistitemcontrollerstate/vertical_circle_product_brand_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/horizontal_product_brand_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/product_brand_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/vertical_product_brand_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/horizontal_product_bundle_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/product_bundle_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/vertical_product_bundle_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productcategorylistitemcontrollerstate/circleproductcategorylistitemcontrollerstate/circle_product_category_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productcategorylistitemcontrollerstate/circleproductcategorylistitemcontrollerstate/horizontal_circle_product_category_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productcategorylistitemcontrollerstate/circleproductcategorylistitemcontrollerstate/vertical_circle_product_category_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productcategorylistitemcontrollerstate/horizontal_product_category_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productcategorylistitemcontrollerstate/product_category_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productcategorylistitemcontrollerstate/vertical_product_category_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/product_discussion_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/productdiscussiondialoglistitemcontrollerstate/product_discussion_dialog_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/productdiscussiondialoglistitemcontrollerstate/vertical_product_discussion_dialog_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/vertical_product_discussion_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productlistitemcontrollerstate/horizontal_product_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productlistitemcontrollerstate/product_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/productlistitemcontrollerstate/vertical_product_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/province_map_header_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/row_container_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/selectcountrieslistitemcontrollerstate/country_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/selectcountrieslistitemcontrollerstate/vertical_country_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/shipping_address_indicator_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/videocarousellistitemcontrollerstate/default_video_carousel_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/videocarousellistitemcontrollerstate/short_video_carousel_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/single_banner_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/spacing_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/tab_bar_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/title_and_description_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/title_description_and_content_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/widget_substitution_list_item_controller_state.dart';
import '../../controllerstate/paging_controller_state.dart';
import '../../dialog_helper.dart';
import '../../errorprovider/error_provider.dart';
import '../../injector.dart';
import '../../listitempagingparameterinjection/list_item_paging_parameter_injection.dart';
import '../../load_data_result.dart';
import '../../page_restoration_helper.dart';
import '../../product_helper.dart';
import '../../productentryheaderbackground/product_entry_header_background.dart';
import '../../typedef.dart';
import '../../widget_helper.dart';
import 'paging_controller_state_paged_child_builder_delegate.dart';

class ListItemPagingControllerStatePagedChildBuilderDelegate<PageKeyType> extends PagingControllerStatePagedChildBuilderDelegate<PageKeyType, ListItemControllerState> {
  final List<ListItemPagingParameterInjection> listItemPagingParameterInjectionList;

  ListItemPagingControllerStatePagedChildBuilderDelegate({
    required PagingControllerState<PageKeyType, ListItemControllerState> pagingControllerState,
    WidgetBuilderWithError? firstPageErrorIndicatorBuilderWithErrorParameter,
    WidgetBuilderWithError? newPageErrorIndicatorBuilderWithErrorParameter,
    WidgetBuilder? firstPageProgressIndicatorBuilder,
    WidgetBuilder? newPageProgressIndicatorBuilder,
    WidgetBuilder? noItemsFoundIndicatorBuilder,
    WidgetBuilder? noMoreItemsIndicatorBuilder,
    bool animateTransitions = false,
    final Duration transitionDuration = const Duration(milliseconds: 250),
    this.listItemPagingParameterInjectionList = const []
  }) : super(
    pagingControllerState: pagingControllerState,
    itemBuilder: (context, item, index) => Container(),
    firstPageErrorIndicatorBuilderWithErrorParameter: firstPageErrorIndicatorBuilderWithErrorParameter ?? (context, e) => WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(
      context: context,
      errorProvider: Injector.locator<ErrorProvider>(),
      e: e
    ),
    newPageErrorIndicatorBuilderWithErrorParameter: firstPageErrorIndicatorBuilderWithErrorParameter ?? (context, e) => WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(
      context: context,
      errorProvider: Injector.locator<ErrorProvider>(),
      e: e,
      promptIndicatorType: PromptIndicatorType.horizontal,
      onPressed: () => pagingControllerState.pagingController.retryLastFailedRequest(),
      buttonText: "Retry".tr
    ),
    firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder,
    newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder,
    noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
    noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder,
  );

  @override
  ItemWidgetBuilder<ListItemControllerState> get itemBuilder => _itemBuilder;

  Widget _itemBuilder<ListItemControllerState>(BuildContext context, ListItemControllerState item, int index) {
    if (item is FailedPromptIndicatorListItemControllerState) {
      return WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(context: context, errorProvider: item.errorProvider, e: item.e);
    } else if (item is CarouselListItemControllerState || item is ShimmerCarouselListItemControllerState) {
      if (item is CarouselListItemControllerState) {
        Widget? backgroundImage;
        double? backgroundImageHeight;
        CarouselBackground? carouselBackground = item.carouselBackground;
        if (carouselBackground is AssetCarouselBackground) {
          backgroundImage = Image.asset(carouselBackground.assetImageName);
          backgroundImageHeight = carouselBackground.imageBackgroundHeight;
        }
        return CarouselListItem(
          padding: item.padding,
          itemList: item.itemListItemControllerState,
          title: item.title,
          titleInterceptor: item.titleInterceptor,
          description: item.description,
          descriptionInterceptor: item.descriptionInterceptor,
          builderWithItem: (context, listItemControllerState) => _itemBuilder(context, listItemControllerState, index),
          backgroundImage: backgroundImage,
          backgroundImageHeight: backgroundImageHeight
        );
      } else if (item is ShimmerCarouselListItemControllerState) {
        return ShimmerCarouselListItem(
          builderWithItem: (context, listItemControllerState) => _itemBuilder(context, listItemControllerState, index),
          padding: item.padding,
          showTitleShimmer: item.showTitleShimmer,
          showDescriptionShimmer: item.showDescriptionShimmer,
          showItemShimmer: item.showItemShimmer,
          shimmerCarouselListItemGenerator: item.shimmerCarouselListItemGenerator,
        );
      } else {
        return Container();
      }
    } else if (item is DefaultVideoCarouselListItemControllerState) {
      return DefaultVideoCarouselListItem(
        defaultVideoListLoadDataResult: item.defaultVideoListLoadDataResult,
      );
    } else if (item is ShortVideoCarouselListItemControllerState) {
      return ShortVideoCarouselListItem(
        shortVideoListLoadDataResult: item.shortVideoListLoadDataResult,
      );
    } else if (item is ProductListItemControllerState) {
      if (item is HorizontalProductListItemControllerState) {
        return HorizontalProductItem(
          productAppearanceData: item.productAppearanceData,
          onAddWishlist: item.onAddWishlist,
          onRemoveWishlist: item.onRemoveWishlist,
          onAddCart: item.onAddCart,
          onRemoveCart: item.onRemoveCart,
        );
      } else if (item is VerticalProductListItemControllerState) {
        if (item is ShimmerVerticalProductListItemControllerState) {
          return ShimmerVerticalProductItem(
            productAppearanceData: item.productAppearanceData,
          );
        } else {
          return VerticalProductItem(
            productAppearanceData: item.productAppearanceData,
            onAddWishlist: item.onAddWishlist,
            onRemoveWishlist: item.onRemoveWishlist,
            onAddCart: item.onAddCart,
            onRemoveCart: item.onRemoveCart,
          );
        }
      } else {
        return Container();
      }
    } else if (item is ProductCategoryListItemControllerState) {
      if (item is HorizontalProductCategoryListItemControllerState) {
        return HorizontalProductCategoryItem(productCategory: item.productCategory);
      } else if (item is VerticalProductCategoryListItemControllerState) {
        if (item is ShimmerVerticalProductCategoryListItemControllerState) {
          return ShimmerVerticalProductCategoryItem(productCategory: item.productCategory);
        } else {
          return VerticalProductCategoryItem(productCategory: item.productCategory);
        }
      } else {
        return Container();
      }
    } else if (item is CircleProductCategoryListItemControllerState) {
      if (item is HorizontalCircleProductCategoryListItemControllerState) {
        return HorizontalCircleProductCategoryItem(productCategory: item.productCategory);
      } else if (item is VerticalCircleProductCategoryListItemControllerState) {
        if (item is ShimmerVerticalCircleProductCategoryListItemControllerState) {
          return ShimmerVerticalCircleProductCategoryItem(productCategory: item.productCategory);
        } else {
          return VerticalCircleProductCategoryItem(productCategory: item.productCategory);
        }
      } else {
        return Container();
      }
    } else if (item is ProductBrandListItemControllerState) {
      if (item is HorizontalProductBrandListItemControllerState) {
        return HorizontalProductBrandItem(productBrand: item.productBrand);
      } else if (item is VerticalProductBrandListItemControllerState) {
        if (item is ShimmerVerticalProductBrandListItemControllerState) {
          return ShimmerVerticalProductBrandItem(productBrand: item.productBrand);
        } else {
          return VerticalProductBrandItem(productBrand: item.productBrand);
        }
      } else {
        return Container();
      }
    } else if (item is CircleProductBrandListItemControllerState) {
      if (item is HorizontalCircleProductBrandListItemControllerState) {
        return HorizontalCircleProductBrandItem(productBrand: item.productBrand);
      } else if (item is VerticalCircleProductBrandListItemControllerState) {
        if (item is ShimmerVerticalCircleProductBrandListItemControllerState) {
          return ShimmerVerticalCircleProductBrandItem(productBrand: item.productBrand);
        } else {
          return VerticalCircleProductBrandItem(productBrand: item.productBrand);
        }
      } else {
        return Container();
      }
    } else if (item is ProductBundleListItemControllerState) {
      if (item is HorizontalProductBundleListItemControllerState) {
        return HorizontalProductBundleItem(
          productBundle: item.productBundle,
          onAddWishlist: item.onAddWishlist,
          onRemoveWishlist: item.onRemoveWishlist,
          onAddCart: item.onAddCart,
          onRemoveCart: item.onRemoveCart,
        );
      } else if (item is VerticalProductBundleListItemControllerState) {
        if (item is ShimmerVerticalProductBundleListItemControllerState) {
          return ShimmerVerticalProductBundleItem(productBundle: item.productBundle);
        } else {
          return VerticalProductBundleItem(
            productBundle: item.productBundle,
            onAddWishlist: item.onAddWishlist,
            onRemoveWishlist: item.onRemoveWishlist,
            onAddCart: item.onAddCart,
            onRemoveCart: item.onRemoveCart,
          );
        }
      } else if (item is SupportVerticalGridVerticalProductBundleListItemControllerState) {
        return SupportVerticalGridVerticalProductBundleItem(
          productBundle: item.productBundle,
          onAddWishlist: item.onAddWishlist,
          onRemoveWishlist: item.onRemoveWishlist,
          onAddCart: item.onAddCart,
          onRemoveCart: item.onRemoveCart,
        );
      } else {
        return Container();
      }
    } else if (item is ProductBundleHeaderListItemControllerState) {
      return ProductBundleHeaderListItem(productBundle: item.productBundle);
    } else if (item is ProductEntryHeaderListItemControllerState) {
      return ProductEntryHeader(
        title: item.title,
        onProductEntryTitleTap: item.onProductEntryTitleTap,
        productEntryHeaderBackground: item.productEntryHeaderBackground
      );
    } else if (item is ProductEntryHeaderLoadDataResultListItemControllerState) {
      return ProductEntryHeaderLoadDataResult(
        errorProvider: item.errorProvider,
        productEntryHeaderContentResponseLoadDataResult: item.productEntryHeaderContentResponseLoadDataResult,
      );
    } else if (item is DeliveryReviewListItemControllerState) {
      if (item is HorizontalDeliveryReviewListItemControllerState) {
        return HorizontalDeliveryReviewItem(
          deliveryReview: item.deliveryReview
        );
      } else if (item is VerticalDeliveryReviewListItemControllerState) {
        if (item is ShimmerVerticalDeliveryReviewListItemControllerState) {
          return ShimmerVerticalDeliveryReviewItem(
            deliveryReview: item.deliveryReview
          );
        } else {
          return VerticalDeliveryReviewItem(
            deliveryReview: item.deliveryReview
          );
        }
      } else {
        return Container();
      }
    } else if (item is NewsListItemControllerState) {
      if (item is HorizontalNewsListItemControllerState) {
        return HorizontalNewsItem(
          news: item.news
        );
      } else if (item is VerticalNewsListItemControllerState) {
        if (item is ShimmerVerticalNewsListItemControllerState) {
          return ShimmerVerticalNewsItem(
            news: item.news
          );
        } else {
          return VerticalNewsItem(
            news: item.news,
          );
        }
      } else {
        return Container();
      }
    } else if (item is LoadingListItemControllerState) {
      return const Center(child: CircularProgressIndicator());
    } else if (item is DynamicListItemControllerState) {
      if (item.listItemControllerState is DynamicListItemControllerState) {
        throw FlutterError("You cannot set DynamicListItemControllerState type in DynamicListItemControllerState's listItemControllerState parameter, because it will causing stack overflow.");
      }
      return item.listItemControllerState != null ? _itemBuilder(context, item.listItemControllerState!, index) : Container();
    } else if (item is RowContainerListItemControllerState) {
      List<Widget> result = [];
      for (var listItemControllerState in item.rowChildListItemControllerState) {
        if (listItemControllerState is RowContainerListItemControllerState) {
          throw FlutterError("You cannot set RowContainerListItemControllerState type in RowContainerListItemControllerState's listItemControllerState parameter, because it will causing stack overflow.");
        }
        Widget rowChild = _itemBuilder(context, listItemControllerState, index);
        if (listItemControllerState is NonExpandedItemInRowControllerState) {
          if (listItemControllerState is NonExpandedItemInRowChildControllerState) {
            result.add(_itemBuilder(context, listItemControllerState.childListItemControllerState, index));
          } else {
            result.add(rowChild);
          }
        } else {
          result.add(Expanded(child: rowChild));
        }
      }
      Widget row = Row(children: result);
      return item.padding != null ? Padding(padding: item.padding!, child: row) : row;
    } else if (item is ColumnContainerListItemControllerState) {
      List<Widget> result = [];
      for (var listItemControllerState in item.columnChildListItemControllerState) {
        if (listItemControllerState is ColumnContainerListItemControllerState) {
          throw FlutterError("You cannot set ColumnContainerListItemControllerState type in ColumnContainerListItemControllerState's listItemControllerState parameter, because it will causing stack overflow.");
        }
        Widget columnChild = _itemBuilder(context, listItemControllerState, index);
        result.add(columnChild);
      }
      Widget column = Column(crossAxisAlignment: CrossAxisAlignment.start, children: result);
      return item.padding != null ? Padding(padding: item.padding!, child: column) : column;
    } else if (item is EmptyContainerListItemControllerState) {
      return Container();
    } else if (item is VirtualSpacingListItemControllerState) {
      return SizedBox(width: item.width, height: item.height ?? Constant.heightSpacingListItem);
    } else if (item is SpacingListItemControllerState) {
      return Container(color: item.color ?? Constant.colorSpacingListItem, width: item.width, height: item.height ?? Constant.heightSpacingListItem);
    } else if (item is DividerListItemControllerState) {
      return ModifiedDivider(
        lineColor: item.lineColor,
        lineHeight: item.lineHeight,
        borderRadius: item.borderRadius
      );
    } else if (item is ColorfulDividerListItemControllerState) {
      return ModifiedColorfulDivider(
        lineColorList: item.lineColorList,
        lineHeight: item.lineHeight,
        borderRadius: item.borderRadius
      );
    } else if (item is TitleAndDescriptionListItemControllerState) {
      if (item is ShimmerTitleAndDescriptionListItemControllerState) {
        return ShimmerTitleAndDescriptionItem(
          title: item.title,
          description: item.description,
          padding: item.padding,
          verticalSpace: item.verticalSpace,
        );
      } else {
        return TitleAndDescriptionItem(
          title: item.title,
          description: item.description,
          padding: item.padding,
          verticalSpace: item.verticalSpace,
          titleAndDescriptionItemInterceptor: item.titleAndDescriptionItemInterceptor,
        );
      }
    } else if (item is TitleDescriptionAndContentListItemControllerState) {
      if (item.content is TitleDescriptionAndContentListItemControllerState) {
        throw FlutterError("You cannot set TitleDescriptionAndContentListItemControllerState type in TitleDescriptionAndContentListItemControllerState's content parameter, because it will causing stack overflow.");
      }
      return TitleDescriptionAndContentItem(
        title: item.title,
        description: item.description,
        builder: (context) => item.content != null ? _itemBuilder(context, item.content!, index) : Container(),
        verticalSpace: item.verticalSpace,
      );
    } else if (item is PageKeyedListItemControllerState) {
      if (item.listItemControllerState is PageKeyedListItemControllerState) {
        throw FlutterError("You cannot set PageKeyedListItemControllerState type in PageKeyedListItemControllerState's listItemControllerState parameter, because it will causing stack overflow.");
      }
      return item.listItemControllerState != null ? _itemBuilder(context, item.listItemControllerState!, index) : Container();
    } else if (item is ColorfulChipTabBarListItemControllerState) {
      return ColorfulChipTabBar(
        colorfulChipTabBarDataList: item.colorfulChipTabBarDataList,
        colorfulChipTabBarController: item.colorfulChipTabBarController,
        isWrap: item.isWrap
      );
    } else if (item is ShimmerColorfulChipTabBarListItemControllerState) {
      return const ShimmerColorfulChipTabBar();
    } else if (item is TabBarListItemControllerState) {
      return ModifiedTabBar(
        tabs: item.tabDataList.map<Tab>((tabData) => Tab(
          height: tabData.height,
          text: tabData.text,
          icon: tabData.icon != null ? tabData.icon!(context) : null,
          iconMargin: tabData.iconMargin,
          child: tabData.child != null ? tabData.child!(context) : null,
        )).toList(),
        controller: item.tabController
      );
    } else if (item is BaseProductDetailHeaderListItemControllerState) {
      if (item is ProductDetailHeaderListItemControllerState) {
        return ProductDetailHeader(
          product: item.product,
        );
      } else if (item is ShimmerProductDetailHeaderListItemControllerState){
        return const ShimmerProductDetailHeader();
      } else {
        return Container();
      }
    } else if (item is ProductDetailShortHeaderListItemControllerState) {
      return ProductDetailShortHeader(
        productDetail: item.productDetail,
        onGetProductEntryIndex: item.onGetProductEntryIndex,
        onAddWishlist: item.onAddWishlist,
        onRemoveWishlist: item.onRemoveWishlist
      );
    } else if (item is WidgetSubstitutionListItemControllerState) {
      return item.widgetSubstitution(context, index);
    } else if (item is IconTitleAndDescriptionListItemControllerState) {
      return IconTitleAndDescriptionListItem(
        title: item.title,
        description: item.description,
        titleAndDescriptionItemInterceptor: item.titleAndDescriptionItemInterceptor,
        icon: item.iconListItemControllerState != null ? _itemBuilder(context, item.iconListItemControllerState, index) : null,
        space: item.space,
        verticalSpace: item.verticalSpace,
      );
    } else if (item is PaddingContainerListItemControllerState) {
      return Padding(
        padding: item.padding,
        child: _itemBuilder(context, item.paddingChildListItemControllerState, index)
      );
    } else if (item is DecoratedContainerListItemControllerState) {
      return Container(
        padding: item.padding,
        decoration: item.decoration,
        child: _itemBuilder(context, item.decoratedChildListItemControllerState, index)
      );
    } else if (item is CardContainerListItemControllerState) {
      return Padding(
        // Use padding widget for avoiding shadow elevation overlap.
        padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
        child: Material(
          color: Colors.white,
          borderRadius: item.borderRadius,
          elevation: 3,
          child: ClipRRect(
            borderRadius: item.borderRadius,
            child: _itemBuilder(context, item.cardContainerChildListItemControllerState, index)
          )
        )
      );
    } else if (item is SingleBannerListItemControllerState) {
      return AspectRatio(
        aspectRatio: item.aspectRatioValue.toDouble(),
        child: ClipRect(
          child: ModifiedCachedNetworkImage(
            imageUrl: item.banner.imageUrl.toEmptyStringNonNull,
          )
        )
      );
    } else if (item is MultiBannerListItemControllerState) {
      return ModifiedCarouselSlider.builder(
        itemCount: item.bannerList.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Column(
          children: [
            AspectRatio(
              aspectRatio: item.aspectRatioValue.toDouble(),
              child: ClipRect(
                child: ProductModifiedCachedNetworkImage(
                  imageUrl: item.bannerList[itemIndex].imageUrl,
                ),
              )
            ),
          ]
        ),
        options: CarouselOptions(
          aspectRatio: item.aspectRatioValue.toDouble(),
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          enableInfiniteScroll: false,
          autoPlay: true,
          viewportFraction: 1.0,
        ),
        carouselController: CarouselController(),
        modifiedCarouselSliderTopStackWidgetBuilder: (context, pageController) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: Constant.bannerIndicatorAreaHeight,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: item.bannerList.length,
                        effect: ScrollingDotsEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                          dotColor: Colors.white.withOpacity(0.5),
                          activeDotColor: Colors.white
                        ),
                      ),
                    )
                  ),
                ]
              )
            ),
          );
        }
      );
    } else if (item is DeliveryToListItemControllerState) {
      LoadDataResult<Address> addressLoadDataResult = item.addressLoadDataResult;
      Widget getDeliveryToWidget(LoadDataResult<Address> addressLoadDataResultParameter) {
        List<InlineSpan> inlineSpanList = [];
        if (addressLoadDataResultParameter.isLoading) {
          inlineSpanList = [
            TextSpan(text: "${"Delivered to".tr} ", style: const TextStyle(color: Colors.white))
          ];
        } else if (addressLoadDataResultParameter.isSuccess) {
          Address address = addressLoadDataResultParameter.resultIfSuccess!;
          inlineSpanList = [
            TextSpan(text: "${"Delivered to".tr} ", style: const TextStyle(color: Colors.white)),
            TextSpan(text: address.country.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ];
        } else if (addressLoadDataResultParameter.isFailed) {
          ErrorProviderResult errorProviderResult = item.errorProvider.onGetErrorProviderResult(addressLoadDataResultParameter.resultIfFailed).toErrorProviderResultNonNull();
          inlineSpanList = [
            TextSpan(text: errorProviderResult.message, style: const TextStyle(color: Colors.white)),
          ];
        }
        return TapArea(
          onTap: () async {
            await DialogHelper.showModalBottomDialogPage<bool, String>(
              context: context,
              modalDialogPageBuilder: (context, parameter) => SelectAddressModalDialogPage(
                onAddressSelectedChanged: item.onAddressSelectedChanged,
              )
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Constant.colorDarkBlue,
            child: Row(
              children: [
                ModifiedSvgPicture.asset(Constant.vectorLocation, color: Colors.white),
                const SizedBox(width: 10),
                Text.rich(
                  TextSpan(
                    children: inlineSpanList
                  )
                )
              ],
            ),
          ),
        );
      }
      if (addressLoadDataResult.isLoading) {
        return IgnorePointer(
          child: ModifiedShimmer.fromColors(
            child: getDeliveryToWidget(addressLoadDataResult)
          ),
        );
      } else {
        return getDeliveryToWidget(addressLoadDataResult);
      }
    } else if (item is ProductDetailImageListItemControllerState) {
      List<ProductEntry> productEntryList = item.productEntryList;
      int productEntryIndex = item.onGetProductEntryIndex();
      String imageUrl = "";
      List<String> imageUrlList = [];
      ProductEntry? selectedProductEntry = ProductHelper.getSelectedProductEntry(
        productEntryList, productEntryIndex
      );
      if (selectedProductEntry != null) {
        imageUrlList = selectedProductEntry.imageUrlList;
        imageUrl = imageUrlList.isNotEmpty ? imageUrlList.first : "";
      }
      if (imageUrlList.isEmpty) {
        return AspectRatio(
          aspectRatio: Constant.aspectRatioValueProductImage.toDouble(),
          child: ClipRRect(
            child: ProductModifiedCachedNetworkImage(
              imageUrl: imageUrl,
            )
          )
        );
      } else {
        return ModifiedCarouselSlider.builder(
          itemCount: imageUrlList.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Column(
            children: [
              AspectRatio(
                aspectRatio: Constant.aspectRatioValueProductImage.toDouble(),
                child: ClipRect(
                  child: ProductModifiedCachedNetworkImage(
                    imageUrl: imageUrlList[itemIndex],
                  ),
                )
              ),
            ]
          ),
          options: CarouselOptions(
            aspectRatio: Constant.aspectRatioValueProductImage.toDouble(),
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            enableInfiniteScroll: false,
            autoPlay: true,
            viewportFraction: 1.0,
          ),
          carouselController: CarouselController(),
          modifiedCarouselSliderTopStackWidgetBuilder: (context, pageController) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: Constant.bannerIndicatorAreaHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: imageUrlList.length,
                          effect: ScrollingDotsEffect(
                            dotWidth: 8,
                            dotHeight: 8,
                            dotColor: Colors.white.withOpacity(0.5),
                            activeDotColor: Colors.white
                          ),
                        ),
                      )
                    ),
                  ]
                )
              ),
            );
          }
        );
      }
    } else if (item is ProductDetailBrandListItemControllerState) {
      return ProductDetailBrandListItem(
        productBrand: item.productBrand,
        onTapProductBrand: item.onTapProductBrand,
        onAddToFavoriteProductBrand: item.onAddToFavoriteProductBrand,
        onRemoveFromFavoriteProductBrand: item.onRemoveFromFavoriteProductBrand,
      );
    } else if (item is ProductCategoryHeaderListItemControllerState) {
      return ProductCategoryHeaderListItem(
        productCategory: item.productCategory,
      );
    } else if (item is ProductBundleHeaderListItemControllerState) {
      return ProductBundleHeaderListItem(
        productBundle: item.productBundle,
      );
    } else if (item is ProvinceMapHeaderListItemControllerState) {
      return ProvinceMapHeaderListItem(
        provinceMap: item.provinceMap,
      );
    } else if (item is ProductBundleHighlightListItemControllerState) {
      return ProductBundleHighlightListItem(
        productBundle: item.productBundle,
        onAddWishlist: item.onAddWishlist,
        onRemoveWishlist: item.onRemoveWishlist,
        onAddCart: item.onAddCart,
        onRemoveCart: item.onRemoveCart,
      );
    } else if (item is CouponListItemControllerState) {
      if (item is HorizontalCouponListItemControllerState) {
        return HorizontalCouponItem(
          coupon: item.coupon,
          onSelectCoupon: item.onSelectCoupon,
          isSelected: item.isSelected,
        );
      } else if (item is VerticalCouponListItemControllerState) {
        if (item is ShimmerVerticalCouponListItemControllerState) {
          return ShimmerVerticalCouponItem(
            coupon: item.coupon,
          );
        } else {
          return VerticalCouponItem(
            coupon: item.coupon,
            onSelectCoupon: item.onSelectCoupon,
            isSelected: item.isSelected
          );
        }
      } else {
        return Container();
      }
    } else if (item is MenuProfileHeaderListItemControllerState) {
      return MenuProfileHeader(
        userLoadDataResult: item.userLoadDataResult,
        errorProvider: item.errorProvider,
      );
    } else if (item is ShortCartListItemControllerState) {
      if (item is HorizontalShortCartListItemControllerState) {
        return HorizontalShortCartItem(
          cart: item.cart,
          onSelectCart: item.onSelectCart,
        );
      } else if (item is VerticalShortCartListItemControllerState) {
        if (item is ShimmerVerticalShortCartListItemControllerState) {
          return ShimmerVerticalShortCartItem(
            cart: item.cart,
          );
        } else {
          return VerticalShortCartItem(
            cart: item.cart,
            onSelectCart: item.onSelectCart,
          );
        }
      } else {
        return Container();
      }
    } else if (item is CartListItemControllerState) {
      if (item is HorizontalCartListItemControllerState) {
        return HorizontalCartItem(
          cart: item.cart,
          isSelected: item.isSelected,
          onChangeSelected: item.onChangeSelected,
          showDefaultCart: item.showDefaultCart,
          showCheck: item.showCheck
        );
      } else if (item is VerticalCartListItemControllerState) {
        if (item is ShimmerVerticalCartListItemControllerState) {
          return ShimmerVerticalCartItem(
            cart: item.cart,
          );
        } else {
          return VerticalCartItem(
            cart: item.cart,
            isSelected: item.isSelected,
            onChangeSelected: item.onChangeSelected,
            onAddToNotes: item.onAddToNotes,
            onAddToWishlist: item.onAddToWishlist,
            onRemoveFromNotes: item.onRemoveFromNotes,
            onChangeNotes: item.onChangeNotes,
            onRemoveCart: item.onRemoveCart,
            onChangeQuantity: item.onChangeQuantity,
            showDefaultCart: item.showDefaultCart,
            showCheck: item.showCheck
          );
        }
      } else {
        return Container();
      }
    } else if (item is CartHeaderListItemControllerState) {
      return CartHeader(
        isSelected: item.isSelected,
        onChangeSelected: item.onChangeSelected,
      );
    } else if (item is HostCartIndicatorListItemControllerState) {
      return HostCartIndicator(
        hostCart: item.hostCart,
      );
    } else if (item is AdditionalItemListItemControllerState) {
      return AdditionalItemWidget(
        additionalItem: item.additionalItem,
        no: item.no
      );
    } else if (item is AdditionalItemSummaryListItemControllerState) {
      return AdditionalItemSummaryWidget(
        additionalItemList: item.additionalItemList,
      );
    } else if (item is ShippingAddressIndicatorListItemControllerState) {
      return ShippingAddressIndicator(
        shippingAddress: item.shippingAddress,
      );
    } else if (item is AddressListItemControllerState) {
      if (item is HorizontalAddressListItemControllerState) {
        return HorizontalAddressItem(
          address: item.address,
          onSelectAddress: item.onSelectAddress,
          onRemoveAddress: item.onRemoveAddress
        );
      } else if (item is VerticalAddressListItemControllerState) {
        return VerticalAddressItem(
          address: item.address,
          onSelectAddress: item.onSelectAddress,
          onRemoveAddress: item.onRemoveAddress,
        );
      } else {
        return Container();
      }
    } else if (item is CountryListItemControllerState) {
      if (item is VerticalCountryListItemControllerState) {
        return VerticalCountryItem(
          country: item.country,
          isSelected: item.isSelected,
          onSelectCountry: item.onSelectCountry
        );
      } else {
        return Container();
      }
    } else if (item is BaseOrderListItemControllerState) {
      if (item is VerticalOrderListItemControllerState) {
        return VerticalOrderItem(
          order: item.order
        );
      } else if (item is IsRunningOrderListItemControllerState) {
        return IsRunningOrderItem(
          isRunningOrderCount: item.isRunningOrderCount,
          onTap: item.onTap
        );
      } else if (item is WaitingForPaymentOrderListItemControllerState) {
        return WaitingForPaymentOrderItem(
          waitingForPaymentOrderCount: item.waitingForPaymentOrderCount,
          onTap: item.onTap
        );
      } else {
        return Container();
      }
    } else if (item is BaseDeliveryReviewDetailListItemControllerState) {
      if (item is DeliveryReviewDetailListItemControllerState) {
        if (item is HorizontalDeliveryReviewDetailListItemControllerState) {
          return HorizontalDeliveryReviewDetailItem(
            deliveryReview: item.deliveryReview,
            deliveryReviewDetailType: item.deliveryReviewDetailType,
          );
        } else if (item is VerticalDeliveryReviewDetailListItemControllerState) {
          return VerticalDeliveryReviewDetailItem(
            deliveryReview: item.deliveryReview,
            deliveryReviewDetailType: item.deliveryReviewDetailType,
            onDeliveryReviewRatingTap: item.onDeliveryReviewRatingTap,
          );
        } else {
          return Container();
        }
      } else if (item is CheckYourContributionDeliveryReviewDetailListItemControllerState) {
        return CheckYourContributionDeliveryReviewDetailItem(
          userLoadDataResult: item.userLoadDataResult,
          errorProvider: item.errorProvider,
          onTap: item.onTap
        );
      } else {
        return Container();
      }
    } else if (item is ProductDiscussionListItemControllerState) {
      if (item is VerticalProductDiscussionListItemControllerState) {
        return VerticalProductDiscussionItem(
          productDiscussion: item.productDiscussion,
          isExpanded: item.isExpanded,
          onProductDiscussionTap: item.onProductDiscussionTap
        );
      } else {
        return Container();
      }
    } else if (item is ProductDiscussionDialogListItemControllerState) {
      if (item is VerticalProductDiscussionDialogListItemControllerState) {
        return VerticalProductDiscussionDialogItem(
          productDiscussionDialog: item.productDiscussionDialog,
          isMainProductDiscussion: item.isMainProductDiscussion,
        );
      } else {
        return Container();
      }
    } else if (item is FaqListItemControllerState) {
      return FaqItem(
        faq: item.faq,
        onTap: item.onTap,
        isExpand: item.isExpanded
      );
    } else if (item is FaqDetailListItemControllerState) {
      return FaqDetailItem(
        faq: item.faq
      );
    } else if (item is BaseCountryDeliveryReviewHeaderListItemControllerState) {
      if (item is ShimmerCountryDeliveryReviewHeaderListItemControllerState) {
        return const ShimmerCountryDeliveryReviewHeaderItem();
      } else if (item is CountryDeliveryReviewHeaderListItemControllerState) {
        return CountryDeliveryReviewHeaderItem(
          countryDeliveryReviewHeaderContent: item.countryDeliveryReviewHeaderContent,
        );
      } else {
        return Container();
      }
    } else if (item is BaseCountryDeliveryReviewMediaShortContentListItemControllerState) {
      if (item is ShimmerCountryDeliveryReviewMediaShortContentListItemControllerState) {
        return const ShimmerCountryDeliveryReviewMediaShortContentItem();
      } else if (item is CountryDeliveryReviewMediaShortContentListItemControllerState) {
        return CountryDeliveryReviewMediaShortContentItem(
          countryDeliveryReviewMediaList: item.countryDeliveryReviewMediaList
        );
      } else {
        return Container();
      }
    } else if (item is CountryDeliveryReviewListItemControllerState) {
      return CountryDeliveryReviewItem(
        countryDeliveryReview: item.countryDeliveryReview
      );
    } else if (item is CountryDeliveryReviewSelectCountryListItemControllerState) {
      return CountryDeliveryReviewSelectCountryItem(
        selectedCountry: item.selectedCountry,
        onSelectCountry: item.onSelectCountry
      );
    } else if (item is CountryDeliveryReviewMediaDetailListItemControllerState) {
      return CountryDeliveryReviewMediaDetailItem(
        countryDeliveryReviewMedia: item.countryDeliveryReviewMedia,
        contextForOpeningMediaView: item.contextForOpeningMediaView
      );
    } else if (item is ChatBubbleListItemControllerState) {
      return ChatBubble(
        userMessage: item.userMessage,
        loggedUser: item.loggedUser,
      );
    } else {
      return Container();
    }
  }

  T? _findDesiredListItemPagingParameterInjection<T extends ListItemPagingParameterInjection>() {
    try {
      return listItemPagingParameterInjectionList.firstWhere((element) => element is T) as T;
    } on StateError catch (e) {
      if (e.message == "No element") {
        return null;
      }
      rethrow;
    }
  }
}