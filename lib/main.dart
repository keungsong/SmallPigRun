import 'package:deliveryboy/provider/auth_provider.dart';
import 'package:deliveryboy/screens/home_screen.dart';
import 'package:deliveryboy/screens/login_screen.dart';
import 'package:deliveryboy/screens/register_screen.dart';
import 'package:deliveryboy/splash-screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => AuthProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ຂົນສົ່ງດ່ວນ',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      builder: EasyLoading.init(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        MyHomePage.id: (context) => MyHomePage(),
        LoginSreen.id: (context) => LoginSreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
      },
    );
  }
}
