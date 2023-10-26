import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/wishlist_delegate_parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import 'package:masterbagasi/presentation/page/product_entry_page.dart';
import 'package:sizer/sizer.dart';
import '../../../../controller/mainmenucontroller/mainmenusubpagecontroller/home_main_menu_sub_controller.dart';
import '../../../../domain/entity/address/address.dart';
import '../../../../domain/entity/banner/banner.dart';
import '../../../../domain/entity/homemainmenucomponententity/banner_home_main_menu_component_entity.dart';
import '../../../../domain/entity/homemainmenucomponententity/home_main_menu_component_entity.dart';
import '../../../../domain/entity/homemainmenucomponententity/separator_home_main_menu_component_entity.dart';
import '../../../../domain/entity/location/location.dart';
import '../../../../misc/additionalloadingindicatorchecker/home_sub_additional_paging_result_parameter_checker.dart';
import '../../../../misc/aspect_ratio_value.dart';
import '../../../../misc/carouselbackground/asset_carousel_background.dart';
import '../../../../misc/carouselbackground/carousel_background.dart';
import '../../../../misc/constant.dart';
import '../../../../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/carousel_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/colorful_divider_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/decorated_container_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/delivery_to_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/failed_prompt_indicator_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/load_data_result_dynamic_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/multi_banner_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/no_content_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/product_bundle_highlight_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/single_banner_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/title_and_description_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/widget_substitution_list_item_controller_state.dart';
import '../../../../misc/controllerstate/paging_controller_state.dart';
import '../../../../misc/dialog_helper.dart';
import '../../../../misc/entityandlistitemcontrollerstatemediator/horizontal_component_entity_parameterized_entity_and_list_item_controller_state_mediator.dart';
import '../../../../misc/error/message_error.dart';
import '../../../../misc/errorprovider/error_provider.dart';
import '../../../../misc/injector.dart';
import '../../../../misc/load_data_result.dart';
import '../../../../misc/main_route_observer.dart';
import '../../../../misc/manager/controller_manager.dart';
import '../../../../misc/on_observe_load_product_delegate.dart';
import '../../../../misc/page_restoration_helper.dart';
import '../../../../misc/paging/modified_paging_controller.dart';
import '../../../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../../misc/paging/pagingresult/paging_result.dart';
import '../../../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/carousel_background_parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import '../../../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/cart_delegate_parameterized_entity_and_list_item_controllere_state_mediator_parameter.dart';
import '../../../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/compound_parameterized_entity_and_list_item_controller_state_mediator.dart';
import '../../../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/horizontal_dynamic_item_carousel_parametered_component_entity_and_list_item_controller_state_mediator_parameter.dart';
import '../../../../misc/shimmercarousellistitemgenerator/factory/product_bundle_shimmer_carousel_list_item_generator_factory.dart';
import '../../../../misc/shimmercarousellistitemgenerator/type/product_bundle_shimmer_carousel_list_item_generator_type.dart';
import '../../../widget/background_app_bar_scaffold.dart';
import '../../../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../../../widget/modified_paged_list_view.dart';
import '../../../widget/modifiedappbar/main_menu_search_app_bar.dart';
import '../../../widget/modifiedcachednetworkimage/transparent_banner_modified_cached_network_image.dart';
import '../../../widget/tap_area.dart';
import '../../../widget/titleanddescriptionitem/title_and_description_item.dart';
import '../../getx_page.dart';
import '../../modaldialogpage/check_rates_for_various_countries_modal_dialog_page.dart';

class HomeMainMenuSubPage extends DefaultGetxPage {
  late final ControllerMember<HomeMainMenuSubController> _homeMainMenuSubController = ControllerMember<HomeMainMenuSubController>().addToControllerManager(controllerManager);
  final String ancestorPageName;

  HomeMainMenuSubPage({Key? key, required this.ancestorPageName}) : super(key: key, systemUiOverlayStyle: SystemUiOverlayStyle.light);

  @override
  void onSetController() {
    _homeMainMenuSubController.controller = Injector.locator<HomeMainMenuSubControllerInjectionFactory>().inject(controllerManager, ancestorPageName);
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulHomeMainMenuSubControllerMediatorWidget(
      homeMainMenuSubController: _homeMainMenuSubController.controller
    );
  }
}

