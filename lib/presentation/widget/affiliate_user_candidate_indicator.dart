import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/error_provider_ext.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/presentation/widget/profile_picture_cache_network_image.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/user/user.dart';
import '../../misc/constant.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/load_data_result.dart';
import 'icon_title_and_description_list_item.dart';

class AffiliateUserCandidateIndicator extends StatelessWidget {
  final LoadDataResult<User> userLoadDataResult;
  final ErrorProvider errorProvider;

  const AffiliateUserCandidateIndicator({
    super.key,
    required this.userLoadDataResult,
    required this.errorProvider
  });

  @override
  Widget build(BuildContext context) {
    String title = "";
    String description = "";
    String profileImageUrl = "";
    String noName = "No Name".tr;
    if (userLoadDataResult.isLoading) {
      String loading = "(${Constant.textLoading})";
      title = loading;
      description = loading;
    } else if (userLoadDataResult.isSuccess) {
      User user = userLoadDataResult.resultIfSuccess!;
      title = user.name.isEmptyString ? user.name.toStringNonNullWithCustomText(text: noName) : user.name.toStringNonNullWithCustomText(text: noName);
      description = user.email.toStringNonNullWithCustomText(text: "No Email".tr);
      profileImageUrl = user.userProfile.avatar.toEmptyStringNonNull;
    } else if (userLoadDataResult.isFailed) {
      ErrorProviderResult errorProviderResult = errorProvider.onGetErrorProviderResult(userLoadDataResult.resultIfFailed!).toErrorProviderResultNonNull();
      title = errorProviderResult.title;
      description = errorProviderResult.message;
    }
    return Padding(
      // Use padding widget for avoiding shadow elevation overlap.
      padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 3,
        child: InkWell(
          onTap: null,
          child: Padding(
            padding: EdgeInsets.all(Constant.paddingListItem),
            child: Row(
              children: [
                Expanded(
                  child: IconTitleAndDescriptionListItem(
                    title: title,
                    description: description,
                    space: 4.w,
                    verticalSpace: (0.5).h,
                    icon: ProfilePictureCacheNetworkImage(
                      profileImageUrl: profileImageUrl,
                      dimension: 10.w,
                    ),
                  ),
                ),
              ]
            ),
          )
        ),
      )
    );
  }
}