import 'package:flutter/material.dart';
import 'package:bandera/screens/home_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(seconds:5));
  FlutterNativeSplash.remove();

  runApp( MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bandera Musical',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.yellow,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Gajraj',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}





