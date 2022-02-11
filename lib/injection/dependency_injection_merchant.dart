import 'package:csi5112_project/data/merchant_data.dart';
import 'package:csi5112_project/data/merchant_data_mock.dart';

import '../data/item_data.dart';
import '../data/item_data_mock.dart';

enum Flavor { mock, real }

class Injector {
  Injector._internal();
  static final _singleton = Injector._internal();
  static const Flavor _flavor = Flavor.mock;

  factory Injector() {
    return _singleton;
  }

  MerchantRepository get merchantRepository {
    switch (_flavor) {
      case Flavor.mock:
        return MockMerchantRepository();
      // case Flavor.real:
      //   return new RandomUserRepository();
      default:
        return MockMerchantRepository();
    }
  }
}
