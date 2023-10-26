import '../../entity/delivery/delivery_review.dart';

class DeliveryReviewDummy {
  DeliveryReviewDummy();

  DeliveryReview generateShimmerDummy() {
    return DeliveryReview(
      id: "1",
      userProfilePicture: "",
      userName: "",
      productImageUrl: "",
      productName: "",
      review: "",
      country: "",
      rating: 5.0,
      reviewDate: DateTime.now(),
    );
  }

  DeliveryReview generateDefaultDummy() {
    return DeliveryReview(
      id: "1",
      userProfilePicture: "",
      userName: "",
      productImageUrl: "",
      productName: "",
      review: "",
      country: "",
      rating: 5.0,
      reviewDate: DateTime.now(),
    );
  }
}