import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final List<BottomNavyBarItem> dummyItems = <BottomNavyBarItem>[
  BottomNavyBarItem(
    icon: Icon(Icons.apps),
    title: Text('Item 1'),
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: Icon(Icons.people),
    title: Text('Item 2'),
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: Icon(Icons.message),
    title: Text('Item 3'),
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: Icon(Icons.settings),
    title: Text('Item 4'),
    textAlign: TextAlign.center,
  ),
];

final ValueChanged<int> onItemSelected = (int index) {};

final BottomNavigationBarThemeData dummyThemeData =
    BottomNavigationBarThemeData(
  selectedIconTheme: IconThemeData(
    color: Colors.green,
  ),
  selectedItemColor: Colors.green,
  selectedLabelStyle: TextStyle(
    color: Colors.green,
  ),
  unselectedIconTheme: IconThemeData(
    color: Colors.red,
  ),
  unselectedItemColor: Colors.red,
  unselectedLabelStyle: TextStyle(
    color: Colors.red,
  ),
  backgroundColor: Colors.pink,
  elevation: 5,
);

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
        itemCornerRadius: itemCornerRadius ?? 50,
        curve: curve ?? Curves.linear,
        onItemSelected: onItemSelected,
        items: dummyItems,
      ),
    ),
  );
}

void main() {
  testWidgets('default values are used when not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: BottomNavyBar(
            onItemSelected: onItemSelected,
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: Icon(Icons.apps),
                title: Text('Item 1'),
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.people),
                title: Text('Item 2'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    expect(
        tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).selectedIndex,
        0);
    expect(
        tester
            .widget<BottomNavyBar>(find.byType(BottomNavyBar))
            .itemCornerRadius,
        50);
    expect(
        tester
            .widget<BottomNavyBar>(find.byType(BottomNavyBar))
            .containerHeight,
        56);
    expect(
        tester
            .widget<BottomNavyBar>(find.byType(BottomNavyBar))
            .animationDuration,
        const Duration(milliseconds: 270));
    expect(
        tester
            .widget<BottomNavyBar>(find.byType(BottomNavyBar))
            .mainAxisAlignment,
        MainAxisAlignment.spaceBetween);
    expect(tester.widget<BottomNavyBar>(find.byType(BottomNavyBar)).curve,
        Curves.linear);
  });

  testWidgets(
      'throws assertion error if items is less than two or greater than five',
      (WidgetTester tester) async {
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

  testWidgets(
    'tests functionality when BottemNavigationBarThemeData is provided in material theme',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            bottomNavigationBarTheme: dummyThemeData,
          ),
          home: Scaffold(
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: 0,
              onItemSelected: onItemSelected,
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(Icons.apps),
                  title: Text('Item 1'),
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.people),
                  title: Text('Item 2'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );

      final navbar = find.byType(BottomNavyBar);

      /// check base theming
      final material = find
          .descendant(of: navbar, matching: find.byType(Material))
          .first
          .evaluate()
          .single
          .widget as Material;

      expect(material.color, Colors.pink);
      expect(material.elevation, 5);

      final navyBarItems = find.byType(ItemWidget);
      expect(navyBarItems, findsNWidgets(2));

      /// check selected item theming
      final selected = navyBarItems.first;

      final selectedBackground = find
          .descendant(of: selected, matching: find.byType(AnimatedContainer))
          .first
          .evaluate()
          .single
          .widget as AnimatedContainer;
      expect(
        (selectedBackground.decoration as BoxDecoration).color,
        Colors.green,
      );

        final selectedIcon = find
          .descendant(of: selected, matching: find.byType(IconTheme))
          .first
          .evaluate()
          .single
          .widget as IconTheme;
      expect(selectedIcon.data.color, Colors.green); 

      final selectedText = find
          .descendant(of: selected, matching: find.byType(DefaultTextStyle))
          .first
          .evaluate()
          .single
          .widget as DefaultTextStyle;
      expect(selectedText.style.color, Colors.green);

      /// check unselected item theming
      final unselected = navyBarItems.last;

      final unselectedBackground = find
          .descendant(of: unselected, matching: find.byType(AnimatedContainer))
          .first
          .evaluate()
          .single
          .widget as AnimatedContainer;
      expect(
        (unselectedBackground.decoration as BoxDecoration).color,
        Colors.red,
      );

     final unselectedIcon = find
          .descendant(of: unselected, matching: find.byType(IconTheme))
          .first
          .evaluate()
          .single
          .widget as IconTheme;
      expect(unselectedIcon.data.color, Colors.red); 
      
    },
  );




  testWidgets(
    'tests functionality when BottemNavigationBarThemeData is provided to the bottomNavybar directly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: 0,
              onItemSelected: onItemSelected,
              theme: dummyThemeData,
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(Icons.apps),
                  title: Text('Item 1'),
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.people),
                  title: Text('Item 2'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );

      final navbar = find.byType(BottomNavyBar);

      /// check base theming
      final material = find
          .descendant(of: navbar, matching: find.byType(Material))
          .first
          .evaluate()
          .single
          .widget as Material;

      expect(material.color, Colors.pink);
      expect(material.elevation, 5);

      final navyBarItems = find.byType(ItemWidget);
      expect(navyBarItems, findsNWidgets(2));

      /// check selected item theming
      final selected = navyBarItems.first;

      final selectedBackground = find
          .descendant(of: selected, matching: find.byType(AnimatedContainer))
          .first
          .evaluate()
          .single
          .widget as AnimatedContainer;
      expect(
        (selectedBackground.decoration as BoxDecoration).color,
        Colors.green,
      );

        final selectedIcon = find
          .descendant(of: selected, matching: find.byType(IconTheme))
          .first
          .evaluate()
          .single
          .widget as IconTheme;
      expect(selectedIcon.data.color, Colors.green); 

      final selectedText = find
          .descendant(of: selected, matching: find.byType(DefaultTextStyle))
          .first
          .evaluate()
          .single
          .widget as DefaultTextStyle;
      expect(selectedText.style.color, Colors.green);

      /// check unselected item theming
      final unselected = navyBarItems.last;

      final unselectedBackground = find
          .descendant(of: unselected, matching: find.byType(AnimatedContainer))
          .first
          .evaluate()
          .single
          .widget as AnimatedContainer;
      expect(
        (unselectedBackground.decoration as BoxDecoration).color,
        Colors.red,
      );

     final unselectedIcon = find
          .descendant(of: unselected, matching: find.byType(IconTheme))
          .first
          .evaluate()
          .single
          .widget as IconTheme;
      expect(unselectedIcon.data.color, Colors.red); 
      
    },
  );
  
}
