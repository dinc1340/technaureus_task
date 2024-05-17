class Categories {
  const Categories({
    required this.categoryimage,
    required this.categorytype,
  });
  final String categoryimage;
  final String categorytype;
}

List<Categories> categorylist = [
  const Categories(
      categoryimage: "asset/images/fruit.jpg", categorytype: "Fruit"),
  const Categories(
      categoryimage: "asset/images/veggie.png", categorytype: "Veggie"),
  const Categories(
      categoryimage: "asset/images/spices.png", categorytype: "Spice"),
  const Categories(
      categoryimage: "asset/images/bread.png", categorytype: "Bread"),
  const Categories(
      categoryimage: "asset/images/dairy.png", categorytype: "Dairy"),
];
