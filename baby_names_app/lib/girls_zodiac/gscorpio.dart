import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GScorpioScreen extends StatefulWidget {
  const GScorpioScreen({Key? key}) : super(key: key);

  @override
  _GScorpioScreenState createState() => _GScorpioScreenState();
}

class _GScorpioScreenState extends State<GScorpioScreen> {
  late Future<List<Map<String, dynamic>>> scorpioData;

  @override
  void initState() {
    super.initState();
    scorpioData = fetchScorpioData();
  }

  Future<List<Map<String, dynamic>>> fetchScorpioData() async {
    final response = await http.get(
        Uri.parse('https://18septbabynames.000webhostapp.com/gscorpio.php'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      if (responseData.isNotEmpty) {
        final List<Map<String, dynamic>> dataList =
            responseData.cast<Map<String, dynamic>>();
        return dataList;
      } else {
        throw Exception('Scorpio data is empty');
      }
    } else {
      throw Exception('Failed to load Scorpio data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scorpio - Girls Names'),
        backgroundColor: Color.fromARGB(255, 253, 1, 211),
      ),
      backgroundColor: Colors.pink[100],
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: scorpioData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final dataList = snapshot.data;

            if (dataList != null && dataList.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final data = dataList[index];
                  final name = data['name'];
                  final meaning = data['meaning'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 253, 71, 211),
                            Color.fromARGB(255, 74, 20, 140),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Card(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$name',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '$meaning',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('Scorpio data not available'),
              );
            }
          }
        },
      ),
    );
  }
}