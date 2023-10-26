import 'give_delivery_review_value.dart';
import 'quality_feedback_delivery_review_value.dart';

class FourRatingGiveDeliveryReviewValue extends GiveDeliveryReviewValue implements QualityFeedbackDeliveryReviewValue {
  String satisfiedFeedback;
  bool _hasServiceQuality;
  bool _hasPackagingQuality;
  bool _hasPriceQuality;
  bool _hasItemQuality;
  bool _hasDeliveryQuality;

  FourRatingGiveDeliveryReviewValue({
    required this.satisfiedFeedback,
    required bool hasServiceQuality,
    required bool hasPackagingQuality,
    required bool hasPriceQuality,
    required bool hasItemQuality,
    required bool hasDeliveryQuality
  }) : _hasServiceQuality = hasServiceQuality,
      _hasPackagingQuality = hasPackagingQuality,
      _hasPriceQuality = hasPriceQuality,
      _hasItemQuality = hasItemQuality,
      _hasDeliveryQuality = hasDeliveryQuality;

  @override
  bool get hasServiceQuality => _hasServiceQuality;

  @override
  set hasServiceQuality(bool value) => _hasServiceQuality = value;

  @override
  bool get hasPackagingQuality => _hasPackagingQuality;

  @override
  set hasPackagingQuality(bool value) => _hasPackagingQuality = value;

  @override
  bool get hasPriceQuality => _hasPriceQuality;

  @override
  set hasPriceQuality(bool value) => _hasPriceQuality = value;

  @override
  bool get hasItemQuality => _hasItemQuality;

  @override
  set hasItemQuality(bool value) => _hasItemQuality = value;

  @override
  bool get hasDeliveryQuality => _hasDeliveryQuality;

  @override
  set hasDeliveryQuality(bool value) => _hasDeliveryQuality = value;
}