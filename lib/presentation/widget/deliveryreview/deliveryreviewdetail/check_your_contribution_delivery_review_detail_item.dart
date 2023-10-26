import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../../../domain/entity/user/user.dart';
import '../../../../misc/constant.dart';
import '../../../../misc/errorprovider/error_provider.dart';
import '../../../../misc/load_data_result.dart';
import '../../loaddataresultimplementer/load_data_result_implementer_directly.dart';
import '../../modified_shimmer.dart';
import '../../modified_svg_picture.dart';
import '../../profile_picture_cache_network_image.dart';

class CheckYourContributionDeliveryReviewDetailItem extends StatelessWidget {
  final LoadDataResult<User> userLoadDataResult;
  final ErrorProvider errorProvider;
  final void Function()? onTap;

  const CheckYourContributionDeliveryReviewDetailItem({
    super.key,
    required this.userLoadDataResult,
    required this.errorProvider,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(8.0);
    return SizedBox(
      child: Padding(
        // Use padding widget for avoiding shadow elevation overlap.
        padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
        child: Material(
          borderRadius: borderRadius,
          elevation: 3,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: borderRadius
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadDataResultImplementerDirectly(
                    loadDataResult: userLoadDataResult,
                    errorProvider: errorProvider,
                    onImplementLoadDataResultDirectly: (userLoadDataResultOutput, errorProviderOutput) {
                      double dimension = 40.0;
                      if (userLoadDataResultOutput.isLoading) {
                        return ModifiedShimmer.fromColors(
                          child: ProfilePictureCacheNetworkImage(
                            profileImageUrl: "",
                            dimension: dimension,
                          ),
                        );
                      } else if (userLoadDataResultOutput.isSuccess) {
                        User resultUser = userLoadDataResultOutput.resultIfSuccess!;
                        return ProfilePictureCacheNetworkImage(
                          profileImageUrl: resultUser.userProfile.avatar,
                          dimension: dimension,
                        );
                      } else {
                        return ProfilePictureCacheNetworkImage(
                          profileImageUrl: "",
                          dimension: dimension,
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${"Check your contribution in".tr} ${DateTime.now().year}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text("You have been help many people with your review!".tr),
                      ],
                    ),
                  ),
                  ModifiedSvgPicture.asset(
                    Constant.vectorArrow,
                    height: 12,
                    color: Colors.black,
                  ),
                ],
              )
            )
          )
        ),
      )
    );
  }
}