import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technaureus_task/models/customer_model.dart';

class CustomerProvider extends ChangeNotifier {
  List<CustomerData> customerlist = [];

  saveUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> customers = customerlist
        .map((item) =>
            '${item.profilePic}|${item.name}|${item.id}|${item.street}|${item.streetTwo}|${item.state}')
        .toList();
    pref.setStringList("customerlist", customers);
  }

  loadUser() async {
    SharedPreferences load = await SharedPreferences.getInstance();
    List<String> loadCustomers = load.getStringList("productlist") ?? [];
    customerlist = loadCustomers.map((item) {
      List<String> parts = item.split('|');
      return CustomerData(
        profilePic: parts[0],
        name: parts[1],
        id: int.parse(parts[2]),
        street: parts[3],
        streetTwo: parts[4],
        state: parts[5],
      );
    }).toList();
    notifyListeners();
  }
}
