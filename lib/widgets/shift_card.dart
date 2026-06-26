import 'package:flutter/material.dart';
import '../models/shift.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class ShiftCard extends StatelessWidget {
  final EmployeeShift shift;

  const ShiftCard({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.shiftGreen,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(shift.label, style: AppStyles.shiftLabel),
          _divider(),
          Flexible(
            child: Text(
              shift.empName,
              style: AppStyles.shiftName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _divider(),
          Text(shift.role, style: AppStyles.shiftRole),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 14,
      color: Colors.grey.shade400,
      margin: const EdgeInsets.symmetric(horizontal: 6),
    );
  }
}
