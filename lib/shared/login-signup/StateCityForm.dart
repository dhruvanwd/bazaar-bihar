import 'package:flutter/material.dart';
import 'CityDropdownSelector.dart';
import 'StateDropdownSelector.dart';
import '../CityStateDropDown/StateCityModel.dart';

typedef void StateChange(StateCity state);
typedef void CityChange(CityModel city);

class StateCityForm extends StatelessWidget {
  final StateChange handleStateChange;
  final StateCity? selectedState;
  final List<String>? cities;
  final CityChange handleCityChange;
  StateCityForm({
    required this.handleStateChange,
    required this.selectedState,
    required this.cities,
    required this.handleCityChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: selectedState != null ? 8 : 0),
            child: StateDropdownSelector(
              onChangeValue: handleStateChange,
              selectedState: selectedState,
            ),
          ),
        ),
        selectedState != null
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CityDropdownSelector(
                    cities: cities!,
                    onChangeValue: handleCityChange,
                  ),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              ),
      ],
    );
  }
}
