import 'dart:io';

import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../../domain/entity/delivery/countrydeliveryreviewmedia/photo_country_delivery_review_media.dart';
import '../../../domain/entity/delivery/countrydeliveryreviewmedia/video_country_delivery_review_media.dart';
import '../../../misc/constant.dart';
import '../../../misc/page_restoration_helper.dart';
import '../../page/country_delivery_review_media_view_page.dart';
import '../modifiedcachednetworkimage/country_delivery_review_modified_cached_network_image.dart';
import '../tap_area.dart';

class CountryDeliveryReviewMediaDetailItem extends StatefulWidget {
  final CountryDeliveryReviewMedia countryDeliveryReviewMedia;
  final BuildContext Function()? contextForOpeningMediaView;

  const CountryDeliveryReviewMediaDetailItem({
    super.key,
    required this.countryDeliveryReviewMedia,
    this.contextForOpeningMediaView
  });

  @override
  State<StatefulWidget> createState() => _CountryDeliveryReviewMediaDetailItemState();
}

class _CountryDeliveryReviewMediaDetailItemState extends State<CountryDeliveryReviewMediaDetailItem> {
  String? _videoFileName;

  @override
  void initState() {
    super.initState();
    _loadVideoThumbnail();
  }

  void _loadVideoThumbnail() async {
    _videoFileName = await VideoThumbnail.thumbnailFile(
      video: widget.countryDeliveryReviewMedia.thumbnailUrl.toEmptyStringNonNull,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 64,
      quality: 75,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TapArea(
      onTap: () => PageRestorationHelper.toCountryDeliveryReviewMediaViewPage(
        widget.contextForOpeningMediaView != null ? widget.contextForOpeningMediaView!() : context,
        CountryDeliveryReviewMediaViewPageParameter(
          countryDeliveryReviewMedia: widget.countryDeliveryReviewMedia
        )
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: () {
            if (widget.countryDeliveryReviewMedia is PhotoCountryDeliveryReviewMedia) {
              return CountryDeliveryReviewModifiedCachedNetworkImage(
                imageUrl: widget.countryDeliveryReviewMedia.thumbnailUrl.toEmptyStringNonNull,
              );
            } else if (widget.countryDeliveryReviewMedia is VideoCountryDeliveryReviewMedia) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _videoFileName != null ? FileImage(File(_videoFileName!)) as ImageProvider<Object> : AssetImage(Constant.imageProductPlaceholder),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            } else {
              return CountryDeliveryReviewModifiedCachedNetworkImage(
                imageUrl: "",
              );
            }
          }()
        ),
      ),
    );
  }
}