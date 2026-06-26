class MealPeriod {
  final String name;
  final String prepTime;
  final String serveTime;
  final double startHour;
  final double endHour;

  const MealPeriod({
    required this.name,
    required this.prepTime,
    required this.serveTime,
    required this.startHour,
    required this.endHour,
  });
}

class EventMeal {
  final String? eventName;
  final String mealName;
  final String? prepTime;
  final String? serveTime;
  final double startHour;
  final double endHour;
  final bool isNA;

  const EventMeal({
    this.eventName,
    required this.mealName,
    this.prepTime,
    this.serveTime,
    required this.startHour,
    required this.endHour,
    this.isNA = false,
  });
}

class EmployeeShift {
  final String empName;
  final String role;
  final double startHour;
  final double durationHours;
  final String label;
  final int rowIndex;

  const EmployeeShift({
    required this.empName,
    required this.role,
    required this.startHour,
    required this.durationHours,
    required this.label,
    required this.rowIndex,
  });
}
