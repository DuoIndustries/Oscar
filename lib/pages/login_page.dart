import 'package:flutter/material.dart';
import 'package:oscar/pages/home_page.dart';
import 'registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oscar/models/local_storage.dart';

class LoginPage extends StatefulWidget{

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Storage _storage = Storage();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController loginController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final loginField = TextFormField(
      autofocus: false,
      controller: loginController,
      keyboardType: TextInputType.emailAddress,
      validator: (value)  {
        if (value!.isEmpty) {
          return "Логин не введён";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Введите валидный логин");
        }
        return null;
      },
      onSaved: (value) {
        loginController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Логин'
      ),
      cursorColor: Colors.deepPurpleAccent,
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      keyboardType: TextInputType.emailAddress,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{8,}$');
          if (value!.isEmpty) {
            return ("Пароль не введён");
          }
          if (!regex.hasMatch(value)) {
            return ("Пароль должен содержать более 8 символов");
          }
        },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Пароль',
      ),
      cursorColor: Colors.deepPurpleAccent,
    );

    final loginButton = Material(
      elevation: 5,
      color: Colors.greenAccent,
      borderRadius: BorderRadius.circular(12),
      child: MaterialButton(
        onPressed: () {
          signIn(loginController.text, passwordController.text);
        },
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: Text('Войти', style: TextStyle(color: Colors.white, fontSize: 18),),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Image.asset(
                  "assets/launch_image.png",
                  height: 200.0,
                  width: 200.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: loginField,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: passwordField,
                      ),
                      SizedBox(
                        height: 160,
                      ),
                      loginButton,
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                  },
                  child: Text('Зарегистрироваться', style: TextStyle(fontSize: 16, color: Colors.greenAccent),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) {
        Fluttertoast.showToast(msg: "Авторизация успешна");
        _storage.writeData('uid', uid.user!.uid);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage())).then((value) => {
        });
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}