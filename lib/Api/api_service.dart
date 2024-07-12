import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/Api/Utilities/api_url.dart';
import 'package:covid_tracker/Model/world_states_model.dart';


class Api {

  Future<WorldStatesModel?> fatchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(ApiUrl.worldStatesApi));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      print(decodedData);
      return WorldStatesModel.fromJson(decodedData);
    } else {
      throw Exception("Something happened");
    }
  }

  Future<List<dynamic>> fatchCountrysListRecords() async {

    var decodedData;
    final response = await http.get(Uri.parse(ApiUrl.CountriesListApi));
    if (response.statusCode == 200) {
      decodedData = json.decode(response.body);

      print(decodedData);
      return decodedData;
    } else {
      throw Exception("Something happened");
    }
  }
}