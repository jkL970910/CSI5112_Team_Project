import 'package:csi5112_project/data/item_data_mock_cart.dart';

import '../data/item_data.dart';

enum Flavor { mock, real }

class InjectorCart {
  InjectorCart._internal();
  static final _singleton = InjectorCart._internal();
  static const Flavor _flavor = Flavor.mock;

  factory InjectorCart() {
    return _singleton;
  }

  ItemRepository get itemRepository {
    switch (_flavor) {
      case Flavor.mock:
        return MockItemRepositoryCart();
      // case Flavor.real:
      //   return new RandomUserRepository();
      default:
        return MockItemRepositoryCart();
    }
  }
}
