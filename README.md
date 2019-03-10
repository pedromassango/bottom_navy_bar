# BottomNavyBar

A beautiful and animated bottom navigation. The navigation bar use your current theme, but you are free to customize it.

## Preview

![FanBottomNavyBar Gif](navy.gif "BottomNavyBar")

## Getting Started

Add the plugin:

```yaml
dependencies:
  ...
  bottom_navy_bar: ^3.0.0
```

## Basic Usage

Adding the widget

```dart
bottomNavigationBar: BottomNavyBar(
   onItemSelected: (index) => setState(() {
       _index = index;
       _controller.animateTo(_index);
   }),
   items: [
     BottomNavyBarItem(
       icon: Icon(Icons.apps),
       title: Text('Home'),
       activeColor: Colors.red,
     ),
     BottomNavyBarItem(
         icon: Icon(Icons.people),
         title: Text('Users'),
         activeColor: Colors.purpleAccent
     ),
     BottomNavyBarItem(
         icon: Icon(Icons.message),
         title: Text('Messages'),
         activeColor: Colors.pink
     ),
     BottomNavyBarItem(
         icon: Icon(Icons.settings),
         title: Text('Settings'),
         activeColor: Colors.blue
     ),
   ],
)
```

## Customization (Optional)

### BottomNavyBar
**iconSize** - the item icon's size<br/>
**items** - navigation items, required more than one item and less than six<br/>
**onItemSelected** - required to listen when a item is tapped it provide the selected item's index<br/>
**backgroundColor** - the navigation bar's background color

### BottomNavyBarItem
**activeColor** - the active item's background and text color<br/>
**inactiveColor** - the inactive item's icon color<br/>
