import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final List<BottomNavyBarItem> dummyItems = <BottomNavyBarItem>[
  BottomNavyBarItem(
    icon: Icon(Icons.apps),
    title: Text('Item 1'),
    activeColor: Colors.red,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: Icon(Icons.people),
    title: Text('Item 2'),
    activeColor: Colors.purpleAccent,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: Icon(Icons.message),
    title: Text('Item 3'),
    activeColor: Colors.pink,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: Icon(Icons.settings),
    title: Text('Item 4'),
    activeColor: Colors.blue,
    textAlign: TextAlign.center,
  ),
];

final ValueChanged<int> onItemSelected = (int index) {};

Widget buildNavyBarBoilerplate({
  Curve? curve,
  int? currentIndex,
  bool? showElevation,
  double? itemCornerRadius,
  required ValueChanged<int> onItemSelected,
}) {
  return MaterialApp(
    home: Scaffold(
      floatingActionButton: BottomNavyBar(
        selectedIndex: currentIndex ?? 0,
        showElevation: showElevation ?? true,
        itemCornerRadius: itemCornerRadius ?? 50,
        curve: curve ?? Curves.linear,
        onItemSelected: onItemSelected,
        items: dummyItems,
      ),
    ),
  );
}

void main() {
  testWidgets('default values are used when not provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: BottomNavyBar(
            onItemSelected: onItemSelected,
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: Icon(Icons.apps),
                title: Text('Item 1'),
                activeColor: Colors.red,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.people),
                title: Text('Item 2'),
                activeColor: Colors.purpleAccent,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    expect(tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).iconSize, 24.0);
    expect(tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).selectedIndex, 0);
    expect(tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).showElevation, true);
    expect(tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).itemCornerRadius, 50);
    expect(tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).containerHeight, 56);
    expect(tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).animationDuration, const Duration(milliseconds: 270));
    expect(tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).mainAxisAlignment, MainAxisAlignment.spaceBetween);
    expect(tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).curve, Curves.linear);
  });
  
  testWidgets('throws assertion error if items is less than two or greater than five', (WidgetTester tester) async {
    Widget boilerplate(List<BottomNavyBarItem> items) {
      return MaterialApp(
        home: Material(
          child: BottomNavyBar(
            onItemSelected: onItemSelected,
            items: items,
          ),
        ),
      );
    }

    // Less than two items, throw exception
    expect(() async {
      await tester.pumpWidget(boilerplate(<BottomNavyBarItem>[
        BottomNavyBarItem(icon: Icon(Icons.home), title: Text('')),
      ]));
    }, throwsAssertionError);

    // More than five items, throw exception
    expect(() async {
      await tester.pumpWidget(boilerplate(<BottomNavyBarItem>[
        BottomNavyBarItem(icon: Icon(Icons.home), title: Text('')),
        BottomNavyBarItem(icon: Icon(Icons.sports_soccer), title: Text('')),
        BottomNavyBarItem(icon: Icon(Icons.chat), title: Text('')),
        BottomNavyBarItem(icon: Icon(Icons.notifications), title: Text('')),
        BottomNavyBarItem(icon: Icon(Icons.person), title: Text('')),
        BottomNavyBarItem(icon: Icon(Icons.settings), title: Text('')),
      ]));
    }, throwsAssertionError);
  });

  testWidgets('show elevation when showElevation is true', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildNavyBarBoilerplate(
          showElevation: true,
          onItemSelected: onItemSelected,
        ),
    );

    final Container containerFinder = tester.firstWidget<Container>(find.byType(Container));

    expect((containerFinder.decoration as BoxDecoration).boxShadow, isNotNull);
    expect((containerFinder.decoration as BoxDecoration).boxShadow!.length, 1);
    expect((containerFinder.decoration as BoxDecoration).boxShadow!.first.blurRadius, 2);
  });
}
