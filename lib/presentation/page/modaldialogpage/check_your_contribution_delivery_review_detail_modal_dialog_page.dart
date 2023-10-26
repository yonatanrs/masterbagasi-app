import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/modaldialogcontroller/check_your_contribution_delivery_review_detail_modal_dialog_controller.dart';
import '../../../domain/entity/delivery/check_your_contribution_delivery_review_detail_response.dart';
import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/get_check_your_contribution_delivery_review_detail_use_case.dart';
import '../../../domain/usecase/get_user_use_case.dart';
import '../../../misc/constant.dart';
import '../../../misc/date_util.dart';
import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/injector.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/multi_language_string.dart';
import '../../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../../widget/loaddataresultimplementer/load_data_result_implementer.dart';
import '../../widget/modified_svg_picture.dart';
import '../../widget/rx_consumer.dart';
import 'modal_dialog_page.dart';

class CheckYourContributionDeliveryReviewDetailModalDialogPage extends ModalDialogPage<CheckYourContributionDeliveryReviewDetailModalDialogController> {
  CheckYourContributionDeliveryReviewDetailModalDialogController get checkYourContributionDeliveryReviewDetailModalDialogController => modalDialogController.controller;

  CheckYourContributionDeliveryReviewDetailModalDialogPage({super.key});

  @override
  CheckYourContributionDeliveryReviewDetailModalDialogController onCreateModalDialogController() {
    return CheckYourContributionDeliveryReviewDetailModalDialogController(
      controllerManager,
      Injector.locator<GetUserUseCase>(),
      Injector.locator<GetCheckYourContributionDeliveryReviewDetailUseCase>()
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulCheckYourContributionDeliveryReviewDetailControllerMediatorWidget(
      checkYourContributionDeliveryReviewDetailModalDialogController: checkYourContributionDeliveryReviewDetailModalDialogController
    );
  }
}

class _StatefulCheckYourContributionDeliveryReviewDetailControllerMediatorWidget extends StatefulWidget {
  final CheckYourContributionDeliveryReviewDetailModalDialogController checkYourContributionDeliveryReviewDetailModalDialogController;

  const _StatefulCheckYourContributionDeliveryReviewDetailControllerMediatorWidget({
    required this.checkYourContributionDeliveryReviewDetailModalDialogController
  });

  @override
  State<_StatefulCheckYourContributionDeliveryReviewDetailControllerMediatorWidget> createState() => _StatefulCheckYourContributionDeliveryReviewDetailControllerMediatorWidgetState();
}

class _StatefulCheckYourContributionDeliveryReviewDetailControllerMediatorWidgetState extends State<_StatefulCheckYourContributionDeliveryReviewDetailControllerMediatorWidget> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.checkYourContributionDeliveryReviewDetailModalDialogController.initAll();
    });
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          RxConsumer<LoadDataResultWrapper<User>>(
            rxValue: widget.checkYourContributionDeliveryReviewDetailModalDialogController.userLoadDataResultWrapperRx,
            onConsumeValue: (context, value) => LoadDataResultImplementer<User>(
              loadDataResult: value.loadDataResult,
              errorProvider: Injector.locator<ErrorProvider>(),
              onSuccessLoadDataResultWidget: (user) {
                String userName = user.name;
                String joinedDate = DateUtil.standardDateFormat4.format(user.createdAt);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      MultiLanguageString({
                        Constant.textEnUsLanguageKey: "Hello, $userName",
                        Constant.textInIdLanguageKey: "Hai, $userName"
                      }).toEmptyStringNonNull,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    const SizedBox(height: 10),
                    Text(
                      MultiLanguageString({
                        Constant.textEnUsLanguageKey: "You've joined since, $joinedDate",
                        Constant.textInIdLanguageKey: "Kamu sudah bergabung sejak, $joinedDate"
                      }).toEmptyStringNonNull
                    ),
                  ]
                );
              }
            )
          ),
          const SizedBox(height: 20),
          RxConsumer<LoadDataResultWrapper<CheckYourContributionDeliveryReviewDetailResponse>>(
            rxValue: widget.checkYourContributionDeliveryReviewDetailModalDialogController.checkYourContributionDeliveryReviewDetailResponseLoadDataResultWrapperRx,
            onConsumeValue: (context, value) => LoadDataResultImplementer<CheckYourContributionDeliveryReviewDetailResponse>(
              loadDataResult: value.loadDataResult,
              errorProvider: Injector.locator<ErrorProvider>(),
              onSuccessLoadDataResultWidget: (checkYourContributionDeliveryReviewDetailResponse) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Column(
                    children: [
                      Text(
                        MultiLanguageString({
                          Constant.textEnUsLanguageKey: "This year, you have helped other buyers by providing:",
                          Constant.textInIdLanguageKey: "Di tahun ini, kamu sudah membantu pembeli lainnya dengan memberikan:"
                        }).toEmptyStringNonNull
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                ModifiedSvgPicture.asset(
                                  Constant.vectorCheckYourContributionDeliveryReviewRating,
                                  overrideDefaultColorWithSingleColor: false
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  checkYourContributionDeliveryReviewDetailResponse.ratingCount.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text("Rating".tr)
                              ],
                            )
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ModifiedSvgPicture.asset(
                                  Constant.vectorCheckYourContributionDeliveryReviewFullReview,
                                  overrideDefaultColorWithSingleColor: false
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  checkYourContributionDeliveryReviewDetailResponse.fullReviewCount.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text("Full Review".tr)
                              ],
                            )
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ModifiedSvgPicture.asset(
                                  Constant.vectorCheckYourContributionDeliveryReviewPhotoAndVideo,
                                  overrideDefaultColorWithSingleColor: false
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  checkYourContributionDeliveryReviewDetailResponse.photoAndVideoCount.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text("Photo & Video".tr)
                              ],
                            )
                          )
                        ]
                      ),
                      const SizedBox(height: 15),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: MultiLanguageString({
                                Constant.textEnUsLanguageKey: "There are still items waiting to be reviewed. Give the review now, come on!",
                                Constant.textInIdLanguageKey: "Masih ada barang yang menunggu untuk diulas nih. Kasih ulasannya sekarang, yuk!"
                              }).toEmptyStringNonNull
                            ),
                          ]
                        )
                      ),
                      const SizedBox(height: 15),
                      SizedOutlineGradientButton(
                        onPressed: () => Get.back(),
                        text: "Give Review".tr,
                        outlineGradientButtonType: OutlineGradientButtonType.solid,
                        outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                        customPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                      ),
                    ]
                  )
                );
              }
            )
          )
        ]
      )
    );
  }
}