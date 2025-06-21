import 'package:flutter/material.dart';
import '../models/calculator_tab.dart';
import '../widgets/calculator_tab_bar.dart';
import '../widgets/calculator_content.dart';
import '../models/calculator_mode.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<CalculatorTab> _tabs = [];
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabs = [
      CalculatorTab(
        id: '1',
        name: 'Calculator 1',
        mode: CalculatorMode.standard,
        history: [],
        currentExpression: '',
      ),
    ];
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addTab() {
    setState(() {
      _tabs.add(
        CalculatorTab(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: 'Calculator ${_tabs.length + 1}',
          mode: CalculatorMode.standard,
          history: [],
          currentExpression: '',
        ),
      );
      _tabController = TabController(length: _tabs.length, vsync: this);
      _tabController.index = _tabs.length - 1;
      _currentTabIndex = _tabs.length - 1;
    });
  }

  void _removeTab(int index) {
    if (_tabs.length > 1) {
      setState(() {
        _tabs.removeAt(index);
        _tabController = TabController(length: _tabs.length, vsync: this);
        if (_currentTabIndex >= _tabs.length) {
          _currentTabIndex = _tabs.length - 1;
        }
        _tabController.index = _currentTabIndex;
      });
    }
  }

  void _renameTab(int index, String newName) {
    setState(() {
      _tabs[index] = _tabs[index].copyWith(name: newName);
    });
  }

  void _changeMode(int tabIndex, CalculatorMode mode) {
    setState(() {
      _tabs[tabIndex] = _tabs[tabIndex].copyWith(mode: mode);
    });
  }

  void _updateTab(int tabIndex, CalculatorTab updatedTab) {
    setState(() {
      _tabs[tabIndex] = updatedTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Calculator'),
        actions: [
          PopupMenuButton<CalculatorMode>(
            icon: const Icon(Icons.menu),
            onSelected: (CalculatorMode mode) {
              _changeMode(_currentTabIndex, mode);
            },
            itemBuilder:
                (BuildContext context) => [
                  const PopupMenuItem<CalculatorMode>(
                    value: CalculatorMode.standard,
                    child: Text('Standard Calculator'),
                  ),
                  const PopupMenuItem<CalculatorMode>(
                    value: CalculatorMode.loan,
                    child: Text('Loan Calculator'),
                  ),
                  const PopupMenuItem<CalculatorMode>(
                    value: CalculatorMode.currency,
                    child: Text('Currency Calculator'),
                  ),
                  const PopupMenuItem<CalculatorMode>(
                    value: CalculatorMode.bmi,
                    child: Text('BMI Calculator'),
                  ),
                  const PopupMenuItem<CalculatorMode>(
                    value: CalculatorMode.unit,
                    child: Text('Unit Converter'),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          CalculatorTabBar(
            tabs: _tabs,
            tabController: _tabController,
            currentTabIndex: _currentTabIndex,
            onTabSelected: (index) {
              setState(() {
                _currentTabIndex = index;
                _tabController.index = index;
              });
            },
            onTabRemoved: _removeTab,
            onTabRenamed: _renameTab,
            onAddTab: _addTab,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  _tabs.asMap().entries.map((entry) {
                    int index = entry.key;
                    CalculatorTab tab = entry.value;
                    return CalculatorContent(
                      tab: tab,
                      onTabUpdated:
                          (updatedTab) => _updateTab(index, updatedTab),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
