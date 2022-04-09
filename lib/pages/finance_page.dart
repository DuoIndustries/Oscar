import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tinkoff_invest/tinkoff_invest.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oscar/models/local_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';

class FinancePage extends StatefulWidget {
  @override
  _FinancePageState createState() => _FinancePageState();
}


class _FinancePageState extends State<FinancePage> {

  Storage _storage = Storage();

  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  bool isTinkoffToken = false;
  static String tinkoff_token = '';

  double allBalance = 0;

  TinkoffInvestApi tinkoffApi = TinkoffInvestApi(tinkoff_token);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      checkTinkoffApi();
    });
  }

  void checkTinkoffApi() async {
    double sum = 0;
    final snapshot = await firestoreInstance.collection('users').doc(await _storage.readData('uid')).get();
    if (snapshot.data()!['tinkoff_token'] != '') {
      setState(() {
        isTinkoffToken = true;
        tinkoff_token = snapshot.data()!['tinkoff_token'];
        tinkoffApi = TinkoffInvestApi(tinkoff_token);
      });
    }
    final portfolioCurrency = await tinkoffApi.portfolio.currencies();
    if (portfolioCurrency.isValue) {
      portfolioCurrency.asValue!.value..payload.currencies.forEach((element) {
        if (element.currency == Currency.RUB) {
          setState(() {
            sum += element.balance;
          });
        }
      });
    }

    final portfolioRes = await tinkoffApi.portfolio.load();
    if (portfolioRes.isValue) {
      portfolioRes.asValue!.value.payload.positions.forEach((element) async {
        setState(() {
          sum += element.balance * element.averagePositionPrice!.value;
        });
        setState(() {
          allBalance = sum;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
          child: Text(((allBalance * 100.0).round() / 100.0).toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: Colors.black87)),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Center(
          child: OutlinedButton(
            onPressed: () {
              Navigator.push((context), MaterialPageRoute(builder: (context) => AnalyticsPage(tinkoffApi)));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.03,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(FontAwesomeIcons.chartPie, color: Colors.black87),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Text('Аналитика', style: TextStyle(fontSize: 20, color: Colors.black87),)
                    ],
                  )
                ],
              ),
            ),
            style: OutlinedButton.styleFrom(
                primary: Colors.black12,
                padding: EdgeInsets.all(10),
            ),
          ),
        )
      ],
    );
  }
}


class AnalyticsPage extends StatefulWidget {

  TinkoffInvestApi tinkoffApi;

  AnalyticsPage(this.tinkoffApi);


  @override
  _AnalyticsPageState createState() => _AnalyticsPageState(tinkoffApi);
}

class _AnalyticsPageState extends State<AnalyticsPage> with TickerProviderStateMixin {

  TinkoffInvestApi tinkoffApi;

  _AnalyticsPageState(this.tinkoffApi);

  late TooltipBehavior _tooltipBehavior;

  final List<ChartData> portfolioAssets = [];

  final List<HistoryData> userHistory = [];

  @override
  void initState() {
    _tooltipBehavior =  TooltipBehavior(enable: true);
    super.initState();
    tinkoffInit();
  }

  void tinkoffInit() async {
    final portfolioRes = await tinkoffApi.portfolio.load();
    if (portfolioRes.isValue) {
      portfolioRes.asValue!.value.payload.positions.forEach((element) {
        setState(() {
          portfolioAssets.add(ChartData(element.name, element.balance * element.averagePositionPrice!.value));
        });
      });
    }
    final out = await tinkoffApi.operations.load(DateTime.parse('2021-01-01'), DateTime.parse('2022-04-09'));
    out.asValue!.value.payload.operations.forEach((element) {
      if (element.operationType == OperationTypeWithCommission.sell && element.status == OperationStatus.done) {
        print(element);
        setState(() {
          userHistory.add(HistoryData('Тинькофф банк', element.payment, element.date, Icon(FontAwesomeIcons.moneyBillTransfer, color: Colors.greenAccent,)));
        });
      } else if (element.operationType == OperationTypeWithCommission.buy && element.status == OperationStatus.done) {
        print(element);
        setState(() {
          userHistory.add(HistoryData('Тинькофф банк', element.payment, element.date, Icon(FontAwesomeIcons.moneyBillTransfer, color: Colors.greenAccent)));
        });
      }
    });
    userHistory.forEach((element) {
      print(element.cost);
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    TabController tabControllerBalance = TabController(length: 2, vsync: this);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text('Аналитика')
              ],
            )
          ),
          Container(
            child: TabBar(
              controller: tabController,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Портфель',),
                Tab(text: 'Баланс',),
                Tab(text: 'Операции',)
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 300, left: 20, right: 20),
                  child: SfCartesianChart(
                    legend: Legend(isVisible: true),
                    series: <ChartSeries>[
                      SplineAreaSeries<ExpenseData, String>(
                          dataSource: [
                            ExpenseData('1', 3),
                            ExpenseData('2', 5)
                          ],
                          xValueMapper: (ExpenseData exp, _) => exp.category,
                          yValueMapper: (ExpenseData exp, _) => exp.value,
                          name: 'Доход',
                          markerSettings: MarkerSettings(
                            isVisible: true,
                          )),
                      SplineAreaSeries<ExpenseData, String>(
                          dataSource: [
                            ExpenseData('1', 2),
                            ExpenseData('2', 3)
                          ],
                          xValueMapper: (ExpenseData exp, _) => exp.category,
                          yValueMapper: (ExpenseData exp, _) => exp.value,
                          name: 'Расходы',
                          markerSettings: MarkerSettings(
                            isVisible: true,
                          )),
                    ],
                    primaryXAxis: CategoryAxis(),
                  )
                ),
                Container(
                  padding: EdgeInsets.only(right: 50, left: 50),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        child: TabBar(
                          controller: tabControllerBalance,
                          labelColor: Colors.black87,
                          indicator: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          tabs: [
                            Container(
                              height: 40,
                              child: Center(child: Text('Активы'),),
                            ),
                            Container(
                              height: 40,
                              child: Center(child: Text('Банки'),),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            controller: tabControllerBalance,
                            children: [
                              SfCircularChart(
                                tooltipBehavior: _tooltipBehavior,
                                legend: Legend(isVisible: true),
                                series: <CircularSeries>[
                                  PieSeries<ChartData, String>(
                                      dataSource: portfolioAssets,
                                      enableTooltip: true,
                                      xValueMapper: (ChartData data, _) => data.x,
                                      yValueMapper: (ChartData data, _) => data.y,
                                      dataLabelSettings: DataLabelSettings(isVisible: true)
                                  )
                                ],
                              ),
                              Text('2')
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: userHistory.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 15),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2
                              )]
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                  child:  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    width: 60,
                                    child: SvgPicture.asset('assets/svg/tinkoff_app.svg'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(userHistory[index].bank, style: TextStyle(fontSize: 20),),
                                ),
                                Center(
                                  child:  Container(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Text(userHistory[index].cost.toString(), style: TextStyle(fontSize: 18, color: userHistory[index].cost > 0 ? Colors.greenAccent : Colors.redAccent),),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class ExpenseData {
  ExpenseData(
      this.category, this.value);
  final String category;
  final num value;
}

class HistoryData {
  HistoryData(
      this.bank, this.cost, this.dateTime, this.icon
      );
  final String bank;
  final double cost;
  final DateTime dateTime;
  final Icon icon;
}