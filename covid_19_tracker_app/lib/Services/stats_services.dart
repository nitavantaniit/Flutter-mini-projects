import 'dart:convert';

import 'package:covid_19_tracker_app/Model/world_stats_model.dart';
import 'package:covid_19_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatsServices {

  Future<WorldStatsModel> fetchWorldStatsRecords() async {

    final response = await http.get(Uri.parse(AppUrl.worldstatsApi));

    if(response.statusCode == 200) {

      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi () async {

    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200) {

      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}