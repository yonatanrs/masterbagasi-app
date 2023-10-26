import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../../controller/mainmenucontroller/mainmenusubpagecontroller/feed_main_menu_sub_controller.dart';
import '../../../../domain/entity/video/defaultvideo/default_video.dart';
import '../../../../domain/entity/video/shortvideo/short_video.dart';
import '../../../../misc/additionalloadingindicatorchecker/feed_sub_additional_paging_result_parameter_checker.dart';
import '../../../../misc/constant.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/load_data_result_dynamic_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/no_content_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/videocarousellistitemcontrollerstate/default_video_carousel_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/videocarousellistitemcontrollerstate/short_video_carousel_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../../../../misc/controllerstate/paging_controller_state.dart';
import '../../../../misc/entityandlistitemcontrollerstatemediator/horizontal_component_entity_parameterized_entity_and_list_item_controller_state_mediator.dart';
import '../../../../misc/injector.dart';
import '../../../../misc/load_data_result.dart';
import '../../../../misc/main_route_observer.dart';
import '../../../../misc/manager/controller_manager.dart';
import '../../../../misc/on_observe_load_product_delegate.dart';
import '../../../../misc/paging/modified_paging_controller.dart';
import '../../../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../../misc/paging/pagingresult/paging_result.dart';
import '../../../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/horizontal_dynamic_item_carousel_parametered_component_entity_and_list_item_controller_state_mediator_parameter.dart';
import '../../../widget/background_app_bar_scaffold.dart';
import '../../../widget/modified_paged_list_view.dart';
import '../../../widget/modifiedappbar/main_menu_search_app_bar.dart';
import '../../getx_page.dart';

class FeedMainMenuSubPage extends DefaultGetxPage {
  late final ControllerMember<FeedMainMenuSubController> _feedMainMenuSubController = ControllerMember<FeedMainMenuSubController>().addToControllerManager(controllerManager);
  final String ancestorPageName;

  FeedMainMenuSubPage({Key? key, required this.ancestorPageName}) : super(key: key, systemUiOverlayStyle: SystemUiOverlayStyle.light);

  @override
  void onSetController() {
    _feedMainMenuSubController.controller = Injector.locator<FeedMainMenuSubControllerInjectionFactory>().inject(controllerManager, ancestorPageName);
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulFeedMainMenuSubControllerMediatorWidget(
      feedMainMenuSubController: _feedMainMenuSubController.controller
    );
  }
}

class _StatefulFeedMainMenuSubControllerMediatorWidget extends StatefulWidget {
  final FeedMainMenuSubController feedMainMenuSubController;

  const _StatefulFeedMainMenuSubControllerMediatorWidget({
    required this.feedMainMenuSubController
  });

  @override
  State<_StatefulFeedMainMenuSubControllerMediatorWidget> createState() => _StatefulFeedMainMenuSubControllerMediatorWidgetState();
}

class _StatefulFeedMainMenuSubControllerMediatorWidgetState extends State<_StatefulFeedMainMenuSubControllerMediatorWidget> {
  late AssetImage _feedAppBarBackgroundAssetImage;
  late final ModifiedPagingController<int, ListItemControllerState> _feedMainMenuSubListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _feedMainMenuSubListItemPagingControllerState;
  final List<BaseLoadDataResultDynamicListItemControllerState> _dynamicItemLoadDataResultDynamicListItemControllerStateList = [];

  @override
  void initState() {
    super.initState();
    _feedAppBarBackgroundAssetImage = AssetImage(Constant.imagePatternFeedMainMenuAppBar);
    _feedMainMenuSubListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.feedMainMenuSubController.apiRequestManager,
      additionalPagingResultParameterChecker: Injector.locator<FeedSubAdditionalPagingResultParameterChecker>()
    );
    _feedMainMenuSubListItemPagingControllerState = PagingControllerState(
      pagingController: _feedMainMenuSubListItemPagingController,
      isPagingControllerExist: false
    );
    _feedMainMenuSubListItemPagingControllerState.pagingController.addPageRequestListenerForLoadDataResult(
      listener: _feedMainMenuListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _feedMainMenuSubListItemPagingControllerState.isPagingControllerExist = true;
    MainRouteObserver.controllerMediatorMap[Constant.subPageKeyFeedMainMenu] = refreshFeedMainMenu;
  }

