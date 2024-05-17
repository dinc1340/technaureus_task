import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:technaureus_task/models/cart_model.dart';

Future<bool> createOrder({
  required int customerId,
  required double totalPrice,
  required List<CartItemModel> cartItemList,
}) async {
  const String apiUrl = 'http://143.198.61.94:8000/api/orders/';
  final headers = {'Content-Type': 'application/json'};

  try {
    final body = jsonEncode({
      'customer_id': customerId,
      'total_price': totalPrice,
      'products': cartItemList.map((cartItem) {
        return {
          'product_id': cartItem.item.id,
          'quantity': cartItem.quantity,
          'price': cartItem.item.price,
        };
      }).toList(),
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (_) {
    return false;
  }
}
