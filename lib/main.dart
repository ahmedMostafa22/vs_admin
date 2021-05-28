import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vs_admin/screens/login.dart';
import 'package:vs_admin/view_models/orders.dart';
import 'package:vs_admin/view_models/products.dart';
import 'package:vs_admin/view_models/stores.dart';
import 'constants.dart';
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => OrdersProvider()),
      ChangeNotifierProvider(create: (context) => ProductsProvider()),
      ChangeNotifierProvider(create: (context) => StoresProvider())
    ],
    child: GetMaterialApp(
        theme: ThemeData(
          buttonColor: Constants.primaryColor,
          primaryColor: Constants.primaryColor,
          accentColor: Constants.primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonTheme: ButtonThemeData(buttonColor: Constants.primaryColor),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder()
            },
          ),
        ),
        home: AuthStateRouter()),
  ));
}

class AuthStateRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          else if (snapshot.hasData) return Home();
          return Login();
        },
      )),
    );
  }
}
