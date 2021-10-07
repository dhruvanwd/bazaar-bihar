import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import './CachedImageManager.dart';
import '../models/CategoryModel.dart';
import './clearSelectionDialog.dart';

class CategoryDropdown extends StatelessWidget {
  final onSelectCat;
  final selectedCat;
  final List<CategoryModel> categories;
  CategoryDropdown(
      {required this.onSelectCat,
      required this.selectedCat,
      required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DropdownSearch<CategoryModel>(
        validator: (v) => v == null ? "required field" : null,
        hint: "Select a category",
        mode: Mode.MENU,
        showSelectedItems: true,
        items: categories,
        popupItemBuilder: (context, cat, isSelected) => ListTile(
          dense: true,
          title: Text(cat.name),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: CachedImageMananger(cat.image),
          ),
        ),
        label: "Category *",
        dropdownSearchDecoration: InputDecoration(
            border: UnderlineInputBorder(), labelText: 'Shop name'),
        showClearButton: true,
        onChanged: onSelectCat,
        selectedItem: selectedCat,
        compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
        clearButtonSplashRadius: 20,
        dropdownBuilder: (context, cat) => cat == null
            ? ListTile(
                dense: true,
                title: Text("Select shop category"),
                contentPadding: EdgeInsets.all(0),
              )
            : ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                title: Text(cat.name),
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: CachedImageMananger(cat.image),
                ),
              ),
        onBeforeChange: (a, b) {
          if (b == null) {
            clearSelectionDialog(context);
          }

          return Future.value(true);
        },
      ),
    );
  }
}
