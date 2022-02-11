import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/data/user_data_mock.dart';

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

  UserRepository get userRepository {
    switch (_flavor) {
      case Flavor.mock:
        return MockUserRepository();
      // case Flavor.real:
      //   return new RandomUserRepository();
      default:
        return MockUserRepository();
    }
  }
}
