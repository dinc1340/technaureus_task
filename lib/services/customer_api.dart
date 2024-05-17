import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:technaureus_task/models/customer_model.dart';

getCustomerData() async {
  const String apiUrl = 'http://143.198.61.94:8000/api/customers/';

  try {
    var response = await http.get(
      Uri.parse(apiUrl),
    );

    if (response.statusCode == 200) {
      return CustomerModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load customer details');
    }
  } catch (e) {
    throw Exception('Error occurred: $e');
  }
}
