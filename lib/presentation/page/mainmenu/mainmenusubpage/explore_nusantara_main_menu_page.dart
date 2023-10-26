import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'dart:math' as math;

import '../../../../controller/mainmenucontroller/mainmenusubpagecontroller/explore_nusantara_main_menu_sub_controller.dart';
import '../../../../domain/entity/province/province_map.dart';
import '../../../../misc/constant.dart';
import '../../../../misc/controllerstate/explore_nusantara_main_menu_controller_state.dart';
import '../../../../misc/custompainter/explore_nusantara_map_custom_painter.dart';
import '../../../../misc/errorprovider/error_provider.dart';
import '../../../../misc/injector.dart';
import '../../../../misc/load_data_result.dart';
import '../../../../misc/main_route_observer.dart';
import '../../../../misc/manager/controller_manager.dart';
import '../../../../misc/page_restoration_helper.dart';
import '../../../widget/background_app_bar_scaffold.dart';
import '../../../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../../../widget/loaddataresultimplementer/load_data_result_implementer.dart';
import '../../../widget/modified_canvas_touch_detector.dart';
import '../../../widget/modified_svg_picture.dart';
import '../../../widget/modifiedappbar/main_menu_search_app_bar.dart';
import '../../../widget/modifiedcachednetworkimage/explore_nusantara_background_modified_cached_network_image.dart';
import '../../../widget/modifiedcachednetworkimage/explore_nusantara_modified_cached_network_image.dart';
import '../../../widget/rx_consumer.dart';
import '../../../widget/tap_area.dart';
import '../../getx_page.dart';
import '../../product_entry_page.dart';

class ExploreNusantaraMainMenuSubPage extends DefaultGetxPage {
  late final ControllerMember<ExploreNusantaraMainMenuSubController> _exploreNusantaraMainMenuSubController = ControllerMember<ExploreNusantaraMainMenuSubController>().addToControllerManager(controllerManager);
  final String ancestorPageName;

  ExploreNusantaraMainMenuSubPage({Key? key, required this.ancestorPageName}) : super(key: key);

  @override
  void onSetController() {
    _exploreNusantaraMainMenuSubController.controller = Injector.locator<ExploreNusantaraMainMenuSubControllerInjectionFactory>().inject(controllerManager, ancestorPageName);
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulExploreNusantaraMainMenuSubControllerMediatorWidget(
      exploreNusantaraMainMenuSubController: _exploreNusantaraMainMenuSubController.controller
    );
  }
}

class _StatefulExploreNusantaraMainMenuSubControllerMediatorWidget extends StatefulWidget {
  final ExploreNusantaraMainMenuSubController exploreNusantaraMainMenuSubController;

  const _StatefulExploreNusantaraMainMenuSubControllerMediatorWidget({
    required this.exploreNusantaraMainMenuSubController
  });

  @override
  State<_StatefulExploreNusantaraMainMenuSubControllerMediatorWidget> createState() => _StatefulExploreNusantaraMainMenuSubControllerMediatorWidgetState();
}

class _StatefulExploreNusantaraMainMenuSubControllerMediatorWidgetState extends State<_StatefulExploreNusantaraMainMenuSubControllerMediatorWidget> {
  late AssetImage _exploreNusantaraAppBarBackgroundAssetImage;

  @override
  void initState() {
    super.initState();
    _exploreNusantaraAppBarBackgroundAssetImage = AssetImage(Constant.imagePatternExploreNusantaraMainMenuAppBar);
    MainRouteObserver.controllerMediatorMap[Constant.subPageKeyExploreNusantaraMainMenu] = refreshExploreNusantaraMainMenu;
  }

  @override
  void didChangeDependencies() {
    precacheImage(_exploreNusantaraAppBarBackgroundAssetImage, context);
    super.didChangeDependencies();
  }

