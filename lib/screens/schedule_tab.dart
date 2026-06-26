import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../viewmodels/schedule_vm.dart';
import '../models/shift.dart';
import '../widgets/shift_card.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  final _vm = ScheduleVM();
  final _scrollCtrl = ScrollController();

  static const double _hourW = 70.0;
  static const double _startHr = 6.0;
  static const double _endHr = 22.0;
  static const double _totalW = (_endHr - _startHr) * _hourW;

  static const List<String> _labels = [
    '6am', '7am', '8am', '9am', '10am', '11am',
    '12pm', '1pm', '2pm', '3pm', '4pm',
    '5pm', '6pm', '7pm', '8pm', '9pm', '10pm',
  ];

  double _x(double hour) => (hour - _startHr) * _hourW;

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shiftRows = _vm.shiftRows;
    final numRows = shiftRows.length;

    const double timeAxisH = 36.0;
    const double guestRowH = 92.0;
    const double eventRowH = 92.0;
    const double shiftH = 44.0;
    const double leftLabelW = 72.0;

    final totalHeight = timeAxisH + guestRowH + eventRowH + 1 + (numRows * shiftH) + 20;

    return SingleChildScrollView(
      child: SizedBox(
        height: totalHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: leftLabelW,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: timeAxisH),
                  _leftLabel('Guest\nBuffet', guestRowH),
                  _leftLabel('Event\nBuffet', eventRowH),
                  Container(height: 1, color: AppColors.borderColor),
                  ...List.generate(numRows, (_) => SizedBox(height: shiftH)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollCtrl,
                child: SizedBox(
                  width: _totalW + _hourW,
                  child: Column(
                    children: [
                      _buildTimeAxis(timeAxisH),
                      _buildGuestRow(guestRowH),
                      _buildEventRow(eventRowH),
                      Container(height: 1, color: AppColors.borderColor),
                      ...List.generate(numRows, (i) {
                        return _buildShiftRow(shiftRows[i] ?? [], shiftH);
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leftLabel(String text, double h) {
    return SizedBox(
      height: h,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 4, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: AppStyles.rowSideLabel),
            const SizedBox(height: 2),
            GestureDetector(
              onTap: () {},
              child: const Text('Details', style: AppStyles.detailsLink),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeAxis(double h) {
    return SizedBox(
      height: h,
      child: Stack(
        children: [
          Row(
            children: _labels.map((label) {
              return SizedBox(
                width: _hourW,
                child: Center(
                  child: Text(label, style: AppStyles.timeAxisLabel),
                ),
              );
            }).toList(),
          ),
          Positioned(
            left: _x(6.72) - 14,
            top: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '06:43\nAM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestRow(double h) {
    return SizedBox(
      height: h,
      child: Stack(
        children: _vm.guestMeals.map((meal) {
          final x = _x(meal.startHour);
          final w = (meal.endHour - meal.startHour) * _hourW;
          return Positioned(
            left: x + 1,
            top: 4,
            width: w - 2,
            height: h - 8,
            child: _mealBlock(meal.name, meal.prepTime, meal.serveTime),
          );
        }).toList(),
      ),
    );
  }

  Widget _mealBlock(String name, String prep, String serve) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.fromLTRB(5, 4, 5, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: AppStyles.mealHeading),
          const SizedBox(height: 2),
          Text('Preparation Time\n$prep', style: AppStyles.mealInfo),
          Text('Serve Time\n$serve', style: AppStyles.mealInfo),
          const SizedBox(height: 2),
          Row(
            children: [
              GestureDetector(onTap: () {}, child: const Text('Menu', style: AppStyles.linkBlue)),
              const SizedBox(width: 8),
              GestureDetector(onTap: () {}, child: const Text('Live Counter', style: AppStyles.linkBlue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventRow(double h) {
    return SizedBox(
      height: h,
      child: Stack(
        children: _vm.eventMeals.map((event) {
          final x = _x(event.startHour);
          final w = (event.endHour - event.startHour) * _hourW;
          return Positioned(
            left: x + 1,
            top: 4,
            width: w - 2,
            height: h - 8,
            child: event.isNA ? _naBlock() : _eventBlock(event),
          );
        }).toList(),
      ),
    );
  }

  Widget _naBlock() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(6),
      child: const Text('N/A', style: TextStyle(fontSize: 11, color: Colors.grey)),
    );
  }

  Widget _eventBlock(EventMeal event) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.fromLTRB(5, 4, 5, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (event.eventName != null)
            Text(event.eventName!, style: AppStyles.mealHeading.copyWith(fontSize: 10)),
          Text(event.mealName, style: AppStyles.mealInfo.copyWith(fontSize: 8)),
          if (event.prepTime != null)
            Text('Preparation Time\n${event.prepTime}', style: AppStyles.mealInfo),
          if (event.serveTime != null && event.serveTime != 'Live Counter')
            Text('Serve Time\n${event.serveTime}', style: AppStyles.mealInfo),
          const SizedBox(height: 2),
          Row(
            children: [
              GestureDetector(onTap: () {}, child: const Text('Menu', style: AppStyles.linkBlue)),
              const SizedBox(width: 6),
              GestureDetector(onTap: () {}, child: const Text('Live Counter', style: AppStyles.linkBlue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShiftRow(List<EmployeeShift> rowShifts, double h) {
    return SizedBox(
      height: h,
      child: Stack(
        children: rowShifts.map((s) {
          final x = _x(s.startHour);
          final w = s.durationHours * _hourW;
          return Positioned(
            left: x + 1,
            top: 5,
            width: w - 2,
            height: h - 10,
            child: ShiftCard(shift: s),
          );
        }).toList(),
      ),
    );
  }
}
