import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_api_implement/repositries/rest_api.dart';
import 'package:task_api_implement/views/common_widgets/TextFieldContainerWidget.dart';

import '../home_screen.dart';
import 'create_account_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoginPageBody(),
      ),
    );
  }
}

class LoginPageBody extends StatefulWidget {
  LoginPageBody({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  var _mailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String _mail = '';
  String _password = '';
  bool _obscureTextNewPass = true;
  IconData _iconVisibleNewPass = Icons.visibility_off;

  void _toggleNewPass() {
    setState(() {
      _obscureTextNewPass = !_obscureTextNewPass;
      if (_obscureTextNewPass == true) {
        _iconVisibleNewPass = Icons.visibility_off;
      } else {
        _iconVisibleNewPass = Icons.visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/app_images/logo.jpg',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _textField(
                      controller: _mailController,
                      icon: Icons.person,
                      isObsecureText: false,
                      maxlines: 1,
                      isHidTap: false,
                      hint: 'User Name',
                      forr: 'mail',
                      isEmptyMsg: 'Enter your user name',
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: 10,
                  ),
                  _textField(
                      controller: _passwordController,
                      icon: Icons.lock,
                      maxlines: 1,
                      isObsecureText: _obscureTextNewPass,
                      isHidTap: true,
                      hint: 'Enter password',
                      forr: 'pass',
                      isEmptyMsg: 'Enter your Password ',
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _signInUser(context);
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(CreateAccountScreen());
                      },
                      child: Text('Create an account here')),
                  SizedBox(
                    height: size.width * 0.15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(
      {controller,
      hint,
      icon,
      maxlines,
      forr,
      bool isObsecureText,
      isHidTap,
      isEmptyMsg,
      keyboardType}) {
    return TextFieldContainerWidget(
      child: TextFormField(
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        controller: controller,
        obscureText: isObsecureText,
        keyboardType: keyboardType,
        maxLines: maxlines,
        decoration: InputDecoration(
            icon: Icon(icon, color: Colors.green),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.green),
            border: InputBorder.none,
            suffixIcon: isHidTap == true
                ? IconButton(
                    icon: Icon(_iconVisibleNewPass,
                        color: Colors.green, size: 20),
                    onPressed: () {
                      _toggleNewPass();
                    })
                : IconButton(
                    icon:
                        Icon(_iconVisibleNewPass, color: Colors.white, size: 0),
                    onPressed: () {
                      _toggleNewPass();
                    })),
        validator: (value) {
          return _validate(value, forr, isEmptyMsg);
        },
        onSaved: (newValue) {
          return _save(newValue, forr);
        },
      ),
    );
  }

  _validate(String value, String forr, String isEmptyMsg) {
    if (value.isEmpty) {
      return isEmptyMsg;
    }
    if (forr == 'pass' && value.length < 6) {
      return 'Incorrect password';
    }
    return null;
  }

  void _signInUser(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      /*
      "username": "adnan postman check",
        "password": "12345678"
       */
      Map<String, dynamic> loginMap = {
        "username": _mailController.text,
        "password": _passwordController.text
      };
      print('loginMap' + loginMap.toString());

      Get.defaultDialog(
        backgroundColor: Colors.blue,
        title: 'Loading...',
        radius: 20.0,
        content: CupertinoActivityIndicator(
          animating: true,
          radius: 10.0,
        ),
      );

      RestApiRepository().login(loginMap).then((value) {
        if (value) {
          Get.back();
          Get.snackbar('Success', 'Login has successful!');
          Get.to(HomeScreen());
        } else {
          Get.snackbar('Error ', 'Login has wrong!');
        }
      }).catchError((error) {
        Get.back();
        Get.snackbar(
          'Server Error',
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });
    }
  }

  _save(String newValue, forr) {
    if (forr == 'mail') {
      return _mail = newValue;
    }
    if (forr == 'pass') {
      return _password = newValue;
    }
  }
}
