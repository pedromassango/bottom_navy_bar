library bottom_navy_bar;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavyBar extends StatefulWidget {
  int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final bool limitedNumberOfItems;
  final int selectedWidth;
  final int unselectedWidth;

  BottomNavyBar(
      {Key key,
      this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      this.backgroundColor,
      this.limitedNumberOfItems = true,
      this.selectedWidth = 130,
      this.unselectedWidth = 50,
      @required this.items,
      @required this.onItemSelected}) {
    assert(items != null);
    assert(items.length >= 2 && (items.length <= 5 || !limitedNumberOfItems));
    assert(onItemSelected != null);
  }

  @override
  _BottomNavyBarState createState() {
    return _BottomNavyBarState(
        items: items,
        backgroundColor: backgroundColor,
        iconSize: iconSize,
        onItemSelected: onItemSelected,
        limitedNumberOfItems: limitedNumberOfItems,
        selectedWidth: selectedWidth,
        unselectedWidth: unselectedWidth);
  }
}

class _BottomNavyBarState extends State<BottomNavyBar> {
  final double iconSize;
  Color backgroundColor;
  List<BottomNavyBarItem> items;

  ValueChanged<int> onItemSelected;
  final bool limitedNumberOfItems;
  final int selectedWidth;
  final int unselectedWidth;

  @override
  void initState() {
    super.initState();
  }

  _BottomNavyBarState(
      {@required this.items,
      this.backgroundColor,
      this.iconSize,
      @required this.onItemSelected,
      this.limitedNumberOfItems,
      this.selectedWidth,
      this.unselectedWidth});

  Widget _buildItem(BottomNavyBarItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected
          ? this.selectedWidth.toDouble()
          : this.unselectedWidth.toDouble(),
      height: double.maxFinite,
      duration: Duration(milliseconds: 270),
      padding: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected
                          ? item.activeColor.withOpacity(1)
                          : item.inactiveColor == null
                              ? item.activeColor
                              : item.inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(
                          color: item.activeColor, fontWeight: FontWeight.bold),
                      child: item.title,
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      decoration: BoxDecoration(color: backgroundColor, boxShadow: [
        if (widget.showElevation)
          BoxShadow(color: Colors.black12, blurRadius: 2)
      ]),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 56,
          padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () {
                  onItemSelected(index);
                  setState(() {
                    widget.selectedIndex = index;
                  });
                },
                child: _buildItem(item, widget.selectedIndex == index),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;

  BottomNavyBarItem(
      {@required this.icon,
      @required this.title,
      this.activeColor = Colors.blue,
      this.inactiveColor}) {
    assert(icon != null);
    assert(title != null);
  }
}
