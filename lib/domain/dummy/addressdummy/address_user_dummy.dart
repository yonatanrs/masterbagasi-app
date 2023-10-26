import '../../entity/address/address_user.dart';

class AddressUserDummy {
  AddressUserDummy();

  AddressUser generateShimmerDummy() {
    return AddressUser(
      id: "",
      name: "",
      role: 0,
      email: ""
    );
  }

  AddressUser generateDefaultDummy() {
    return AddressUser(
      id: "",
      name: "",
      role: 0,
      email: ""
    );
  }
}