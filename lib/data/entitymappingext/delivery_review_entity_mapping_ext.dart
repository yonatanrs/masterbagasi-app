import 'package:masterbagasi/data/entitymappingext/address_entity_mapping_ext.dart';
import 'package:masterbagasi/data/entitymappingext/user_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../domain/entity/address/country.dart';
import '../../domain/entity/delivery/country_delivery_review.dart';
import '../../domain/entity/delivery/country_delivery_review_response.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/other_country_delivery_review_media.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/photo_country_delivery_review_media.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/video_country_delivery_review_media.dart';
import '../../domain/entity/delivery/delivery_review.dart';
import '../../domain/entity/user/user.dart';
import '../../misc/response_wrapper.dart';

extension DeliveryReviewEntityMappingExt on ResponseWrapper {
  List<DeliveryReview> mapFromResponseToDeliveryReviewList() {
    return response.map<DeliveryReview>((deliveryReviewResponse) => ResponseWrapper(deliveryReviewResponse).mapFromResponseToDeliveryReview()).toList();
  }
}

extension DeliveryReviewDetailEntityMappingExt on ResponseWrapper {
  CountryDeliveryReview mapFromResponseToCountryDeliveryReview() {
    String name = "";
    String avatar = "";
    if (response["user"] != null) {
      User user = ResponseWrapper(response["user"]).mapFromResponseToUser();
      name = user.name;
      avatar = user.userProfile.avatar.toEmptyStringNonNull;
    } else {
      name = response["name"];
      avatar = response["avatar"];
    }
    return CountryDeliveryReview(
      id: response["id"],
      userName: name,
      userProfilePicture: avatar,
      rating: ResponseWrapper(response["rating"]).mapFromResponseToDouble()!,
      review: response["message"],
      reviewDate: ResponseWrapper(response["created_at"]).mapFromResponseToDateTime()!,
      countryDeliveryReviewMedia: () {
        String obtainedKey = "";
        var responseMap = response as Map<String, dynamic>;
        for (var key in responseMap.keys) {
          if (key.contains("shipping_review_attachment")) {
            obtainedKey = key;
            break;
          }
        }
        if (obtainedKey.isNotEmptyString) {
          return response[obtainedKey];
        } else {
          return [];
        }
      }().map<CountryDeliveryReviewMedia>(
        (countryDeliveryReviewMediaResponse) => ResponseWrapper(countryDeliveryReviewMediaResponse).mapFromResponseToCountryDeliveryReviewMedia()
      ).toList()
    );
  }

  CountryDeliveryReviewMedia mapFromResponseToCountryDeliveryReviewMedia() {
    String? shippingReviewId = response["shipping_review_id"] ?? response["dummy_shipping_review_id"];
    String effectiveId = response["id"];
    String effectivePath = response["path"] ?? "";
    if (GetUtils.isImage(effectivePath)) {
      return PhotoCountryDeliveryReviewMedia(
        id: effectiveId,
        shippingReviewId: shippingReviewId,
        thumbnailUrl: effectivePath
      );
    } else if (GetUtils.isVideo(effectivePath)) {
      return VideoCountryDeliveryReviewMedia(
        id: effectiveId,
        shippingReviewId: shippingReviewId,
        thumbnailUrl: effectivePath
      );
    }
    return OtherCountryDeliveryReviewMedia(
      id: effectiveId,
      shippingReviewId: shippingReviewId,
      thumbnailUrl: effectivePath
    );
  }

  CountryDeliveryReviewResponse mapFromResponseToCountryDeliveryReviewResponse() {
    return CountryDeliveryReviewResponse(
      id: response["id"],
      zoneId: response["zone_id"],
      name: response["name"],
      code: response["code"],
      createdAt: ResponseWrapper(response["created_at"]).mapFromResponseToDateTime()!,
      updatedAt: ResponseWrapper(response["updated_at"]).mapFromResponseToDateTime()!,
      code2: response["code2"],
      phoneCode: response["phone_code"],
      image: response["image"],
      avgRating: ResponseWrapper(response["avg_rating"]).mapFromResponseToDouble()!,
      countryDeliveryReviewList: response["combined_review"].map<CountryDeliveryReview>(
        (countryDeliveryReviewResponse) => ResponseWrapper(countryDeliveryReviewResponse).mapFromResponseToCountryDeliveryReview()
      ).toList()
    );
  }

  DeliveryReview mapFromResponseToDeliveryReview() {
    String name = "";
    String avatar = "";
    String countryId = "";
    String countryCode = "";
    String countryName = "";
    if (response["user"] != null) {
      User user = ResponseWrapper(response["user"]).mapFromResponseToUser();
      name = user.name;
      avatar = user.userProfile.avatar.toEmptyStringNonNull;
    } else {
      name = response["name"];
      avatar = response["avatar"];
    }
    if (response["country"] != null) {
      dynamic countryResponse = response["country"];
      countryId = countryResponse["id"];
      countryCode = countryResponse["code"];
      countryName = countryResponse["name"];
    } else {
      countryId = response["country_id"];
      countryCode = response["country_code"];
      countryName = response["country_name"];
    }
    return DeliveryReview(
      id: "1",
      userName: name,
      userProfilePicture: avatar,
      productImageUrl: "",
      productName: "",
      rating: ResponseWrapper(response["rating"]).mapFromResponseToDouble()!,
      country: countryName,
      countryCode: countryCode,
      review: response["message"],
      reviewDate: ResponseWrapper(response["created_at"]).mapFromResponseToDateTime()!,
    );
  }
}