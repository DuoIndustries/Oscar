import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex  = index;
            });
          },
          children: <Widget> [
            Container(color: Colors.blueGrey,),
            Container(color: Colors.red,),
            Container(color: Colors.green,),
            Container(color: Colors.blue,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Главная'),
              icon: Icon(Icons.home),
              activeColor: Colors.greenAccent,
              inactiveColor: Colors.teal
          ),
          BottomNavyBarItem(
              title: Text('Задачи'),
              icon: Icon(Icons.assignment),
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Colors.teal
          ),
          BottomNavyBarItem(
              title: Text('Финансы'),
              icon: Icon(Icons.account_balance_wallet),
              activeColor: Colors.amberAccent,
              inactiveColor: Colors.teal
          ),
        ],
      ),
    );
  }
}