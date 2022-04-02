import 'package:flutter/material.dart';
import 'main_page.dart';
import 'tasks_page.dart';
import 'finance_page.dart';
import 'functions_page.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:avatar_glow/avatar_glow.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  var _speechToText = SpeechToText();
  bool isListening = false;
  String recognizedText = '';

  void listen() async {
    if (!isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (status) => print("$status"),
        onError: (errorNotification) => print("$errorNotification")
      );
      if (available) {
        setState(() {
          isListening = true;
        });
        _speechToText.listen(
          onResult: (result) => setState(() {
            recognizedText = result.recognizedWords;
            print(recognizedText);
          }),
        );
      }
    } else {
      setState(() {
        isListening = false;
      });
      _speechToText.stop();
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
                boxShadow: [BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10
                )]
              ),
            ),
            currentScreen
          ],
        ),
        bucket: bucket,
      ),
      floatingActionButton: AvatarGlow(
        animate: isListening,
        repeat: true,
        showTwoGlows: true,
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(Size(50, 50)),
          onPressed: () {
            listen();
          },
          child: Icon(Icons.mic, size: 30, color: Colors.white),
          fillColor: Colors.greenAccent,
          shape: CircleBorder(),
          padding: EdgeInsets.all(0),
        ),
        endRadius: 30,
        glowColor: Colors.redAccent,
        duration: Duration(milliseconds: 2000),
        repeatPauseDuration: Duration(milliseconds: 100),
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
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            FunctionsPage(); // if user taps on this dashboard tab will be active
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_tree_sharp,
                          color: _currentIndex == 3 ? Colors.redAccent : Colors.grey,
                        ),
                        Text(
                          'Функции',
                          style: TextStyle(
                            color: _currentIndex == 3 ? Colors.redAccent : Colors.grey,
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