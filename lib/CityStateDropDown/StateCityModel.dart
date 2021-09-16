// To parse this JSON data, do
//
//     final stateCity = stateCityFromJson(jsonString);

import 'package:bazaar_bihar/CityStateDropDown/stateRawDetails.dart';

class StateCity {
  StateCity({
    required this.state,
    required this.districts,
  });

  String state;
  List<String> districts;

  factory StateCity.fromJson(Map<String, dynamic> json) => StateCity(
        state: json["state"],
        districts: List<String>.from(json["districts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "districts": List<String>.from(districts.map((x) => x)),
      };
}

List<StateCity> stateCityList =
    List<StateCity>.from(statesRawList.map((x) => StateCity.fromJson(x)));
