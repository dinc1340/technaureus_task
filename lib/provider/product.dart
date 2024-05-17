import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technaureus_task/models/cart_model.dart';
import 'package:technaureus_task/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<CartItemModel> cartItemList = [];

  void addToCart(CartItemModel value) {
    bool itemExists = false;
    for (int i = 0; i < cartItemList.length; i++) {
      if (cartItemList[i].item.id == value.item.id) {
        cartItemList[i].increaseQuantity();
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      cartItemList.add(value);
      value.increaseQuantity();
    }

    saveData();
    notifyListeners();
  }

  void removeFromCart(CartItemModel value) {
    for (int i = 0; i < cartItemList.length; i++) {
      if (cartItemList[i].item.id == value.item.id) {
        cartItemList[i].reduceQuantity();
        if (cartItemList[i].quantity <= 0) {
          cartItemList.removeAt(i);
        }
        break;
      }
    }

    saveData();
    notifyListeners();
  }

  double get totalCartPrice {
    double totalPrice = 0.0;
    for (var item in cartItemList) {
      totalPrice += (item.quantity * (item.item.price ?? 0));
    }
    return totalPrice;
  }

  void saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> productsJson =
        cartItemList.map((product) => jsonEncode(product.toJson())).toList();
    pref.setStringList("productList", productsJson);
  }

  void loadData() async {
    SharedPreferences load = await SharedPreferences.getInstance();
    List<String>? loadedProductsJson = load.getStringList("productList");
    if (loadedProductsJson != null) {
      cartItemList = loadedProductsJson.map((productJson) {
        Map<String, dynamic> productMap = jsonDecode(productJson);
        int quantity = productMap['quantity'];
        ProductData product = ProductData.fromJson(productMap['item']);
        return CartItemModel(quantity: quantity, item: product);
      }).toList();
    } else {
      cartItemList = [];
    }
    notifyListeners();
  }

  void clearData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('productList');
    cartItemList.clear();
    notifyListeners();
  }
}
