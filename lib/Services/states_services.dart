import 'dart:convert';

import 'package:covid_19_tracker_app/Model/world_states_model.dart';
import 'package:covid_19_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class WorldStatesServcies {
  Future<WorldStatesModel> fetchWorldStatesApi() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> fetchCountriesStatesApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesListUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
