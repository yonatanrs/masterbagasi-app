import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/error_provider_ext.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/user/user.dart';
import '../../misc/constant.dart';
import '../../misc/dialog_helper.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/load_data_result.dart';
import '../../misc/page_restoration_helper.dart';
import 'icon_title_and_description_list_item.dart';
import 'modified_svg_picture.dart';
import 'profile_picture_cache_network_image.dart';

class MenuProfileHeader extends StatelessWidget {
  final LoadDataResult<User> userLoadDataResult;
  final ErrorProvider errorProvider;

  const MenuProfileHeader({
    Key? key,
    required this.userLoadDataResult,
    required this.errorProvider
  }) : super(key: key);

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
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            onTap: userLoadDataResult.isLoading ? null : () {},
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
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  onTap: () => PageRestorationHelper.toMsmePartnerPage(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            "Become a MSME Partner".tr,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                        const SizedBox(width: 10),
                        ModifiedSvgPicture.asset(
                          Constant.vectorArrow,
                          height: 10,
                        ),
                      ]
                    ),
                  )
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  onTap: () => PageRestorationHelper.toAffiliatePage(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Register MB Affiliation".tr,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis
                        ),
                        const SizedBox(width: 10),
                        ModifiedSvgPicture.asset(
                          Constant.vectorArrow,
                          height: 10,
                        ),
                      ]
                    ),
                  )
                ),
              ),
            )
          ]
        )
      ],
    );
  }
}