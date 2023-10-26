import 'address_user.dart';
import 'country.dart';
import 'zone.dart';

class Address {
  String id;
  String email;
  String name;
  String userId;
  String label;
  String countryId;
  int isPrimary;
  String address;
  String? address2;
  String phoneNumber;
  String zipCode;
  String city;
  String state;
  Country country;
  AddressUser? addressUser;

  Address({
    required this.id,
    required this.email,
    required this.name,
    required this.userId,
    required this.label,
    required this.countryId,
    required this.isPrimary,
    required this.address,
    required this.address2,
    required this.phoneNumber,
    required this.zipCode,
    required this.city,
    required this.state,
    required this.country,
    required this.addressUser
  });
}