class _StatefulHomeMainMenuSubControllerMediatorWidget extends StatefulWidget {
  final HomeMainMenuSubController homeMainMenuSubController;

  const _StatefulHomeMainMenuSubControllerMediatorWidget({
    required this.homeMainMenuSubController
  });

  @override
  State<_StatefulHomeMainMenuSubControllerMediatorWidget> createState() => _StatefulHomeMainMenuSubControllerMediatorWidgetState();
}

class _StatefulHomeMainMenuSubControllerMediatorWidgetState extends State<_StatefulHomeMainMenuSubControllerMediatorWidget> {
  late final ModifiedPagingController<int, ListItemControllerState> _homeMainMenuSubListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _homeMainMenuSubListItemPagingControllerState;
  final List<BaseLoadDataResultDynamicListItemControllerState> _dynamicItemLoadDataResultDynamicListItemControllerStateList = [];

  late AssetImage _homeAppBarBackgroundAssetImage;

  @override
  void initState() {
    super.initState();
    _homeAppBarBackgroundAssetImage = AssetImage(Constant.imagePatternHomeMainMenuAppBar);
    _homeMainMenuSubListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.homeMainMenuSubController.apiRequestManager,
      additionalPagingResultParameterChecker: Injector.locator<HomeSubAdditionalPagingResultParameterChecker>()
    );
    _homeMainMenuSubListItemPagingControllerState = PagingControllerState(
      pagingController: _homeMainMenuSubListItemPagingController,
      isPagingControllerExist: false
    );
    _homeMainMenuSubListItemPagingControllerState.pagingController.addPageRequestListenerForLoadDataResult(
      listener: _homeMainMenuListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _homeMainMenuSubListItemPagingControllerState.isPagingControllerExist = true;
    MainRouteObserver.controllerMediatorMap[Constant.subPageKeyHomeMainMenu] = refreshHomeMainMenu;
  }

  @override
  void didChangeDependencies() {
    precacheImage(_homeAppBarBackgroundAssetImage, context);
    super.didChangeDependencies();
  }

