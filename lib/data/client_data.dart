import 'dart:async';

class User {
  final String id;
  String username;
  String password;
  String phoneNum;
  String address;
  List<Map<String, String>>
      cart; // String is for itemId, int is for num of items
  static const defaultValue = [
    {"itemId": "", "itemNum": ""}
  ];
  User(
      {this.id = "",
      this.username = "",
      this.password = "",
      this.phoneNum = "",
      this.address = "",
      this.cart = defaultValue});
  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        password = map['password'],
        phoneNum = map['phoneNum'],
        address = map['address'],
        cart = map['cart'];
}

abstract class UserRepository {
  Future<List<User>> fetch();
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return "Exception:$message";
  }
}
