import '../data/mock_data.dart';
import '../models/shift.dart';

class ScheduleVM {
  final List<MealPeriod> guestMeals = MockData.guestMeals;
  final List<EventMeal> eventMeals = MockData.eventMeals;
  final List<EmployeeShift> shifts = MockData.shifts;

  Map<int, List<EmployeeShift>> get shiftRows {
    final map = <int, List<EmployeeShift>>{};
    for (var s in shifts) {
      map.putIfAbsent(s.rowIndex, () => []).add(s);
    }
    return map;
  }
}
