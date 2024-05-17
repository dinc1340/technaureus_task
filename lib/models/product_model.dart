import 'dart:convert';

ProductClass userModelFromJson(String str) =>
    ProductClass.fromJson(json.decode(str));

String userModelToJson(ProductClass data) => json.encode(data.toJson());

class ProductClass {
  final int errorCode;
  final List<ProductData> data;
  final String message;

  ProductClass({
    required this.errorCode,
    required this.data,
    required this.message,
  });

  factory ProductClass.fromJson(Map<String, dynamic> json) => ProductClass(
        errorCode: json["error_code"],
        data: List<ProductData>.from(
            json["data"].map((x) => ProductData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class ProductData {
  final int? id;
  final String? name;
  final String? image;
  final int? price;
  final DateTime? createdDate;
  final String? createdTime;
  final DateTime? modifiedDate;
  final String? modifiedTime;
  final bool? flag;

  ProductData({
    this.id,
    this.name,
    this.image,
    this.price,
    this.createdDate,
    this.createdTime,
    this.modifiedDate,
    this.modifiedTime,
    this.flag,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        createdDate: DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "created_date":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date":
            "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
      };
}
