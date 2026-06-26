import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static const TextStyle screenTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle tabActive = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle tabInactive = TextStyle(
    fontSize: 12,
    color: Colors.black87,
  );

  static const TextStyle timeAxisLabel = TextStyle(
    fontSize: 10,
    color: AppColors.grayText,
  );

  static const TextStyle mealHeading = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  );

  static const TextStyle mealInfo = TextStyle(
    fontSize: 8,
    color: Color(0xFF666666),
    height: 1.4,
  );

  static const TextStyle linkBlue = TextStyle(
    fontSize: 9,
    color: AppColors.linkBlue,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.linkBlue,
  );

  static const TextStyle rowSideLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle detailsLink = TextStyle(
    fontSize: 10,
    color: AppColors.linkBlue,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.linkBlue,
  );

  static const TextStyle shiftLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle shiftName = TextStyle(
    fontSize: 10,
    color: Colors.black87,
  );

  static const TextStyle shiftRole = TextStyle(
    fontSize: 10,
    color: Colors.black54,
  );

  static const TextStyle tableHeader = TextStyle(
    fontSize: 11,
    color: AppColors.grayText,
  );

  static const TextStyle tableCell = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}
