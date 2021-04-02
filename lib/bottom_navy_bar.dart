library bottom_navy_bar;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A beautiful and animated bottom navigation that paints a rounded shape
/// around its [items] to provide a wonderful look.
///
/// Update [selectedIndex] to change the selected item.
/// [selectedIndex] is required and must not be null.
class BottomNavyBar extends StatelessWidget {
  BottomNavyBar({
    Key? key,
    this.theme,
    this.selectedIndex = 0,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  /// The selected item is index. Changing this property will change and animate
  /// the item being selected. Defaults to zero.
  final int selectedIndex;

  /// The  bottom navigation bar theme. It defaults to
  /// [Theme.BottomNavigationBarTheme] if not provided.
  final BottomNavigationBarThemeData? theme;

  /// Use this to change the item's animation duration. Defaults to 270ms.
  final Duration animationDuration;

  /// Defines the appearance of the buttons that are displayed in the bottom
  /// navigation bar. This should have at least two items and five at most.
  final List<BottomNavyBarItem> items;

  /// A callback that will be called when a item is pressed.
  final ValueChanged<int> onItemSelected;

  /// Defines the alignment of the items.
  /// Defaults to [MainAxisAlignment.spaceBetween].
  final MainAxisAlignment mainAxisAlignment;

  /// The [items] corner radius, if not set, it defaults to 50.
  final double itemCornerRadius;

  /// Defines the bottom navigation bar height. Defaults to 56.
  final double containerHeight;

  /// Used to configure the animation curve. Defaults to [Curves.linear].
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarThemeData _theme =
        theme ?? BottomNavigationBarTheme.of(context);

    return Material(
      elevation: _theme.elevation ?? 0,
      color: _theme.backgroundColor,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: ItemWidget(
                  item: item,
                  theme: _theme,
                  isSelected: index == selectedIndex,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

@visibleForTesting
class ItemWidget extends StatelessWidget {
  final bool isSelected;
  final BottomNavyBarItem item;
  final BottomNavigationBarThemeData theme;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.theme,
    required this.animationDuration,
    required this.itemCornerRadius,
    this.curve = Curves.linear,
  }) : super(key: key);

  /// assuring correct default theming and allowing for per item customization
  /// is a bit unneccesarily complicated, see this issue:
  /// https://github.com/flutter/flutter/issues/72685

  @visibleForTesting
  Color bgColor(BuildContext context) {
    final selected = item.activeColor?.withOpacity(0.2) ??
        theme.selectedItemColor ??
        Theme.of(context).primaryColor;
    final unselected = item.inactiveColor?.withOpacity(0.2) ??
        theme.unselectedItemColor ??
        Theme.of(context).scaffoldBackgroundColor;

    return isSelected ? selected : unselected;
  }

  @visibleForTesting
  IconThemeData get iconTheme => _iconTheme;
  IconThemeData get _iconTheme {
    final selected = theme.selectedIconTheme?.copyWith(
          color: item.activeColor ?? null,
        ) ??
        IconThemeData.fallback().copyWith(color: item.activeColor ?? null);
    final unselected = theme.unselectedIconTheme
            ?.copyWith(color: item.inactiveColor ?? null) ??
        IconThemeData.fallback().copyWith(color: item.inactiveColor ?? null);
    return isSelected ? selected : unselected;
  }

  @visibleForTesting
  TextStyle get labelStyle => _labelStyle;
  TextStyle get _labelStyle {
    final selected =
        theme.selectedLabelStyle?.copyWith(color: item.activeColor ?? null) ??
            TextStyle(color: item.activeColor ?? null);
    final unselected = theme.unselectedLabelStyle
            ?.copyWith(color: item.inactiveColor ?? null) ??
        TextStyle(color: item.inactiveColor ?? null);
    return isSelected ? selected : unselected;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: bgColor(context),
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 130 : 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: _iconTheme,
                  child: item.icon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                        style: _labelStyle,
                        maxLines: 1,
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The [BottomNavyBar.items] definition.
class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor,
    this.textAlign,
    this.inactiveColor,
  });

  /// Defines this item's icon which is placed in the right side of the [title].
  final Widget icon;

  /// Defines this item's title which placed in the left side of the [icon].
  final Widget title;

  /// The [icon] and [title] color defined when this item is selected. Defaults
  /// to [Colors.blue].
  final Color? activeColor;

  /// The [icon] and [title] color defined when this item is not selected.
  final Color? inactiveColor;

  /// The alignment for the [title].
  ///
  /// This will take effect only if [title] it a [Text] widget.
  final TextAlign? textAlign;
}
