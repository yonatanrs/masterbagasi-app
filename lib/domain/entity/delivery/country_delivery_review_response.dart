import 'country_delivery_review.dart';

class CountryDeliveryReviewResponse {
  String id;
  String zoneId;
  String name;
  String code;
  DateTime? createdAt;
  DateTime? updatedAt;
  String code2;
  String phoneCode;
  String? image;
  double avgRating;
  List<CountryDeliveryReview> countryDeliveryReviewList;

  CountryDeliveryReviewResponse({
    required this.id,
    required this.zoneId,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.code2,
    required this.phoneCode,
    required this.image,
    required this.avgRating,
    required this.countryDeliveryReviewList
  });
}