class Cargo {
  String id;
  String zoneId;
  double minWeight;
  double maxWeight;
  int price;
  int priceTogether;

  Cargo({
    required this.id,
    required this.zoneId,
    required this.minWeight,
    required this.maxWeight,
    required this.price,
    required this.priceTogether
  });
}