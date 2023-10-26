import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../controller/product_detail_controller.dart';
import '../../domain/entity/cart/support_cart.dart';
import '../../domain/entity/product/product.dart';
import '../../domain/entity/product/product_detail.dart';
import '../../domain/entity/product/product_detail_get_other_from_this_brand_parameter.dart';
import '../../domain/entity/product/product_detail_get_other_in_this_category_parameter.dart';
import '../../domain/entity/product/product_detail_parameter.dart';
import '../../domain/entity/product/productentry/product_entry.dart';
import '../../domain/entity/product/productvariant/product_variant.dart';
import '../../domain/entity/wishlist/support_wishlist.dart';
import '../../domain/usecase/add_to_cart_use_case.dart';
import '../../domain/usecase/get_product_category_list_use_case.dart';
import '../../domain/usecase/get_product_detail_from_your_search_product_entry_list_use_case.dart';
import '../../domain/usecase/get_product_detail_other_chosen_for_you_product_entry_list_use_case.dart';
import '../../domain/usecase/get_product_detail_other_from_this_brand_product_entry_list_use_case.dart';
import '../../domain/usecase/get_product_detail_other_in_this_category_product_entry_list_use_case.dart';
import '../../domain/usecase/get_product_detail_other_interested_product_brand_list_use_case.dart';
import '../../domain/usecase/get_product_detail_use_case.dart';
import '../../misc/additionalloadingindicatorchecker/product_detail_additional_paging_result_parameter_checker.dart';
import '../../misc/constant.dart';
import '../../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../../misc/controllerstate/listitemcontrollerstate/builder_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/colorful_chip_tab_bar_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/load_data_result_dynamic_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/product_detail_brand_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/product_detail_image_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/product_detail_short_header_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/title_and_description_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/dialog_helper.dart';
import '../../misc/entityandlistitemcontrollerstatemediator/horizontal_component_entity_parameterized_entity_and_list_item_controller_state_mediator.dart';
import '../../misc/error/message_error.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/on_observe_load_product_delegate.dart';
import '../../misc/page_restoration_helper.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/cart_delegate_parameterized_entity_and_list_item_controllere_state_mediator_parameter.dart';
import '../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/compound_parameterized_entity_and_list_item_controller_state_mediator.dart';
import '../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/horizontal_dynamic_item_carousel_parametered_component_entity_and_list_item_controller_state_mediator_parameter.dart';
import '../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/wishlist_delegate_parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import '../../misc/product_helper.dart';
import '../../misc/string_util.dart';
import '../../misc/toast_helper.dart';
import '../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../widget/colorful_chip_tab_bar.dart';
import '../widget/modified_divider.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modifiedappbar/default_search_app_bar.dart';
import 'getx_page.dart';
import 'product_chat_page.dart';
import 'product_entry_page.dart';
import 'search_page.dart';

class ProductDetailPage extends RestorableGetxPage<_ProductDetailPageRestoration> {
  late final ControllerMember<ProductDetailController> _productDetailController = ControllerMember<ProductDetailController>().addToControllerManager(controllerManager);

  final String productId;
  final String productEntryId;

  ProductDetailPage({
    Key? key,
    required this.productId,
    required this.productEntryId
  }) : super(key: key, pageRestorationId: () => "product-detail-page");

  @override
  void onSetController() {
    _productDetailController.controller = GetExtended.put<ProductDetailController>(
      ProductDetailController(
        controllerManager,
        Injector.locator<GetProductDetailUseCase>(),
        Injector.locator<GetProductCategoryListUseCase>(),
        Injector.locator<GetProductDetailOtherChosenForYouProductEntryListUseCase>(),
        Injector.locator<GetProductDetailOtherFromThisBrandProductEntryListUseCase>(),
        Injector.locator<GetProductDetailOtherInThisCategoryProductEntryListUseCase>(),
        Injector.locator<GetProductDetailFromYourSearchProductEntryListUseCase>(),
        Injector.locator<GetProductDetailOtherInterestedProductBrandListUseCase>(),
        Injector.locator<AddToCartUseCase>(),
        Injector.locator<WishlistAndCartControllerContentDelegate>()
      ),
      tag: pageName
    );
  }

