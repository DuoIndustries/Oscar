import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinkoff_invest/tinkoff_invest.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oscar/models/local_storage.dart';

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
    checkTinkoffApi();
  }

  void checkTinkoffApi() async {
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
        print(element);
        if (element.currency == Currency.RUB) {
          setState(() {
            allBalance += element.balance;
          });
        }
      });
    }
    final portfolioRes = await tinkoffApi.portfolio.load();
    if (portfolioRes.isValue) {
      portfolioRes.asValue!.value.payload.positions.forEach((element) async {
        final marketPrice = await tinkoffApi.market.searchByTicker(element.ticker.toString());
        print(marketPrice.asValue!.value.payload.instruments.first);
        print(element);
        setState(() {
          allBalance += element.balance * element.averagePositionPrice!.value;
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
            onPressed: () {},
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
                      Icon(Icons.architecture, color: Colors.black87),
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
                primary: Colors.greenAccent,
                padding: EdgeInsets.all(10),
            ),
          ),
        )
      ],
    );
  }
}