  void refreshExploreNusantaraMainMenu() {
    // Nothing
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.exploreNusantaraMainMenuSubController.loadProvinceMap();
    });
    return BackgroundAppBarScaffold(
      backgroundAppBarImage: _exploreNusantaraAppBarBackgroundAssetImage,
      appBar: MainMenuSearchAppBar(value: 0.0),
      body: Expanded(
        child: Stack(
          children: [
            RxConsumer<ExploreNusantaraMainMenuControllerState>(
              rxValue: widget.exploreNusantaraMainMenuSubController.exploreNusantaraMainMenuControllerStateRx,
              onConsumeValue: (context, value) {
                if (value.provinceMapListLoadDataResult.isSuccess) {
                  return Stack(
                    children: [
                      Builder(
                        builder: (context) {
                          ProvinceMap provinceMap = value.selectedProvinceMap!;
                          String banner = provinceMap.bannerMobile.isNotEmptyString ? provinceMap.bannerMobile.toEmptyStringNonNull : provinceMap.bannerDesktop.toEmptyStringNonNull;
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AspectRatio(
                              aspectRatio: Constant.aspectRatioValueExploreNusantaraBanner.toDouble(),
                              child: ExploreNusantaraBackgroundModifiedCachedNetworkImage(imageUrl: banner),
                            ),
                          );
                        }
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: AspectRatio(
                            aspectRatio: Constant.aspectRatioValueExploreNusantaraBackground.toDouble(),
                            child: ExploreNusantaraBackgroundModifiedCachedNetworkImage(
                              imageUrl: value.selectedProvinceMap!.background.toEmptyStringNonNull
                            ),
                          ),
                        ),
                      ),
                    ]
                  );
                } else {
                  return Container();
                }
              }
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).canvasColor.withOpacity(0.0),
                      Theme.of(context).canvasColor,
                      Theme.of(context).canvasColor,
                      Theme.of(context).canvasColor.withOpacity(0.0),
                    ],
                    stops: const [
                      0.0, 0.2, 0.8, 1.0
                    ]
                  )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome To Nusantara".tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  RxConsumer<ExploreNusantaraMainMenuControllerState>(
                    rxValue: widget.exploreNusantaraMainMenuSubController.exploreNusantaraMainMenuControllerStateRx,
                    onConsumeValue: (context, value) => LoadDataResultImplementer<List<ProvinceMap>>(
                      loadDataResult: value.provinceMapListLoadDataResult,
                      errorProvider: Injector.locator<ErrorProvider>(),
                      onSuccessLoadDataResultWidget: (provinceMapList) {
                        double width = MediaQuery.of(context).size.width;
                        double height = width * 350.0 / 1000.0;
                        return SizedBox(
                          width: width,
                          height: height,
                          child: ModifiedCanvasTouchDetector(
                            builder: (context) => CustomPaint(
                              painter: ExploreNusantaraMapCustomPainter(
                                context: context,
                                provinceMapList: provinceMapList,
                                selectedProvinceMap: value.selectedProvinceMap,
                                onSelectProvinceMap: (provinceMap) {
                                  widget.exploreNusantaraMainMenuSubController.selectProvinceMap(provinceMap);
                                },
                              )
                            )
                          )
                        );
                      }
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  RxConsumer<ExploreNusantaraMainMenuControllerState>(
                    rxValue: widget.exploreNusantaraMainMenuSubController.exploreNusantaraMainMenuControllerStateRx,
                    onConsumeValue: (context, value) {
                      if (value.provinceMapListLoadDataResult.isSuccess) {
                        return Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: ExploreNusantaraModifiedCachedNetworkImage(
                                imageUrl: value.selectedProvinceMap!.icon.toEmptyStringNonNull
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                              child: SizedBox(
                                height: 45,
                                child: Stack(
                                  children: [
                                    IgnorePointer(
                                      child: SizedOutlineGradientButton(
                                        onPressed: () {},
                                        text: "",
                                        outlineGradientButtonType: OutlineGradientButtonType.solid,
                                        outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          child: TapArea(
                                            onTap: () => widget.exploreNusantaraMainMenuSubController.previousProvinceMap(),
                                            child: Transform.rotate(
                                              angle: -math.pi,
                                              child: ModifiedSvgPicture.asset(
                                                Constant.vectorArrow,
                                                color: Colors.white,
                                                height: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TapArea(
                                            onTap: () => PageRestorationHelper.toProductEntryPage(
                                              context,
                                              ProductEntryPageParameter(
                                                productEntryParameterMap: {
                                                  "province": value.selectedProvinceMap!.slug,
                                                  "province_id": value.selectedProvinceMap!.id
                                                }
                                              )
                                            ),
                                            child: Center(
                                              child: Text(
                                                value.selectedProvinceMap!.name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                                )
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                          child: TapArea(
                                            onTap: () => widget.exploreNusantaraMainMenuSubController.nextProvinceMap(),
                                            child: ModifiedSvgPicture.asset(
                                              Constant.vectorArrow,
                                              color: Colors.white,
                                              height: 10,
                                            ),
                                          )
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ]
                        );
                      } else {
                        return Container();
                      }
                    }
                  )
                ]
              )
            ),
          ]
        ),
      ),
    );
  }
}