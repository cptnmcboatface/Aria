class User {
  final String uid;
  User({this.uid});
}

class Product{
  String name;
  var images;
  int price;
  Product({this.name,this.price,this.images});

}

class Category{
  String name;
  var products;
  Category({this.name,this.products});
}