  @override
  void didChangeDependencies() {
    precacheImage(_feedAppBarBackgroundAssetImage, context);
    super.didChangeDependencies();
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _feedMainMenuListItemPagingControllerStateListener(int pageKey) async {
    HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator componentEntityMediator = Injector.locator<HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator>();
    HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter carouselParameterizedEntityMediator = HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter(
      onSetState: () => setState(() {}),
      dynamicItemLoadDataResultDynamicListItemControllerStateList: _dynamicItemLoadDataResultDynamicListItemControllerStateList
    );
    return SuccessLoadDataResult<PagingResult<ListItemControllerState>>(
      value: PagingDataResult<ListItemControllerState>(
        page: 1,
        totalPage: 1,
        totalItem: 1,
        itemList: [
          componentEntityMediator.mapWithParameter(
            widget.feedMainMenuSubController.getShortVideoFeed(),
            parameter: carouselParameterizedEntityMediator
          ),
          VirtualSpacingListItemControllerState(height: 20),
          componentEntityMediator.mapWithParameter(
            widget.feedMainMenuSubController.getDeliveryReviewList(),
            parameter: carouselParameterizedEntityMediator
          ),
          VirtualSpacingListItemControllerState(height: 20),
          componentEntityMediator.mapWithParameter(
            widget.feedMainMenuSubController.getNewsList(),
            parameter: carouselParameterizedEntityMediator
          ),
          VirtualSpacingListItemControllerState(height: 20),
          componentEntityMediator.mapWithParameter(
            widget.feedMainMenuSubController.getTripDefaultVideoFeed(),
            parameter: carouselParameterizedEntityMediator
          ),
        ]
      )
    );
  }

  void refreshFeedMainMenu() {
    _feedMainMenuSubListItemPagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    OnObserveLoadProductDelegateFactory onObserveLoadProductDelegateFactory = Injector.locator<OnObserveLoadProductDelegateFactory>();
    widget.feedMainMenuSubController.setFeedMainMenuSubDelegate(
      FeedMainMenuSubDelegate(
        onObserveLoadProductDelegate: onObserveLoadProductDelegateFactory.generateOnObserveLoadProductDelegate(),
        onObserveLoadShortVideoDirectly: (onObserveLoadShortVideoDirectlyParameter) {
          LoadDataResult<List<ShortVideo>> shortVideoListLoadDataResult = onObserveLoadShortVideoDirectlyParameter.shortVideoListLoadDataResult;
          return ShortVideoCarouselListItemControllerState(
            shortVideoListLoadDataResult: shortVideoListLoadDataResult
          );
        },
        onObserveLoadTripDefaultVideoDirectly: (onObserveLoadTripDefaultVideoDirectlyParameter) {
          LoadDataResult<List<DefaultVideo>> defaultVideoListLoadDataResult = onObserveLoadTripDefaultVideoDirectlyParameter.tripDefaultVideoListLoadDataResult;
          return DefaultVideoCarouselListItemControllerState(
            defaultVideoListLoadDataResult: defaultVideoListLoadDataResult
          );
        }
      )
    );
    return BackgroundAppBarScaffold(
      backgroundAppBarImage: _feedAppBarBackgroundAssetImage,
      appBar: MainMenuSearchAppBar(value: 0.0),
      body: Expanded(
        child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
          pagingControllerState: _feedMainMenuSubListItemPagingControllerState,
          onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
            pagingControllerState: pagingControllerState!
          ),
          pullToRefresh: true
        ),
      ),
    );
  }
}