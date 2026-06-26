import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../viewmodels/orders_vm.dart';
import '../models/order.dart';

class LiveOrdersTab extends StatefulWidget {
  const LiveOrdersTab({super.key});

  @override
  State<LiveOrdersTab> createState() => _LiveOrdersTabState();
}

class _LiveOrdersTabState extends State<LiveOrdersTab> {
  final _vm = OrdersVM();

  String _fmtTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOrderList(),
        Container(height: 1, color: AppColors.borderColor),
        Expanded(child: _buildOrderDetail()),
      ],
    );
  }

  // top scrollable list of orders
  Widget _buildOrderList() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: _vm.orders.length,
        itemBuilder: (ctx, i) {
          final o = _vm.orders[i];
          final isSelected = i == _vm.selectedIdx;
          return GestureDetector(
            onTap: () => setState(() => _vm.selectedIdx = i),
            child: Container(
              width: 160,
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.dark : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? AppColors.dark : AppColors.borderColor,
                ),
                boxShadow: [
                  if (!isSelected)
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Order #${o.orderId}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Room ${o.room}',
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? Colors.white60 : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statusChip(o, isSelected),
                      Text(
                        _fmtTime(o.timerSec),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _statusChip(KitchenOrder o, bool dark) {
    final isPreparing = o.status == 'Preparing';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: dark
            ? Colors.white.withValues(alpha: 0.15)
            : (isPreparing ? Colors.orange.shade50 : Colors.blue.shade50),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        o.status,
        style: TextStyle(
          fontSize: 9,
          color: dark
              ? Colors.white
              : (isPreparing ? Colors.orange.shade700 : Colors.blue),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // bottom section - order detail
  Widget _buildOrderDetail() {
    final order = _vm.current;
    return Column(
      children: [
        // order info row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoCol('Order Id', order.orderId),
              const SizedBox(width: 16),
              _infoCol('Room', order.room),
              const SizedBox(width: 16),
              _infoCol('Order Status', order.status),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Timer', style: AppStyles.tableHeader),
                  Text(
                    _fmtTime(order.timerSec),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(height: 1, color: AppColors.borderColor),
        // table column headers
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Row(
            children: [
              const Expanded(child: Text('Item Name', style: AppStyles.tableHeader)),
              const Text('Quantity', style: AppStyles.tableHeader),
              const SizedBox(width: 20),
              const SizedBox(width: 70, child: Text('Assigned', style: AppStyles.tableHeader)),
              const SizedBox(width: 64),
            ],
          ),
        ),
        Container(height: 1, color: AppColors.borderColor),
        // items list
        Expanded(
          child: ListView.separated(
            itemCount: order.items.length,
            separatorBuilder: (ctx2, idx2) => Container(height: 1, color: AppColors.borderColor),
            itemBuilder: (ctx, i) => _itemRow(order.items[i], i),
          ),
        ),
        // cancel all button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.red),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Cancel All', style: TextStyle(color: AppColors.red, fontSize: 13)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemRow(OrderItem item, int idx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(item.name, style: AppStyles.tableCell),
          ),
          Text(item.qty, style: const TextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(width: 20),
          SizedBox(
            width: 70,
            child: item.assignedTo != null
                ? Text(item.assignedTo!, style: const TextStyle(fontSize: 13))
                : GestureDetector(
                    onTap: () => setState(() => _vm.assignItem(idx, 'Rahul K.')),
                    child: const Text(
                      'Assign',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.linkGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.red),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text('Cancel', style: TextStyle(fontSize: 12, color: AppColors.red)),
          ),
        ],
      ),
    );
  }

  Widget _infoCol(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.tableHeader),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
