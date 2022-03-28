import 'package:flutter/material.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget{

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController loginController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final loginField = TextFormField(
      autofocus: false,
      controller: loginController,
      keyboardType: TextInputType.emailAddress,
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
        onPressed: () {},
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
}