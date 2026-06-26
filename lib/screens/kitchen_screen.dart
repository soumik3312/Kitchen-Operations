import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import 'schedule_tab.dart';
import 'live_orders_tab.dart';
import 'shelf_life_tab.dart';

class KitchenScreen extends StatefulWidget {
  const KitchenScreen({super.key});

  @override
  State<KitchenScreen> createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(child: _getTabContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 4),
      child: Row(
        children: [
          const Text('Kitchen Operations', style: AppStyles.screenTitle),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 22),
            color: Colors.grey[600],
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.access_time_outlined, size: 22),
            color: Colors.grey[600],
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabNames = ['Schedule', 'Live Orders', 'Shelf Life Items'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          ...List.generate(tabNames.length, (i) {
            final active = i == _tab;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _tab = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: active ? AppColors.dark : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: active
                        ? null
                        : Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    tabNames[i],
                    style: active ? AppStyles.tabActive : AppStyles.tabInactive,
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          Icon(Icons.more_horiz, color: Colors.grey[500], size: 20),
        ],
      ),
    );
  }

  Widget _getTabContent() {
    switch (_tab) {
      case 0:
        return const ScheduleTab();
      case 1:
        return const LiveOrdersTab();
      case 2:
        return const ShelfLifeTab();
      default:
        return const ScheduleTab();
    }
  }
}
