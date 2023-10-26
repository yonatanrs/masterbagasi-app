import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/domain/dummy/addressdummy/country_dummy.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../controller/country_delivery_review_controller.dart';
import '../../domain/entity/delivery/country_delivery_review_based_country_parameter.dart';
import '../../domain/entity/delivery/country_delivery_review_header_content.dart';
import '../../domain/entity/delivery/country_delivery_review_response.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../domain/usecase/get_country_delivery_review_use_case.dart';
import '../../misc/constant.dart';
import '../../misc/controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_header_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_media_short_content_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_select_country_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/error/message_error.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../widget/background_app_bar_scaffold.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modifiedappbar/main_menu_search_app_bar.dart';
import 'country_delivery_review_media_view_page.dart';
import 'getx_page.dart';

class CountryDeliveryReviewPage extends RestorableGetxPage<_CountryDeliveryReviewPageRestoration> {
  final String countryId;

  late final ControllerMember<CountryDeliveryReviewController> _countryDeliveryReviewController = ControllerMember<CountryDeliveryReviewController>().addToControllerManager(controllerManager);

  CountryDeliveryReviewPage({
    Key? key,
    required this.countryId
  }) : super(
    key: key,
    pageRestorationId: () => "country-delivery-review-page"
  );

  @override
  void onSetController() {
    _countryDeliveryReviewController.controller = GetExtended.put<CountryDeliveryReviewController>(
      CountryDeliveryReviewController(
        controllerManager,
        Injector.locator<GetCountryDeliveryReviewUseCase>()
      ),
      tag: pageName
    );
  }

  @override
  _CountryDeliveryReviewPageRestoration createPageRestoration() => _CountryDeliveryReviewPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulCountryDeliveryReviewControllerMediatorWidget(
      countryDeliveryReviewController: _countryDeliveryReviewController.controller,
      countryId: countryId,
    );
  }
}

class _CountryDeliveryReviewPageRestoration extends MixableGetxPageRestoration with CountryDeliveryReviewPageRestorationMixin, CountryDeliveryReviewMediaViewPageRestorationMixin {
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

class CountryDeliveryReviewPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final String countryId;

  CountryDeliveryReviewPageGetPageBuilderAssistant({
    required this.countryId
  });

  @override
  GetPageBuilder get pageBuilder => (() => CountryDeliveryReviewPage(
    countryId: countryId
  ));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(
    CountryDeliveryReviewPage(
      countryId: countryId
    )
  ));
}

mixin CountryDeliveryReviewPageRestorationMixin on MixableGetxPageRestoration {
  late CountryDeliveryReviewPageRestorableRouteFuture countryDeliveryReviewPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    countryDeliveryReviewPageRestorableRouteFuture = CountryDeliveryReviewPageRestorableRouteFuture(
      restorationId: restorationIdWithPageName('country-delivery-review-route')
    );
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    countryDeliveryReviewPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    countryDeliveryReviewPageRestorableRouteFuture.dispose();
  }
}

class CountryDeliveryReviewPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  CountryDeliveryReviewPageRestorableRouteFuture({
    required String restorationId
  }) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      }
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    if (arguments is! String) {
      throw MessageError(message: "Arguments must be a String");
    }
    return GetExtended.toWithGetPageRouteReturnValue<String?>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        CountryDeliveryReviewPageGetPageBuilderAssistant(
          countryId: arguments
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

class _StatefulCountryDeliveryReviewControllerMediatorWidget extends StatefulWidget {
  final CountryDeliveryReviewController countryDeliveryReviewController;
  final String countryId;

  const _StatefulCountryDeliveryReviewControllerMediatorWidget({
    required this.countryDeliveryReviewController,
    required this.countryId
  });

  @override
  State<_StatefulCountryDeliveryReviewControllerMediatorWidget> createState() => _StatefulCountryDeliveryReviewControllerMediatorWidgetState();
}

class _StatefulCountryDeliveryReviewControllerMediatorWidgetState extends State<_StatefulCountryDeliveryReviewControllerMediatorWidget> {
  late AssetImage _countryDeliveryReviewAppBarBackgroundAssetImage;
  late final ModifiedPagingController<int, ListItemControllerState> _countryDeliveryReviewListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _countryDeliveryReviewListItemPagingControllerState;

  late String _currentSelectedCountryId;

  @override
  void initState() {
    super.initState();
    _currentSelectedCountryId = widget.countryId;
    _countryDeliveryReviewAppBarBackgroundAssetImage = AssetImage(Constant.imagePatternFeedMainMenuAppBar);
    _countryDeliveryReviewListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.countryDeliveryReviewController.apiRequestManager,
    );
    _countryDeliveryReviewListItemPagingControllerState = PagingControllerState(
      pagingController: _countryDeliveryReviewListItemPagingController,
      isPagingControllerExist: false
    );
    _countryDeliveryReviewListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _countryDeliveryReviewListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _countryDeliveryReviewListItemPagingControllerState.isPagingControllerExist = true;
  }

  @override
  void didChangeDependencies() {
    precacheImage(_countryDeliveryReviewAppBarBackgroundAssetImage, context);
    super.didChangeDependencies();
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _countryDeliveryReviewListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    LoadDataResult<CountryDeliveryReviewResponse> countryDeliveryReviewResponseLoadDataResult = await widget.countryDeliveryReviewController.getCountryDeliveryReview(
      CountryDeliveryReviewBasedCountryParameter(
        countryId: _currentSelectedCountryId
      )
    );
    return countryDeliveryReviewResponseLoadDataResult.map<PagingResult<ListItemControllerState>>((countryDeliveryReviewResponse) {
      return PagingDataResult<ListItemControllerState>(
        itemList: [
          CountryDeliveryReviewContainerListItemControllerState(
            countryDeliveryReviewList: countryDeliveryReviewResponse.countryDeliveryReviewList,
            onUpdateState: () => setState(() {}),
            errorProvider: Injector.locator<ErrorProvider>(),
            getCountryDeliveryReviewHeaderListItemControllerState: () => CountryDeliveryReviewHeaderListItemControllerState(
              countryDeliveryReviewHeaderContent: CountryDeliveryReviewHeaderContent(
                countryName: countryDeliveryReviewResponse.name,
                rating: countryDeliveryReviewResponse.avgRating,
                reviewCount: countryDeliveryReviewResponse.countryDeliveryReviewList.length,
                backgroundImageUrl: countryDeliveryReviewResponse.image.toEmptyStringNonNull
              )
            ),
            getCountryDeliveryReviewMediaShortContentListItemControllerState: () => CountryDeliveryReviewMediaShortContentListItemControllerState(
              countryDeliveryReviewMediaList: () {
                List<CountryDeliveryReviewMedia> countryDeliveryReviewMediaList = [];
                for (var countryDeliveryReview in countryDeliveryReviewResponse.countryDeliveryReviewList) {
                  countryDeliveryReviewMediaList.addAll(countryDeliveryReview.countryDeliveryReviewMedia);
                }
                return countryDeliveryReviewMediaList;
              }()
            ),
            getCountryDeliveryReviewSelectCountryListItemControllerState: () => CountryDeliveryReviewSelectCountryListItemControllerState(
              selectedCountry: Injector.locator<CountryDummy>().generateDefaultDummy()..id = _currentSelectedCountryId,
              onSelectCountry: (country) {
                _currentSelectedCountryId = country.id;
                _countryDeliveryReviewListItemPagingController.refresh();
              }
            )
          )
        ],
        page: 1,
        totalPage: 1,
        totalItem: 1
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundAppBarScaffold(
      backgroundAppBarImage: _countryDeliveryReviewAppBarBackgroundAssetImage,
      appBar: MainMenuSearchAppBar(value: 0.0),
      body: Expanded(
        child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
          pagingControllerState: _countryDeliveryReviewListItemPagingControllerState,
          onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
            pagingControllerState: pagingControllerState!
          ),
          pullToRefresh: true
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}