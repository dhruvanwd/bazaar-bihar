import 'package:ej_selector/ej_selector.dart';
import 'package:flutter/material.dart';

class CityModel {
  final city;
  CityModel(this.city);
}

class CityDropdownSelector extends StatelessWidget {
  final onChangeValue;
  final List<String> cities;
  CityDropdownSelector({required this.onChangeValue, required this.cities});

  @override
  Widget build(BuildContext context) {
    final citiesList = cities.map((e) => CityModel(e)).toList();
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: EJSelectorButton<CityModel>(
        useValue: false,
        hint: Text(
          'Select your city',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
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
                  value.city,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )
              : child,
        ),
        selectedWidgetBuilder: (valueOfSelected) => Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Text(
            valueOfSelected.city,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ),
        items: citiesList
            .map(
              (item) => EJSelectorItem(
                value: item,
                widget: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Text(
                    item.city,
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