  @override
  _ProductDetailPageRestoration createPageRestoration() => _ProductDetailPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulProductDetailControllerMediatorWidget(
        productId: productId,
        productEntryId: productEntryId,
        productDetailController: _productDetailController.controller,
      ),
    );
  }
}

class _ProductDetailPageRestoration extends MixableGetxPageRestoration with ProductDetailPageRestorationMixin, ProductEntryPageRestorationMixin, SearchPageRestorationMixin, ProductChatPageRestorationMixin {
  @override
  // ignore: unnecessary_overrides
  void initState() {
    super.initState();
  }

  @override
  // ignore: unnecessary_overrides
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  // ignore: unnecessary_overrides
  void dispose() {
    super.dispose();
  }
}

class ProductDetailPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final String productId;
  final String productEntryId;

  ProductDetailPageGetPageBuilderAssistant({
    required this.productId,
    required this.productEntryId
  });

  @override
  GetPageBuilder get pageBuilder => (() => ProductDetailPage(
    productId: productId,
    productEntryId: productEntryId,
  ));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(
    ProductDetailPage(
      productId: productId,
      productEntryId: productEntryId
    )
  ));
}

mixin ProductDetailPageRestorationMixin on MixableGetxPageRestoration {
  late ProductDetailPageRestorableRouteFuture productDetailPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    productDetailPageRestorableRouteFuture = ProductDetailPageRestorableRouteFuture(restorationId: restorationIdWithPageName('login-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    productDetailPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    productDetailPageRestorableRouteFuture.dispose();
  }
}

class ProductDetailPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  ProductDetailPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    if (arguments is! String) {
      throw MessageError(message: "Arguments must be a String");
    }
    ProductDetailPageParameter productDetailPageParameter = arguments.toProductDetailPageParameter();
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        ProductDetailPageGetPageBuilderAssistant(
          productId: productDetailPageParameter.productId,
          productEntryId: productDetailPageParameter.productEntryId
        )
      ),
    );
  }

  @pragma('vm:entry-point')
  static Route<void> _pageRouteBuilder(BuildContext context, Object? arguments) {
    return _getRoute(arguments)!;
  }

  @override
  bool checkBeforePresent([Object? arguments]) => _getRoute(arguments) != null;

  @override
  void presentIfCheckIsPassed([Object? arguments]) => _pageRoute.present(arguments);

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    restorator.registerForRestoration(_pageRoute, restorationId);
  }

  @override
  void dispose() {
    _pageRoute.dispose();
  }
}

class _StatefulProductDetailControllerMediatorWidget extends StatefulWidget {
  final ProductDetailController productDetailController;
  final String productId;
  final String productEntryId;

  const _StatefulProductDetailControllerMediatorWidget({
    required this.productDetailController,
    required this.productId,
    required this.productEntryId
  });

  @override
  State<_StatefulProductDetailControllerMediatorWidget> createState() => _StatefulProductDetailControllerMediatorWidgetState();
}

class _StatefulProductDetailControllerMediatorWidgetState extends State<_StatefulProductDetailControllerMediatorWidget> {
  late final ModifiedPagingController<int, ListItemControllerState> _productDetailListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _productDetailListItemPagingControllerState;
  final List<LoadDataResultDynamicListItemControllerState> _dynamicItemLoadDataResultDynamicListItemControllerStateList = [];
  late ColorfulChipTabBarController _productVariantColorfulChipTabBarController;
  String _selectedProductEntryId = "";
  LoadDataResult<ProductDetail> _productDetailLoadDataResult = NoLoadDataResult<ProductDetail>();