  void _checkingMainMenuContent(List<HomeMainMenuComponentEntity> mainMenuContentList, List<ListItemControllerState> listItemControllerStateList) {
    HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator componentEntityMediator = Injector.locator<HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator>();
    HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter carouselParameterizedEntityMediator = HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter(
      onSetState: () => setState(() {}),
      dynamicItemLoadDataResultDynamicListItemControllerStateList: _dynamicItemLoadDataResultDynamicListItemControllerStateList
    );
    int i = 0;
    _dynamicItemLoadDataResultDynamicListItemControllerStateList.clear();
    while (i < mainMenuContentList.length) {
      HomeMainMenuComponentEntity homeMainMenuComponentEntity = mainMenuContentList[i];
      if (homeMainMenuComponentEntity is SeparatorHomeMainMenuComponentEntity) {
        listItemControllerStateList.add(
          VirtualSpacingListItemControllerState(
            height: Constant.paddingListItem
          )
        );
      } else if (homeMainMenuComponentEntity is BannerHomeMainMenuComponentEntity) {
        listItemControllerStateList.add(
          SingleBannerListItemControllerState(
            banner: homeMainMenuComponentEntity.banner,
            aspectRatioValue: homeMainMenuComponentEntity.aspectRatioValue
          )
        );
      } else {
        ListItemControllerState listItemControllerState = componentEntityMediator.mapWithParameter(
          homeMainMenuComponentEntity, parameter: carouselParameterizedEntityMediator
        );
        if (listItemControllerState is NoContentListItemControllerState) {
          listItemControllerStateList.add(
            FailedPromptIndicatorListItemControllerState(
              errorProvider: Injector.locator<ErrorProvider>(),
              e: FailedLoadDataResult.throwException(() => throw MessageError(
                title: "Item Not Showed",
                message: "This item cannot be showed ${kDebugMode ? "(${homeMainMenuComponentEntity.runtimeType})" : ""}"
              ))!.e,
            )
          );
        } else {
          listItemControllerStateList.add(listItemControllerState);
        }
      }
      i++;
    }
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _homeMainMenuListItemPagingControllerStateListener(int pageKey) async {
    List<HomeMainMenuComponentEntity> firstMainMenuContentList = [
      widget.homeMainMenuSubController.getDeliveryTo(),
    ];
    List<HomeMainMenuComponentEntity> middleMainMenuContentList = [
      widget.homeMainMenuSubController.getHomepageBanner(),
    ];
    List<HomeMainMenuComponentEntity> mainMenuContentList = [
      ...widget.homeMainMenuSubController.getHomeMainMenuComponentEntity()
    ];
    List<ListItemControllerState> firstListItemControllerStateList = [];
    List<ListItemControllerState> middleListItemControllerStateList = [];
    List<ListItemControllerState> listItemControllerStateList = [];
    _checkingMainMenuContent(firstMainMenuContentList, firstListItemControllerStateList);
    _checkingMainMenuContent(middleMainMenuContentList, middleListItemControllerStateList);
    _checkingMainMenuContent(mainMenuContentList, listItemControllerStateList);
    return SuccessLoadDataResult<PagingResult<ListItemControllerState>>(
      value: PagingDataResult<ListItemControllerState>(
        page: 1,
        totalPage: 1,
        totalItem: 1,
        itemList: [
          ...firstListItemControllerStateList,
          ColorfulDividerListItemControllerState(
            lineColorList: [Constant.colorButtonGradient2, Constant.colorButtonGradient3],
            lineHeight: 3
          ),
          ...middleListItemControllerStateList,
          ...listItemControllerStateList,
        ]
      )
    );
  }

  void refreshHomeMainMenu() {
    _homeMainMenuSubListItemPagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.setWishlistAndCartDelegate(
      Injector.locator<WishlistAndCartDelegateFactory>().generateWishlistAndCartDelegate(
        onGetBuildContext: () => context,
        onGetErrorProvider: () => Injector.locator<ErrorProvider>()
      )
    );
    OnObserveLoadProductDelegateFactory onObserveLoadProductDelegateFactory = Injector.locator<OnObserveLoadProductDelegateFactory>()
      ..onInjectLoadProductEntryCarouselParameterizedEntity = (
        () => CompoundParameterizedEntityAndListItemControllerStateMediatorParameter(
          parameterizedEntityAndListItemControllerStateMediatorParameterList: [
            WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter(
              onAddToWishlist: (data) => widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.addToWishlist(data),
              onRemoveFromWishlist: (data) => widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.removeFromWishlist(data),
            ),
            CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter(
              onAddCart: (data) => widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.addToCart(data),
            )
          ]
        )
      )
      ..onInjectLoadProductBundleCarouselParameterizedEntity = (
        () => CompoundParameterizedEntityAndListItemControllerStateMediatorParameter(
          parameterizedEntityAndListItemControllerStateMediatorParameterList: [
            WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter(
              onAddToWishlist: (data) => widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.addToWishlist(data),
              onRemoveFromWishlist: (data) => widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.removeFromWishlist(data),
            ),
            CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter(
              onAddCart: (data) => widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.addToCart(data),
            )
          ]
        )
      )
      ..onInjectCarouselParameterizedEntity = (
        (data) {
          Widget moreTapArea({
            void Function()? onTap,
            TextStyle Function(TextStyle)? onInterceptTextStyle
          }) {
            TextStyle textStyle = TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12
            );
            return TapArea(
              onTap: onTap,
              child: Text(
                "More".tr,
                style: onInterceptTextStyle != null ? onInterceptTextStyle(textStyle) : textStyle
              ),
            );
          }
          Widget titleArea({
            required Widget title,
            void Function()? onTapMore,
            TextStyle Function(TextStyle)? onInterceptTextStyle
          }) {
            return Row(
              children: [
                Expanded(child: title),
                const SizedBox(width: 10),
                moreTapArea(
                  onTap: onTapMore,
                  onInterceptTextStyle: onInterceptTextStyle
                )
              ],
            );
          }
          late CarouselBackground carouselBackground;
          TitleInterceptor? titleInterceptor;
          if (data == Constant.carouselKeyIndonesianCategoryProduct) {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternGrey);
          } else if (data == Constant.carouselKeyIndonesianOriginalBrand) {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternGrey2);
            titleInterceptor = (text, style) => titleArea(
              title: Text(text.toStringNonNull, style: style?.copyWith()),
              onInterceptTextStyle: (style) => style.copyWith(),
              onTapMore: () => PageRestorationHelper.toProductBrandPage(context)
            );
          } else if (data == Constant.carouselKeyIsViral) {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternBlue);
            titleInterceptor = (text, style) => titleArea(
              title: Text(text.toStringNonNull, style: style?.copyWith(color: Colors.white)),
              onTapMore: () => PageRestorationHelper.toProductEntryPage(
                context,
                ProductEntryPageParameter(
                  productEntryParameterMap: {
                    "type": "viral",
                    "name": {
                      Constant.textEnUsLanguageKey: "Is Viral",
                      Constant.textInIdLanguageKey: "Lagi Viral"
                    }
                  }
                )
              ),
            );
          } else if (data == Constant.carouselKeySnackForLyingAround) {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternBlue);
            titleInterceptor = (text, style) => titleArea(
              title: Text(text.toStringNonNull, style: style?.copyWith(color: Colors.white)),
              onTapMore: () => PageRestorationHelper.toProductEntryPage(
                context,
                ProductEntryPageParameter(
                  productEntryParameterMap: {
                    "category": "cemilan-buat-rebahan"
                  }
                )
              ),
            );
          } else if (data == Constant.carouselKeyProductBundleHighlight) {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternBlue);
          } else if (data == Constant.carouselKeyBestSellingInMasterBagasi) {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternBlue);
            titleInterceptor = (text, style) => titleArea(
              title: Text(text.toStringNonNull, style: style?.copyWith(color: Colors.white)),
              onTapMore: () => PageRestorationHelper.toProductEntryPage(
                context,
                ProductEntryPageParameter(
                  productEntryParameterMap: {
                    "fyp": true,
                    "name": {
                      Constant.textEnUsLanguageKey: "Bestselling in Masterbagasi",
                      Constant.textInIdLanguageKey: "Terlaris di Masterbagasi"
                    }
                  }
                )
              ),
            );
          } else if (data == Constant.carouselKeyCoffeeAndTeaOriginIndonesia) {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternBlue);
            titleInterceptor = (text, style) => titleArea(
              title: Text(text.toStringNonNull, style: style?.copyWith(color: Colors.white)),
              onTapMore: () => PageRestorationHelper.toProductEntryPage(
                context,
                ProductEntryPageParameter(
                  productEntryParameterMap: {
                    "category": "teh-kopi-asli-indonesia"
                  }
                )
              ),
            );
          } else if (data == Constant.carouselKeyBeautyProductIndonesia) {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternBlue);
            titleInterceptor = (text, style) => titleArea(
              title: Text(text.toStringNonNull, style: style?.copyWith(color: Colors.white)),
              onTapMore: () => PageRestorationHelper.toProductEntryPage(
                context,
                ProductEntryPageParameter(
                  productEntryParameterMap: {
                    "category": "produk-kecantikan-indonesia"
                  }
                )
              ),
            );
          } else if (data == Constant.carouselKeyFashionProductIndonesia) {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternBlue);
            titleInterceptor = (text, style) => titleArea(
              title: Text(text.toStringNonNull, style: style?.copyWith(color: Colors.white)),
              onTapMore: () => PageRestorationHelper.toProductEntryPage(
                context,
                ProductEntryPageParameter(
                  productEntryParameterMap: {
                    "category": "produk-fesyen-indonesia"
                  }
                )
              ),
            );
          } else {
            carouselBackground = AssetCarouselBackground(assetImageName: Constant.imagePatternGrey);
          }
          return CarouselParameterizedEntityAndListItemControllerStateMediatorParameter(
            carouselBackground: carouselBackground,
            titleInterceptor: titleInterceptor
          );
        }
      );
    widget.homeMainMenuSubController.setHomeMainMenuDelegate(
      HomeMainMenuDelegate(
        onObserveLoadProductDelegate: onObserveLoadProductDelegateFactory.generateOnObserveLoadProductDelegate(),
        onObserveSuccessLoadProductBundleHighlight: (onObserveSuccessLoadProductBundleHighlightParameter) {
          return DecoratedContainerListItemControllerState(
            padding: EdgeInsets.all(Constant.paddingListItem),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Constant.imagePatternGrey3),
                fit: BoxFit.cover,
                opacity: 0.4
              )
            ),
            decoratedChildListItemControllerState: CompoundListItemControllerState(
              listItemControllerState: [
                TitleAndDescriptionListItemControllerState(
                  title: "Save More With Bundles".tr,
                  titleAndDescriptionItemInterceptor: (padding, title, titleWidget, description, descriptionWidget, titleAndDescriptionWidget, titleAndDescriptionWidgetList) {
                    return Row(
                      children: [
                        Expanded(child: titleAndDescriptionWidget),
                        TapArea(
                          onTap: () => PageRestorationHelper.toProductBundlePage(context),
                          child: Text(
                            "More".tr,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            )
                          ),
                        )
                      ]
                    );
                  },
                  verticalSpace: 0.3.h,
                ),
                VirtualSpacingListItemControllerState(height: 3.w),
                ProductBundleHighlightListItemControllerState(
                  productBundle: onObserveSuccessLoadProductBundleHighlightParameter.productBundle,
                  onAddWishlist: (productBundleOutput) => widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.addToWishlist(productBundleOutput),
                  onRemoveWishlist: (productBundleOutput) => widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.removeFromWishlist(productBundleOutput),
                  onAddCart: (productBundleOutput) => widget.homeMainMenuSubController.wishlistAndCartControllerContentDelegate.addToCart(productBundleOutput),
                )
              ]
            )
          );
        },
        onObserveLoadingLoadProductBundleHighlight: (onObserveLoadingLoadProductBundleHighlightParameter) {
          return ShimmerCarouselListItemControllerState<ProductBundleShimmerCarouselListItemGeneratorType>(
            padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
            showTitleShimmer: true,
            showDescriptionShimmer: false,
            showItemShimmer: true,
            shimmerCarouselListItemGenerator: Injector.locator<ProductBundleShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
          );
        },
        onObserveSuccessLoadMultipleTransparentBanner: (onObserveSuccessLoadMultipleTransparentBannerParameter) {
          dynamic data = onObserveSuccessLoadMultipleTransparentBannerParameter.data;
          if (data == Constant.transparentBannerKeyMultipleHomepage) {
            return MultiBannerListItemControllerState(
              bannerList: onObserveSuccessLoadMultipleTransparentBannerParameter.transparentBannerList.map(
                (transparentBanner) => Banner(
                  id: transparentBanner.id,
                  imageUrl: transparentBanner.imageUrl
                )
              ).toList(),
              aspectRatioValue: Constant.aspectRatioValueHomepageBanner
            );
          } else if (data == Constant.transparentBannerKeyMultipleShippingPrice){
            return CompoundListItemControllerState(
              listItemControllerState: [
                MultiBannerListItemControllerState(
                  bannerList: onObserveSuccessLoadMultipleTransparentBannerParameter.transparentBannerList.map(
                    (transparentBanner) => Banner(
                      id: transparentBanner.id,
                      imageUrl: transparentBanner.imageUrl
                    )
                  ).toList(),
                  aspectRatioValue: Constant.aspectRatioValueShippingPriceBanner
                ),
                WidgetSubstitutionListItemControllerState(
                  widgetSubstitution: (BuildContext context, int index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem, vertical: 10),
                    child: Align(
                      child: SizedOutlineGradientButton(
                        width: double.infinity,
                        outlineGradientButtonType: OutlineGradientButtonType.solid,
                        onPressed: () async {
                          DialogHelper.showModalDialogPage<String, String>(
                            context: context,
                            modalDialogPageBuilder: (context, parameter) => CheckRatesForVariousCountriesModalDialogPage(
                              onGotoCountryDeliveryReview: (countryId) => PageRestorationHelper.toCountryDeliveryReviewPage(
                                countryId, context
                              ),
                            ),
                          );
                        },
                        text: "Check Rates to Other Countries".tr,
                      ),
                      alignment: Alignment.topLeft
                    )
                  )
                )
              ]
            );
          } else {
            return NoContentListItemControllerState();
          }
        },
        onObserveSuccessLoadTransparentBanner: (onObserveSuccessLoadTransparentBannerParameter) {
          return DecoratedContainerListItemControllerState(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Constant.imagePatternGrey3),
                fit: BoxFit.cover,
                opacity: 0.4
              )
            ),
            decoratedChildListItemControllerState: CompoundListItemControllerState(
              listItemControllerState: [
                VirtualSpacingListItemControllerState(height: Constant.paddingListItem),
                PaddingContainerListItemControllerState(
                  padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
                  paddingChildListItemControllerState: TitleAndDescriptionListItemControllerState(
                    title: onObserveSuccessLoadTransparentBannerParameter.title.toStringNonNull,
                    titleAndDescriptionItemInterceptor: (padding, title, titleWidget, description, descriptionWidget, titleAndDescriptionWidget, titleAndDescriptionWidgetList) {
                      return Row(
                        children: [
                          Expanded(child: titleAndDescriptionWidget),
                          TapArea(
                            onTap: () {
                              Map<String, dynamic> productEntryParameterMap = {};
                              dynamic data = onObserveSuccessLoadTransparentBannerParameter.data;
                              if (data == Constant.transparentBannerKeyKitchenContents) {
                                productEntryParameterMap = {
                                  "type": "kitchen",
                                  "name": {
                                    Constant.textEnUsLanguageKey: "Indonesian Kitchen Contents",
                                    Constant.textInIdLanguageKey: "Isi Dapur Indonesia"
                                  }
                                };
                              } else if (data == Constant.transparentBannerKeyHandycrafts) {
                                productEntryParameterMap = {
                                  "type": "handycrafts",
                                  "name": {
                                    Constant.textEnUsLanguageKey: "Handicrafts made by the Nation's Children",
                                    Constant.textInIdLanguageKey: "Kerajinan Tangan Karya Anak Bangsa"
                                  }
                                };
                              }
                              PageRestorationHelper.toProductEntryPage(
                                context,
                                ProductEntryPageParameter(
                                  productEntryParameterMap: productEntryParameterMap
                                )
                              );
                            },
                            child: Text(
                              "More".tr,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                              )
                            ),
                          )
                        ]
                      );
                    },
                    verticalSpace: 0.3.h,
                  ),
                ),
                VirtualSpacingListItemControllerState(height: 3.w),
                WidgetSubstitutionListItemControllerState(
                  widgetSubstitution: (context, index) {
                    AspectRatioValue aspectRatioValue = Constant.aspectRatioValueTransparentBanner;
                    double height = MediaQuery.of(context).size.width * aspectRatioValue.height / aspectRatioValue.width;
                    return SizedBox(
                      width: double.infinity,
                      height: height,
                      child: TransparentBannerModifiedCachedNetworkImage(
                        imageUrl: onObserveSuccessLoadTransparentBannerParameter.transparentBanner.imageUrl,
                      ),
                    );
                  }
                )
              ]
            )
          );
        },
        onObserveLoadingLoadTransparentBanner: (onObserveLoadingLoadTransparentBannerParameter) {
          return ShimmerCarouselListItemControllerState<ProductBundleShimmerCarouselListItemGeneratorType>(
            padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
            showTitleShimmer: true,
            showDescriptionShimmer: false,
            showItemShimmer: true,
            shimmerCarouselListItemGenerator: Injector.locator<ProductBundleShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
          );
        },
        onObserveLoadCurrentAddress: (onObserveLoadCurrentAddressParameter) {
          MainRouteObserver.onRefreshAddress = onObserveLoadCurrentAddressParameter.repeatableDynamicItemCarouselAdditionalParameter.onRepeatLoading;
          return DeliveryToListItemControllerState(
            addressLoadDataResult: onObserveLoadCurrentAddressParameter.addressLoadDataResult,
            errorProvider: Injector.locator<ErrorProvider>(),
            onAddressSelectedChanged: (address) {
              onObserveLoadCurrentAddressParameter.repeatableDynamicItemCarouselAdditionalParameter.onRepeatLoading();
            }
          );
        }
      )
    );
    return BackgroundAppBarScaffold(
      backgroundAppBarImage: _homeAppBarBackgroundAssetImage,
      appBar: MainMenuSearchAppBar(value: 0.0),
      body: Expanded(
        child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
          pagingControllerState: _homeMainMenuSubListItemPagingControllerState,
          onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
            pagingControllerState: pagingControllerState!
          ),
          pullToRefresh: true
        ),
      ),
    );
  }
}