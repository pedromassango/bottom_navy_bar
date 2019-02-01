# BottomNavyBar

A beautiful and animated bottom navigation. The navigation bar use your current theme, but you are free to customize it.

## Preview

![FanBottomNavyBar Gif](navy2.gif "BottomNavyBar")

## Getting Started

Add the plugin:

```yaml
dependencies:
  ...
  bottom_navy_bar: ^0.1.0
```

## Basic Usage

Adding the widget
```dart
bottomNavigationBar: BottomNavyBar(
        onItemSelected: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavyBarItem(icon: Icon(Icons.apps), title: Text('Home')),
          BottomNavyBarItem(icon: Icon(Icons.people), title: Text('Users')),
          BottomNavyBarItem(icon: Icon(Icons.message), title: Text('Messages')),
          BottomNavyBarItem(icon: Icon(Icons.settings), title: Text('Settings')),
        ],
)
```

## Customization (Optional)
**iconSize** - the item icon's size<br/>
**activeColor** - the active item's background color<br/>
**inactiveColor** - the inactive item's icon color<br/>
**backgroundColor** - the navigation bar's background color
