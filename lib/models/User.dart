class User {
  final String uid;
  User({this.uid});
}

class Product {
  String name;
  String id;
  var images;
  int price;
  Product({this.name, this.price, this.images, this.id});
}

class ShoppingCart {
  var products;
  var quantities;
  ShoppingCart({this.products,this.quantities});
}

class Category {
  String name;
  var products;
  Category({this.name, this.products});
}
