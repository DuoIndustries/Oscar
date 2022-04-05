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


  TinkoffInvestApi tinkoffApi = TinkoffInvestApi('', debug: true);

  @override
  void initState() {
    super.initState();
    checkTinkoffApi();
  }

  void checkTinkoffApi() async {
    await _storage.readData('uid').then((String? value) => {
      firestoreInstance.collection('users').doc(value).get().then((snapshot) async {
        if (snapshot.get('tinkoff_token') != '') {
          setState(() {
            isTinkoffToken = true;
            tinkoff_token = snapshot.get('tinkoff_token');
            tinkoffApi = TinkoffInvestApi(tinkoff_token, debug: true);
          });
        } else {
          isTinkoffToken = false;
        }
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
