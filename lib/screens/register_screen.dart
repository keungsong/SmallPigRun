import 'package:deliveryboy/provider/auth_provider.dart';
import 'package:deliveryboy/screens/login_screen.dart';
import 'package:deliveryboy/widgets/image_picker.dart';
import 'package:deliveryboy/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = 'register-screen';
  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ShopPicCard(),
                  RegisterForm(),
                  // _authData.loading  == true ? Container():
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
