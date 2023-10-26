class RefreshDeliveryReview {
  void Function()? onRefreshWaitingToBeReviewedDeliveryReview;
  void Function()? onRefreshHistoryDeliveryReview;

  RefreshDeliveryReview({
    this.onRefreshWaitingToBeReviewedDeliveryReview,
    this.onRefreshHistoryDeliveryReview
  });

  void refresh() {
    if (onRefreshWaitingToBeReviewedDeliveryReview != null) {
      onRefreshWaitingToBeReviewedDeliveryReview!();
    }
    if (onRefreshHistoryDeliveryReview != null) {
      onRefreshHistoryDeliveryReview!();
    }
  }

  void dispose() {
    onRefreshWaitingToBeReviewedDeliveryReview = null;
    onRefreshHistoryDeliveryReview = null;
  }
}