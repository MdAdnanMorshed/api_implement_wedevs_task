import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_api_implement/repositries/rest_api.dart';
import 'package:task_api_implement/views/common_widgets/TextFieldContainerWidget.dart';

import 'login_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CreateAccount(),
      ),
    );
  }
}

class CreateAccount extends StatefulWidget {
  CreateAccount({
    Key key,
  }) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  var _userNameController = TextEditingController();
  var _mailAddressController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String _phone = '';
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
                  SizedBox(height: size.width / 4),
                  Image.asset(
                    'assets/app_images/logo.jpg',
                    width: 100,
                    height: 200,
                  ),
                  Text('Create Account '),
                  SizedBox(
                    height: 10,
                  ),
                  _textField(
                      controller: _userNameController,
                      icon: Icons.location_history,
                      isObsecureText: false,
                      maxlines: 1,
                      isHidTap: false,
                      hint: ' User Name ',
                      forr: 'name',
                      isEmptyMsg: 'Enter the user name ',
                      keyboardType: TextInputType.text),
                  _textField(
                      controller: _mailAddressController,
                      icon: Icons.email,
                      isObsecureText: false,
                      maxlines: 1,
                      isHidTap: false,
                      hint: 'Mail Address',
                      forr: 'mail',
                      isEmptyMsg: 'Enter your mail address ',
                      keyboardType: TextInputType.text),
                  _textField(
                      controller: _passwordController,
                      icon: Icons.lock,
                      maxlines: 1,
                      isObsecureText: _obscureTextNewPass,
                      isHidTap: true,
                      hint: 'Enter Password',
                      forr: 'pass',
                      isEmptyMsg: 'Enter your Password ',
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _createAccount(context);
                    },
                    child: Text('Register '),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(LoginScreen());
                      },
                      child: Text('Already Have an Account? Login Now')),
                  SizedBox(
                    height: size.height * 0.15,
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

  void _createAccount(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map<String, dynamic> bodyMap = {
        "username": _mailAddressController.text,
        "email": _passwordController.text,
        "password": _passwordController.text
      };
      print('bodyMap' + bodyMap.toString());

      Get.defaultDialog(
        backgroundColor: Colors.blue,
        title: 'Loading...',
        radius: 20.0,
        content: CupertinoActivityIndicator(
          animating: true,
          radius: 10.0,
        ),
      );

      RestApiRepository().createAccountPostMethod(bodyMap).then((value) {
        if (value) {
          Get.back();
          Get.snackbar('Success', 'Register has successFul');
        } else {
          Get.snackbar('Error', 'Register has error');
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
    if (forr == 'phone') {
      return _phone = newValue;
    }
    if (forr == 'pass') {
      return _password = newValue;
    }
  }
}
