import 'package:flutter/material.dart';
import 'package:baby_names_app/screens/boys_names_screen.dart';
import 'package:baby_names_app/screens/girls_names_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0), 
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purpleAccent, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Baby Names",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico', 
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Icon(
                    Icons.child_care, 
                    color: Colors.white,
                    size: 36.0,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Baby Names Application",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoysNamesScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/bn2.png"),
                radius: 70.0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Boys' Names",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 3, 94, 250), 
                  ),
                ),
                SizedBox(width: 5.0), 
                Icon(
                  Icons.child_care, 
                  color: Color.fromARGB(255, 3, 94, 250),
                  size: 24.0,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text("Tap on the avatar to see names"),
            SizedBox(height: 40.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GirlsNamesScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/bn3.png"),
                radius: 70.0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Girls' Names",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 254, 6, 89), 
                  ),
                ),
                SizedBox(width: 5.0), 
                Icon(
                  Icons.child_care, 
                  color: Color.fromARGB(255, 254, 6, 89),
                  size: 24.0,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text("Tap on the avatar to see names"),
          ],
        ),
      ),
      backgroundColor: Colors.purple[100],
    );
  }
}