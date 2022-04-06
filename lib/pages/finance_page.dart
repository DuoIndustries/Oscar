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


  TinkoffInvestApi tinkoffApi = TinkoffInvestApi(tinkoff_token, debug: false, sandboxMode: true);

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
    final portfolioRes = await tinkoffApi.portfolio.load();
    if (portfolioRes.isValue) {
      final portfolio = portfolioRes.asValue!.value.payload;
      print('Portfolio: ${portfolio.positions}');
    } else {
      print('Load portfolio failed: ${portfolioRes.asError!.error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
