import '../data/mock_data.dart';
import '../models/shelf_item.dart';

class ShelfVM {
  int activeTab = 1;

  List<IngredientItem> ingredients = List.from(MockData.ingredients);
  List<ShelfLifeItem> shelfItems = MockData.shelfItems;

  void updateRequiredQty(int idx, String val) {
    ingredients[idx].requiredQty = val;
  }
}
