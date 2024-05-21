import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'item.dart';

class ItemData with ChangeNotifier {
  List<Item> _items = [];

  ItemData() {
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    _items = await DatabaseHelper().getItems();
    notifyListeners();
  }

  void toggleStatus(int index) {
    _items[index].toggleStatus();
    DatabaseHelper().updateItem(_items[index]);
    notifyListeners();
  }

  void addItem(String title) {
    final newItem = Item(title: title);
    DatabaseHelper().insertItem(newItem).then((_) => _fetchItems());
  }

  void deleteItem(int index) {
    final id = _items[index].id;
    if (id != null) {
      DatabaseHelper().deleteItem(id).then((_) => _fetchItems());
    }
  }

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);
}
