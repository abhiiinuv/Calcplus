import 'package:flutter/material.dart';
import '../models/calculator_tab.dart';

class CalculatorTabBar extends StatelessWidget {
  final List<CalculatorTab> tabs;
  final TabController tabController;
  final int currentTabIndex;
  final Function(int) onTabSelected;
  final Function(int) onTabRemoved;
  final Function(int, String) onTabRenamed;
  final VoidCallback onAddTab;

  const CalculatorTabBar({
    super.key,
    required this.tabs,
    required this.tabController,
    required this.currentTabIndex,
    required this.onTabSelected,
    required this.onTabRemoved,
    required this.onTabRenamed,
    required this.onAddTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.grey[900],
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                final tab = tabs[index];
                final isSelected = index == currentTabIndex;

                return GestureDetector(
                  onTap: () => onTabSelected(index),
                  onLongPress:
                      () => _showRenameDialog(context, index, tab.name),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 4,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            tab.name,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (tabs.length > 1) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => onTabRemoved(index),
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: isSelected ? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: onAddTab,
              icon: const Icon(Icons.add, color: Colors.orange),
              iconSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _showRenameDialog(BuildContext context, int index, String currentName) {
    final TextEditingController controller = TextEditingController(
      text: currentName,
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              'Rename Tab',
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Tab Name',
                labelStyle: TextStyle(color: Colors.orange),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    onTabRenamed(index, controller.text.trim());
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Rename',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
    );
  }
}
