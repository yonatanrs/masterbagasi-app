class Coupon {
  String id;
  String userProfessionId;
  String title;
  String code;
  String type;
  DateTime activePeriodStart;
  DateTime activePeriodEnd;
  int minPerUser;
  String? imageMobile;
  String? imageDesktop;
  String? bannerDesktop;
  String? bannerMobile;
  String notes;

  Coupon({
    required this.id,
    required this.userProfessionId,
    required this.title,
    required this.code,
    required this.type,
    required this.activePeriodStart,
    required this.activePeriodEnd,
    required this.minPerUser,
    required this.imageMobile,
    required this.imageDesktop,
    required this.bannerDesktop,
    required this.bannerMobile,
    required this.notes
  });
}