import 'dart:async';
import 'package:csi5112_project/data/client_data.dart';

import 'item_data.dart';

class MockUserRepository implements UserRepository {
  @override
  Future<List<User>> fetch() => Future.value(kUsers);
}

var kUsers = <User>[
  User(
    id: '1',
    username: 'Lucy',
    password: '1234',
    phoneNum: "613888767",
    address: "uottawa",
    cart: [
      {"itemId": "1234", "itemNum": "2"},
      {"itemId": "2234", "itemNum": "1"}
    ],
  ),
  User(
    id: '2',
    username: 'Lily',
    password: '9876',
    phoneNum: "613487767",
    address: "carleton",
    cart: [
      {"itemId": "3234", "itemNum": "2"},
      {"itemId": "4234", "itemNum": "5"}
    ],
  ),
];
