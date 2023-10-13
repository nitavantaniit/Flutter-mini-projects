import 'package:firebase_core/firebase_core.dart';
import 'package:group_chat_app/pages/auth/login_page.dart';
import 'package:group_chat_app/pages/home_page.dart';
import 'package:group_chat_app/shared/constants.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'helper/helper_function.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var DefaultFirebaseOptions;
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggerInStatus();
  }

  getUserLoggerInStatus() async {
    await HelperFunction.getUserLoggerInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: constants().primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? const HomePage() : const LoginPage(),
      
    );
  }
}