  @override
  void initState() {
    super.initState();
    _productDetailListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.productDetailController.apiRequestManager,
      additionalPagingResultParameterChecker: Injector.locator<ProductDetailAdditionalPagingResultParameterChecker>()
    );
    _productDetailListItemPagingControllerState = PagingControllerState(
      pagingController: _productDetailListItemPagingController,
      isPagingControllerExist: false
    );
    _productDetailListItemPagingControllerState.pagingController.addPageRequestListenerForLoadDataResult(
      listener: _productDetailListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _productDetailListItemPagingControllerState.isPagingControllerExist = true;
    _selectedProductEntryId = widget.productEntryId;
    _productVariantColorfulChipTabBarController = ColorfulChipTabBarController(-1);
    _productVariantColorfulChipTabBarController.addListener(() => setState(() {}));
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _productDetailListItemPagingControllerStateListener(int pageKey) async {
    HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator componentEntityMediator = Injector.locator<HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator>();
    HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter carouselParameterizedEntityMediator = HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter(
      onSetState: () => setState(() {}),
      dynamicItemLoadDataResultDynamicListItemControllerStateList: _dynamicItemLoadDataResultDynamicListItemControllerStateList
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productDetailLoadDataResult = IsLoadingLoadDataResult<ProductDetail>();
      setState(() {});
    });
    LoadDataResult<ProductDetail> productDetailLoadDataResult = await widget.productDetailController.getProductDetail(
      ProductDetailParameter(
        productId: widget.productId
      )
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productDetailLoadDataResult = productDetailLoadDataResult;
      setState(() {});
    });
    return productDetailLoadDataResult.map((productDetail) {
      int a = 0;
      int selectedProductVariantIndex = -1;
      List<ProductEntry> productEntryList = productDetail.productEntry;
      for (ProductEntry productEntry in productEntryList) {
        List<ProductVariant> productVariantList = productEntry.productVariantList;
        if (productVariantList.isNotEmpty) {
          ProductVariant firstProductVariant = productVariantList.first;
          if (firstProductVariant.productEntryId == widget.productEntryId) {
            if (selectedProductVariantIndex == -1) {
              selectedProductVariantIndex = a;
              _productVariantColorfulChipTabBarController.value = selectedProductVariantIndex;
              break;
            }
          }
        }
        a++;
      }
      return PagingDataResult<ListItemControllerState>(
        page: 1,
        totalPage: 1,
        totalItem: 1,
        itemList: [
          ProductDetailImageListItemControllerState(
            productEntryList: productDetail.productEntry,
            onGetProductEntryIndex: () {
              return _productVariantColorfulChipTabBarController.value;
            }
          ),
          ProductDetailShortHeaderListItemControllerState(
            productDetail: productDetail,
            onGetProductEntryIndex: () {
              return _productVariantColorfulChipTabBarController.value;
            },
            onAddWishlist: (productAppearanceData) => widget.productDetailController.wishlistAndCartControllerContentDelegate.addToWishlist(productAppearanceData as SupportWishlist),
            onRemoveWishlist: (productAppearanceData) => widget.productDetailController.wishlistAndCartControllerContentDelegate.removeFromWishlist(productAppearanceData as SupportWishlist),
          ),
          VirtualSpacingListItemControllerState(height: 2.h),
          PaddingContainerListItemControllerState(
            padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
            paddingChildListItemControllerState: TitleAndDescriptionListItemControllerState(
              title: productDetail.name,
              verticalSpace: 5,
              titleAndDescriptionItemInterceptor: (padding, title, titleWidget, description, descriptionWidget, titleAndDescriptionWidget, titleAndDescriptionWidgetList) {
                if (titleWidget != null) {
                  if (titleWidget is Text) {
                    titleAndDescriptionWidgetList.first = Text(title.toStringNonNull, style: titleWidget.style?.copyWith(fontWeight: FontWeight.normal));
                  }
                }
                return titleAndDescriptionWidget;
              }
            ),
          ),
          if (productEntryList.isNotEmpty)
            CompoundListItemControllerState(
              listItemControllerState: [
                BuilderListItemControllerState(
                  buildListItemControllerState: () {
                    List<ColorfulChipTabBarData> colorfulChipTabBarDataList = [];
                    int i = 0;
                    int selectedProductVariantIndex = -1;
                    List<ProductEntry> productEntryList = productDetail.productEntry;
                    for (ProductEntry productEntry in productEntryList) {
                      List<ProductVariant> productVariantList = productEntry.productVariantList;
                      if (productVariantList.isNotEmpty) {
                        ProductVariant firstProductVariant = productVariantList.first;
                        if (firstProductVariant.productEntryId == widget.productEntryId) {
                          if (selectedProductVariantIndex == -1) {
                            selectedProductVariantIndex = i;
                          }
                        }
                        String productVariantDescription = "";
                        int j = 0;
                        for (ProductVariant productVariant in productVariantList) {
                          productVariantDescription += "${(j > 0 ? ", " : "")}${productVariant.type} (${productVariant.name})";
                          j++;
                        }
                        colorfulChipTabBarDataList.add(
                          ColorfulChipTabBarData(
                            title: productVariantDescription,
                            color: Theme.of(context).colorScheme.primary,
                            data: firstProductVariant.productEntryId
                          )
                        );
                      }
                      i++;
                    }
                    return CompoundListItemControllerState(
                      listItemControllerState: [
                        if (colorfulChipTabBarDataList.isNotEmpty)
                          ...[
                            VirtualSpacingListItemControllerState(height: 2.h),
                            PaddingContainerListItemControllerState(
                              padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
                              paddingChildListItemControllerState: TitleAndDescriptionListItemControllerState(
                                title: "Select Variant".tr,
                                description: null,
                                verticalSpace: 25,
                                titleAndDescriptionItemInterceptor: (padding, title, titleWidget, description, descriptionWidget, titleAndDescriptionWidget, titleAndDescriptionWidgetList) {
                                  titleAndDescriptionWidgetList.first = Text(title.toStringNonNull, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
                                  return titleAndDescriptionWidget;
                                }
                              )
                            ),
                            VirtualSpacingListItemControllerState(height: 2.h),
                            ColorfulChipTabBarListItemControllerState(
                              colorfulChipTabBarController: _productVariantColorfulChipTabBarController,
                              colorfulChipTabBarDataList: colorfulChipTabBarDataList,
                            ),
                          ]
                      ],
                    );
                  }
                ),
              ]
            ),
          VirtualSpacingListItemControllerState(height: 2.h),
          PaddingContainerListItemControllerState(
            padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
            paddingChildListItemControllerState: TitleAndDescriptionListItemControllerState(
              title: "Product Detail".tr,
              description: productDetail.description,
              verticalSpace: 25,
              titleAndDescriptionItemInterceptor: (padding, title, titleWidget, description, descriptionWidget, titleAndDescriptionWidget, titleAndDescriptionWidgetList) {
                ProductEntry? _selectedProductEntry = ProductHelper.getSelectedProductEntry(
                  productDetail.productEntry, _productVariantColorfulChipTabBarController.value
                );
                bool hasSelectedProductEntry = _selectedProductEntry != null;
                List<List<String>> productDetailContentList = [
                  if (productDetail.productCertificationList.isNotEmpty) <String>["Certification".tr, productDetail.productCertificationList.first.name],
                  //<String>["Contain".tr, product.],
                  <String>["Category".tr, productDetail.productCategory.name],
                  <String>["Province".tr, (productDetail.province?.name).toStringNonNull],
                  <String>["Brand".tr, productDetail.productBrand.name],
                  if (hasSelectedProductEntry) ...[
                    <String>["SKU".tr, _selectedProductEntry.sku],
                    <String>["Sustension".tr, _selectedProductEntry.sustension]
                  ]
                ];
                titleAndDescriptionWidgetList.first = Text(title.toStringNonNull, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
                titleAndDescriptionWidgetList.last = Column(
                  children: productDetailContentList.mapIndexed(
                    (index, productDetailContentListValue) {
                      List<Widget> columnResult = [
                        Row(
                          children: [
                            Expanded(
                              child: Text(productDetailContentListValue[0]),
                            ),
                            Expanded(
                              child: Text(productDetailContentListValue[1]),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 5),
                            const ModifiedDivider(),
                            if (index < productDetailContentList.length - 1)
                              const SizedBox(height: 5),
                          ]
                        ),
                      ];
                      return Column(
                        children: columnResult,
                      );
                    }
                  ).toList(),
                );
                return titleAndDescriptionWidget;
              }
            ),
          ),
          VirtualSpacingListItemControllerState(height: 4.h),
          PaddingContainerListItemControllerState(
            padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
            paddingChildListItemControllerState: TitleAndDescriptionListItemControllerState(
              title: "Product Description".tr,
              description: productDetail.description,
              verticalSpace: 25,
              titleAndDescriptionItemInterceptor: (padding, title, titleWidget, description, descriptionWidget, titleAndDescriptionWidget, titleAndDescriptionWidgetList) {
                titleAndDescriptionWidgetList.first = Text(title.toStringNonNull, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
                return titleAndDescriptionWidget;
              }
            ),
          ),
          VirtualSpacingListItemControllerState(height: 4.h),
          componentEntityMediator.mapWithParameter(
            widget.productDetailController.getOtherInThisCategory(
              ProductDetailGetOtherInThisCategoryParameter(
                categorySlug: productDetail.productCategory.slug
              )
            ),
            parameter: carouselParameterizedEntityMediator
          ),
          VirtualSpacingListItemControllerState(height: 4.h),
          ProductDetailBrandListItemControllerState(
            productBrand: productDetail.productBrand,
            onTapProductBrand: (productBrand) => PageRestorationHelper.toProductEntryPage(
              context,
              ProductEntryPageParameter(
                productEntryParameterMap: {
                  "brand_id": productBrand.id,
                  "brand": productBrand.slug
                }
              )
            )
          ),
          VirtualSpacingListItemControllerState(height: 4.h),
          componentEntityMediator.mapWithParameter(
            widget.productDetailController.getOtherFromThisBrand(
              ProductDetailGetOtherFromThisBrandParameter(
                brandSlug: productDetail.productBrand.slug
              )
            ),
            parameter: carouselParameterizedEntityMediator
          ),
          VirtualSpacingListItemControllerState(height: 4.h),
          componentEntityMediator.mapWithParameter(
            widget.productDetailController.getOtherChosenForYou(),
            parameter: carouselParameterizedEntityMediator
          ),
          VirtualSpacingListItemControllerState(height: 4.h),
          componentEntityMediator.mapWithParameter(
            widget.productDetailController.getOtherFromYourSearch(),
            parameter: carouselParameterizedEntityMediator
          ),
          VirtualSpacingListItemControllerState(height: 4.h),
          componentEntityMediator.mapWithParameter(
            widget.productDetailController.getOtherInterestedProductBrand(),
            parameter: carouselParameterizedEntityMediator
          ),
          VirtualSpacingListItemControllerState(height: 4.h),
        ]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    OnObserveLoadProductDelegateFactory onObserveLoadProductDelegateFactory = Injector.locator<OnObserveLoadProductDelegateFactory>()
      ..onInjectLoadProductEntryCarouselParameterizedEntity = (
        () => CompoundParameterizedEntityAndListItemControllerStateMediatorParameter(
          parameterizedEntityAndListItemControllerStateMediatorParameterList: [
            WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter(
              onAddToWishlist: (data) async => widget.productDetailController.wishlistAndCartControllerContentDelegate.addToWishlist(data),
              onRemoveFromWishlist: (data) async => widget.productDetailController.wishlistAndCartControllerContentDelegate.removeFromWishlist(data),
            ),
            CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter(
              onAddCart: (data) async => widget.productDetailController.wishlistAndCartControllerContentDelegate.addToCart(data),
            )
          ]
        )
      )
      ..onInjectLoadProductBundleCarouselParameterizedEntity = (
        () => CompoundParameterizedEntityAndListItemControllerStateMediatorParameter(
          parameterizedEntityAndListItemControllerStateMediatorParameterList: [
            WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter(
              onAddToWishlist: (data) async => widget.productDetailController.wishlistAndCartControllerContentDelegate.addToWishlist(data),
              onRemoveFromWishlist: (data) async => widget.productDetailController.wishlistAndCartControllerContentDelegate.removeFromWishlist(data),
            ),
            CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter(
              onAddCart: (data) async => widget.productDetailController.wishlistAndCartControllerContentDelegate.addToCart(data),
            )
          ]
        )
      );
    widget.productDetailController.setProductDetailMainMenuDelegate(
      ProductDetailMainMenuDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onObserveLoadProductDelegate: onObserveLoadProductDelegateFactory.generateOnObserveLoadProductDelegate(),
        onGetSupportCart: () {
          return _productDetailLoadDataResult.isSuccess
            ? _productDetailLoadDataResult.resultIfSuccess!.productEntry as SupportCart
            : null;
        },
        onShowAddToCartRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onShowAddToCartRequestProcessFailedCallback: (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
          context: context,
          errorProvider: Injector.locator<ErrorProvider>(),
          e: e
        ),
        onAddToCartRequestProcessSuccessCallback: () async {
          ToastHelper.showToast("${"Success add to cart".tr}.");
        },
        onShowBuyDirectlyRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onShowBuyDirectlyRequestProcessFailedCallback: (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
          context: context,
          errorProvider: Injector.locator<ErrorProvider>(),
          e: e
        ),
        onBuyDirectlyRequestProcessSuccessCallback: () async {

        }
      )
    );
    widget.productDetailController.wishlistAndCartControllerContentDelegate.setWishlistAndCartDelegate(
      Injector.locator<WishlistAndCartDelegateFactory>().generateWishlistAndCartDelegate(
        onGetBuildContext: () => context,
        onGetErrorProvider: () => Injector.locator<ErrorProvider>()
      )
    );
    return Scaffold(
      appBar: DefaultSearchAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _productDetailListItemPagingControllerState,
                onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
                  pagingControllerState: pagingControllerState!
                ),
                pullToRefresh: true
              ),
            ),
            if (_productDetailLoadDataResult.isSuccess)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: SizedOutlineGradientButton(
                        text: '',
                        width: double.infinity,
                        outlineGradientButtonType: OutlineGradientButtonType.outline,
                        onPressed: () => PageRestorationHelper.toProductChatPage(widget.productId, context),
                        child: const Icon(Icons.chat, size: 16)
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedOutlineGradientButton(
                        width: double.infinity,
                        outlineGradientButtonType: OutlineGradientButtonType.outline,
                        onPressed: widget.productDetailController.buyDirectly,
                        text: "Buy Directly".tr,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedOutlineGradientButton(
                        width: double.infinity,
                        outlineGradientButtonType: OutlineGradientButtonType.solid,
                        onPressed: () {
                          if (_productDetailLoadDataResult.isSuccess) {
                            ProductDetail productDetail = _productDetailLoadDataResult.resultIfSuccess!;
                            int productEntryIndex = _productVariantColorfulChipTabBarController.value;
                            ProductEntry? productEntry = ProductHelper.getSelectedProductEntry(
                              productDetail.productEntry, productEntryIndex
                            );
                            if (productEntry != null) {
                              widget.productDetailController.wishlistAndCartControllerContentDelegate.addToCart(productEntry);
                            }
                          }
                        },
                        text: "+ ${"Cart".tr}",
                      ),
                    ),
                  ],
                )
              )
          ]
        )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ProductDetailPageParameter {
  String productId;
  String productEntryId;

  ProductDetailPageParameter({
    required this.productId,
    required this.productEntryId
  });
}

extension ProductDetailPageParameterExt on ProductDetailPageParameter {
  String toEncodeBase64String() => StringUtil.encodeBase64StringFromJson(
    <String, dynamic>{
      "product_id": productId,
      "product_entry_id": productEntryId,
    }
  );
}

extension ProductDetailPageParameterStringExt on String {
  ProductDetailPageParameter toProductDetailPageParameter() {
    dynamic result = StringUtil.decodeBase64StringToJson(this);
    return ProductDetailPageParameter(
      productId: result["product_id"],
      productEntryId: result["product_entry_id"],
    );
  }
}