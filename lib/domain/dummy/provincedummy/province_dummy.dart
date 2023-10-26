import '../../entity/province/province.dart';

class ProvinceDummy {
  ProvinceDummy();

  Province generateShimmerDummy() {
    return Province(
      id: "",
      name: "",
      description: "",
      slug: "",
      icon: "",
      bannerDesktop: "",
      bannerMobile: "",
      background: "",
    );
  }

  Province generateDefaultDummy() {
    return Province(
      id: "1",
      name: "Product Brand Sample",
      description: "Product Brand Sample Description",
      slug: "product-brand-slug",
      icon: null,
      bannerDesktop: null,
      bannerMobile: null,
      background: null
    );
  }
}