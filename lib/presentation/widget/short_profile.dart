import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/user/user.dart';
import '../../misc/typedef.dart';
import 'profile_picture_cache_network_image.dart';

typedef ShortProfileDisplayProfileBuilder = Widget Function(BuildContext context, Widget displayProfileWidget, String profileImageUrl);
typedef ShortProfileNameBuilder = Widget Function(BuildContext context, Widget nameTextWidget, String name);
typedef ShortProfileDescriptionBuilder = Widget Function(BuildContext context, Widget descriptionTextWidget, String description);
typedef ShortProfileRatingBuilder = Widget Function(BuildContext context, Widget ratingIndicatorWidget, double rating);

class ShortProfile extends StatelessWidget {
  final User? user;
  final TypeCallback<User>? onTap;
  final double? dimension;
  final double? fontSize;
  final bool withDisplayProfile;
  final bool withName;
  final bool withDescription;
  final double? spacing;
  final ShortProfileDisplayProfileBuilder? displayProfileBuilder;
  final ShortProfileNameBuilder? nameBuilder;
  final ShortProfileDescriptionBuilder? descriptionBuilder;
  final CrossAxisAlignment? rowCrossAxisAlignment;

  const ShortProfile({
    Key? key,
    required this.user,
    required this.onTap,
    this.dimension,
    this.fontSize,
    this.withDisplayProfile = true,
    this.withName = true,
    this.withDescription = false,
    this.spacing,
    this.displayProfileBuilder,
    this.nameBuilder,
    this.descriptionBuilder,
    this.rowCrossAxisAlignment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidget = [];
    void addColumnWidget(Widget widget) {
      if (columnWidget.isNotEmpty) {
        columnWidget.add(SizedBox(height: (0.5).h));
      }
      columnWidget.add(widget);
    }
    if (withName) {
      String name = user != null ? user!.name.toStringNonNull : "(${"No Name".tr})";
      Widget nameText = Text(name, style: TextStyle(fontSize: fontSize ?? 12, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis);
      addColumnWidget(nameBuilder != null ? nameBuilder!(context, nameText, name) : nameText);
    }
    if (withDescription) {
      String description = user != null ? user!.userProfile.placeBirth.toStringNonNull : "(${"No Title".tr})";
      Widget descriptionText = Text(description, style: TextStyle(fontSize: fontSize ?? 12));
      addColumnWidget(descriptionBuilder != null ? descriptionBuilder!(context, descriptionText, description) : descriptionText);
    }
    Widget? effectiveDisplayPicture;
    if (withDisplayProfile) {
      String profileImageUrl = user != null ? user!.userProfile.avatar.toStringNonNull : "";
      Widget displayPicture = ProfilePictureCacheNetworkImage(
        profileImageUrl: profileImageUrl,
        dimension: dimension ?? 6.w,
      );
      effectiveDisplayPicture = displayProfileBuilder != null ? displayProfileBuilder!(context, displayPicture, profileImageUrl) : displayPicture;
    }
    return GestureDetector(
      onTap: onTap != null && user != null ? (() => onTap!(user!)) : null,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: rowCrossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (effectiveDisplayPicture != null) effectiveDisplayPicture,
          if (effectiveDisplayPicture != null) SizedBox(width: spacing ?? 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columnWidget
            )
          )
        ],
      )
    );
  }
}

class MediumShortProfile extends ShortProfile {
  MediumShortProfile({
    Key? key,
    required User? user,
    required TypeCallback<User>? onTap,
    bool withDescription = false,
    bool withRating = false,
    double? externalRating,
    ShortProfileDisplayProfileBuilder? displayProfileBuilder,
    ShortProfileNameBuilder? nameBuilder,
    ShortProfileDescriptionBuilder? descriptionBuilder,
    CrossAxisAlignment? rowCrossAxisAlignment
  }) : super(
    key: key,
    user: user,
    onTap: onTap,
    fontSize: 14,
    dimension: 10.w,
    spacing: 3.w,
    withDescription: withDescription,
    displayProfileBuilder: displayProfileBuilder,
    nameBuilder: nameBuilder,
    descriptionBuilder: descriptionBuilder,
    rowCrossAxisAlignment: rowCrossAxisAlignment
  );
}