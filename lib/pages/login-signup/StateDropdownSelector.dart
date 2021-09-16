import 'package:bazaar_bihar/CityStateDropDown/StateCityModel.dart';
import 'package:ej_selector/ej_selector.dart';
import 'package:flutter/material.dart';

class StateDropdownSelector extends StatelessWidget {
  final onChangeValue;
  final StateCity? selectedState;
  const StateDropdownSelector(
      {required this.onChangeValue, required this.selectedState});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: EJSelectorButton<StateCity>(
        useValue: false,
        hint: Text(
          'Select your state',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        value: selectedState,
        onChange: onChangeValue,
        buttonBuilder: (child, value) => Container(
          alignment: Alignment.centerLeft,
          height: 50,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade400, width: 2),
            ),
          ),
          child: value != null
              ? Text(
                  value.state,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )
              : child,
        ),
        selectedWidgetBuilder: (valueOfSelected) => Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Text(
            valueOfSelected.state,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ),
        items: stateCityList
            .map(
              (item) => EJSelectorItem(
                value: item,
                widget: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Text(
                    item.state,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
