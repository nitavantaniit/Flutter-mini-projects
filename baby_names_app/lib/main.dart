import 'package:baby_names_app/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:baby_names_app/screens/boys_names_screen.dart';
import 'package:baby_names_app/screens/girls_names_screen.dart';
import 'package:baby_names_app/boys_zodiac/baeries.dart';
import 'package:baby_names_app/boys_zodiac/baquarius.dart';
import 'package:baby_names_app/boys_zodiac/bcancer.dart';
import 'package:baby_names_app/boys_zodiac/bcapricorn.dart';
import 'package:baby_names_app/boys_zodiac/bgemini.dart';
import 'package:baby_names_app/boys_zodiac/bleo.dart';
import 'package:baby_names_app/boys_zodiac/blibra.dart';
import 'package:baby_names_app/boys_zodiac/bpisces.dart';
import 'package:baby_names_app/boys_zodiac/bsagittarius.dart';
import 'package:baby_names_app/boys_zodiac/bscorpio.dart';
import 'package:baby_names_app/boys_zodiac/btaurus.dart';
import 'package:baby_names_app/boys_zodiac/bvirgo.dart';
import 'package:baby_names_app/girls_zodiac/gaeries.dart';
import 'package:baby_names_app/girls_zodiac/gaquarius.dart';
import 'package:baby_names_app/girls_zodiac/gcancer.dart';
import 'package:baby_names_app/girls_zodiac/gcapricorn.dart';
import 'package:baby_names_app/girls_zodiac/ggemini.dart';
import 'package:baby_names_app/girls_zodiac/gleo.dart';
import 'package:baby_names_app/girls_zodiac/glibra.dart';
import 'package:baby_names_app/girls_zodiac/gpisces.dart';
import 'package:baby_names_app/girls_zodiac/gsagittarius.dart';
import 'package:baby_names_app/girls_zodiac/gscorpio.dart';
import 'package:baby_names_app/girls_zodiac/gtaurus.dart';
import 'package:baby_names_app/girls_zodiac/gvirgo.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), 
        '/boys_names': (context) => BoysNamesScreen(),
        '/baeries': (context) => BAriesScreen(),
        '/btaurus': (context) => BTaurusScreen(),
        '/bgemini': (context) => BGeminiScreen(),
        '/bcancer': (context) => BCancerScreen(),
        '/bleo': (context) => BLeoScreen(),
        '/bvirgo': (context) => BVirgoScreen(),
        '/blibra': (context) => BLibraScreen(),
        '/bscorpio': (context) => BScorpioScreen(),
        '/bsagittarius': (context) => BSagittariusScreen(),
        '/bcapricorn': (context) => BCapricornScreen(),
        '/baquarius': (context) => BAquariusScreen(),
        '/bpisces': (context) => BPiscesScreen(),
        '/girls_names': (context) => GirlsNamesScreen(),
        '/gaeries': (context) => GAeriesScreen(), 
        '/gtaurus': (context) => GTaurusScreen(),
        '/ggemini': (context) => GGeminiScreen(),
        '/gcancer': (context) => GCancerScreen(),
        '/gleo': (context) => GLeoScreen(),
        '/gvirgo': (context) => GVirgoScreen(),
        '/glibra': (context) => GLibraScreen(),
        '/gscorpio': (context) => GScorpioScreen(),
        '/gsagittarius': (context) => GSagittariusScreen(),
        '/gcapricorn': (context) => GCapricornScreen(),
        '/gaquarius': (context) => GAquariusScreen(),
        '/gpisces': (context) => GPiscesScreen(),
      },
    );
  }
}






