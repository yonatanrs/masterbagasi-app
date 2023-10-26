import 'zone.dart';

class Country {
  String id;
  String zoneId;
  String name;
  String code;
  Zone zone;

  Country({
    required this.id,
    required this.zoneId,
    required this.name,
    required this.code,
    required this.zone
  });
}