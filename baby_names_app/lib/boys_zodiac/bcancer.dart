import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BCancerScreen extends StatefulWidget {
  const BCancerScreen({Key? key}) : super(key: key);

  @override
  _BCancerScreenState createState() => _BCancerScreenState();
}

class _BCancerScreenState extends State<BCancerScreen> {
  late Future<List<Map<String, dynamic>>> cancerData;

  @override
  void initState() {
    super.initState();
    cancerData = fetchCancerData();
  }

  Future<List<Map<String, dynamic>>> fetchCancerData() async {
    final response = await http.get(
        Uri.parse('https://18septbabynames.000webhostapp.com/bcancer.php'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      if (responseData.isNotEmpty) {
        final List<Map<String, dynamic>> dataList =
            responseData.cast<Map<String, dynamic>>();
        return dataList;
      } else {
        throw Exception('Cancer data is empty');
      }
    } else {
      throw Exception('Failed to load Cancer data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancer - Boys Names'),
        backgroundColor:  Color.fromARGB(255, 1, 94, 253), 
      ),
      backgroundColor: Colors.lightBlue[100], 
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: cancerData,
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
                            Colors.blue, 
                            Colors.purple, 
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
                child: Text('Cancer data not available'),
              );
            }
          }
        },
      ),
    );
  }
}