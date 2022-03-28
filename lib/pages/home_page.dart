import 'package:flutter/material.dart';
import 'main_page.dart';
import 'tasks_page.dart';
import 'finance_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final List<Widget> pages = [
    MainPage(),
    TasksPage(),
    FinancePage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = MainPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.album),
        backgroundColor: Colors.grey,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            MainPage(); // if user taps on this dashboard tab will be active
                        _currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: _currentIndex == 0 ? Colors.greenAccent : Colors.grey,
                        ),
                        Text(
                          'Главная',
                          style: TextStyle(
                            color: _currentIndex == 0 ? Colors.greenAccent : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            TasksPage(); // if user taps on this dashboard tab will be active
                        _currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.assignment,
                          color: _currentIndex == 1 ? Colors.deepPurpleAccent : Colors.grey,
                        ),
                        Text(
                          'Задачи',
                          style: TextStyle(
                            color: _currentIndex == 1 ? Colors.deepPurpleAccent : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            FinancePage(); // if user taps on this dashboard tab will be active
                        _currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_balance_wallet,
                          color: _currentIndex == 2 ? Colors.amberAccent : Colors.grey,
                        ),
                        Text(
                          'Финансы',
                          style: TextStyle(
                            color: _currentIndex == 2 ? Colors.amberAccent : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}