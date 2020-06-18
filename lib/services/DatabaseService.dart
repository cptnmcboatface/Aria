import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aria_makeup/models/User.dart';

class DataBase {
  final uid;
  DataBase({this.uid});
  final databaseReference = Firestore.instance;

  void createUser() async {
    print('User Created');
    await databaseReference
        .collection("Users")
        .document(uid)
        .setData({'uid': uid, 'Orders': {}, 'Liked Items': []});
    this.createCart();
  }

  void createCart() async {
    print("Record Created");
    await databaseReference
        .collection("Shopping Carts")
        .document(uid)
        .setData({'Products': [], 'Quantities': {}});
  }

  void addItem(itemID) async {
    print("Itemm Added to Cart");
    await databaseReference
        .collection("Shopping Carts")
        .document(uid)
        .updateData({
      'Products': FieldValue.arrayUnion([itemID]),
      'Quantities' + '.' + itemID: 1
    });
  }

  void removeItem(itemID) async {
    print("Item Removed from Cart");
    await databaseReference
        .collection("Shopping Carts")
        .document(uid)
        .updateData({
      'Products': FieldValue.arrayRemove([itemID]),
      'Quantities' + '.' + itemID: 0
    });
  }

  void updateItemQuantity(itemID, newCount) async {
    print("Quantity Updated");
    await databaseReference
        .collection("Shopping Carts")
        .document(uid)
        .updateData({'Quantities' + '.' + itemID: newCount});
  }

  void addOrder(Order order) async {
    print("Order Recieved");
    await databaseReference
        .collection("Orders")
        .document(order.orderId)
        .setData({
      'Products': order.shoppingCart.products,
      'Quantity': order.shoppingCart.quantities,
      'User': order.uid,
      'Name': order.name,
      'Address': order.address,
      'Phone Number': order.phoneNumber,
      'price': order.price
    });
    this.addOrdertoUser(order);
    this.createCart();
  }

  void addOrdertoUser(Order order) async {
    print("Order Added to User Profile");
    await databaseReference.collection("Users").document(uid).updateData({
      'Orders.' + order.orderId: {
        'OrderId': order.orderId,
        'Products': order.shoppingCart.products,
        'Quantity': order.shoppingCart.quantities,
        'User': order.uid,
        'Name': order.name,
        'Address': order.address,
        'Phone Number': order.phoneNumber,
        'price': order.price
      }
    });
  }

  Future<bool> checkUser() async {
    return await databaseReference
        .collection("Users")
        .document(uid)
        .get()
        .then((userSnapshot) {
      if (userSnapshot.data == null) {
        return false;
      } else {
        return true;
      }
    });
  }

  Map<String, Product> _productMapFromSnapshot(QuerySnapshot snapshot) {
    return Map.fromIterable(snapshot.documents,
        key: (value) => value.data["id"],
        value: (value) => Product(
            name: value.data['Name'],
            price: value.data['Price'],
            images: value.data['Images'],
            id: value.data['id']));
  }

  Map<String, Category> _categoryMapFromSnapshot(QuerySnapshot snapshot) {
    return Map.fromIterable(snapshot.documents,
        key: (value) => value.data["category"],
        value: (value) => Category(
            name: value.data["category"],
            products: value.data['Products'].toList()));
  }

  Stream<Map<String, Category>> get categoryStream {
    return databaseReference
        .collection("Categories")
        .snapshots()
        .map(_categoryMapFromSnapshot);
  }

  Stream<Map<String, Product>> get productStream {
    return databaseReference
        .collection("Products")
        .snapshots()
        .map(_productMapFromSnapshot);
  }

  ShoppingCart _shoppingCartFromSnapshot(DocumentSnapshot snapshot) {
    return ShoppingCart(
        products: snapshot.data['Products'].toList(),
        quantities: snapshot.data['Quantities']);
  }

  Stream<ShoppingCart> get shoppingCartStream {
    return databaseReference
        .collection("Shopping Carts")
        .document(uid)
        .snapshots()
        .map(_shoppingCartFromSnapshot);
  }
  List <String> _ListFromSnapshot(DocumentSnapshot snapshot){
    return snapshot.data["Liked Items"];
  }

  Stream<List<String>> get likedItemsStrem {
    return databaseReference.collection("Users").document(uid).snapshots().map(_ListFromSnapshot);
    
  }
}
