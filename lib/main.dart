// Flutter package
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginsignuphome/screen/home.dart';

// file import from screen Folder
import 'package:loginsignuphome/screen/welcome.dart';

import 'screen/login.dart';

void main() {
  // Closing Land scape mode in Mobile
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelComePage(),
        '/loginpage': (context) => LoginPage(),
        '/homepage': (context) => HomePage()
      },
    );
  }
}
