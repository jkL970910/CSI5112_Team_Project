import 'dart:async';
import 'package:csi5112_project/data/user_data.dart';

import 'item_data.dart';
import 'merchant_data.dart';

class MockMerchantRepository implements MerchantRepository {
  @override
  Future<List<Merchant>> fetch() => Future.value(kMerchant);
}

var kMerchant = <Merchant>[
  Merchant(
    id: '1',
    username: 'Bob',
    password: '6677',
    phoneNum: "623888767",
    address: "Blair",
    cart: [
      {"itemId": "1234", "itemNum": "9"},
      {"itemId": "2234", "itemNum": "7"}
    ],
  ),
  Merchant(
    id: '2',
    username: 'Paul',
    password: '0876',
    phoneNum: "615487767",
    address: "Rideau",
    cart: [
      {"itemId": "3234", "itemNum": "9"},
      {"itemId": "4234", "itemNum": "20"}
    ],
  ),
];
