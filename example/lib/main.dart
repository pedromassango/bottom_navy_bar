
import 'package:Yazhiragu/ui/homepage/bottomnav.dart';
import 'package:flutter/material.dart';
import 'dart:async';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  PageController pageController = PageController(initialPage: 0);


  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Center(
            child: Text('PAGE 1'),
          ),
          Center(
            child: Text('PAGE 2'),
          ),
          Center(
            child: Text('PAGE 3'),
          )
        ],
      ),
      bottomNavigationBar:       
      StreamBuilder(
        stream: indexcontroller.stream,
        initialData: 0,
        builder: (c,snap){
         int currentindex = snap.data;
         return BottomNav(
        currentIndex: currentindex,
        onItemSelected:onItmSelected,
        items: [
          BottomNavItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
          ),
          BottomNavItem(
              icon: Icon(Icons.people),
              title: Text('Users'),
              activeColor: Colors.purpleAccent
          ),
          BottomNavItem(
              icon: Icon(Icons.message),
              title: Text('Messages'),
              activeColor: Colors.pink
          ),
        ],
      );
        },
      )

    );
  }

void onPageChanged(int pageIndex){
  indexcontroller.add(pageIndex);
}


  void onItmSelected(int itemIndex){
   indexcontroller.add(itemIndex);
   pageController.jumpToPage(itemIndex);
  }
}
