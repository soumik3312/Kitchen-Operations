class IngredientItem {
  final String name;
  String? availableQty;
  String requiredQty;
  String unit;
  String? updatedBy;

  IngredientItem({
    required this.name,
    this.availableQty,
    this.requiredQty = '50',
    this.unit = 'kg',
    this.updatedBy,
  });
}

class ShelfLifeItem {
  final String itemId;
  final String name;
  final String type;
  final String preservation;
  final String location;
  final String totalQty;
  final int daysLeft;
  final String available;

  const ShelfLifeItem({
    required this.itemId,
    required this.name,
    required this.type,
    required this.preservation,
    required this.location,
    required this.totalQty,
    required this.daysLeft,
    required this.available,
  });
}
