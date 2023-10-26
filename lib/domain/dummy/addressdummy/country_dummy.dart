import '../../entity/address/country.dart';
import 'zone_dummy.dart';

class CountryDummy {
  ZoneDummy zoneDummy;

  CountryDummy({
    required this.zoneDummy
  });

  Country generateShimmerDummy() {
    return Country(
      id: "",
      zoneId: "",
      name: "",
      code: "",
      zone: zoneDummy.generateShimmerDummy()
    );
  }

  Country generateDefaultDummy() {
    return Country(
      id: "19e0e323-35b2-445c-9a0a-6c62fa9ee8d4",
      zoneId: "0ba109f5-cb95-4683-a110-7c52f7e6b3e3",
      name: "Afghanistan",
      code: "AF",
      zone: zoneDummy.generateDefaultDummy()
    );
  }
}