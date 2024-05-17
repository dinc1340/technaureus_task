import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:technaureus_task/models/product_model.dart';

getUserData() async {
  const String apiUrl = 'http://143.198.61.94:8000/api/products/';

  try {
    var response = await http.get(
      Uri.parse(apiUrl),
    );

    if (response.statusCode == 200) {
      return ProductClass.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load media');
    }
  } catch (e) {
    throw Exception('Error occurred: $e');
  }
}
