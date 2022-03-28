import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}


class _RegistrationPageState extends State<RegistrationPage> {

  final _formKey = GlobalKey<FormState>();

  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final loginEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final passwordConfirmEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.face),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Имя'
      ),
      cursorColor: Colors.deepPurpleAccent,
    );

    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.face),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Фамилия'
      ),
      cursorColor: Colors.deepPurpleAccent,
    );

    final loginField = TextFormField(
      autofocus: false,
      controller: loginEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        loginEditingController.text = value!;
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
      controller: passwordEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Пароль'
      ),
      cursorColor: Colors.deepPurpleAccent,
    );

    final passwordConfirmField = TextFormField(
      autofocus: false,
      controller: passwordConfirmEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        passwordConfirmEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Подтвердить пароль'
      ),
      cursorColor: Colors.deepPurpleAccent,
    );

    final  registerButton = Material(
      elevation: 5,
      color: Colors.greenAccent,
      borderRadius: BorderRadius.circular(12),
      child: MaterialButton(
        onPressed: () {},
        minWidth: MediaQuery.of(context).size.width * 0.8,
        child: Text('Зарегистрироваться', style: TextStyle(color: Colors.white, fontSize: 18),),
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Image.asset(
              "assets/launch_image.png",
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: firstNameField,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: secondNameField,
            ),
            SizedBox(
              height: 20,
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
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: passwordConfirmField,
            ),
            SizedBox(
              height: 100,
            ),
            registerButton
          ],
        ),
      ),
    );
  }
}