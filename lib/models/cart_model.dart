import 'package:technaureus_task/models/product_model.dart';

class CartItemModel {
  int quantity;
  final ProductData item;

  CartItemModel({this.quantity = 0, required this.item});

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        quantity: json['quantity'] ?? 0,
        item: ProductData.fromJson(json['item']),
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'item': item.toJson(),
      };

  void increaseQuantity() {
    quantity++;
  }

  void reduceQuantity() {
    quantity--;
  }
}
