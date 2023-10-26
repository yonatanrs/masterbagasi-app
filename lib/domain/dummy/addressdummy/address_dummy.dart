import '../../entity/address/address.dart';
import 'address_user_dummy.dart';
import 'country_dummy.dart';

class AddressDummy {
  CountryDummy countryDummy;
  AddressUserDummy addressUserDummy;

  AddressDummy({
    required this.countryDummy,
    required this.addressUserDummy
  });

  Address generateShimmerDummy() {
    return Address(
      id: "",
      email: "",
      name: "",
      userId: "",
      label: "",
      countryId: "",
      isPrimary: 1,
      address: "",
      address2: "",
      phoneNumber: "",
      zipCode: "",
      city: "",
      state: "",
      country: countryDummy.generateShimmerDummy(),
      addressUser: addressUserDummy.generateShimmerDummy()
    );
  }

  Address generateDefaultDummy() {
    return Address(
      id: "1e448fe8-4dbe-4315-a7d6-381c7e5a37d0",
      email: "test@gmail.com",
      name: "test",
      userId: "c617c55c-e4b5-4815-b0de-b422b78434b7",
      label: "Address 2",
      countryId: "19e0e323-35b2-445c-9a0a-6c62fa9ee8d4",
      isPrimary: 1,
      address: "Street 2",
      address2: null,
      phoneNumber: "08512412521532",
      zipCode: "16517",
      city: "Test",
      state: "Test",
      country: countryDummy.generateDefaultDummy(),
      addressUser: addressUserDummy.generateDefaultDummy()
    );
  }
}