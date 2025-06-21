# Multi Calculator App

A comprehensive Flutter calculator application with multiple calculator modes and tabbed interface.

## Features

### 🎨 Theme
- Black, white, and orange color scheme
- Modern and clean UI design

### 📱 Multiple Calculator Modes
- **Standard Calculator**: Basic arithmetic operations
- **Loan Calculator**: Calculate monthly payments
- **Currency Calculator**: Convert between currencies
- **BMI Calculator**: Calculate Body Mass Index
- **Unit Converter**: Convert between different units

### 🗂️ Tabbed Interface
- Multiple calculation tabs (like browser tabs)
- Add new tabs with the + button
- Remove tabs with the X button (if more than 1 tab)
- Rename tabs by long-pressing on them
- Each tab maintains its own calculation history

### 📊 History Feature
- All calculations are stored in history
- History is displayed in darker gray above current expression
- History persists as you continue calculating

## How to Use

1. **Switch Calculator Modes**: Use the menu button (☰) in the app bar to switch between different calculator types
2. **Add New Tabs**: Click the + button to add a new calculation tab
3. **Remove Tabs**: Click the X button on any tab (except the last one)
4. **Rename Tabs**: Long-press on any tab to rename it
5. **View History**: Previous calculations appear in the darker gray area above the current expression

## Running the App

```bash
# Navigate to the project directory
cd calc_app

# Get dependencies
flutter pub get

# Run on web (Edge/Chrome)
flutter run -d edge

# Run on Windows (requires Visual Studio)
flutter run -d windows

# Run on Android (requires Android setup)
flutter run -d android
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── calculator_mode.dart  # Enum for different calculator types
│   └── calculator_tab.dart   # Model for tab data
├── screens/
│   └── calculator_screen.dart # Main screen with tab management
└── widgets/
    ├── calculator_tab_bar.dart    # Custom tab bar widget
    ├── calculator_content.dart    # Content area with history display
    ├── standard_calculator.dart   # Standard calculator interface
    ├── loan_calculator.dart       # Loan calculator interface
    ├── currency_calculator.dart   # Currency converter interface
    ├── bmi_calculator.dart        # BMI calculator interface
    └── unit_converter.dart        # Unit converter interface
```

## Adding New Calculator Modes

To add new calculator modes:

1. Add the new mode to the `CalculatorMode` enum in `lib/models/calculator_mode.dart`
2. Create a new widget file in `lib/widgets/`
3. Add the new mode to the menu in `lib/screens/calculator_screen.dart`
4. Add the case in `_buildCalculatorByMode()` in `lib/widgets/calculator_content.dart`

## Requirements

- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher
- For Windows development: Visual Studio with "Desktop development with C++" workload
- For Android development: Android Studio and Android SDK
- For web development: Chrome or Edge browser 