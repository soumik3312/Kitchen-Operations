import '../data/mock_data.dart';
import '../models/order.dart';

class OrdersVM {
  List<KitchenOrder> orders = MockData.orders;
  int selectedIdx = 0;

  KitchenOrder get current => orders[selectedIdx];

  void assignItem(int itemIdx, String person) {
    current.items[itemIdx].assignedTo = person;
  }
}
