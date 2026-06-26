import '../models/shift.dart';
import '../models/order.dart';
import '../models/shelf_item.dart';

class MockData {
  static final List<MealPeriod> guestMeals = [
    const MealPeriod(
      name: 'Break Fast',
      prepTime: '6:30 AM – 11:00 AM',
      serveTime: '8:30 AM – 11:00 AM',
      startHour: 6.5,
      endHour: 11.0,
    ),
    const MealPeriod(
      name: 'Lunch',
      prepTime: '11:00 AM – 12:30 PM',
      serveTime: '12:30 PM – 03:00 PM',
      startHour: 11.0,
      endHour: 15.0,
    ),
    const MealPeriod(
      name: 'Dinner',
      prepTime: '05:00 PM – 07:30 PM',
      serveTime: '07:30 PM – 10:00 PM',
      startHour: 17.0,
      endHour: 22.0,
    ),
  ];

  static final List<EventMeal> eventMeals = [
    const EventMeal(
      mealName: 'N/A',
      startHour: 6.0,
      endHour: 10.0,
      isNA: true,
    ),
    const EventMeal(
      eventName: 'Event Name 1',
      mealName: 'Lunch',
      prepTime: '10:00 AM – 12:00 PM',
      serveTime: '12:00 PM – 2:30 PM',
      startHour: 10.0,
      endHour: 12.0,
    ),
    const EventMeal(
      eventName: 'Event Name 1',
      mealName: 'Lunch',
      prepTime: '12:00 PM – 2:30 PM',
      serveTime: 'Live Counter',
      startHour: 12.0,
      endHour: 14.5,
    ),
    const EventMeal(
      eventName: 'Event Name 2',
      mealName: 'Dinner',
      prepTime: '5:00 PM – 7:00 PM',
      serveTime: '7:00 PM – 9:30 PM',
      startHour: 17.0,
      endHour: 19.0,
    ),
    const EventMeal(
      eventName: 'Event Name 2',
      mealName: 'Dinner',
      prepTime: '7:00 PM – 9:30 PM',
      serveTime: 'Live Counter',
      startHour: 19.0,
      endHour: 21.5,
    ),
  ];

  static final List<EmployeeShift> shifts = [
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 6.0, durationHours: 8.0, label: '3:45/8hour', rowIndex: 0),
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 14.0, durationHours: 6.0, label: '3:45/8hour', rowIndex: 0),
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 7.0, durationHours: 5.0, label: '3:45/8hour', rowIndex: 1),
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 8.0, durationHours: 8.0, label: '3:45/8hour', rowIndex: 2),
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 6.0, durationHours: 7.0, label: '3:45/8hour', rowIndex: 3),
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 6.0, durationHours: 8.0, label: '3:45/8hour', rowIndex: 4),
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 14.5, durationHours: 5.5, label: '3:45/8hour', rowIndex: 4),
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 6.0, durationHours: 4.0, label: '3:45/8hour', rowIndex: 5),
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 9.0, durationHours: 8.0, label: '3:45/8hour', rowIndex: 6),
    const EmployeeShift(empName: 'Rajeev Singh', role: 'Head Chef', startHour: 6.0, durationHours: 8.0, label: '3:45/8hour', rowIndex: 7),
  ];

  static List<KitchenOrder> orders = [
    KitchenOrder(
      orderId: '10098',
      room: 'A-101',
      status: 'Preparing',
      timerSec: 1778,
      items: [
        OrderItem(name: 'Butter Chicken', qty: '2×500g', assignedTo: 'Rahul K.'),
        OrderItem(name: 'Butter Chicken', qty: '2×500g', assignedTo: 'Rahul K.'),
        OrderItem(name: 'Butter Chicken', qty: '2×500g'),
      ],
    ),
    KitchenOrder(
      orderId: '10099',
      room: 'B-202',
      status: 'Pending',
      timerSec: 1800,
      items: [
        OrderItem(name: 'Paneer Tikka', qty: '1×250g', assignedTo: 'Salman'),
        OrderItem(name: 'Dal Makhani', qty: '2×300g'),
      ],
    ),
    KitchenOrder(
      orderId: '10100',
      room: 'C-105',
      status: 'Preparing',
      timerSec: 940,
      items: [
        OrderItem(name: 'Chicken Curry', qty: '3×400g', assignedTo: 'Rahul K.'),
        OrderItem(name: 'Naan', qty: '6×pcs'),
      ],
    ),
  ];

  static final List<IngredientItem> ingredients = [
    IngredientItem(name: 'Beef Steak', availableQty: '100kg', requiredQty: '50', unit: 'kg', updatedBy: 'Rahul K.'),
    IngredientItem(name: 'Paneer Tikka', availableQty: '--', requiredQty: '50', unit: 'Pieces', updatedBy: 'Salman'),
    IngredientItem(name: 'Beef Steak', availableQty: '100kg', requiredQty: '50', unit: 'kg'),
    IngredientItem(name: 'Paneer Tikka', availableQty: '50kg', requiredQty: '50', unit: 'Pieces', updatedBy: 'Salman'),
  ];

  static final List<ShelfLifeItem> shelfItems = [
    const ShelfLifeItem(itemId: 'IND1', name: 'Tomato', type: 'Vegetables', preservation: 'Refrigerator', location: 'Location 1', totalQty: '8 kg', daysLeft: 3, available: '2 kg'),
    const ShelfLifeItem(itemId: 'IND1', name: 'Cheese', type: 'Dairy', preservation: 'Deep Freeze', location: 'Location 2', totalQty: '8 kg', daysLeft: 3, available: '2 kg'),
    const ShelfLifeItem(itemId: 'IND1', name: 'Rice', type: 'Grocery', preservation: 'Dry', location: 'Location 1', totalQty: '20 kg', daysLeft: 50, available: '3 kg'),
    const ShelfLifeItem(itemId: 'IND1', name: 'Tomato', type: 'Vegetables', preservation: 'Refrigerator', location: 'Location 2', totalQty: '8 kg', daysLeft: 6, available: '7 kg'),
    const ShelfLifeItem(itemId: 'IND1', name: 'Tomato', type: 'Vegetables', preservation: 'Refrigerator', location: 'Location 1', totalQty: '8 kg', daysLeft: 23, available: '4 kg'),
    const ShelfLifeItem(itemId: 'IND1', name: 'Tomato', type: 'Vegetables', preservation: 'Refrigerator', location: 'Location 2', totalQty: '8 kg', daysLeft: 50, available: '7 kg'),
  ];
}
