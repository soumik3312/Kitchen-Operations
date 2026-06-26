import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../viewmodels/shelf_vm.dart';
import '../models/shelf_item.dart';

class ShelfLifeTab extends StatefulWidget {
  const ShelfLifeTab({super.key});

  @override
  State<ShelfLifeTab> createState() => _ShelfLifeTabState();
}

class _ShelfLifeTabState extends State<ShelfLifeTab> {
  final _vm = ShelfVM();
  final List<String> _subTabs = ['Prepare', 'Available', 'Required'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSubTabBar(),
        const SizedBox(height: 4),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildSubTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: List.generate(_subTabs.length, (i) {
          final active = i == _vm.activeTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _vm.activeTab = i),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: active ? AppColors.dark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: active ? AppColors.dark : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    _subTabs[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: active ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildContent() {
    switch (_vm.activeTab) {
      case 0:
        return _buildPrepareTab();
      case 1:
        return _buildAvailableTab();
      case 2:
        return _buildRequiredTab();
      default:
        return _buildAvailableTab();
    }
  }

  Widget _buildPrepareTab() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 720,
              child: Column(
                children: [
                  _prepareTableHeader(),
                  Container(height: 1, color: AppColors.borderColor),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _vm.shelfItems.length,
                      separatorBuilder: (ctx2, idx2) => Container(height: 1, color: AppColors.borderColor),
                      itemBuilder: (ctx, i) => _prepareItemRow(_vm.shelfItems[i]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _prepareTableHeader() {
    final cols = ['Item ID', 'Item Name', 'Type', 'Preservation', 'Location', 'Total Qty', 'Days Left', 'Available', 'Action'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: cols.map((c) {
          return SizedBox(
            width: 80,
            child: Text(c, style: AppStyles.tableHeader),
          );
        }).toList(),
      ),
    );
  }

  Widget _prepareItemRow(ShelfLifeItem item) {
    Color daysColor;
    if (item.daysLeft <= 5) {
      daysColor = AppColors.red;
    } else if (item.daysLeft <= 15) {
      daysColor = AppColors.orange;
    } else {
      daysColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(item.itemId, style: const TextStyle(fontSize: 12))),
          SizedBox(width: 80, child: Text(item.name, style: const TextStyle(fontSize: 12))),
          SizedBox(width: 80, child: Text(item.type, style: const TextStyle(fontSize: 12))),
          SizedBox(width: 80, child: Text(item.preservation, style: const TextStyle(fontSize: 12))),
          SizedBox(width: 80, child: Text(item.location, style: const TextStyle(fontSize: 12))),
          SizedBox(width: 80, child: Text(item.totalQty, style: const TextStyle(fontSize: 12))),
          SizedBox(
            width: 80,
            child: Text(
              '${item.daysLeft} Days',
              style: TextStyle(fontSize: 12, color: daysColor, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 80, child: Text(item.available, style: const TextStyle(fontSize: 12))),
          SizedBox(
            width: 80,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.red),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Remove from Offer',
                  style: TextStyle(fontSize: 9, color: AppColors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableTab() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 450,
              child: Column(
                children: [
                  Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
          child: Row(
            children: const [
              Expanded(child: Text('Item Name', style: AppStyles.tableHeader)),
              Text('Available\nQuantity', style: TextStyle(fontSize: 11, color: AppColors.grayText, height: 1.3)),
              SizedBox(width: 40),
              Text('Updated by', style: AppStyles.tableHeader),
            ],
          ),
        ),
        Container(height: 1, color: AppColors.borderColor),
        Expanded(
          child: ListView.separated(
            itemCount: _vm.ingredients.length,
            separatorBuilder: (ctx2, idx2) => Container(height: 1, color: AppColors.borderColor),
            itemBuilder: (ctx, i) {
              final ing = _vm.ingredients[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(ing.name, style: AppStyles.tableCell),
                    ),
                    Text(
                      ing.availableQty ?? '--',
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    const SizedBox(width: 40),
                    Text(
                      ing.updatedBy ?? '--',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              );
            },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Edit', style: TextStyle(color: Colors.black87, fontSize: 13)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequiredTab() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 450,
              child: Column(
                children: [
                  Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
          child: Row(
            children: const [
              Expanded(child: Text('Item Name', style: AppStyles.tableHeader)),
              Text('Required\nQuantity', style: TextStyle(fontSize: 11, color: AppColors.grayText, height: 1.3)),
              SizedBox(width: 16),
              Text('Updated by', style: AppStyles.tableHeader),
            ],
          ),
        ),
        Container(height: 1, color: AppColors.borderColor),
        Expanded(
          child: ListView.separated(
            itemCount: _vm.ingredients.length,
            separatorBuilder: (ctx2, idx2) => Container(height: 1, color: AppColors.borderColor),
            itemBuilder: (ctx, i) {
              final ing = _vm.ingredients[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(ing.name, style: AppStyles.tableCell),
                    ),
                    SizedBox(
                      width: 50,
                      height: 34,
                      child: TextFormField(
                        initialValue: ing.requiredQty,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        onChanged: (v) => _vm.updateRequiredQty(i, v),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(ing.unit, style: const TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      ing.updatedBy ?? '--',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              );
            },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Saved successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.dark,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ],
    );
  }
}
