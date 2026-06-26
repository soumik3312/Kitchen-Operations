class OrderItem {
  final String name;
  final String qty;
  String? assignedTo;

  OrderItem({
    required this.name,
    required this.qty,
    this.assignedTo,
  });
}

class KitchenOrder {
  final String orderId;
  final String room;
  final String status;
  int timerSec;
  final List<OrderItem> items;

  KitchenOrder({
    required this.orderId,
    required this.room,
    required this.status,
    required this.timerSec,
    required this.items,
  });
}
