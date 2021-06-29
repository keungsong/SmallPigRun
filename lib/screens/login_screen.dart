import 'package:deliveryboy/provider/auth_provider.dart';
import 'package:deliveryboy/screens/home_screen.dart';
import 'package:deliveryboy/screens/register_screen.dart';
import 'package:deliveryboy/services/firebase_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginSreen extends StatefulWidget {
  static const String id = 'login-screen';
  @override
  _LoginSreenState createState() => _LoginSreenState();
}

class _LoginSreenState extends State<LoginSreen> {
  FirebaseServices _services = FirebaseServices();
  final _formKey = GlobalKey<FormState>();
  Icon icon;
  bool _visible = false;
  var _usernameTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  String email, password;

  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
          body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Lottie.asset(
                          'assets/delivery.json',
                          height: 200,
                        ),
                        Text(
                          'Small Pig Running',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'ໝູນ້ອຍແລ່ນໄວ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _usernameTextController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ກະລຸນາປ້ອນອີແມລ';
                        }
                        final bool _isValid = EmailValidator.validate(
                            _usernameTextController.text);
                        if (!_isValid) {
                          return 'ອີເມວບໍ່ຖືກຕ້ອງ';
                        }
                        setState(() {
                          email = value;
                        });
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'ອີເມວເຂົ້າລະບົບ',
                          prefixIcon: Icon(Icons.email_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                          focusColor: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordTextController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ກະລຸນາໃສ່ລະຫັດຜ່ານ';
                        }
                        if (value.length < 6) {
                          return 'ລະຫັດຕ່ຳສຸດ 6 ຕົວອັກສອນ';
                        }
                        setState(() {
                          password = value;
                        });
                        return null;
                      },
                      obscureText: _visible == false ? true : false,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: _visible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _visible = !_visible;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'ລະຫັດຜ່ານ',
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                          focusColor: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              EasyLoading.show(status: 'ກະລຸນາລໍຖ້າ...');
                              _services.validateUser(email).then((value) {
                                if (value.exists) {
                                  if (value.data()['password'] == password) {
                                    _authData
                                        .loginBoys(email, password)
                                        .then((credential) {
                                      if (credential != null) {
                                        EasyLoading.showSuccess(
                                                'ເຂົ້າລະບົບສຳເລັບ')
                                            .then((value) {
                                          Navigator.pushReplacementNamed(
                                              context, MyHomePage.id);
                                        });
                                      } else {
                                        EasyLoading.showInfo('ກະລຸນາລົງທະບຽນ')
                                            .then((value) {
                                          _authData.getEmail(email);
                                          Navigator.pushNamed(
                                              context, RegisterScreen.id);
                                        });
                                        /* ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'ຂໍອາໄພ ບໍ່ພົບບັນຊີນີ້')));*/
                                      }
                                    });
                                  } else {
                                    EasyLoading.showError('ລະຫັດບໍ່ຖືກຕ້ອງ');
                                  }
                                } else {
                                  EasyLoading.showError(
                                      '$email ບໍ່ໄດ້ຮັບການລົງທະບຽນເປັນທີມຂົນສົ່ງເທື່ອ');
                                }
                              });
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'ເຂົ້າລະບົບ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                      ],
                    ),
                    /* FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterScreen.id);
                        },
                        child: RichText(
                            text: TextSpan(text: '', children: [
                          TextSpan(
                              text: 'ຍັງບໍ່ມີບັນຊີ ? ',
                              style: TextStyle(color: Colors.black54)),
                          TextSpan(
                              text: 'ລົງທະບຽນ',
                              style: TextStyle(color: Colors.blue))
                        ])))*/
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
